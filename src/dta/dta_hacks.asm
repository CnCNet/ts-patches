%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

sstring SaveGameLoadPathWide,  "", 512
sstring SaveGameLoadPath,      "", 256

sstring str_SaveGameLoadFolder, "Saved Games\%s"
sstring str_SaveGameFolderFormat, "Saved Games\*.%3s"
sstring str_SaveGameFolderFormat2, "Saved Games\SAVE%04lX.%3s"
sstring str_SaveGamesFolder, "Saved Games"

sstring str_EnhanceINI, "ENHANCE.INI"
sstring str_MainMIX, "MAIN.MIX"
sstring str_SoundsMIX, "SOUNDS.MIX"
sstring str_DTALong, "The Dawn of the Tiberium Age"
sstring str_DTAGameWindow, "DTA (Game Window)"
sstring str_LanguageDLLNotFound, "Language.dll not found, please reinstall The Dawn of the Tiberium Age."
sstring str_SettingsINI, "Settings.ini"
sstring str_SoundsINI, "SOUNDS.INI"
sstring str_ThemeINI, "THEME.INI"
sstring str_GMenuMIX, "GMENU.MIX"
sstring str_RulesINI, "RULES.INI"
sstring str_ArtINI, "ART.INI"
sstring str_ArtEINI, "ARTE.INI"
sstring str_AIINI, "AI.INI"
sstring str_AIEINI, "AIE.INI"
sstring str_PatchMIX, "PATCH.MIX"
sstring str_PCacheMIX, "PCACHE.MIX"
sstring str_ExpandMIX, "EXPAND%02d.MIX"
sstring str_ECacheMIX, "ECACHE%02d.MIX"
sstring str_TibsunMIX, "TIBSUN.MIX"
sstring str_CacheMIX, "CACHE.MIX"
sstring str_LocalMIX, "LOCAL.MIX"
sstring str_ConquerMIX, "CONQUER.MIX"
sstring str_Sounds01MIX, "SOUNDS01.MIX"
sstring str_ScoresMIX, "SCORES.MIX"
sstring str_TutorialINI, "TUTORIAL.INI"
sstring str_Isodes, "ISODES"
sstring str_IsodesMIX, "ISODES.MIX"
sstring str_SideMIX, "SIDE%02d.MIX"
sstring str_SideCDMIX, "SIDECD%02d.MIX"
sstring str_Screenshots, "Screenshots\SCRN%04d.pcx"
sstring str_MapselINI, "MAPSEL.INI"
sstring str_MapselINI2, "MAPSEL%02d.INI"
sstring str_MenuINI, "MENU.INI"
sstring str_BriefingPCX, "BRIEFING.PCX"
sstring str_MissionINI, "MISSION.INI"
sstring str_MissionINI2, "MISSION%01d.INI"
sstring str_Scores01MIX, "SCORES01.MIX"
sstring str_BattleINI, "BATTLE.INI"
sstring str_BattleEINI, "BATTLEE.INI"
sstring str_SidencMIX, "SIDENC%02d.MIX"
sstring str_SideMIXRoot, "SIDE%02dE.MIX"
sstring str_SpeechMIX, "SPEECH%02d.MIX"
sstring str_MPMapsINI, "MPMAPS.INI"
sstring str_MoviesMIX, "MOVIES.MIX"
sstring str_DTAAlreadyRunning, "DTA is already running!"
sstring str_D1, "D1"
sstring str_D2, "D2"
sstring str_DTA, "DTA"
sstring str_DesINI, "DES"
sstring str_IsotemMIX, "ISOTEM"
sstring str_DesertMIX, "DESERT"
sstring str_TemperatMIX, "TEMPERAT"
sstring str_Des, "DES"

sstring str_IsotemPAL, "ISOTEM.PAL"
sstring str_IsodesPAL, "ISODES.PAL"
sstring str_UnittemPAL, "UNITTEM.PAL"
sstring str_UnitdesPAL, "UNITDES.PAL"
sstring str_DesertPAL, "DESERT.PAL"
sstring str_TemperatPAL, "TEMPERAT.PAL"

@SET 0x006CA930, {db "DESERT",0,0,0,0}
@SET 0x006CA940, {db "DES",0,0,0}
@SET 0x006CA94A, {db "ISODES",0}
@SET 0x006CA954, {db "DES",0}
@SET 0x006CA958, {db "TEMPERATE", 0,0,0,0}
@SET 0x006CA968, {db "TEM", 0,0,0}
@SET 0x006CA972, {db "ISOTEM", 0}
@SET 0x006CA97C, {db "TEM", 0}

