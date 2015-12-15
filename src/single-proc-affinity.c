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

  library = LoadLibraryA("kernel32.dll");
  if (!library)
    abort;

  SetProcAffinityMask = GetProcAddress(library, "SetProcessAffinityMask");
  if (!SetProcAffinityMask)
    return;

  CurrentProcess = GetCurrentProcess();
  if (!CurrentProcess)
    return;

  if (!SetProcAffinityMask(CurrentProcess,1))
    return;
  return;
}

