#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CLEAR(0x0061CB57, 0x90, 0x0061CB63);
CLEAR(0x0061CBD6, 0x90, 0x0061CBE0);

bool TacticalZoom = 0;

void    __thiscall ToggleTacticalZoom_nothing(void *a) { }
char *  __thiscall ToggleTacticalZoom_Description(void *a) { return "Zoom in on the Tactical Map viewport"; }
char *  __thiscall ToggleTacticalZoom_INIname(void *a)     { return "ToggleTacticalZoom"; }
char *  __thiscall ToggleTacticalZoom_Category(void *a)    { return "Debug"; }
char *  __thiscall ToggleTacticalZoom_Name(void *a)        { return "ToggleTacticalZoom"; }

int     __thiscall ToggleTacticalZoom_Execute(void *a)     {
    TacticalZoom ^= 1;

    if (TacticalZoom)
        TActionClass__Zoom_In();
    else
        TActionClass__Zoom_Out();
}

//void  __thiscall CommandDestroy(void *a, char b) { }

vtCommandClass vtToggleTacticalZoomCommand = {
  CommandDestroy,
  ToggleTacticalZoom_INIname,
  ToggleTacticalZoom_Name,
  ToggleTacticalZoom_Category,
  ToggleTacticalZoom_Description,
  ToggleTacticalZoom_Execute,
  ToggleTacticalZoom_nothing
};
CommandClass ToggleTacticalZoomCommand = { &vtToggleTacticalZoomCommand,0,17,17 };
