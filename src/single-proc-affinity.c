#include "macros/patch.h"
#include "TiberianSun.h"
#include <windows.h>
#include <assert.h>

typedef BOOL (WINAPI *SetProcAffinityFunction)(HANDLE, DWORD_PTR);
typedef BOOL (WINAPI *GetProcessAffinityFunction)(HANDLE, PDWORD_PTR, PDWORD_PTR);

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

void
SetMultiProcAffinity() {
  HMODULE library;
  SetProcAffinityFunction SetProcAffinityMask;
  GetProcessAffinityFunction GetProcAffinityMask;
  HANDLE CurrentProcess;

  DWORD procAffinity;
  DWORD systemAffinity;

  library = LoadLibraryA("kernel32.dll");
  if (!library)
    abort;

  SetProcAffinityMask = GetProcAddress(library, "SetProcessAffinityMask");
  if (!SetProcAffinityMask)
    return;

  GetProcAffinityMask = GetProcAddress(library, "GetProcessAffinityMask");
  if (!GetProcAffinityMask)
      return;

  CurrentProcess = GetCurrentProcess();
  if (!CurrentProcess)
    return;

  if (GetProcAffinityMask(CurrentProcess, &procAffinity, &systemAffinity))
      SetProcAffinityMask(CurrentProcess, systemAffinity);

  return;
}
