#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x005091A5, _MainLoop_AfterRender);

bool HaventSetSpecTeam = true;

void __thiscall
MainLoop_AfterRender(MessageListClass *msg) {
  MessageListClass__Manage(msg);

  if (PlayerPtr->gap[0xCB] == true && HaventSetSpecTeam) {
    set_team_spec();
    HaventSetSpecTeam = false;
  }
  updateMumble();
}
