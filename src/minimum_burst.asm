%include "TiberianSun.inc"
%include "macros/patch.inc"

;;; Fixes common crash at 0047f938 caused by bad mods with Burst=0 in weapontypes
hack 0x00680DAF
    call 0x004DD140
    cmp eax, 0
    jnz hackend

    mov eax, 1
    jmp hackend
