#pragma once

#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <windows.h>
#include "Enums/RTTIType.h"
#include "Enums/EventTypes.h"
#include "TopLevelTypes.h"
#include "CommandClasses.h"
#include "Classes/AbstractClass.h"
#include "Classes/AbstractTypeClass.h"
#include "Classes/WeaponTypeClass.h"
#include "Classes/ObjectTypeClass.h"
#include "Classes/TechnoTypeClass.h"
#include "Classes/IPX.h"
#include "Classes/ObjectClass.h"
#include "TiberianSun_Structures.h"
#include "Classes/RulesClass.h"
#include "Classes/HouseClass.h"
#include "Classes/SessionClass.h"
#include "Classes/RadioClass_MissionClass.h"
#include "Classes/TechnoClass.h"
#include "Classes/FootClass.h"
#include "Classes/AircraftClass.h"
#include "Classes/StripClass.h"
#include "Classes/DSurface.h"

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

// This header works with sym.asm which defines the Vanilla symbols
// This header will be split up as it becomes larger

typedef char INIClass[128];
extern bool DisableEdgeScrolling;
extern bool OverrideColors;
extern int TextBackgroundColor;
extern uint8_t PlayerColorMap[];
extern MouseClass MouseClass_Map;
extern Rect ViewPortRect;
extern Rect VisibleRect;
extern int32_t VisibleRect__Width;
extern int32_t VisibleRect__Height;
extern RulesClass *Rules;
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
extern vtCommandClass vtChatToAlliesCommand;
extern CommandClass ChatToAllCommand;
extern vtCommandClass vtChatToAllCommand;
extern CommandClass ChatToPlayerCommand;
extern CommandClass MultiplayerDebugCommand;
extern CommandClass TextBackgroundColorCommand;
extern CommandClass GrantControlCommand;
extern CommandClass ToggleTacticalZoomCommand;
extern CommandClass ToggleInfoPanelCommand;
extern CommandClass PlaceBuildingCommand;
extern CommandClass RepeatBuildingCommand;
extern CommandClass SelectOneLessCommand;

extern bool SpawnerActive;
extern bool Player_Active;
extern HouseClass *PlayerPtr;
extern bool ChatToAlliesFlag;
extern bool ChatToAllFlag;
extern bool ChatToSpectatorsFlag;
extern uint32_t IsSpectatorArray[8];
extern size_t HouseClassArray_Count;
extern ScenarioClass *ScenarioStuff;
extern uint32_t Frame;
extern uint32_t GameIDNumber;
extern int32_t DragDistance;
extern bool OnlyRightClickDeselect;
extern TutorialStruct *Tutorials;
extern size_t TutorialActiveCount;
extern size_t TutorialMax;
extern bool TutorialSorted;
extern bool MouseAlwaysInFocus;
extern char *SearchDirs;
extern uint32_t WOLGameID;
extern bool OutOfSync;
extern DynamicVectorClass_Objects CurrentObjectsArray;
extern DynamicVectorClass_Houses HouseClassArray;
extern SessionClass SessionType;
extern WWKeyboardClass *WWKeyboard;
extern uint32_t ForceFire1;
extern uint32_t ForceFire2;
extern MessageListClass MessageListClass_this;
extern double FramesPerMinute;
extern int32_t FramesPerSecond;
extern int32_t AverageFPS;
extern int32_t AverageFPS2;
extern int32_t PlayerEventCounts[8];
extern bool IsHost;
extern int32_t InfoPanel;
extern DSurface *SidebarSurface;
extern DSurface *TempSurface;
extern DSurface *CompositeSurface;
extern DSurface *AlternateSurface;
extern StripClass RIGHT_STRIP;
extern StripClass LEFT_STRIP;
extern Rect SidebarLoc;
extern bool SidebarClass_Redraw_Buttons;
extern int32_t GameStartTime;
extern IPXManagerClass IPXManagerClass_this;
extern char *ArmorNames[];
extern int ShowHelpKey;

