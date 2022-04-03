//
// Bink video player interface that uses the games drawer.
//
// Author: CCHyper
//
 
#ifndef _BINK_MOVIE_H_
#define _BINK_MOVIE_H_

#include "TiberianSun.h"
#include <windows.h>


BOOL __fastcall BinkMovie_Create(char * filename);
BOOL __fastcall BinkMovie_CreateSurface(char * filename, DSurface *surface);
void __fastcall BinkMovie_Play(void);
void __fastcall BinkMovie_Close(void);
void __fastcall BinkMovie_SetPosition(unsigned x_pos, unsigned y_pos);
void __fastcall BinkMovie_Go_To_Frame(int frame);
void __fastcall BinkMovie_Pause(BOOL pause);
BOOL __fastcall BinkMovie_Has_Finished(void);
BOOL __fastcall BinkMovie_Open(char * filename);
BOOL __fastcall BinkMovie_Next_Frame(DSurface * surface, unsigned x_pos, unsigned y_pos);
BOOL __fastcall BinkMovie_Advance_Frame(void);
void __fastcall BinkMovie_Draw_Frame(void);
void __fastcall BinkMovie_Render_Frame(DSurface * surface, unsigned x_pos, unsigned y_pos);
void __fastcall BinkMovie_Destroy(void);
BOOL __fastcall BinkMovie_ResumePause(void);
float __fastcall BinkMovie_Set_Master_Volume(float vol);
BOOL BinkMovie_File_Loaded();


//
// Flag to start playing?
//
extern BOOL BinkBreakoutAllowed;
extern BOOL BinkScaleToFit;
extern BOOL BinkFullscreenMovie;
extern BOOL BinkIngameMovie;
extern BOOL BinkRadarDraw;
extern char BinkFilename[32];

extern int BinkXPos;
extern int BinkYPos;


#endif // _BINK_MOVIE_H_
