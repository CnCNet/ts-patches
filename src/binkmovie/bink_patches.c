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
	
	BinkFullscreenMovie = TRUE;
	
    BinkBreakoutAllowed = TRUE;
	
	// Play!
    BinkMovie_Play();

    if (hidden) {
        HiddenSurface->vtable->Fill(HiddenSurface, 0);
        GScreenClass__Do_Blit(1, HiddenSurface, 0);
    }
	
	// Cleanup bink movie the player.
	BinkMovie_Close();
	
	BinkFullscreenMovie = FALSE;

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


//
// Play a ingame bink movie.
//
BOOL __fastcall Play_Ingame_Movie_As_Bink(char *filename)
{
	// Load dll imports if not already loaded.
	if (!BinkImportsLoaded) {
		if (!Load_Bink_DLL()) {
			WWDebug_Printf("Play_Ingame_Movie_As_Bink failed to load DLL!\n", filename);
#ifdef BINK_REQUIRED
			MessageBoxA(MainWindow, "Unable to load BinkW32.dll!\n", "Error!", MB_OK);
			Emergency_Exit();
			exit(1);
#endif
			return FALSE;
		}
	}
	
	// Destroy any existing movie playing.
	BinkMovie_Close();

	// Create an instance of the Bink video player, drawing is
	// handled elsewhere for ingame movies.
	//BinkMovie_CreateSurface(filename, SidebarSurface);
	BinkMovie_CreateSurface(filename, PrimarySurface);
	
	if (!BinkMovie_File_Loaded()) {
		BinkMovie_Close();
		return FALSE;
	}
	
	// Fixup position.
	int radar_movie_width = 140;
	int radar_movie_height = 110;
	int xpos = ((SidebarSurface->Width-radar_movie_width)/2)+1;
	int ypos = 27;
	
	// We draw to primary now, so we need to do an absolute adjustment.
	xpos = xpos + (PrimarySurface->Width-SidebarSurface->Width);
	
	BinkMovie_SetPosition(xpos, ypos);
	
	// To make sure the video doesnt stop when the user presses the ESC key.
	BinkBreakoutAllowed = FALSE;
	
	BinkIngameMovie = TRUE;
	
	return TRUE;
}


//
// Intercept to the games Play_Ingame_Movie which checks if the Bink video file is 
// available, falling back to VQA if not.
//
void __fastcall Play_Ingame_Movie_Intercept(int vqtype)
{
	if (vqtype == -1 || vqtype >= DynamicVectorClass_Movies_ActiveCount) {
		return;
	}
	
	// Get pointer to movie name entry
	char **movie_name = (char *)((int)DynamicVectorClass_Movies_Vector + (vqtype * 4));
	
	static char filename_buffer[32];
	strncpy(filename_buffer, *movie_name, 32);
	
	// Invalid filename
    if (filename_buffer[0] == '\0') {
        WWDebug_Printf("Invalid movie filename \"%s\"!\n", filename_buffer);
        return;
    }

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
		WWDebug_Printf("Play_Ingame_Movie \"%s\" as Bink!\n", upper_filename);
		if (Play_Ingame_Movie_As_Bink(bink_buffer)) {
			CCFileClass__Destroy(&binkfile);
			CCFileClass__Destroy(&vqafile);
			return;
		}
	}

	// The movie did not exist as a .BIK, attempt to play the .VQA.
    if (vqa_available) {
        WWDebug_Printf("Play_Ingame_Movie \"%s\" as VQA!\n", upper_filename);
        Play_Ingame_Movie(vqtype);	// Call the games Play_Ingame_Movie.
		
    } else {
		WWDebug_Printf("Failed to play ingame movie \"%s\"!\n", upper_filename);
	}

	CCFileClass__Destroy(&binkfile);
	CCFileClass__Destroy(&vqafile);
}


