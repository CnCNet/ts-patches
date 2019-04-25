%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

sstring str_SoundsMIX, "SOUNDS.MIX"
sstring str_TOLong, "Tiberian Odyssey"
sstring str_DTAGameWindow, "TO (Game Window)"
sstring str_LanguageDLLNotFound, "Language.dll not found, please start TO.exe and click Save in the Options menu."
sstring str_SoundsINI, "SOUND.INI"
sstring str_CacheMIX, "CACHE.MIX"
sstring str_Sounds01MIX, "SOUNDS01.MIX"
sstring str_SideMIX, "SIDE%02d.MIX"
sstring str_SideCDMIX, "SIDECD%02d.MIX"
sstring str_MenuINI, "MENU.INI"
sstring str_BriefingPCX, "BRIEFING.PCX"
sstring str_BattleEINI, "BATTLEE.INI"
sstring str_SidencMIX, "SIDENC%02d.MIX"
sstring str_SideMIXRoot, "SIDE%02dE.MIX"
sstring str_MPMapsINI, "MPMAPS.INI"
sstring str_MoviesMIX, "MOVIES%02d.MIX"
sstring str_DTAAlreadyRunning, "TO is already running!"
sstring str_D1, "D1"
sstring str_D2, "D2"
sstring str_DTA, "TO"

sstring str_Red, "Red"
sstring str_DarkRed, "DarkRed"

; String references
@SET 0x0044EBF3, push str_SoundsMIX
@SET 0x00472567, push str_TOLong
@SET 0x0047256C, push str_LanguageDLLNotFound
@SET 0x004E0912, push str_SoundsINI
@SET 0x004E0919, push str_SoundsINI
@SET 0x004E4078, push str_CacheMIX
@SET 0x004E430F, push str_SoundsMIX ; Sounds01.MIX?
@SET 0x004E4360, push str_SoundsMIX ; Sounds01.MIX?
@SET 0x004E439C, push str_SoundsMIX
@SET 0x004E43ED, push str_SoundsMIX
@SET 0x004E80D8, push str_SideMIX
@SET 0x004E838C, push esi
@SET 0x005801BB, push str_MenuINI
;@SET 0x005C04AF, {mov ecx, str_BriefingPCX}
@SET 0x005FF2C0, {cmp edx, str_TOLong}
@SET 0x005FF2C8, push str_TOLong
@SET 0x005FF2D9, push str_TOLong
@SET 0x005FF3AA, {cmp ecx, str_TOLong}
@SET 0x005FF3B2, push str_TOLong
@SET 0x005FF3C3, push str_TOLong
@SET 0x005FF4EC, push str_TOLong
@SET 0x005EE8B0, push str_MPMapsINI
@SET 0x005EEB82, push str_MPMapsINI
@SET 0x0044ECC5, push str_MoviesMIX
@SET 0x004E4543, push str_MoviesMIX
@SET 0x006861ED, {mov dword [esp+48h], str_TOLong} ; dword ptr
@SET 0x00686215, push str_TOLong
@SET 0x0068621A, push str_TOLong
@SET 0x006862BD, push str_TOLong
@SET 0x006862C2, push str_TOLong

@SET 0x006CA940, {db "TEM",0,0,0}
@SET 0x006CA954, {db "TEM",0}
@SET 0x006CA968, {db "SNO", 0,0,0}
@SET 0x006CA97C, {db "SNO", 0}

@SET 0x006F99D8, {db "TOCREDIT.txt"}

; Erase NAWALL and GAWALL
@SET 0x00710DA4, {db 0,0,0,0,0,0}
@SET 0x00710DAC, {db 0,0,0,0,0,0}

;

;; Trackbar Border Color change
@SET 0x0059138B, {db 0x09, 0x92, 0x0F}
; Selected list-box item background color
@SET 0x00591395, {db 0x00, 0x7D, 0x00}
;

;
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