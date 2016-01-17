%include "TiberianSun.inc"
%include "macros/patch.inc"

@CLEAR 0x0042EF29, 0x90, 0x0042EF2F
@LJMP 0x0042EF29, _BuildingClass_WhatAction_NoRallyPlaceInShroud

_BuildingClass_WhatAction_NoRallyPlaceInShroud:
        mov     edx, [esi+220h]
        cmp     dword [edx+508h], 10h ; Barracks?
        jz      0x0042F009            ; Allowed to place rally

        mov     edi, [esp+1Ch]
        pushad
        push    edi
        mov     ecx, MouseClass_Map
        call    is_coord_shrouded     ; from ts_util.c

        test    al, al
        popad
        jnz     .no_rally

        mov     edx, [esi+220h]
        jmp     0x0042EF2F

.no_rally:
        mov     ebx, 2                ; no move
        jmp     0x0042EFB4
