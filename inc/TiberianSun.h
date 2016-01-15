#include <stdbool.h>
#include <stdint.h>
#include "TiberianSun_Structures.h"

// This header works with sym.asm which defines the Vanilla symbols
// This header will be split up as it becomes larger

typedef char INIClass[128];
extern bool OverrideColors;
extern int TextBackgroundColor;
extern uint8_t PlayerColorMap[];
extern MouseClass **MouseClass_Map;
extern int dword_7B3304;

// ### Functions ###

bool __thiscall INIClass__GetBool(INIClass iniClass, char *section, char *key, bool defaultValue);
int  __thiscall INIClass__GetInt(INIClass iniClass, char *section, char *key, int defaultValue);
uint32_t __thiscall TechnoClass_What_Weapon_Should_I_Use(void *ac, void *w);
int __thiscall AircraftClass__Mission_Attack(AircraftClass *me);
void ApplyUserColorOverrides();

int  __thiscall MapClass__GetCellFloorHeight(MouseClass **Map, xyzCoordStruct *);
CellClass * __thiscall MapClass__Get_Target_Coord(MouseClass **Map, xyzCoordStruct *);
bool __thiscall MapClass__Cell_Is_Shrouded(MouseClass **Map, xyzCoordStruct *);
bool __thiscall is_coord_shrouded(MouseClass **Map, wCoordStruct *xy_coords);


// ### Variables ###

extern bool VideoWindowed;
extern bool VideoBackBuffer;
extern INIClass INIClass_SUN_INI;

// ### Macros ###

#define SunIni_GetBool(a,b,c) INIClass__GetBool(INIClass_SUN_INI,a,b,c)
#define SunIni_GetInt(a,b,c) INIClass__GetInt(INIClass_SUN_INI,a,b,c)