// ### Functions ###

void   __thiscall FileClass__FileClass(FileClass *fileClass, char *fileName);
bool   __thiscall FileClass__Is_Available(FileClass *fileClass, bool forced);
int    __thiscall FileClass__Size(FileClass *fileClass);
int    __thiscall FileClass__Read(FileClass *fileClass, void *buf, size_t len);
void   __thiscall FileClass__dtor(FileClass *fileClass);
int    __thiscall FileClass__Write(FileClass *fileClass, void *buf, size_t len);
bool   __thiscall FileClass__Open(FileClass *fileClass, int mode);

void   __thiscall CCFileClass__CCFileClass(CCFileClass *ccfile, char *name);
bool   __thiscall CCFileClass__Is_Available(CCFileClass *ccfile, bool force);
size_t __thiscall CCFileClass__Size(CCFileClass *ccfile);
size_t __thiscall CCFileClass__Read(CCFileClass *ccfile, void *buf, size_t len);
int    __thiscall CCFileClass__Write(CCFileClass *fileClass, void *buf, size_t len);
void   __thiscall CCFileClass__Destroy(CCFileClass *ccfile);
bool   __thiscall CCFileClass__Open(CCFileClass *fileClass, int mode);

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
int32_t __thiscall Is_Techno(AbstractClass *this);
int32_t __thiscall Is_Foot(AbstractClass *this);
void * __thiscall ObjectClass__Who_Can_Build_Me(void *this, int a1, int a2);

void ApplyUserColorOverrides();
void __stdcall Save_Scenario();

void __thiscall TActionClass__Zoom_Out();
void __thiscall TActionClass__Zoom_In();

int  __thiscall MapClass__GetCellFloorHeight(MouseClass *Map, xyzCoordStruct *);
CellClass * __thiscall MapClass__Get_Target_Coord(MouseClass *Map, xyzCoordStruct *);
bool __thiscall MapClass__Cell_Is_Shrouded(MouseClass *Map, xyzCoordStruct *);
bool __thiscall is_coord_shrouded(MouseClass *Map, wCoordStruct *xy_coords);
CellClass * __thiscall MapClass__Coord_Cell(MouseClass *Map, wCoordStruct *);
void MapClass__Reveal_The_Map();
void __thiscall MapClass__Fill_Map_With_Fog(MouseClass *this);
void __thiscall GScreenClass__Input(MouseClass *Map, int, int, int);
void __thiscall GScreenClass__Render(MouseClass *Map);
void __thiscall GScreenClass__Flag_To_Redraw(MouseClass *Map);
void __thiscall SidebarClass__StripClass__Flag_To_Redraw(void *this);
void __thiscall SidebarClass__Blit(void *this, char a2);
void __thiscall SidebarClass__Draw_It(MouseClass *Map, char a2);
void __thiscall SidebarClass__Init_IO(MouseClass *this);
void __thiscall SidebarClass__Init_For_House(MouseClass *this);
void __thiscall DisplayClass__Init_IO(void *this);

extern __fastcall void
CC_Draw_Shape(DSurface *surface, void *palette, Image *image, int32_t frame,
              XYCoord *s_pos, Rect *position, int32_t a6, int32_t a7,
              int32_t a8, int32_t a9, int32_t tint, Image *z_shape,
              int32_t z_frame, int32_t a13, int32_t where);
extern void __thiscall DSurface_FillRect(DSurface *surface, Rect *location, int color);

extern __thiscall Image *MixFileClass__CCFileClass__Retrieve(char *name);

void __fastcall Create_Units(char i);
void __cdecl hook_wwdebug_printf(char const *fmt, ...);
int __thiscall DynamicVectorClass__CommandClass__Add(void *v, CommandClass **c);
void  __thiscall CommandDestroy(void *a, char b);

void ShowInfo(DSurface *s, Rect *l);
int32_t ResponseTimeFunc(int32_t a);

