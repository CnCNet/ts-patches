%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Set default tech level to 7
@SET 0x006FB628, dd 7

;; Trackbar Border Color change
@SET 0x0059138B, {db 0xA0, 0xA7, 0xA0}

;; Hack to make tiberium get affected by lighting (at the cost of remappability)
@NJNB 0x004557FF, 0x004559AE ;jnb loc_4559AE

;; Don't add random extra cash to the money crate value specified in Rules.ini
@CLEAR 0x0045839D, 0x90, 0x004583A3
@SET 0x0045839D, {lea edx, [eax]}

; TechLevel slider limit
@SET 0x0055AF05, push 70001h
@SET 0x0055E110, push 70001h

;; "Some change in code calling to SendDlgItemMessageA" - techlevel slider limit??
@SET 0x0057C932, push 70001h

;; Sidebar text off by default
@SET 0x00589972, {mov [eax+19h], cl}
@SET 0x00589975, {mov [eax+1Ah], cl}

;; Disable dialog "slide-open" sound effect
@SJMP 0x00593DBF, 0x00593DF9 ; jmp short loc_593DF9

;; Remove glowing edges from dialogs
@SET 0x0059D410, retn 0Ch

; "Overlay tiberium fix thing, 4th etc"
@SET 0x00644DF9, {mov dword [esi+0ACh], 0Ch} ;dword ptr

;; IsCoreDefender selection box size
@SET 0x0065BD7E, {mov edx, 200h}
@SET 0x0065BD94, {mov dword [edi+8], 64h} ;dword ptr
@SET 0x0065BD9B, nop
@SET 0x0065BD9C, nop

;; Rules.ini key, WalkFrames= default value
@SET 0x0065B9E6, {mov byte [esi+4D0h], 1} ;byte ptr
@SET 0x0065BF3D, {mov [esi+21h], eax}

; AI starting units will start in Unload mode instead of Area Guard mode (was 05 for Guard mode)
@SET 0x005DEE36, push 0Fh

; Prevent more than 75 cameos from appearing in a sidebar column and thus crashing the game
;; @SJGE 0x005F463B, 0x005F46A1    ;jge short loc_5F46A1

; Reduce minimum scatter radius of clusters to 0.5 cells
@SET 0x004465DA, {db 0x7F}
@SET 0x004465DB, {db 0x00}

; Reduce maximum scatter radius of clusters to 1.4 cells
@SET 0x004465D5, {db 0x7F}
@SET 0x004465D6, {db 0x00}

; Increase max number of bounces for bouncy projectiles from 3 to 127
@SET 0x00445514, {cmp eax, 127}

; Change subterranean pitch-up speed to different value from pitch-down speed
@SET 0x0064C8CD, {db 0xA0}
@SET 0x0064C8CE, {db 0x8A}
@SET 0x0064C8CF, {db 0x6D}

; Decrease subterranean pitch speed before digging down
@SET 0x006D8A96, {db 0xB6}

; Decrease subterranean pitch speed after digging up
@SET 0x006D8AA6, {db 0x90}

; Increase subterranean movement speed
@SET 0x006D8A9E, {db 0x40}

; Skip setting CD when loading multiplayer scenario
@SJMP 0x005DB25E, 0x005DB288

sstring str_SettingsINI, "Settings.ini"
sstring str_EnhanceINI, "ENHANCE.INI"
sstring str_ArtEINI, "ARTE.INI"
sstring str_AIEINI, "AIE.INI"
sstring str_BriefingPCX, "BRIEFING.PCX"

; String references
@SET 0x00407081, push str_EnhanceINI ; push offset str_EnhanceINI?
@SET 0x004E0605, push str_SettingsINI
@SET 0x004E1196, push str_ArtEINI
@SET 0x004E11E6, push str_EnhanceINI
@SET 0x004E1547, push str_AIEINI
@SET 0x0058A146, push str_SettingsINI
@SET 0x005C04AF, {mov ecx, str_BriefingPCX}
@SET 0x005C649C, push str_ArtEINI
@SET 0x005D1B26, push str_ArtEINI
@SET 0x005D6D45, push str_ArtEINI
@SET 0x005ED7F3, push str_SettingsINI
@SET 0x005EE47B, push str_SettingsINI
@SET 0x00601093, push str_SettingsINI
@SET 0x00687E07, push str_SettingsINI

