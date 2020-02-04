#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"

CALL(0x005091A5, _MainLoop_AfterRender);

bool HaventSetSpecTeam = true;

int32_t PlayerEventCounts[8];
int32_t PlayerEventExecs[8];
int32_t PlayerEventLastFrame[8];

int32_t AutoSaveGame;
int32_t NextAutoSave;
int32_t ResponseTimeFrame = 0;
int32_t ResponseTimeInterval = 4;

int32_t NextAutoSS = 0;
int32_t AutoSSInterval = 4;
int32_t AutoSSGrowth = 4;
int32_t AutoSSIntervalMax = 30;


void __thiscall
MainLoop_AfterRender(MessageListClass *msg) {
	MessageListClass__Manage(msg);

	if (SpawnerActive) {
		if (PlayerPtr->Defeated == true && HaventSetSpecTeam) {
			set_team_spec();
			HaventSetSpecTeam = false;
		}

		if (IntegrateMumbleSun && IntegrateMumbleSpawn) {
			updateMumble();
		}

		if (IsHost &&
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

		if (DoScreenshotOnceThenExit && DoScreenshotOnceThenExitFrame == Frame)
		{
			ScreenCaptureCommandClass_Execute();
			Queue_Exit();
			//Exit_Process();
		}

		if (ReplayPlayback) {
			Replay_Read_Frame_Func();
		}

		if (DumpDebugInfoFrame == Frame)
		{
			Print_CRCs(0);
		}
	}
}
