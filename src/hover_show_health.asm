; Hovering Over a Unit or Structure Reveals Its Health

; Objects have to be selected to show their health and additional symbols. This
; hack adds support to show (only) the health bar when the mouse hovers over it.
;
; Additionally, veterancy insignia and the medic icon are now always displayed,
; even if the unit is neither selected nor hovered. This works as if the unit
; were selected, that is, enemies won't see it.

; Author: AlexB
; Date: 2016-11-23, 2016-11-27

%include "macros/patch.inc"

@LJMP 0x005E8910, _DisplayClass_SetAction_HoverHealth
@LJMP 0x0062B277, _TechnoClass_DrawFront_HoverHealth
@LJMP 0x0062C4AC, _TechnoClass_DrawHealthBar_HoverHealth1
@LJMP 0x0062C8C0, _TechnoClass_DrawHealthBar_HoverHealth2
@LJMP 0x006375D0, _TechnoClass_DrawPipScale_HoverHealth1
@LJMP 0x00637CB1, _TechnoClass_DrawPipScale_HoverHealth2

section .bss
    MouseHovered RESD 1
    HealthBarForced RESB 1

section .text

; thiscall
; param 1: ObjectClass pointer
_ObjectClass_IsHovered:
    cmp BYTE [HealthBarForced], 0
    jne .Hovered

    cmp [MouseHovered], ecx
    jne .NotHovered

    mov eax, [ecx]; AbstractClass::vtbl
    call [eax+88h]; ObjectClass::GetType

    cmp BYTE [eax+0C9h], 0; ObjectTypeClass::Selectable
    jz .NotHovered

  .Hovered:
    mov eax, 1
    ret

  .NotHovered:
    xor eax, eax
    ret


_DisplayClass_SetAction_HoverHealth:
    mov eax, [esp+8h]
    mov [MouseHovered], eax
    mov eax, [0x007E4868]
    jmp 0x005E8915


_TechnoClass_DrawFront_HoverHealth:
    mov [HealthBarForced], al

    test al, al
    jnz 0x0062B27F

    push 1
    mov eax, [esp+98h]
    push eax
    mov eax, [esp+98h]
    push eax
    mov eax, [ebx]; TechnoClass::vtbl
    mov ecx, ebx
    call [eax+330h]; TechnoClass::DrawHealthBar

    jmp 0x0062BE24


_TechnoClass_DrawHealthBar_HoverHealth1:
    cmp BYTE [ebx+30h], 0; ObjectClass::Selected
    jne .Draw

    mov ecx, ebx
    call _ObjectClass_IsHovered

    test al, al
    jne .Draw

    mov edi, [esp+5Ch]
    jmp 0x0062C6C1

  .Draw:
    fld QWORD [ebx+0B0h]; TechnoClass::ArmorMultiplier
    jmp 0x0062C4B2


_TechnoClass_DrawHealthBar_HoverHealth2:
    cmp BYTE [ebx+30h], 0; ObjectClass::Selected
    jne .Draw

    push ecx

    mov ecx, ebx
    call _ObjectClass_IsHovered

    pop ecx

    test al, al
    jne .Draw

    mov esi, [esp+5Ch]
    jmp 0x0062CA19

  .Draw:
    mov edx, 2
    jmp 0x0062C8C5


_TechnoClass_DrawPipScale_HoverHealth1:
    cmp BYTE [esi+30h], 0; ObjectClass::Selected
    je .Hovered

    call [edx+84h]
    jmp 0x006375D6

  .Hovered:
    mov ebp, [esp+54h]
    jmp 0x00637B77


_TechnoClass_DrawPipScale_HoverHealth2:
    mov eax, [esi+0E4h]; TechnoClass::Group
    cmp BYTE [esi+30h], 0; ObjectClass::Selected
    jne .Return

    or eax, -1

  .Return:
    jmp 0x00637CB7