; Set global variable byte containing side ID to load files for
; (enabled until spawner has been reimplemented through Vinifera)
@SET 0x004E2CFA, {mov byte [0x7E2500], al}
@SET 0x004E2CFF, nop
@SET 0x004E2D00, {add esp, 4}
@SJMP 0x004E2D03, 0x004E2D13 ; jmp short
@SET 0x004E2D05, nop

; Load sidebar MIX files for new sides properly
; (enabled until spawner has been reimplemented through Vinifera)
@SET 0x005DD798, {mov cl, byte [0x007E2500]}
@CLEAR 0x005DD79E, 0x90, 0x005DD7A2

; Load speech MIX files for new sides properly
; Defaults SpeechSide to our hijacked player side value
; (enabled until spawner has been reimplemented through Vinifera)
hack 0x005DD75B
    mov  eax, [Scen]
    xor  ecx, ecx
    mov  cl, byte [0x007E2500] ; PlayerSide (was Session.IsGDI)
    mov  [eax+0x1E44], ecx ; set SpeechSide
    jmp  0x005DD784        ; go back to game code for initializing side

;
; The following patches will not be included in Vinifera compatible builds.
;
%ifndef VINIFERA

sstring str_SoundsMIX, "SOUNDS.MIX"
sstring str_DTALong, "Dawn of the Tiberium Age"
sstring str_DTAGameWindow, "DTA (Game Window)"
sstring str_LanguageDLLNotFound, "Language.dll not found, please start DTA.exe and click Save in the Options menu."
;sstring str_SoundsINI, "SOUNDS.INI"
sstring str_CacheMIX, "CACHE.MIX"
sstring str_Sounds01MIX, "SOUNDS01.MIX"
sstring str_Isodes, "ISODES"
sstring str_IsodesMIX, "ISODES.MIX"
;sstring str_SideMIX, "SIDE%02d.MIX"
sstring str_SideCDMIX, "SIDECD%02d.MIX"
sstring str_MenuINI, "MENU.INI"
sstring str_BattleEINI, "BATTLEE.INI"
sstring str_SidencMIX, "SIDENC%02d.MIX"
;sstring str_SideMIXRoot, "SIDE%02dE.MIX"
sstring str_MPMapsINI, "OBSOLETE.000"
sstring str_MoviesMIX, "MOVIES.MIX"
sstring str_DTAAlreadyRunning, "DTA is already running!"

sstring str_D1, "D1"
sstring str_D2, "D2"
sstring str_DTA, "DTA"
sstring str_DesINI, "DESERT"
sstring str_IsotempMIX, "ISOTEMP"
sstring str_DesertMIX, "DESERT"
sstring str_TemperatMIX, "TEMPERAT"
sstring str_Des, "DES"

sstring str_IsotemPAL, "ISOTEM.PAL"
sstring str_IsodesPAL, "ISODES.PAL"
sstring str_UnittemPAL, "UNITTEM.PAL"
sstring str_UnitdesPAL, "UNITDES.PAL"
sstring str_DesertPAL, "DESERT.PAL"
sstring str_TemperatPAL, "TEMPERAT.PAL"

