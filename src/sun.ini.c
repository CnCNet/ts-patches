#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include <windows.h>

CLEAR(0x006010B8, 0x90, 0x006010D3);
CALL(0x006010B8, _LoadSunIni);

bool OverrideColors;
bool HoverShowHealth;
bool MoveToUndeploy = true;
int32_t InfoPanel = -1;
bool SkipScoreScreen = false;
extern int32_t DoubleTapInterval;
bool AddTeamStyle2 = false;
bool AltToRally = false;
bool ForceConversionType4 = true;
bool UsingTSDDRAW = false;

void LoadSunIni()
{
    IsNoCD = SunIni_GetBool("Options", "NoCD", true);
    if (SunIni_GetBool("Options", "SingleProcAffinity", true))
        SetSingleProcAffinity();

    VideoBackBuffer = SunIni_GetBool("Video", "VideoBackBuffer", true);
    NoWindowFrame = SunIni_GetBool("Video", "NoWindowFrame", false);
    UseGraphicsPatch = SunIni_GetBool("Video", "UseGraphicsPatch", true);
    VideoWindowed = SunIni_GetBool("Video", "Video.Windowed", false);
    ScrollDelay = SunIni_GetInt("Options", "ScrollDelay", 0);
    ForceConversionType4 = SunIni_GetBool("Video", "ForceConversionType4", true);

    if (SunIni_GetBool("Video", "DisableHighDpiScaling", false))
        DisableHighDpiScaling();
    if (SunIni_GetBool("Video", "DisableMaxWindowedMode", true))
        fnDisableMaxWindowedMode();
    if (SunIni_GetBool("Win8Compat", "Enabled", false))
    {
        DWMOffForPrimaryLock =     SunIni_GetBool("Win8Compat", "DWMOffForPrimaryLock", DWMOffForPrimaryLock);
        DWMOffForPrimaryBlt =      SunIni_GetBool("Win8Compat", "DWMOffForPrimaryBlt", DWMOffForPrimaryBlt);
        ForceFullscreenSprite =    SunIni_GetBool("Win8Compat", "ForceFullscreenSprite", ForceFullscreenSprite);
        ForceBltToPrimary =        SunIni_GetBool("Win8Compat", "ForceBltToPrimary", ForceBltToPrimary);
        LockColorkey =             SunIni_GetBool("Win8Compat", "LockColorkey", LockColorkey);
        DWMOffForFullscreen =      SunIni_GetBool("Win8Compat", "DWMOffForFullscreen", DWMOffForFullscreen);
        DisableLockEmulation =     SunIni_GetBool("Win8Compat", "DisableLockEmulation", DisableLockEmulation);
        EnableOverlays =           SunIni_GetBool("Win8Compat", "EnableOverlays", EnableOverlays);
        DisableSurfaceLock =       SunIni_GetBool("Win8Compat", "DisableSurfaceLock", DisableSurfaceLock);
        RedirectPrimarySurfBlts =  SunIni_GetBool("Win8Compat", "RedirectPrimarySurfBlts", RedirectPrimarySurfBlts);
        StripMaxWindowBorder =     SunIni_GetBool("Win8Compat", "StripMaxWindowBorder", StripMaxWindowBorder);
        DisableMaxWindowedMode =   SunIni_GetBool("Win8Compat", "DisableMaxWindowedMode", DisableMaxWindowedMode);

        SetWin8CompatData();
    }

    HMODULE hDDraw = LoadLibraryA("ddraw.dll");
    bool *isDDraw = (bool *)GetProcAddress(hDDraw, "TSDDRAW");

    UsingTSDDRAW = isDDraw && *isDDraw;

    LPDWORD TargetFPS = (LPDWORD)GetProcAddress(hDDraw, "TargetFPS");
    if (TargetFPS)
    {
        *TargetFPS = SunIni_GetInt("Video", "DDrawTargetFPS", *TargetFPS);
    }

#ifndef SINGLEPLAYER

    bool *handleClose = (bool *)GetProcAddress(hDDraw, "GameHandlesClose");
    if (handleClose)
        *handleClose = true;

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
    HoverShowHealth = SunIni_GetBool("Options", "HoverShowHealth", true);
    InfoPanel = SunIni_GetInt("Options", "InfoPanel", -1);
    MoveToUndeploy = SunIni_GetBool("Options", "MoveToUndeploy", true);
    SkipScoreScreen = SunIni_GetBool("Options", "SkipScoreScreen", false);
    DoubleTapInterval = SunIni_GetInt("Options", "DoubleTapInterval", -1);
    AltToRally = SunIni_GetBool("Options", "AltToRally", false);
    AddTeamStyle2 = SunIni_GetBool("Options", "AddTeamStyle2", false);
#endif
}