; String references
@SET 0x00407081, push str_EnhanceINI ; push offset str_EnhanceINI?
@SET 0x0044EAF5, push str_MainMIX
@SET 0x0044EBF3, push str_SoundsMIX
@SET 0x00472567, push str_DTALong
@SET 0x0047256C, push str_LanguageDLLNotFound
@SET 0x004E0605, push str_SettingsINI
@SET 0x004E0912, push str_SoundsINI
@SET 0x004E0919, push str_SoundsINI
@SET 0x004E09DC, push str_ThemeINI
@SET 0x004E0A97, push str_GMenuMIX
@SET 0x004E0F33, push str_RulesINI
@SET 0x004E1048, push str_RulesINI
@SET 0x004E111B, push str_ArtINI
@SET 0x004E1196, push str_ArtEINI
@SET 0x004E11E6, push str_EnhanceINI
@SET 0x004E1513, push str_AIINI
@SET 0x004E1547, push str_AIEINI
@SET 0x004E3D3E, push str_PatchMIX
@SET 0x004E3D7C, push str_PatchMIX
@SET 0x004E3DE7, push str_PatchMIX
@SET 0x004E3DF9, push str_PCacheMIX
@SET 0x004E3E4E, push str_PCacheMIX
@SET 0x004E3E71, push str_PCacheMIX
@SET 0x004E3E97, push str_ExpandMIX
@SET 0x004E3F81, push str_ECacheMIX
@SET 0x004E402B, push str_TibsunMIX
@SET 0x004E4078, push str_CacheMIX
@SET 0x004E40BA, push str_LocalMIX
@SET 0x004E40FB, push str_LocalMIX
@SET 0x004E412A, push str_ConquerMIX
@SET 0x004E4187, push str_ConquerMIX
@SET 0x004E430F, push str_SoundsMIX ; Sounds01.MIX?
@SET 0x004E4360, push str_SoundsMIX ; Sounds01.MIX?
@SET 0x004E439C, push str_SoundsMIX
@SET 0x004E43ED, push str_SoundsMIX
@SET 0x004E4429, push str_ScoresMIX
@SET 0x004E447A, push str_ScoresMIX
@SET 0x004E467E, push str_TutorialINI
@SET 0x004E80D8, push str_SideMIX
@SET 0x004E8377, push str_SideCDMIX
@SET 0x004E8391, push str_SideCDMIX
@SET 0x004EAC41, push str_Screenshots
@SET 0x0056E226, push str_MapselINI2
@SET 0x0056E23E, push str_MapselINI
@SET 0x0057FBEB, push str_GMenuMIX
@SET 0x0057FC52, push str_GMenuMIX
@SET 0x005801BB, push str_MenuINI
@SET 0x0058A146, push str_SettingsINI
@SET 0x005C04AF, {mov ecx, str_BriefingPCX}
@SET 0x005C094A, push str_MissionINI2
@SET 0x005C0962, push str_MissionINI
@SET 0x005C6447, push str_ArtINI
@SET 0x005C649C, push str_ArtEINI
@SET 0x005D1B26, push str_ArtEINI
@SET 0x005DDCEB, push str_MissionINI2
@SET 0x005D1C25, push str_ArtINI
@SET 0x005D6D45, push str_ArtEINI
@SET 0x005ED7F3, push str_SettingsINI
@SET 0x005EE47B, push str_SettingsINI
@SET 0x005FF2C0, {cmp edx, str_DTALong}
@SET 0x005FF2C8, push str_DTALong
@SET 0x005FF2D9, push str_DTALong
@SET 0x005FF3AA, {cmp ecx, str_DTALong}
@SET 0x005FF3B2, push str_DTALong
@SET 0x005FF3C3, push str_DTALong
@SET 0x005FF4EC, push str_DTALong
@SET 0x00601093, push str_SettingsINI
@SET 0x005EE8B0, push str_MPMapsINI
@SET 0x005EEB82, push str_MPMapsINI
@SET 0x0044ECC5, push str_MoviesMIX
@SET 0x004E4543, push str_MoviesMIX
@SET 0x004E862B, push str_SpeechMIX
@SET 0x004E0CD4, push str_BattleINI
@SET 0x004E0D53, push str_BattleINI
@SET 0x004E0DD8, push str_BattleEINI
@SET 0x0044EB2B, push str_Scores01MIX
@SET 0x0044EC94, push str_Scores01MIX
@SET 0x004E44B6, push str_Scores01MIX
@SET 0x004E4507, push str_Scores01MIX

;;; The game will never start with these - dkeeton
@SET 0x006861ED, {mov dword [esp+48h], str_DTALong} ; dword ptr
@SET 0x00686215, push str_DTALong
@SET 0x0068621A, push str_DTALong
@SET 0x006862BD, push str_DTALong
@SET 0x006862C2, push str_DTALong
@SET 0x00687E07, push str_SettingsINI

