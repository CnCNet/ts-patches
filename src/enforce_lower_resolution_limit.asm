;
; Patch to enforce a lower resolution limit.
;
; Author: CCHyper
;
%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gint FORCE_WIDTH_MIN, 640  ; The lowest screen width the user can set.
gint FORCE_HEIGHT_MIN, 400 ; The lowest screen height the user can set.

@LJMP 0x00589E46, _OptionsClass_Load_Settings_Enforce_Lower_Resolution_Limit
@LJMP 0x00601128, _WinMain_Enforce_Lower_Resolution_Limit

_OptionsClass_Load_Settings_Enforce_Lower_Resolution_Limit:

.check_width:
	cmp dword [GameOptionsClass_ScreenWidth], FORCE_WIDTH_MIN
	jge .check_height
	
	mov eax, dword [FORCE_WIDTH_MIN]
	mov dword [GameOptionsClass_ScreenWidth], eax
	
.check_height:
	cmp dword [GameOptionsClass_ScreenHeight], FORCE_HEIGHT_MIN
	jge .out
	
	mov eax, dword [FORCE_HEIGHT_MIN]
	mov dword [GameOptionsClass_ScreenHeight], eax
	
.out:
	; stolen bytes
	mov [esi+20h], eax
	mov ecx, [esi+1Ch]
	push eax
	push ecx
	push 0x00706D74 ; "Resolution = %d X %d\n"
	call 0x004082D0 ; WWDebug_Printf()

	jmp 0x00589E58


_WinMain_Enforce_Lower_Resolution_Limit:

	; stolen bytes
	mov dword [GameOptionsClass_ScreenHeight], eax

.check_width:
	cmp dword [GameOptionsClass_ScreenWidth], FORCE_WIDTH_MIN
	jge .check_height
	
	mov eax, dword [FORCE_WIDTH_MIN]
	mov dword [GameOptionsClass_ScreenWidth], eax
	
.check_height:
	cmp dword [GameOptionsClass_ScreenHeight], FORCE_HEIGHT_MIN
	jge .out
	
	mov eax, dword [FORCE_HEIGHT_MIN]
	mov dword [GameOptionsClass_ScreenHeight], eax
	
.out:
	mov ecx, dword [GameOptionsClass_ScreenWidth]
	mov eax, dword [GameOptionsClass_ScreenHeight]
	push eax
	push ecx
	push 0x00706D74 ; "Resolution = %d X %d\n"
	call 0x004082D0 ; WWDebug_Printf()
	
	add esp, 0Ch

	jmp 0x0060112D