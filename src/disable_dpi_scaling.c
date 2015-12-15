#include <windows.h>
#include "TiberianSun.h"

typedef bool (__stdcall *SetProcessDPIAware_)();

void DisableHighDpiScaling()
{
    HMODULE hModule = LoadLibraryA("User32.dll");
    if (hModule)
    {
        SetProcessDPIAware_ setProcessDPIAware = (SetProcessDPIAware_)GetProcAddress(hModule, "SetProcessDPIAware");
        if (setProcessDPIAware) 
            setProcessDPIAware();
    }
}