; Remove need for MAPS%02d.MIX
@SET 0x0044EB1E, push str_CacheMIX
@SET 0x004E41D0, push str_CacheMIX



; Palette renames
; UNITSNO.PAL -> UNITTEM.PAL
@SET 0x004DFD65, {mov ecx, str_UnittemPAL}
@SET 0x004E015C, {mov ecx, str_UnittemPAL}
@SET 0x004E7D83, {mov ecx, str_UnittemPAL}
; UNITTEM.PAL -> UNITDES.PAL
@SET 0x004E7D8A, {mov ecx, str_UnitdesPAL}
; TEMPERAT.PAL -> DESERT.PAL
@SET 0x004DFDDF, {mov ecx, str_DesertPAL}

; Set default tech level to 7
@SET 0x006FB628, dd 7
;

;; Trackbar Border Color change
@SET 0x0059138B, {db 0xA0, 0xA7, 0xA0}

;; Hack to make tiberium get affected by lighting (at the cost of remappability)
@NJNB 0x004557FF, 0x004559AE ;jnb loc_4559AE
;
;; Don't add random extra cash to the money crate value specified in Rules.ini
@CLEAR 0x0045839D, 0x90, 0x004583A3
@SET 0x0045839D, {lea edx, [eax]}
;
;; Units in Area Guard mode will revert to regular Guard mode when you press S
@SJMP 0x00494AB5, 0x00494AE3 ; jmp short loc_494AE3

; # Units in Guard mode will no longer chase after enemies that move out of firing range
; 000A1AA8: 75 90
; 000A1AA9: 2C 90
; Already included in guard_mode_patch.asm?

; Disable check for MoviesXX.mix, forces function to return al=1
@SET 0x004E45D8, {mov al, 1}
@SET 0x004E45DA, nop
; Included in no_movie_and_score_mix_dependency.asm

; Disable check for MULTI.MIX, force function to return al=1
@SJMP 0x004E42EE, 0x004E42FD ; jmp short loc_4E42FD

; Remove framework mode mmt/mms loading
@LJMP 0x004F5182, 0x004F528C    ; jmp loc_4F528C
;
; TechLevel slider limit
@SET 0x0055AF05, push 70001h
@SET 0x0055E110, push 70001h

;; "Some change in code calling to SendDlgItemMessageA" - techlevel slider limit??
@SET 0x0057C932, push 70001h
;
;; Sidebar text off by default
@SET 0x00589972, {mov [eax+19h], cl}
@SET 0x00589975, {mov [eax+1Ah], cl}
;
;; IsScoreShuffle on by default
@SET 0x005899F1, {mov byte [eax+35h], 1} ;byte ptr
@SET 0x005899F5, nop
@SET 0x005899F6, nop
@SET 0x005899F7, nop
;
;; Disable dialog "slide-open" sound effect
@SJMP 0x00593DBF, 0x00593DF9 ; jmp short loc_593DF9
;
;; Remove glowing edges from dialogs
@SET 0x0059D410, retn 0Ch

;; Skip useless debug logging code
; *******BREAKS THE SPAWNER
;; @SET 0x005FF81C, jmp 0x005FFC41

; "Overlay tiberium fix thing, 4th etc"
@SET 0x00644DF9, {mov dword [esi+0ACh], 0Ch} ;dword ptr
;
;; "Facings stuff"
@SET 0x006530EB, {cmp dword [eax+4CCh], 20h} ;dword ptr
@SET 0x00653106, {shr ebx, 0Ah}
@SET 0x0065310D, {and ebx, 1Fh}

;; IsCoreDefender selection box size
@SET 0x0065BD7E, {mov edx, 200h}
@SET 0x0065BD94, {mov dword [edi+8], 64h} ;dword ptr
@SET 0x0065BD9B, nop
@SET 0x0065BD9C, nop
;
;; Rules.ini key, WalkFrames= default value
@SET 0x0065B9E6, {mov byte [esi+4D0h], 1} ;byte ptr
@SET 0x0065BF3D, {mov [esi+21h], eax}

; Set global variable byte containing side ID to load files for
@SET 0x004E2CFA, {mov byte [0x7E2500], al}
@SET 0x004E2CFF, nop
@SET 0x004E2D00, {add esp, 4}
@SJMP 0x004E2D03, 0x004E2D13 ; jmp short
@SET 0x004E2D05, nop

; Disable check for Scores.mix 
; (music will still be read, but the game won't crash if the MIX file isn't found)
@SJMP 0x004E44A5, 0x004E44B6 ; jmp short
; Included in no_movie_and_score_mix_dependency.asm

