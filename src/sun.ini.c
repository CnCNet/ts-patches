#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CLEAR(0x006010B8, 0x90, 0x006010D3);
CALL(0x006010B8, _LoadSunIni);

bool OverrideColors;

void LoadSunIni()
{
    IsNoCD = SunIni_GetBool("Options", "NoCD", true);
    if (SunIni_GetBool("Options", "SingleProcAffinity", true)) 
        SetSingleProcAffinity();

    VideoBackBuffer = SunIni_GetBool("Video", "VideoBackBuffer", true);
    NoWindowFrame = SunIni_GetBool("Video", "NoWindowFrame", false);
    UseGraphicsPatch = SunIni_GetBool("Video", "UseGraphicsPatch", true);
    VideoWindowed = SunIni_GetBool("Video", "Video.Windowed", false);

    if (SunIni_GetBool("Video", "DisableHighDpiScaling", false)) 
        DisableHighDpiScaling();
    if (SunIni_GetBool("Video", "DisableMaxWindowedMode", false)) 
        DisableMaxWindowedMode();
    if (OverrideColors = SunIni_GetBool("Options","OverrideColors",false))
      ApplyUserColorOverrides();
    TextBackgroundColor = SunIni_GetInt("Options","TextBackgroundColor",0);

}
