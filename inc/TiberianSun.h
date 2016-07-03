#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <windows.h>
#include "TiberianSun_Structures.h"
#include "Classes/RulesClass.h"

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
extern Hotkey *Hotkeys;
extern Hotkey *Hotkeys_Vector;
extern int32_t Hotkeys_ActiveCount;
extern int32_t Hotkeys_VectorMax;
extern void *DynamicVectorClass__CommandClass;
extern CommandClass MapSnapshotCommand;
extern CommandClass ChatToAlliesCommand;
extern CommandClass ChatToAllCommand;
extern CommandClass ChatToPlayerCommand;
extern CommandClass MultiplayerDebugCommand;
extern CommandClass TextBackgroundColorCommand;
extern bool SpawnerActive;
extern bool Player_Active;
extern HouseClass *PlayerPtr;
extern bool ChatToAlliesFlag;
extern bool ChatToAllFlag;
extern void **HouseClassArray;
extern size_t HouseClassArray_Count;
extern void *ScenarioStuff;
extern uint32_t Frame;
extern uint32_t GameIDNumber;
extern int32_t DragDistance;
extern bool OnlyRightClickDeselect;
extern TutorialStruct *Tutorials;
extern size_t TutorialActiveCount;
extern size_t TutorialMax;
extern bool TutorialSorted;

// ### Functions ###

bool __thiscall INIClass__GetBool(INIClass iniClass, char *section, char *key, bool defaultValue);
int  __thiscall INIClass__GetInt(INIClass iniClass, char *section, char *key, int defaultValue);
char * __thiscall INIClass__GetEntry(INIClass iniClass, char *section,  int i);
size_t __thiscall INIClass__EntryCount(INIClass iniClass, char *section);
size_t __thiscall INIClass__GetString(INIClass iniClass, char *section, char *key, char *defaultValue, char *buf, size_t len);
void   __thiscall INIClass__Destroy(INIClass iniClass);
void * __thiscall INIClass__Find_Section(INIClass iniClass, int i);
void * __thiscall INIClass__Find_Entry(INIClass iniClass, char *s, char *e);

void    __thiscall RulesClass__Process(void *rules, INIClass iniClass);
void    __thiscall RulesClass__Objects(void *rules, INIClass iniClass);
int32_t __thiscall RulesClass__AudioVisual(RulesClass *rules, INIClass iniClass);

uint32_t __thiscall TechnoClass_What_Weapon_Should_I_Use(void *ac, void *w);
int __thiscall AircraftClass__Mission_Attack(AircraftClass *me);
int __thiscall TechnoClass__Can_Player_Fire(void *);
int __thiscall ObjectClass__InAir(void *);
void ApplyUserColorOverrides();
void __stdcall Save_Scenario();

int  __thiscall MapClass__GetCellFloorHeight(MouseClass **Map, xyzCoordStruct *);
CellClass * __thiscall MapClass__Get_Target_Coord(MouseClass **Map, xyzCoordStruct *);
bool __thiscall MapClass__Cell_Is_Shrouded(MouseClass **Map, xyzCoordStruct *);
bool __thiscall is_coord_shrouded(MouseClass **Map, wCoordStruct *xy_coords);
CellClass * __thiscall MapClass__Coord_Cell(MouseClass **Map, wCoordStruct *);
void MapClass__Reveal_The_Map();
void __thiscall MapClass__Fill_Map_With_Fog(MouseClass *this);
void __fastcall Create_Units(char i);
void __cdecl hook_wwdebug_printf(char const *fmt, ...);
int __thiscall DynamicVectorClass__CommandClass__Add(void *v, CommandClass **c);
void __thiscall MessageListClass__Manage(MessageListClass *m);
int  __fastcall MapSnapshot(char *name, int n);
void __stdcall Load_Keyboard_Hotkeys();
void __thiscall CCINIClass_Vector_Resize(Hotkey **h, int32_t size);
void __thiscall Multiplayer_Debug_Print();
void __thiscall HouseClass__Make_Ally_House(HouseClass *self, HouseClass *house);
void __stdcall HookInitCommands();
void ParseIntLL(char *entry_string, int_ll **head);
void *__cdecl operator_new(size_t size);
void __cdecl operator_delete(void *memory);
size_t WWDebug_Printf(const char *, ...);
int32_t __thiscall Random2Class__operator(void *self, int32_t a2, int32_t a3);
int32_t _sprintf(char *dest, char *format, ...);
size_t __strcmpi(const char *, const char *);
//void *memcpy(char *dest, const char *src, size_t len);
// ### Variables ###

extern bool VideoWindowed;
extern bool VideoBackBuffer;
extern INIClass INIClass_SUN_INI;
extern INIClass INIClass_SPAWN;

// ### Macros ###

#define SunIni_GetBool(a,b,c) INIClass__GetBool(INIClass_SUN_INI,a,b,c)
#define SunIni_GetInt(a,b,c) INIClass__GetInt(INIClass_SUN_INI,a,b,c)

// ### Mumble ###
extern wchar_t TeamName[128];
extern char **WOL_SERVER_PORT; // Hijack this as a pointer to TeamName when spawner is active

void initMumble();
void updateMumble();

void __stdcall set_team_name(char *s);
void __stdcall set_team_spec();
extern bool IntegrateMumbleSun;
extern bool IntegrateMumbleSpawn;


// Disable alt tab
void LoadKeyboardHook();
