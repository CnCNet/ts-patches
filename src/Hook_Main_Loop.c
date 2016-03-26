#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x005091A5, _MainLoop_AfterRender);

void __thiscall
MainLoop_AfterRender(MessageListClass *msg) {
  MessageListClass__Manage(msg);
}
