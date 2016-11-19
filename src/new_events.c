#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include <stdbool.h>

SETDWORD(0x00493D12, _NewEventNames);
SETDWORD(0x00493D82, _NewEventNames);
SETDWORD(0x00493DF2, _NewEventNames);

SETDWORD(0x00493E52, _NewEventNames);
SETDWORD(0x00493EC2, _NewEventNames);
SETDWORD(0x004940B2, _NewEventNames);

SETDWORD(0x00494122, _NewEventNames);
SETDWORD(0x004941A2, _NewEventNames);
SETDWORD(0x00494222, _NewEventNames);

SETDWORD(0x005B36D5, _NewEventNames);
SETDWORD(0x005B527E, _NewEventNames);

SETDWORD(0x005B45E4, _NewEventLengths);
SETDWORD(0x005B4AEF, _NewEventLengths);
SETDWORD(0x005B4CFA, _NewEventLengths);


volatile
char *NewEventNames[] = {
    "EMPTY",
    "POWERON",
    "POWEROFF",
    "ALLY",
    "MEGAMISSION",
    "MEGAMISSION_F",
    "IDLE",
    "SCATTER",
    "DESTRUCT",
    "DEPLOY",
    "PLACE",
    "OPTIONS",
    "GAMESPEED",
    "PRODUCE",
    "SUSPEND",
    "ABANDON",
    "PRIMARY",
    "SPECIAL_PLACE",
    "EXIT",
    "ANIMATION",
    "REPAIR",
    "SELL",
    "SELLCELL",
    "SPECIAL",
    "FRAMESYNC",
    "MESSAGE",
    "RESPONSE_TIME",
    "FRAMEINFO",
    "SAVEGAME",
    "ARCHIVE",
    "ADDPLAYER",
    "TIMING",
    "PROCESS_TIME",
    "PAGEUSER",
    "REMOVEPLAYER",
    "LATENCYFUNDGE",
    "GRANTCONTROL"
};

volatile
uint8_t NewEventLengths[] = {
    0,    //"EMPTY",
    8,    //"POWERON",
    8,    //"POWEROFF",
    4,    //"ALLY",
    0x1c, //"MEGAMISSION",
    0x24, //"MEGAMISSION_F",
    8,    //"IDLE",
    8,    //"SCATTER",
    0,    //"DESTRUCT",
    8,    //"DEPLOY",
    8,    //"PLACE",
    0,    //"OPTIONS",
    4,    //"GAMESPEED",
    8,    //"PRODUCE",
    8,    //"SUSPEND",
    8,    //"ABANDON",
    8,    //"PRIMARY",
    8,    //"SPECIAL_PLACE",
    0,    //"EXIT",
    0x10, //"ANIMATION",
    8,    //"REPAIR",
    8,    //"SELL",
    4,    //"SELLCELL",
    4,    //"SPECIAL",
    0,    //"FRAMESYNC",
    0,    //"MESSAGE",
    1,    //"RESPONSE_TIME",
    7,    //"FRAMEINFO",
    0,    //"SAVEGAME",
    0x10, //"ARCHIVE",
    4,    //"ADDPLAYER",
    5,    //"TIMING",
    2,    //"PROCESS_TIME",
    0,    //"PAGEUSER",
    4,    //"REMOVEPLAYER",
    4,    //"LATENCYFUNDGE",
    4,    //"GRANTCONTROL"
};

void
EnqueueEvent(EventClass *this)
{
    if (Outlist.Count < 64)
    {
        memcpy(&(Outlist.Array[Outlist.Tail]), this, sizeof(EventClass));
        Outlist.Count++;
        Outlist.Tail++;
        Outlist.Tail &= 0x3F;
    }

}


void __stdcall
Switch_NewEvents(EventClass *e)
{
    WWDebug_Printf("Executing extended event 0x%x\n", e->Type);
    switch(e->Type) {
    case 0x24:
        Toggle_Control(e);
        break;
    default:
        WWDebug_Printf("Extended event not found\n");
    }
}
