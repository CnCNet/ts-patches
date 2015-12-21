#include <stdbool.h>
#include <stdint.h>

// This header works with sym.asm which defines the Vanilla symbols
// This header will be split up as it becomes larger

typedef char INIClass[128];
extern bool OverrideColors;
extern int TextBackgroundColor;
extern uint8_t PlayerColorMap[];

// ### Functions ###

bool __thiscall INIClass__GetBool(INIClass iniClass, char *section, char *key, bool defaultValue);
int  __thiscall INIClass__GetInt(INIClass iniClass, char *section, char *key, int defaultValue);
void ApplyUserColorOverrides();

// ### Variables ###

extern bool VideoWindowed;
extern bool VideoBackBuffer;
extern INIClass INIClass_SUN_INI;

// ### Macros ###

#define SunIni_GetBool(a,b,c) INIClass__GetBool(INIClass_SUN_INI,a,b,c)
#define SunIni_GetInt(a,b,c) INIClass__GetInt(INIClass_SUN_INI,a,b,c)
