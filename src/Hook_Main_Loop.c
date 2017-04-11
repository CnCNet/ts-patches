#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x005091A5, _MainLoop_AfterRender);

bool HaventSetSpecTeam = true;

int32_t PlayerEventCounts[8];
int32_t PlayerEventExecs[8];
int32_t PlayerEventLastFrame[8];

int32_t AutoSaveGame;
int32_t NextAutoSave;

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
        EnqueueEvent(&e);
    }
  }
}
