%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
 
;@LJMP 0x004A4D60, _FootClass__Death_Announcement_No_Announcement_For_Insignificant

;_FootClass__Death_Announcement_No_Announcement_For_Insignificant:
hack 0x004A4D60
    mov     eax, [ecx]
    call    dword [eax+84h]
    cmp     byte [eax+0x0CB], 1 ; is Insignificant= set to Yes?
    jz      .Ret
   
.Normal_Code:
    mov     al, [ecx+1FEh]
    jmp     0x004A4D66
 
.Ret:
    retn    4
