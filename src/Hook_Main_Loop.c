#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"

#define MAX_SP_AUTOSAVES 5

CALL(0x005091A5, _MainLoop_AfterRender);
CALL(0x00509388, _MainLoop_PreRemoveAllInactive);

bool HaventSetSpecTeam = true;
bool IsDoingMPSaveNextFrame = false;
bool IsSavingThisFrame = false;

int32_t PlayerEventCounts[8];
int32_t PlayerEventExecs[8];
int32_t PlayerEventLastFrame[8];

int32_t AutoSaveGame;
int32_t NextAutoSave;
int32_t NextSPAutoSaveId = 0;

int32_t ResponseTimeFrame = 0;
int32_t ResponseTimeInterval = 4;

int32_t NextAutoSS = 0;
int32_t AutoSSInterval = 4;
int32_t AutoSSGrowth = 4;
int32_t AutoSSIntervalMax = 30;

char AutoSaveNameBuf[256];
char AutoSaveDescrBuf[256];

void __thiscall
MainLoop_AfterRender(MessageListClass *msg) {
  MessageListClass__Manage(msg);

	if (SpawnerActive) {
        
		if (SessionClass_this.GameSession != 0) { // GAME_CAMPAIGN
		
			if (PlayerPtr->Defeated == true && HaventSetSpecTeam) {
				set_team_spec();
				HaventSetSpecTeam = false;
			}

			if (IntegrateMumbleSun && IntegrateMumbleSpawn) {
				updateMumble();
			}

			if (IsHost && 
                SessionClass_this.GameSession != 5 && // disable for GAME_SKIRMISH
				AutoSaveGame > 0 && Frame >= NextAutoSave)
			{
				NextAutoSave = Frame + AutoSaveGame;
				EventClass e;
				EventClass__EventClass_noarg(&e, PlayerPtr->ID, EVENTTYPE_SAVEGAME);
				EventClass__EnqueueEvent(&e);
			}

			if (UseProtocolZero && Frame >= ResponseTimeFrame)
			{
				ResponseTimeFrame = Frame + ResponseTimeInterval;
				Send_Response_Time();
			}

			if (RunAutoSS && SessionClass_this.GameSession == 3 && Frame > NextAutoSS)
			{
				DoingAutoSS = 1;
				ScreenCaptureCommandClass_Execute();
				DoingAutoSS = 0;
				NextAutoSS = Frame + AutoSSInterval * 60; //60fps
				if (AutoSSInterval < AutoSSIntervalMax)
					AutoSSInterval += AutoSSGrowth;
			}
		}
	}
}

void __fastcall MainLoop_PreRemoveAllInactive() {
    Remove_All_Inactive();
    
    if (SpawnerActive) {
        if (SessionClass_this.GameSession == 0) { // GAME_CAMPAIGN
            // Auto-save for singleplayer missions
            
            if (AutoSaveGame > 0) {
                
                // Print message on earlier frame so it gets rendered before
                // the save process starts
                if (Frame == NextAutoSave) {
                    MessageListClass__Add_Message(&MessageListClass_this, 0, 0,
                              "Auto-saving...",
                              4, 0x4046,
                              (int)(Rules->MessageDuration * FramesPerMinute)/2);
                }
                
                if (Frame > NextAutoSave) {

                    Pause_Scenario_Timer();
                    Call_Back();

                    NextAutoSave = Frame + AutoSaveGame;
                    NextSPAutoSaveId++;
                    if (NextSPAutoSaveId > MAX_SP_AUTOSAVES)
                        NextSPAutoSaveId = 1;
                    
                    int sprintf_result = sprintf(AutoSaveNameBuf, "AUTOSAVE%d.SAV", NextSPAutoSaveId);
                    int sprintf_result2 = sprintf(AutoSaveDescrBuf, "Mission Auto-Save (Slot %d)", NextSPAutoSaveId);
                
                    if (sprintf_result > 0 && sprintf_result2 > 0) {
                        Save_Game(AutoSaveNameBuf, AutoSaveDescrBuf, false);
                    }

                    Resume_Scenario_Timer();
                }
            }
        } else if (SessionClass_this.GameSession == 3) {
            // Auto-save for multiplayer

            // We do it by ourselves here instead of letting original Westwood code save when
            // the event is executed, because saving mid-frame before Remove_All_Inactive()
            // has been called can lead to save corruption
            // In other words, by doing it here we fix a Westwood bug/oversight

            if (IsSavingThisFrame) {
                Save_Game("SAVEGAME.NET", "Multiplayer Game", false);
                IsSavingThisFrame = false;
            }

            // Print message on earlier frame so it gets rendered before
            // the save process starts
            if (IsDoingMPSaveNextFrame) {
                MessageListClass__Add_Message(&MessageListClass_this, 0, 0,
                "Saving game...",
                4, 0x4046,
                (int)(Rules->MessageDuration * FramesPerMinute)/2);

                IsSavingThisFrame = true;
                IsDoingMPSaveNextFrame = false;
            }
        }
    }
}

