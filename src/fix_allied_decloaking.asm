%include "macros/patch.inc"

; Fixes a bug where objects with Sensors=yes cause nearby cloaked objects of allied players to decloak.
; Author: Rampastring

hack 0x0043B2E5
    pushad
	; We have one house in ECX and another in EDX
	push edx
	call 0x004BDA20 ; HouseClass::Is_Ally(HouseClass *)
	test al, al
	popad
	jz .not_allied
	jmp 0x0043B2F9 ; Don't decloak
	
.not_allied:
	; Original code partially overwritten by our jump
	mov edx, [eax]
	mov ecx, eax
	call [edx+84h]
	mov cl, [eax+44Dh] ; Sensors
	test cl, cl
	jnz 0x0043B32D
	jmp 0x0043B2F9



hack 0x0043B193
	pushad
	push edx
	call 0x004BDA20 ; HouseClass::Is_Ally(HouseClass *)
	test al, al
	popad
	jz .not_allied_2
	jmp 0x0043B1A9
	
.not_allied_2:
    ; Original code partially overwritten by our jump
	mov edx, [eax]
	mov ecx, eax
	call [edx+84h]
	mov cl, [eax+44Dh]
	test cl, cl
	jnz 0x0043B1DD
	jmp 0x0043B1A9
	
	