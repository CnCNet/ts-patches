//
// Utility functions for performing one-time loading of Bink library
// functions from the DLL.
//
// The prototypes used assume you are using the version shipped
// with Red Alert 2 or Renegade (roughly 1.0). If you have either of
// these games installed you can copied it from there. We do not
// distrubute or link to any version of the BinkSDK or DLL.
//
// Author: CCHyper
//

#include "TiberianSun.h"
#include "bink_load_dll.h"


BOOL BinkImportsLoaded = FALSE;

static HMODULE BinkDLL = NULL;

BINKCLOSE BinkClose = NULL;
BINKDDSURFACETYPE BinkDDSurfaceType = NULL;
BINKSETVOLUME BinkSetVolume = NULL;
BINKGETERROR BinkGetError = NULL;
BINKOPEN BinkOpen = NULL;
BINKSETSOUNDSYSTEM BinkSetSoundSystem = NULL;
BINKOPENDIRECTSOUND BinkOpenDirectSound = NULL;
BINKGOTO BinkGoto = NULL;
BINKPAUSE BinkPause = NULL;
BINKNEXTFRAME BinkNextFrame = NULL;
BINKCOPYTOBUFFER BinkCopyToBuffer = NULL;
BINKDOFRAME BinkDoFrame = NULL;
BINKWAIT BinkWait = NULL;


BOOL __fastcall Load_Bink_DLL()
{
	// We already performed a sucessful one-time init, return TRUE.
	if (BinkImportsLoaded) {
		return TRUE;
	}
	
	WWDebug_Printf("Load_Bink_DLL()\n");

	// Look for Bink DLL.
	if (BinkDLL == NULL && GetFileAttributesA("binkw32.dll") != INVALID_FILE_ATTRIBUTES) {
		BinkDLL = LoadLibraryA("binkw32.dll");
	}
	
	if (BinkDLL == NULL) {
		WWDebug_Printf("LoadLibraryA() failed with %d.\n", GetLastError());
		BinkImportsLoaded = FALSE;
		return FALSE;
	}

	BinkClose = (BINKCLOSE)GetProcAddress(BinkDLL, "_BinkClose@4");
	if (!BinkClose) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkClose", GetLastError());
		return FALSE;
	}

	BinkDDSurfaceType = (BINKDDSURFACETYPE)GetProcAddress(BinkDLL, "_BinkDDSurfaceType@4");
	if (!BinkDDSurfaceType) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkDDSurfaceType", GetLastError());
		return FALSE;
	}

	BinkSetVolume = (BINKSETVOLUME)GetProcAddress(BinkDLL, "_BinkSetVolume@8");
	if (!BinkSetVolume) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkSetVolume", GetLastError());
		return FALSE;
	}

	BinkGetError = (BINKGETERROR)GetProcAddress(BinkDLL, "_BinkGetError@0");
	if (!BinkGetError) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkGetError", GetLastError());
		return FALSE;
	}

	BinkOpen = (BINKOPEN)GetProcAddress(BinkDLL, "_BinkOpen@8");
	if (!BinkOpen) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "_BinkOpen@8", GetLastError());
		return FALSE;
	}

	BinkSetSoundSystem = (BINKSETSOUNDSYSTEM)GetProcAddress(BinkDLL, "_BinkSetSoundSystem@8");
	if (!BinkSetSoundSystem) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkSetSoundSystem", GetLastError());
		return FALSE;
	}

	BinkOpenDirectSound = (BINKOPENDIRECTSOUND)GetProcAddress(BinkDLL, "_BinkOpenDirectSound@4");
	if (!BinkOpenDirectSound) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkOpenDirectSound", GetLastError());
		return FALSE;
	}

	BinkGoto = (BINKGOTO)GetProcAddress(BinkDLL, "_BinkGoto@12");
	if (!BinkGoto) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkGoto", GetLastError());
		return FALSE;
	}

	BinkPause = (BINKPAUSE)GetProcAddress(BinkDLL, "_BinkPause@8");
	if (!BinkPause) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkPause", GetLastError());
		return FALSE;
	}

	BinkNextFrame = (BINKNEXTFRAME)GetProcAddress(BinkDLL, "_BinkNextFrame@4");
	if (!BinkNextFrame) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkNextFrame", GetLastError());
		return FALSE;
	}

	BinkCopyToBuffer = (BINKCOPYTOBUFFER)GetProcAddress(BinkDLL, "_BinkCopyToBuffer@28");
	if (!BinkCopyToBuffer) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkCopyToBuffer", GetLastError());
		return FALSE;
	}

	BinkDoFrame = (BINKDOFRAME)GetProcAddress(BinkDLL, "_BinkDoFrame@4");
	if (!BinkDoFrame) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkDoFrame", GetLastError());
		return FALSE;
	}

	BinkWait = (BINKWAIT)GetProcAddress(BinkDLL, "_BinkWait@4");
	if (!BinkWait) {
		WWDebug_Printf("GetProcAddress failed to load %s (error: %d).\n", "BinkWait", GetLastError());
		return FALSE;
	}
	
	BinkImportsLoaded = TRUE;
	return TRUE;
}

void __fastcall Unload_Bink_DLL()
{
	FreeLibrary(BinkDLL);
	
	BinkClose = NULL;
	BinkDDSurfaceType = NULL;
	BinkSetVolume = NULL;
	BinkGetError = NULL;
	BinkOpen = NULL;
	BinkSetSoundSystem = NULL;
	BinkOpenDirectSound = NULL;
	BinkGoto = NULL;
	BinkPause = NULL;
	BinkNextFrame = NULL;
	BinkCopyToBuffer = NULL;
	BinkDoFrame = NULL;
	BinkWait = NULL;
	
	BinkImportsLoaded = FALSE;
}
