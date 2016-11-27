#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"


CALL(0x00494E8C, _Save_Game_add_message);

void __thiscall
Save_Game_add_message(MouseClass *this)
{
    GScreenClass__Render(this);
    MessageListClass__Add_Message(&MessageListClass_this, 0, 0,
                                  "Game Saved.",
                                  4, 0x4046,
                                 (int)(Rules->MessageDuration * FramesPerMinute)/2);
}
