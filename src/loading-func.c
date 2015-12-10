#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

void LoadSunIni()
{
    if (INIClass__GetBool(INIClass_SUN_INI, "Options", "SingleProcAffinity", true)) SetSingleProcAffinity();
    NoWindowFrame = INIClass__GetBool(INIClass_SUN_INI, "Video", "NoWindowFrame", false);
    UseGraphicsPatch = INIClass__GetBool(INIClass_SUN_INI, "Video", "UseGraphicsPatch", true);
    IsNoCD = INIClass__GetBool(INIClass_SUN_INI, "Options", "NoCD", true);
}
