#define _UNICODE
#define UNICODE

#include <windows.h>
//#include "TiberianSun.h"


struct LinkedMem {
  UINT32        uiVersion;
  DWORD         uiTick;
  float         fAvatarPosition[3];
  float         fAvatarFront[3];
  float         fAvatarTop[3];
  wchar_t       name[256];
  float         fCameraPosition[3];
  float         fCameraFront[3];
  float         fCameraTop[3];
  wchar_t       identity[256];
  UINT32	context_len;
  unsigned char context[256];
  wchar_t       description[2048];
};

bool IntegrateMumbleSpawn;
bool IntegrateMumbleSun;
LinkedMem *lm = NULL;

extern "C" void WWDebug_Printf(const char *f, ...);
extern "C" void initMumble();
extern "C" void updateMumble();
extern "C" wchar_t TeamName[128];

typedef void *(__stdcall *OpenFileMappingWFunc)(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCTSTR lpName);
typedef void *(__stdcall *MapViewOfFileFunc)(HANDLE hFileMapingObject, DWORD dwDesiredAccess, DWORD dwFileOffsetHigh,
                                             DWORD dwFileOffsetLow, SIZE_T dwNumberOfBytesToMap);
void
initMumble() {

  HMODULE hModule = LoadLibraryA("Kernel32.dll");
  if (!hModule)
    return;

  OpenFileMappingWFunc openFileMappingW = (OpenFileMappingWFunc) GetProcAddress(hModule, "OpenFileMappingW");
  MapViewOfFileFunc mapViewOfFile = (MapViewOfFileFunc) GetProcAddress(hModule, "MapViewOfFile");

  HANDLE hMapObject = openFileMappingW(FILE_MAP_ALL_ACCESS, FALSE, L"MumbleLink");
  if (hMapObject == NULL) {
    WWDebug_Printf("Mumble Not Found\n");
    return;
  }

  lm = (LinkedMem *) mapViewOfFile(hMapObject, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(LinkedMem));
  if (lm == NULL) {
    CloseHandle(hMapObject);
    hMapObject = NULL;
    WWDebug_Printf("Mumble Not Found\n");
    return;
  }
  WWDebug_Printf("Mumble Found and shmem open\n");

  if(lm->uiVersion != 2) {
    wcsncpy(lm->name, L"Source engine:CnCTS", 256);
    wcsncpy(lm->description, L"CnCNet Tiberian Sun Game", 2048);
    lm->uiVersion = 2;
  }
}


void
updateMumble() {
  if (! lm)
    return;

  lm->uiTick++;

  wcsncpy(lm->identity, TeamName, 128);
  memcpy(lm->context, "[Tiberian Sun]",14);
  lm->context_len = 14;
}
