%include "macros/patch.inc"
 
;@LJMP 0x0045882C, _Crate_Goodie_Veterancy_Crate_Add_Trainable_Check

; In the original games, objects with Trainable=no still gain veterancy from
; veterancy crates. This fixes it.
; Author: Iran

hack 0x0045882C
_Crate_Goodie_Veterancy_Crate_Add_Trainable_Check: 
    call    0x00405DF0 ; AbstractClass__Is_Techno
    test    al, al
    jz      0x0045894E
 
    mov     ecx, [esp+0x18] ; get pointer to technoclass object
    mov     eax, [ecx]
    call    dword [eax+84h] ; get technotype
    cmp     byte [eax+43Eh], 0 ; Check Trainable=
    jz      0x0045894E
 
    jmp     0x00458839
