%include "TiberianSun.inc"
%include "macros/patch.inc"

hack 0x0042EFB7, 0x0042EFBD
_BuildingClass_WhatAction_Check_MoveToUndeploy:
        jz    0x0042F009

        cmp   byte[MoveToUndeploy], 1
        je    .Reg

        cmp   ebx, 1            ; ACTION_MOVE
        jnz   0x0042F009

        mov   edx, [Left_Alt_Key]
        mov   ecx, [WWKeyboard]
        push  edx
        call  WWKeyboardClass__Down

        test  al, al
        jnz   0x0042F009        ; Yes, Allow Move

        mov   edx, [Right_Alt_Key]
        mov   ecx, [WWKeyboard]
        push  edx
        call  WWKeyboardClass__Down

        test  al, al
        jnz   0x0042F009        ; Yes, Allow Move

        mov   ebx, 2            ; ACTION_NOMOVE
        jmp   0x0042F009
 .Reg:
        mov   edx, [esi]
        push  0
        jmp   hackend
