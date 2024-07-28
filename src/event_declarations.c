#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"
#include <stdlib.h>

SETDWORD(0x00493D12, _EventNames);
SETDWORD(0x00493D82, _EventNames);
SETDWORD(0x00493DF2, _EventNames);

SETDWORD(0x00493E52, _EventNames);
SETDWORD(0x00493EC2, _EventNames);
SETDWORD(0x004940B2, _EventNames);

SETDWORD(0x00494122, _EventNames);
SETDWORD(0x004941A2, _EventNames);
SETDWORD(0x00494222, _EventNames);

SETDWORD(0x005B36D5, _EventNames);
SETDWORD(0x005B527E, _EventNames);

SETDWORD(0x005B45E4, _EventLengths);
SETDWORD(0x005B4AEF, _EventLengths);
SETDWORD(0x005B4CFA, _EventLengths);


volatile
char *EventNames[] = {
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
    "GRANTCONTROL",
    "RESPONSE_TIME2"
};

volatile
uint8_t EventLengths[] = {
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
    4,    //"GRANTCONTROL",
    2,    //"RESPONSE_TIME2"
};

int CountEvents = _countof(EventLengths);

void __stdcall
Extended_Events(EventClass *e)
{
    //WWDebug_Printf("Executing extended event 0x%x\n", e->Type);
    switch(e->Type) {
    case 0:
        break; // Empty Event
#ifdef SHAREDCONTROL
    case 0x24:
        Toggle_Control(e);
        break;
#endif
    case 0x25:
        Handle_Timing_Change(e);
        break;
    default:
        WWDebug_Printf("Extended event not found %d\n", e->Type);
    }
}