; String references
;@SET 0x0044EBF3, push str_SoundsMIX
@SET 0x00472567, push str_DTALong
@SET 0x0047256C, push str_LanguageDLLNotFound
;@SET 0x004E0912, push str_SoundsINI
;@SET 0x004E0919, push str_SoundsINI
@SET 0x004E4078, push str_CacheMIX
@SET 0x004E430F, push str_SoundsMIX ; Sounds01.MIX?
@SET 0x004E4360, push str_SoundsMIX ; Sounds01.MIX?
;@SET 0x004E439C, push str_SoundsMIX
;@SET 0x004E43ED, push str_SoundsMIX
;@SET 0x004E80D8, push str_SideMIX
@SET 0x004E838C, push esi
@SET 0x004E8391, push str_SideCDMIX	; Search for SideCD##.mix instead of E01SC##.mix
@SET 0x005801BB, push str_MenuINI
@SET 0x005FF2C0, {cmp edx, str_DTALong}
@SET 0x005FF2C8, push str_DTALong
@SET 0x005FF2D9, push str_DTALong
@SET 0x005FF3AA, {cmp ecx, str_DTALong}
@SET 0x005FF3B2, push str_DTALong
@SET 0x005FF3C3, push str_DTALong
@SET 0x005FF4EC, push str_DTALong
@SET 0x005EE8B0, push str_MPMapsINI
@SET 0x005EEB82, push str_MPMapsINI
@SET 0x0044ECC5, push str_MoviesMIX
@SET 0x004E4543, push str_MoviesMIX
@SET 0x004E0DD8, push str_BattleEINI
@SET 0x006861ED, {mov dword [esp+48h], str_DTALong} ; dword ptr
@SET 0x00686215, push str_DTALong
@SET 0x0068621A, push str_DTALong
@SET 0x006862BD, push str_DTALong
@SET 0x006862C2, push str_DTALong

@SET 0x006CA930, {db "DESERT",0,0,0,0}
@SET 0x006CA940, {db "DESERT",0,0,0}
@SET 0x006CA94A, {db "ISODES",0}
@SET 0x006CA954, {db "DES",0}
@SET 0x006CA958, {db "TEMPERATE", 0,0,0,0}
@SET 0x006CA968, {db "TEMPERAT", 0,0,0}
@SET 0x006CA972, {db "ISOTEMP", 0}
@SET 0x006CA97C, {db "TEM", 0}

; Palette renames
; UNITSNO.PAL -> UNITTEM.PAL
@SET 0x004DFD65, {mov ecx, str_UnittemPAL}
@SET 0x004E015C, {mov ecx, str_UnittemPAL}
@SET 0x004E7D83, {mov ecx, str_UnittemPAL}
; UNITTEM.PAL -> UNITDES.PAL
@SET 0x004E7D8A, {mov ecx, str_UnitdesPAL}
; TEMPERAT.PAL -> DESERT.PAL
@SET 0x004DFDDF, {mov ecx, str_DesertPAL}

;; IsScoreShuffle on by default
@SET 0x005899F1, {mov byte [eax+35h], 1} ;byte ptr
@SET 0x005899F5, nop
@SET 0x005899F6, nop
@SET 0x005899F7, nop

;; "Facings stuff"
@SET 0x006530EB, {cmp dword [eax+4CCh], 20h} ;dword ptr
@SET 0x00653106, {shr ebx, 0Ah}
@SET 0x0065310D, {and ebx, 1Fh}

;; Skip useless debug logging code
; *******BREAKS THE SPAWNER
;; @SET 0x005FF81C, jmp 0x005FFC41

; Disable check for MoviesXX.mix, forces function to return al=1
@SET 0x004E45D8, {mov al, 1}
@SET 0x004E45DA, nop
; Included in no_movie_and_score_mix_dependency.asm

; Remove framework mode mmt/mms loading
@LJMP 0x004F5182, 0x004F528C    ; jmp loc_4F528C

; Load sidebar MIX files for new sides properly (for saved games)
@SET 0x005D6C4F, {mov cl, [eax+1D91h]}
@CLEAR 0x005D6C55, 0x90, 0x005D6C58

; Load speech MIX files for new sides properly (for saved games)
@SET 0x005D6DCE, {xor ecx, ecx}
@SET 0x005D6DD0, {mov cl, [eax+1D91h]}
@CLEAR 0x005D6DD6, 0x90, 0x005D6DDB

%endif