//
// Handle the playback of a Bink movie on the sidebar radar.
//
void RadarClass_Play_Bink_Movie()
{
	static int _volume_percent = 40; // was 50
	static BOOL _playing = FALSE;
	static BOOL _volume_adjusted = FALSE;
	static int _prev_volume;
	
	if (BinkIngameMovie) {
		
		if (!_playing) {
			if (BinkFilename[0] != '\0') {
				WWDebug_Printf("RadarClass_Play_Bink_Movie(%s)!\n", BinkFilename);
			}
			_playing = TRUE;
		}
		
		// Adjust the game volume down to 50% so we can hear the radar video.
		if (!_volume_adjusted && !Is_Speaking()) {
			_prev_volume = DSAudio_Set_Volume_Percent(&DSAudio, _volume_percent);
			_volume_adjusted = TRUE;
		}
		
		BinkRadarDraw = TRUE;
		
		//WWDebug_Printf("Radar: Before BinkMovie_Advance_Frame.\n");
		
		BinkMovie_Advance_Frame();
		
		//WWDebug_Printf("Radar: After BinkMovie_Advance_Frame.\n");
		
		BinkRadarDraw = FALSE;
		
		// Has the movie finished?
		if (BinkMovie_Has_Finished()) {
						
			// Restore game volume.
			if (_volume_adjusted) {
				DSAudio_Set_Volume_All(&DSAudio, _prev_volume);
				_volume_adjusted = FALSE;
			}
			
			WWDebug_Printf("Ingame Bink movie finished!\n");
			
			BinkIngameMovie = FALSE;
			BinkBreakoutAllowed = TRUE;
			
			WWDebug_Printf("Restoring radar mode\n");
			
			RadarClass_14B4 = 5;
			RadarClass__Radar_Activate(&MouseClass_Map, RadarClass_14BC);
			
			// Cleanup bink movie the player.
			BinkMovie_Close();
			
			_playing = FALSE;
		}
	}
}


void __thiscall RadarClass_Play_Movie_Intercept(void *this)
{
	if (BinkIngameMovie) {
		RadarClass_Play_Bink_Movie();
	} else {
		//WWDebug_Printf("Before RadarClass__Play_Movie.\n");
		RadarClass__Play_Movie(this);
		//WWDebug_Printf("After RadarClass__Play_Movie.\n");
	}
}


bool Windows_Procedure_Is_Movie_Playing_Intercept()
{
	return BinkFullscreenMovie || BinkIngameMovie || Current_Movie_Ptr != NULL || IngameVQ_Count > 0;
}


void MovieClass_Update_Intercept()
{
	if (BinkFullscreenMovie) {

		//
		// Clear the surfaces, this fixes a issue were the game
		// game be seen if the window moves.
		//
		HiddenSurface->vtable->Fill(HiddenSurface, 0);
		//AlternateSurface->vtable->Fill(AlternateSurface, 0);
		//CompositeSurface->vtable->Fill(CompositeSurface, 0);
		//PrimarySurface->vtable->Fill(PrimarySurface, 0);
		
	} else if (BinkIngameMovie) {
		
		if (!BinkMovie_Has_Finished()) {
			//WWDebug_Printf("MovieClass_Update_Intercept: Before BinkMovie_Draw_Frame.\n");
			BinkMovie_Draw_Frame();
			//WWDebug_Printf("MovieClass_Update_Intercept: After BinkMovie_Draw_Frame.\n");
		} else {
			// Cleanup bink movie the player.
			BinkMovie_Close();
		}
		
	} else {
		//WWDebug_Printf("About to call MovieClass_Update.\n");
		MovieClass_Update();
	}
}


bool RadarClass_AI_Intercept()
{
	return BinkIngameMovie || IngameVQ_Count > 0;
}


void __fastcall Movie_Handle_Focus_Intercept(bool state)
{
	if (BinkFullscreenMovie || BinkIngameMovie) {
		BinkMovie_Pause(state);
	} else {
		Movie_Handle_Focus(state);
	}
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

CALL(0x0061A90B, _Play_Ingame_Movie_Intercept);
CALL(0x0061BF23, _Play_Ingame_Movie_Intercept);

CALL(0x005B8F20, _RadarClass_Play_Movie_Intercept);

CALL(0x00685CEE, _Windows_Procedure_Is_Movie_Playing_Intercept);

CALL(0x00685CF7, _MovieClass_Update_Intercept);

CALL(0x005B9144, _RadarClass_AI_Intercept);
SETBYTE(0x005B914B, 0x74); // jz

CALL(0x005DB52E, _Movie_Handle_Focus_Intercept);
LJMP(0x005DB602, _Movie_Handle_Focus_Intercept);
CALL(0x0068598F, _Movie_Handle_Focus_Intercept);
CALL(0x00685B97, _Movie_Handle_Focus_Intercept);
CALL(0x00685EA0, _Movie_Handle_Focus_Intercept);


//CLEAR(0x00602467, 0x90, 0x00602474);
CALL(0x00602474, _Bink_Library_Shutdown);
SETBYTE(0x00602479, 0x5E); // pop esi
SETBYTE(0x0060247A, 0x5B); // pop ebx
SETBYTE(0x0060247B, 0xC3); // ret
