%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"


;;; FootClass::Active_Click_With
hack 0x004A2F3F, 0x004A2F45
        mov  ecx, [edi+0x220]     ; BuildingClass Struct type
        mov  al, byte [ecx+0x450] ; BuildingTypeClass.t.Repairable
        test al, al
        jnz  .Reg

 .Out:
        jmp  0x004A2F6A
 .Reg:
        mov  ecx, dword [esi+0xEC]
        jmp  hackend

;;; InfantryClass::Mission_Attack
hack 0x004D7834, 0x004D783A
        mov  ecx,  [ecx+0x220]
        mov  al, byte [ecx+0x450]
        test al, al
        jnz  .Reg

 .Out:
        jmp  0x004D78A4

 .Reg:
        mov  ecx, [esi+0x11C]
        jmp  hackend
