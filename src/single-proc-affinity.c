#include "macros/patch.h"
#include "TiberianSun.h"
#include <windows.h>
#include <assert.h>

typedef BOOL (WINAPI *SetProcAffinityFunction)(HANDLE, DWORD_PTR);

void
SetSingleProcAffinity() {
  HMODULE library;
  SetProcAffinityFunction SetProcAffinityMask;
  HANDLE CurrentProcess;

  library = (*_imp__LoadLibraryA)("kernel32.dll");
  if (!library)
    abort;

  SetProcAffinityMask = (*_imp__GetProcAddress)(library, "SetProcessAffinityMask");
  if (!SetProcAffinityMask)
    return;

  CurrentProcess = (*_imp__GetCurrentProcess)();
  if (!CurrentProcess)
    return;

  if (!SetProcAffinityMask(CurrentProcess,1))
    return;
  return;
}