void __thiscall MessageListClass__Manage(MessageListClass *m);
void __thiscall MessageListClass__Draw(MessageListClass *m);
void __thiscall MessageListClass__Add_Message(MessageListClass *this, char *buf,
                                              char *name, char *message, int color,
                                              int32_t PrintType, int32_t duration);
void __fastcall Simple_Text_Print(XYCoord *out_width, char *str, DSurface *surface,
                                  Rect *surf_rect,
                                  Rect *dest, int32_t *color,
                                  int32_t bg_color,
                                  int32_t TextPrintType, int32_t a9);

int  __fastcall MapSnapshot(char *name, int n);
void __stdcall Load_Keyboard_Hotkeys();
void InfoPanelHotkeysInit();
void __thiscall CCINIClass_Vector_Resize(Hotkey **h, int32_t size);
void __thiscall Multiplayer_Debug_Print();
void __thiscall HouseClass__Make_Ally_House(HouseClass *self, HouseClass *house);
bool __thiscall HouseClass__Is_Ally(HouseClass *this, int his_id);
bool __thiscall HouseClass__Is_Ally_HH(HouseClass *this, HouseClass *him);
bool __thiscall HouseClass__Is_Ally_HI(HouseClass *this, int his_id);
bool __thiscall HouseClass__Is_Ally_Techno(HouseClass *this, void *him);
bool __thiscall HouseClass__Is_Player(HouseClass *this);
void __thiscall HouseClass__Manual_Place(HouseClass *this, void *factory_building, void *place_building);
void __thiscall HouseClass__Begin_Production(HouseClass *this, int RTTI, int HeapID, int a3);
void *__fastcall HouseTypeClass__From_Name(char *name);
HouseClass *__fastcall HouseClass__House_From_HouseType(void *this);
bool __thiscall HouseClass__Is_Coach(HouseClass *this);
bool __thiscall HouseClass__Is_Spectator(HouseClass *this);

void * __thiscall FactoryClass__Get_Product(void *factory);
bool  __thiscall FactoryClass__Has_Completed(void *factory);

void __stdcall HookInitCommands();
void ParseIntLL(char *entry_string, int_ll **head);
void *__cdecl operator_new(size_t size);
void __cdecl operator_delete(void *memory);

bool __thiscall WWKeyboardClass__Down(WWKeyboardClass *this, uint32_t key);
void __fastcall PrettyPrintKey(int16_t code, char *buf);

LRESULT CALLBACK WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

#ifndef WWDEBUG
#define WWDebug_Printf(format, ...)
#else
void WWDebug_Printf(char *fmt, ...);
#endif


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
#define SunIni_GetString(a,b,c,d,e) INIClass__GetString(INIClass_SUN_INI,a,b,c,d,e);

// ### Mumble ###
extern wchar_t TeamName[128];
extern char **WOL_SERVER_PORT; // Hijack this as a pointer to TeamName when spawner is active

void initMumble();
void updateMumble();

void __stdcall set_team_name(char *s);
void __stdcall set_team_spec();
extern bool IntegrateMumbleSun;
extern bool IntegrateMumbleSpawn;


extern void MultiScore__Present();

// Disable alt tab
void LoadKeyboardHook();
bool sidebar_has_cameo(int RTTI, int HeapID);

extern bool DWMOffForPrimaryLock;
extern bool DWMOffForPrimaryBlt;
extern bool ForceFullscreenSprite;
extern bool ForceBltToPrimary;
extern bool LockColorkey;
extern bool DWMOffForFullscreen;
extern bool DisableLockEmulation;
extern bool EnableOverlays;
extern bool DisableSurfaceLock;
extern bool RedirectPrimarySurfBlts;
extern bool StripMaxWindowBorder;
extern bool DisableMaxWindowedMode;

void SetWin8CompatData();


LONG WINAPI Top_Level_Exception_Filter(struct _EXCEPTION_POINTERS *ExceptionInfo);
LONG __fastcall PrintException(int id, struct _EXCEPTION_POINTERS *ExceptionInfo);
