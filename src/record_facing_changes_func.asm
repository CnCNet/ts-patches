%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Records facing changes for sync logging

cextern record_facing_void

section .bss
    original_thisptr              RESD 1

hack 0x00496670
        mov  dword [original_thisptr], ecx
        ; the function we call below uses the cdecl calling convention,
        ; meaning it picks up its data from the stack and leaves cleaning
        ; up the stack to the callee, meaning we don't need to do any
        ; special operations aside from calling it

        ; we only save the value of ecx in case the function
        ; happened to modify ecx
        call record_facing_void
        mov  ecx, dword [original_thisptr]
.Reg:
        ; Original code, replace bytes that we took for our jump-to-hack
        sub  esp, 10h
        push ebx
        push esi
        mov  esi, ecx
        jmp  0x00496677
