//
// Utility functions for performing one-time loading of Bink library
// functions from the DLL.
//
// Author: CCHyper
//

#ifndef _BINK_LOAD_DLL_H_
#define _BINK_LOAD_DLL_H_

#include "bink.h"
#include <windows.h>


extern BOOL BinkImportsLoaded;

BOOL __fastcall Load_Bink_DLL();
void __fastcall Unload_Bink_DLL();


//
// Pointers to Bink DLL exports.
//
extern BINKCLOSE BinkClose;
extern BINKDDSURFACETYPE BinkDDSurfaceType;
extern BINKSETVOLUME BinkSetVolume;
extern BINKGETERROR BinkGetError;
extern BINKOPEN BinkOpen;
extern BINKSETSOUNDSYSTEM BinkSetSoundSystem;
extern BINKOPENDIRECTSOUND BinkOpenDirectSound;
extern BINKGOTO BinkGoto;
extern BINKPAUSE BinkPause;
extern BINKNEXTFRAME BinkNextFrame;
extern BINKCOPYTOBUFFER BinkCopyToBuffer;
extern BINKDOFRAME BinkDoFrame;
extern BINKWAIT BinkWait;


#endif // _BINK_LOAD_DLL_H_
