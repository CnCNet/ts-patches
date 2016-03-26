#include <stdbool.h>
#include <stdint.h>
#include "TiberianSun_Structures.h"

// This header works with sym.asm which defines the Vanilla symbols
// This header will be split up as it becomes larger

typedef char INIClass[128];
extern bool DisableEdgeScrolling;
extern bool OverrideColors;
extern int TextBackgroundColor;
extern uint8_t PlayerColorMap[];
extern MouseClass *MouseClass_Map;
extern int dword_7B3304;
extern DynamicVectorClass DynamicVectorClass_AircraftClass;
extern bool MultiplayerDebug;
extern void *DynamicVectorClass__CommandClass;
extern CommandClass MapSnapshotCommand;
extern CommandClass ChatToAlliesCommand;
extern CommandClass ChatToAllCommand;
extern CommandClass ChatToPlayerCommand;
extern bool ChatToAlliesFlag;
extern bool ChatToAllFlag;
extern void **HouseClassArray;
extern size_t HouseClassArray_Count;
// ### Functions ###

bool __thiscall INIClass__GetBool(INIClass iniClass, char *section, char *key, bool defaultValue);
int  __thiscall INIClass__GetInt(INIClass iniClass, char *section, char *key, int defaultValue);
uint32_t __thiscall TechnoClass_What_Weapon_Should_I_Use(void *ac, void *w);
int __thiscall AircraftClass__Mission_Attack(AircraftClass *me);
int __thiscall TechnoClass__Can_Player_Fire(void *);
int __thiscall ObjectClass__InAir(void *);
void ApplyUserColorOverrides();

int  __thiscall MapClass__GetCellFloorHeight(MouseClass **Map, xyzCoordStruct *);
CellClass * __thiscall MapClass__Get_Target_Coord(MouseClass **Map, xyzCoordStruct *);
bool __thiscall MapClass__Cell_Is_Shrouded(MouseClass **Map, xyzCoordStruct *);
bool __thiscall is_coord_shrouded(MouseClass **Map, wCoordStruct *xy_coords);
CellClass * __thiscall MapClass__Coord_Cell(MouseClass **Map, wCoordStruct *);
void __cdecl hook_wwdebug_printf(char const *fmt, ...);
int __thiscall DynamicVectorClass__CommandClass__Add(void *v, CommandClass **c);
void __thiscall MessageListClass__Manage(MessageListClass *m);

void __stdcall HookInitCommands();
void __stdcall Load_Keyboard_Hotkeys();

size_t __strcmpi(const char *, const char *);

// ### Variables ###

extern bool VideoWindowed;
extern bool VideoBackBuffer;
extern INIClass INIClass_SUN_INI;


// ### Macros ###

#define SunIni_GetBool(a,b,c) INIClass__GetBool(INIClass_SUN_INI,a,b,c)
#define SunIni_GetInt(a,b,c) INIClass__GetInt(INIClass_SUN_INI,a,b,c)
