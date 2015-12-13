#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

void LoadSunIni()
{
    IsNoCD = SunIni_GetBool("Options", "NoCD", true);
    if (SunIni_GetBool("Options", "SingleProcAffinity", true)) 
        SetSingleProcAffinity();
    
    NoWindowFrame = SunIni_GetBool("Video", "NoWindowFrame", false);
    UseGraphicsPatch = SunIni_GetBool("Video", "UseGraphicsPatch", true);
    VideoWindowed = SunIni_GetBool("Video", "Video.Windowed", false);
}
