%include "TiberianSun.inc"
%include "macros/patch.inc"

hack 0x0042EFB4, 0x0042EFBD
_BuildingClass_WhatAction_Check_MoveToUndeploy:

        cmp   byte[MoveToUndeploy], 1
        je    .Reg

        cmp   ebx, 1            ; ACTION_MOVE
        jnz   .Reg

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
 	cmp   ebx, 5
        jnz   0x0042F009
        mov   edx, [esi]
        push  0
        jmp   hackend
