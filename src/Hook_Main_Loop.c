#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"

#define MAX_SP_AUTOSAVES 3

CALL(0x005091A5, _MainLoop_AfterRender);
CALL(0x00509388, _MainLoop_PreRemoveAllInactive);

bool HaventSetSpecTeam = true;

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
                
                if (Frame == NextAutoSave) {
                    MessageListClass__Add_Message(&MessageListClass_this, 0, 0,
                              "Auto-saving...",
                              4, 0x4046,
                              (int)(Rules->MessageDuration * FramesPerMinute)/2);
                }
                
                if (Frame > NextAutoSave) {

                    // desperate attempt to save corruption issues
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

                    // desperate attempt to fix save corruption issues
                    Resume_Scenario_Timer();
                }
            }
        }
    }
}

