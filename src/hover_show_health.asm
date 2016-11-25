%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gint ObjectUnderMouse, 0
sstring debug_str, {"ObjectUnderMouse %x", 0xa}

hack 0x00477CD4
_DsiplayClass__Tactical__Action_record_object:
    call 0x005E8600

    mov eax, [esp+0xC]
    mov [ObjectUnderMouse], eax

    jmp hackend

hack 0x0062B26C, 0x0062B273
_TechnoClasss__Draw_It_show_health_boxes:
    mov  al, [ebx+0x30]          ; .Selected
    test al, al
    jnz  0x0062B27F

    cmp  ebx, [ObjectUnderMouse]
    jnz  hackend

    cmp  byte[HoverShowHealth], 1
    jnz  hackend

    mov  byte[esp+0x6C], 1
    jmp  0x0062B27F
