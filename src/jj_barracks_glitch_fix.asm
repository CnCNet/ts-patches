%include "TiberianSun.inc"
%include "macros/patch.inc"


;;; This fixes the problem of Jump Jet infantry spawning and blocking any new units from being built
;;; from a barracks.
;;; To recreate the problem: if you set a rally point far away so that the JJ will spawn flying then if you
;;; Move that JJ before it clears the barracks (aka lands) it will block the barracks from producing any new units.

;;; The fix here is just to make it so that you can't move a JJ until it "clears" the barracks.
hack 0x004D6FB0, 0x004D6FB7
_jj_barracks_glitch_fix_mouse_over_object:
        mov     al, [ecx+1FDh]  ; Tethered?
        test    al, al
        jz      .lct_jump_out

        push    edi
        mov     edi, [ecx+32Ch] ; Locomotor
        mov     eax, [edi]
        cmp     eax, 0x006D35BC ; JumpJetLocomotionClass::`vftable'
        pop     edi
        jz      .lct_no_move

.lct_jump_out:
        mov     eax, [esp+8]
        sub     esp, 20h
        jmp     hackend

.lct_no_move:
        mov     eax, 0          ; 0 = ACTION_NONE, 7 = ACTION_SELECT
        retn    8


hack 0x004D78B0, 0x004D78B5
_jj_barracks_glitch_fix_mouse_over_terrain:
        mov     al, [ecx+1FDh]
        test    al, al
        jz      .lct_jump_out

        push    edi
        mov     edi, [ecx+32Ch]
        mov     eax, [edi]
        cmp     eax, 0x006D35BC ; JumpJetLocomotionClass::`vftable'
        pop     edi
        jz      .lct_no_move

.lct_jump_out:
        sub     esp, 0Ch
        push    ebx
        push    ebp
        jmp     hackend

.lct_no_move:
        mov     eax, 0          ; 0 = ACTION_NONE, 7 = ACTION_SELECT
        retn    0Ch
