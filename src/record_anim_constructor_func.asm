%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Records animation constructor calls for sync logging

cextern record_animation_constructor_void

hack 0x00413AE0
        push ecx
        ; the function we call below uses the cdecl calling convention,
        ; meaning it picks up its data from the stack and leaves cleaning
        ; up the stack to the callee, meaning we don't need to do any
        ; special operations aside from calling it
        ; we only push and pop ecx in case the function
        ; happens to use it
        call record_animation_constructor_void
        pop ecx
.Reg:
        ; Original code, replace bytes that we took for our jump-to-hack
        push ebp
        mov  ebp, esp
        and  esp, 0FFFFFFF8h
        jmp  0x00413AE6

