#include <windows.h>
#include "TiberianSun.h"

typedef int (__stdcall *SetAppCompatData_)(int index, int data);

void DisableMaxWindowedMode()
{
    HMODULE hModule = LoadLibraryA("ddraw.dll");
    if (hModule)
    {
        SetAppCompatData_ setAppCompatData = (SetAppCompatData_)GetProcAddress(hModule, "SetAppCompatData");
        if (setAppCompatData) 
            setAppCompatData(12, 0);
    }
}
