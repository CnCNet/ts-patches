#include <stdbool.h>
#include <stdint.h>

// This header works with sym.asm which defines the Vanilla symbols
// This header will be split up as it becomes larger

typedef char INIClass[128];

// ### Functions ###

bool __thiscall INIClass__GetBool(INIClass iniClass, char *section, char *key, bool defaultValue);

// ### Variables ###

extern INIClass INIClass_SUN_INI;
