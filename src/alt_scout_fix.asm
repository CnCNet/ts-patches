%include "TiberianSun.inc"
%include "macros/patch.inc"

;;; Aircraft and subterrean units are not allowed to move to shroud.
;;; Players complain that those units can move to shroud when they are moving to a rally point
;;; This fix disallows players to place a rally point in shroud for war factory and helipad.
;;; Barracks is allowed to place a rally point in shroud.

 hack 0x0042EF29, 0x0042EF2F
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
