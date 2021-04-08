;
; Collection of ASM patches that enable Bink movie support.
;
; Author: CCHyper
;
%include "TiberianSun.inc"
%include "macros/patch.inc"

cextern Windows_Procedure_Should_Blit_Patch
cextern CompositeSurface
cextern WWMouse
cextern InScenario
cextern BinkFullscreenMovie
cextern Current_Movie_Ptr
cextern IngameVQ_Count

@LJMP 0x00685CB9, _Windows_Procedure_Should_Blit_Patch_asm_patch

;
; This fixes a issue were the game be seen behind the video
; if the window moves. This was a bug in the vanilla game.
;
_Windows_Procedure_Should_Blit_Patch_asm_patch:
	cmp byte [InScenario], 1
	jnz .move_update

	mov edx, dword [BinkFullscreenMovie]
	test edx, edx
	jnz .move_update

	mov edx, dword [Current_Movie_Ptr]
	test edx, edx
	jnz .move_update

	mov edx, dword [IngameVQ_Count]
	cmp edx, 1
	jge .move_update
	
	; Blit game layer.
	mov eax, dword [CompositeSurface]
	jmp 0x00685CC2
	
	; Update a movie
.move_update:
	jmp 0x00685CEE
