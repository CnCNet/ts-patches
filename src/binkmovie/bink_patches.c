//
// Collection of patches that enable Bink movie support.
//
// Author: CCHyper
//
// NOTE: If you wish to make the Bink video playback interface
//       exit on failure to play or find the the .BIK, the compile
//       the project with "BINK_REQUIRED".
//
// WARNING: This playback interface assumes the user is playing at
//          least 800x600, otherwise it will fail gracefully.
//

#include "macros/patch.h"
#include "TiberianSun.h"
#include <stdio.h>

#include "bink_load_dll.h"
#include "binkmovie.h"


//
// Play a bink movie.
//
BOOL __fastcall Play_Movie_As_Bink(char *filename, int theme, bool a3, bool stretch, bool hidden)
{
    WWKeyboardClass__Clear(WWKeyboard);
    WWMouseClass__Hide_Mouse(WWMouse);
	
	// Load dll imports if not already loaded.
	if (!BinkImportsLoaded) {
		if (!Load_Bink_DLL()) {
			WWDebug_Printf("Play_Movie_As_Bink failed to load DLL!\n", filename);
#ifdef BINK_REQUIRED
			ShowCursor(TRUE);
			MessageBoxA(MainWindow, "Unable to load BinkW32.dll!\n", "Error!", MB_ICONWARNING|MB_OK);
			Emergency_Exit();
			exit(1);
#endif
			return FALSE;
		}
	}

	// Only play fullscreen movies in campaign/singleplayer
    if (SessionType.GameSession != GAME_CAMPAIGN) {
        return FALSE;
    }

    if (hidden) {
        HiddenSurface->vtable->Fill(HiddenSurface, 0);
        GScreenClass__Do_Blit(1, HiddenSurface, 0);
    }

	// Prepare the bink movie player.
	
	if (!BinkMovie_Create(filename)) {
		return FALSE;
	}
	
    BinkBreakoutAllowed = TRUE;
	
	// Play!
    BinkMovie_Play();

    if (hidden) {
        HiddenSurface->vtable->Fill(HiddenSurface, 0);
        GScreenClass__Do_Blit(1, HiddenSurface, 0);
    }
	
	// Cleanup bink movie the player.
	BinkMovie_Close();

    WWMouseClass__Show_Mouse(WWMouse);
    GScreenClass__Flag_To_Redraw(&MouseClass_Map, 2);
    WWKeyboardClass__Clear(WWKeyboard);
	
	return TRUE;
}

//
// Intercept to the games Play_Movie which checks if the Bink video file is 
// available, falling back to VQA if not.
//
void __fastcall Play_Movie_Intercept(char *filename, int theme, bool a3, bool stretch, bool hidden)
{
	static char filename_buffer[32];
	strncpy(filename_buffer, filename, 32);
	
	// Find the location of the file extension indentifier.
    char *movie_name = strchr((char *)filename_buffer, '.');
	
	// Unexpected filename format passed in.
    if (!movie_name) {
        WWDebug_Printf("Invalid movie filename \"%s\"!\n", filename_buffer);
        return;
    }

	// Insert a null-char where the "." was. This will give us the actual
	// movie name without the extension, allowing us to rebuild them.
    *movie_name = '\0';

    char *upper_filename = strupr((char *)filename_buffer);

    char bink_buffer[32-4];
    sprintf(bink_buffer, "%s.BIK", upper_filename);
	
    char vqa_buffer[32-4];
    sprintf(vqa_buffer, "%s.VQA", upper_filename);
	
    CCFileClass binkfile;
    CCFileClass vqafile;
	
	CCFileClass__CCFileClass(&binkfile, bink_buffer);
	CCFileClass__CCFileClass(&vqafile, vqa_buffer);
	
	BOOL bink_available = CCFileClass__Is_Available(&binkfile, FALSE);
	BOOL vqa_available = CCFileClass__Is_Available(&vqafile, FALSE);
	
	// If the movie exists as a .BIK, if so, play as Bink!
	if (bink_available) {
		WWDebug_Printf("Play_Movie \"%s\" as Bink!\n", upper_filename);
		if (Play_Movie_As_Bink(bink_buffer, theme, a3, stretch, hidden)) {
			CCFileClass__Destroy(&binkfile);
			CCFileClass__Destroy(&vqafile);
			return;
		}
	}
		
	// The movie did not exist as a .BIK or failed to play, attempt to play the .VQA.
    if (vqa_available) {
        WWDebug_Printf("Play_Movie \"%s\" as VQA!\n", upper_filename);
        Play_Movie(vqa_buffer, theme, a3, stretch, hidden);	// Call the game Play_Movie.
		
    } else {
		WWDebug_Printf("Failed to play movie \"%s\"!\n", upper_filename);
	}
		
	CCFileClass__Destroy(&binkfile);
	CCFileClass__Destroy(&vqafile);
}


void Bink_Library_Shutdown()
{
	// Cleanup dll imports.
	if (BinkImportsLoaded) {
		Unload_Bink_DLL();
	}
}


//
// Hook in our intercepts.
//
CALL(0x004E07AD, _Play_Movie_Intercept);
CALL(0x004E07CC, _Play_Movie_Intercept);
CALL(0x004E0840, _Play_Movie_Intercept);
CALL(0x004E2865, _Play_Movie_Intercept);
CALL(0x004E287F, _Play_Movie_Intercept);
CALL(0x00563A1C, _Play_Movie_Intercept);
CALL(0x0057FEDA, _Play_Movie_Intercept);
CALL(0x0057FF3F, _Play_Movie_Intercept);
CALL(0x005DB314, _Play_Movie_Intercept);
CALL(0x005E35C8, _Play_Movie_Intercept);

//CLEAR(0x00602467, 0x90, 0x00602474);
CALL(0x00602474, _Bink_Library_Shutdown);
SETBYTE(0x00602479, 0x5E); // pop esi
SETBYTE(0x0060247A, 0x5B); // pop ebx
SETBYTE(0x0060247B, 0xC3); // ret
