%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gint  DragDistance, 4
gbool OnlyRightClickDeselect, false

;;; Can use edx
hack 0x00479353
        push eax
        cmp     byte[OnlyRightClickDeselect], 1 ; Disable drag select
        jne     .test_drag_distance

        cmp     dword[CurrentObjectsArray_Count], 0
        je     .test_drag_distance

        mov     eax, [Left_Shift_Key]
        mov     ecx, WWKeyboard
        push    eax
        call    WWKeyboardClass__Down

        test    al, al
        jnz     .test_drag_distance

        mov     eax, [Right_Shift_Key]
        mov     ecx, WWKeyboard
        push    eax
        call    WWKeyboardClass__Down

        test    al, al
        jnz     .test_drag_distance

        pop     eax
        jmp     0x00479397
.test_drag_distance:
        pop     eax
        cmp     eax, dword[DragDistance]
        jle     0x00479397
        jmp     hackend
