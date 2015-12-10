%include "macros/patch.inc"
%include "macros/datatypes.inc"

;@CLEAR 0x004D3F8A 0x00 0x004D3F8B ; power=0 hard-coded to damage 1 at 0x004D3F84, set it to 00 instead
; hard-coded power=17 for Vinifera at 0x00644DCA

@LJMP 0x0045ED08, _Tiberium_Chain_Reaction_Dont_Crash_With_Power_Zero

_Tiberium_Chain_Reaction_Dont_Crash_With_Power_Zero:
    mov edi, [ebx+84h]
    cmp edi, 0
    jz .Set_EDI_To_1
    
    jmp 0x0045ED0E
    
.Set_EDI_To_1:
    mov edi, 1
    jmp 0x0045ED0E