; Load sidebar MIX files for new sides properly (for saved games)
@SET 0x005D6C4F, {mov cl, [eax+1D91h]}
@CLEAR 0x005D6C55, 0x90, 0x005D6C58

; Load speech MIX files for new sides properly (for saved games)
@SJMP 0x005D6DB8, 0x005D6DCE     ;jmp short

@SET 0x005D6DCE, {xor ecx, ecx}
@SET 0x005D6DD0, {mov cl, [eax+1D91h]}
@CLEAR 0x005D6DD6, 0x90, 0x005D6DDB

; Load sidebar MIX files for new sides properly
@SET 0x005DD798, {mov cl, byte [0x007E2500]}
@CLEAR 0x005DD79E, 0x90, 0x005DD7A2

; Load speech MIX files for new sides properly
@SET 0x005DD822, {xor ecx, ecx}
@CLEAR 0x005DD822, 0x90, 0x005DD828
@SET 0x005DD82B, {mov cl, byte [0x007E2500]} ; Compile warning: byte value exceeds bounds?

; AI starting units will start in Unload mode instead of Area Guard mode (was 05 for Guard mode)
@SET 0x005DEE36, push 0Fh

; Prevent more than 75 cameos from appearing in a sidebar column and thus crashing the game
;; @SJGE 0x005F463B, 0x005F46A1    ;jge short loc_5F46A1

; Remove Ion Storm special effects: flight denial, immobile hover units, disabled radar,
; IonSensitive weapons
@SET 0x0040E115, {mov eax, 0}
@SET 0x0040E4BB, {mov eax, 0}
@SET 0x0042C6AC, {mov eax, 0}
@SET 0x0042C8F8, {mov eax, 0}
@SET 0x004322D1, {mov eax, 0}
@SET 0x004324B1, {mov eax, 0}
@SET 0x004A2CAC, {mov eax, 0}
@SET 0x004A88FC, {mov eax, 0}
@SET 0x004A893A, {mov eax, 0}
@SET 0x004C9580, {mov eax, 0} ; Remove disabled radar
@SET 0x004CF698, {mov eax, 0}
@SET 0x004D9B83, {mov eax, 0}
@SET 0x004EC95D, {mov ecx, 0}
@SET 0x004EC962, nop
@SET 0x004ECC80, {mov eax, 0}
@SET 0x004F96D6, {mov eax, 0}
@SET 0x004F9771, {mov eax, 0}
@SET 0x0062FA96, {mov eax, 0} ; Remove IonSensitive effect
@SET 0x0065834E, {mov eax, 0}

; Auto-target units of houses with MultiplayerPassive=yes
;; @CLEAR 0x0062D4B2, 0x90, 0x0062D4BA

;;@LJMP 0x00505A20, _Delete_Save_Game_Game_Folder_Format_String_Change
hack 0x00505A20
_Delete_Save_Game_Game_Folder_Format_String_Change:
    pushad

    mov     eax, [esp+4]

    push    eax
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c

    popad
    mov     eax, SaveGameLoadPath
    push    eax
    jmp     hackend

;@LJMP 0x005D4FFD, _Save_Game_Save_Game_Folder_Format_String_Change1
hack 0x005D4FFD
_Save_Game_Save_Game_Folder_Format_String_Change1:
    lea     eax, [esp+0x2C]

    pushad

    push    str_SaveGamesFolder
    push    esi
    call    stristr_
    add     esp, 8

    cmp     eax, 0
    jnz     .No_Change

    push    esi
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c

    popad

    mov     esi, SaveGameLoadPath
    xor     edi, edi
    jmp     0x005D5003

.No_Change:
    popad
    xor     edi, edi
    jmp     0x005D5003

@SET 0x00504FFB, {push str_SaveGameFolderFormat2}

@SET 0x0050528E, {push str_SaveGameFolderFormat2}

hack 0x005D693C, 0x005D6942
_Load_Game_Save_Game_Folder_Format_String_Change1:
    lea     eax, [esp+0x24]

    pushad

    push    esi
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPathWide
    call    [0x006CA464] ; WsSprintfA
    add     esp, 0x0c

    popad

    mov     esi, SaveGameLoadPathWide
    push    0x40
    jmp     hackend

@SET 0x00505859, {push str_SaveGameFolderFormat}

@SET 0x00505503, {push str_SaveGameFolderFormat}

hack 0x005D7E96
_Read_SaveFile_Binary_Hack_Save_Games_Sub_Directory:
    push    esi

    pushad

    push    ecx
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c

    popad

    mov     ecx, SaveGameLoadPath


    lea     eax, [esp+8]
    jmp     0x005D7E9B
