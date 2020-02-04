#include <windows.h>
#include <stdio.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "Enums/EventTypes.h"
#include "patch.h"

#define CHAT_MSG_SIZE 256

bool AutomaticPlayback = false;
HANDLE ReplayFile = NULL;
int readEvents = 0;
int readChatMsg = 0;
int NormalizedDelayGameSpeed = -1;


// PLACE = 10
// ABSTRACT_BUILDING 

// return false will block the event from happening
bool __stdcall Write_Event_To_Replay_File(EventClass *e) {
	if (ReplayPlayback && !AutomaticPlayback) {
		if (e->Type != EVENTTYPE_GAMESPEED
			&& e->Type != EVENTTYPE_OPTIONS
			&& e->Type != EVENTTYPE_EXIT
			&& e->Type != EVENTTYPE_SAVEGAME
			&& e->Type != EVENTTYPE_DESTRUCT) {
			return false;
		}
	}

	if (ReplayPlayback)
		if (e->Type == EVENTTYPE_RESPONSE_TIME2 || e->Type == EVENTTYPE_RESPONSE_TIME 
			|| e->Type == EVENTTYPE_PROCESS_TIME || e->Type == EVENTTYPE_TIMING) return false;

	if (ReplayRecording)
		if (e->Type == EVENTTYPE_RESPONSE_TIME2 || e->Type == EVENTTYPE_RESPONSE_TIME
			|| e->Type == EVENTTYPE_PROCESS_TIME || e->Type == EVENTTYPE_TIMING) return true;

	// debug show event
	/*
	char buf[1024];
	_sprintf(buf, "Event: Type = %s (%d), FRAME = %d, Id = %d Target_ID = %d", EventNames[e->Type], e->Type, e->Frame, e->ID, e->Target_ID);

	MessageListClass__Add_Message(&MessageListClass_this, 0, 0,
		buf,
		4, 0x4046,
		(int)(Rules->MessageDuration * FramesPerMinute) / 2); */

	if (ReplayPlayback  && e->Type == EVENTTYPE_GAMESPEED) {
		// don't change the real gamespeed, just the normalized sped if the replay itself has a GAMESPEED EVENT
		if (AutomaticPlayback) {
			NormalizedDelayGameSpeed = e->Target_ID;			
		} // If we're manually changing gamespeed, change the gamespeed (the game will use NormalizedDelayGameSpeed for GameOptionsClass::Normalize_Delay()
		else {
			GameOptionsClass_GameSpeed = e->Target_ID;

			switch (GameOptionsClass_GameSpeed) {
			case 6:
				RequestedFPS = 10;
				break;
			case 5:
				RequestedFPS = 12;
				break;
			case 4:
				RequestedFPS = 15;
				break;
			case 3:
				RequestedFPS = 20;
				break;
			case 2:
				RequestedFPS = 30;
				break;
			case 1:
				RequestedFPS = 45;
				break;
			case 0:
			default:
				RequestedFPS = 60;
				break;

			}
		}
		
		return false;
	}


	if (ReplayRecording && (e->Type == EVENTTYPE_OPTIONS 
		|| e->Type == EVENTTYPE_SAVEGAME || e->Type == EVENTTYPE_RESPONSE_TIME2)) return true;

	// ignore this
	// The game will automatically create this events in the ::AI() functions
	// so if we record them they playback double
	//if (e->Type == 10/*PLACE*/ && e->Target_ID != ABSTRACT_BUILDING) return;  

	if (ReplayRecording && ReplayFile == NULL) {
		ReplayFile = fopen(ReplayName, "wb+");
	}

	if (ReplayRecording) {
		fwrite((void*)e, sizeof(EventClass), 1, ReplayFile);
		fflush(ReplayFile);
		//fclose(ReplayFile);
	}
	return true;
}

bool runFunc = true;

void Replay_Read_Frame_Func() { 
	if (runFunc == false) return;

	if (ReplayFile == NULL) {
		ReplayFile = CreateFileA(ReplayName, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	}
	SetFilePointer(ReplayFile, (readEvents * sizeof(EventClass)) + (CHAT_MSG_SIZE * readChatMsg), NULL, FILE_BEGIN);
	EventClass e;

	while (true) {
		int readAmount;
		bool success = ReadFile(ReplayFile, &e, sizeof(EventClass), (LPDWORD)&readAmount, NULL);
		if (readAmount == 0) {
			runFunc = false;
			break;
		}

		if (success) {
			if (e.Frame == Frame) {
				readEvents++;
				AutomaticPlayback = true;

				EventClass__EventClass_Execute(&e);

				// EXIT event is special, if another player exits the event do list handling code will remove the player
				/* if (e.Type == EVENTTYPE_EXIT) {
					e.Target_ID = 2;
					e.ID = 2;
					EventClass__EnqueueEvent(&e);
				}
				else {
					//EventClass__EventClass_Execute(&e);
					//EventClass__EnqueueEvent(&e);
				} */
				AutomaticPlayback = false;

				// Handle chat message
				if (e.Type == EVENTTYPE_MESSAGE)
				{
					char buf[CHAT_MSG_SIZE];

					SetFilePointer(ReplayFile, (readEvents * sizeof(EventClass)) + (CHAT_MSG_SIZE * readChatMsg), NULL, FILE_BEGIN);
					ReadFile(ReplayFile, &buf, CHAT_MSG_SIZE, (LPDWORD)&readAmount, NULL);

					MessageListClass__Add_Message(&MessageListClass_this, 0, 0,
						buf,
						4, 0x4046,
						(int)(Rules->MessageDuration * FramesPerMinute) / 2);

					readChatMsg++;
				}
			}
			else {
				break;
			}
				
		}
		else {
			runFunc = false;
			break;
		}
	}
}

void __stdcall Write_Chat_To_Replay(const char* msg) {
	if (!ReplayRecording) return;

	// Execute fake msg event so we can we record the message
	EventClass e;
	e.Type = EVENTTYPE_MESSAGE;
	e.ID = 0;
	e.Frame = Frame;
	EventClass__EventClass_Execute(&e);

	// Write the msg to the binary file
	char buf[CHAT_MSG_SIZE];
	memset(buf, 0, CHAT_MSG_SIZE);
	strcpy(buf, msg);

	if (ReplayFile == NULL) {
		ReplayFile = fopen(ReplayName, "wb+");
	}

	fwrite((void*)buf, CHAT_MSG_SIZE, 1, ReplayFile);
	fflush(ReplayFile);
}