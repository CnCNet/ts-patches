%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Records Override_Mission calls for sync logging

cextern record_override_mission_void


hack 0x004A44F0
        push ecx
        ; the function we call below uses the cdecl calling convention,
        ; meaning it picks up its data from the stack and leaves cleaning
        ; up the stack to the callee, meaning we don't need to do any
        ; special operations aside from calling it
        mov  eax, [ecx]
        call [eax+2Ch] ; What_Am_I()
        push eax
        mov  eax, [ecx+0ECh] ; fetch object owner
        mov  ecx, [eax+020h]  ; fetch house ID
        push ecx
        call record_override_mission_void
        pop  ecx
        pop  ecx
        pop  ecx
.Reg:
        ; Original code, replace bytes that we took for our jump-to-hack
        mov  edx, [esp+4h]
        push esi
        push edi
        jmp  0x004A44F6
