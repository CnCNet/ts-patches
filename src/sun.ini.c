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

#ifndef SINGLEPLAYER
    if (OverrideColors = SunIni_GetBool("Options","OverrideColors",false))
      ApplyUserColorOverrides();
    TextBackgroundColor = SunIni_GetInt("Options","TextBackgroundColor",0);

    DisableEdgeScrolling = SunIni_GetBool("Options","DisableEdgeScrolling",false);
    MultiplayerDebug = SunIni_GetBool("Options","MultiplayerDebug",false);
    IntegrateMumbleSun = SunIni_GetBool("Options", "IntegrateMumble", false);

    if (SunIni_GetBool("Options", "DisableAltTab", false)) {
      WWDebug_Printf("Disabling Alt+Tab\n");
      LoadKeyboardHook();
    }
    DragDistance = SunIni_GetInt("Options", "DragDistance", 4);

    MouseAlwaysInFocus =     SunIni_GetBool("Options", "MouseAlwaysInFocus", false);

#endif
}
