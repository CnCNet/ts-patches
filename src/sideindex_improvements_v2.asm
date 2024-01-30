; Support for multiple sides for Prerequisites and AITriggerTypes

; This removes some assumptions that there are only two sides, called "GDI" and
; "Nod" with index 0 and 1 respectively, and all other country IDs get -1. After
; applying this hack, only "Neutral" and "Special" will get the invalid side
; index -1 while all other houses get their index in the Countries list as side
; index.

; "GDI" and "Nod" are still special cased: Country IDs starting with those names
; are still assigned the side indexes 0 and 1 respectively, just like in the
; original game.

; Author: AlexB
; Date: 2016-07-28
; Some comments updated by Rampastring on 2024-01-30 to point to ActsLike instead of SideIndex

%include "macros/patch.inc"
%include "macros/hack.inc"

; Assign Country index as side index, hardcode Neutral and Special to -1, as
; well as IDs starting with GDI or Nod to 0 and 1 respectively.
hack 0x004BADDD
_HouseClass_CTOR_SideIndex:
    mov edi, eax
    push 0x006FD598; offset "Neutral"
    lea eax, [edi+14h]; AbstractTypeClass::ID
    push eax
    call 0x006B73A0; __strcmpi
    add esp, 08h
    test eax, eax
    jz 0x004BAE20

    push 0x006F20F4; offset "Special"
    lea eax, [edi+14h]; AbstractTypeClass::ID
    push eax
    call 0x006B73A0; __strcmpi
    add esp, 08h
    test eax, eax
    jz 0x004BAE20

    xor esi, esi

    push 3
    push 0x006FCEB8; offset "GDI"
    lea eax, [edi+14h]; AbstractTypeClass::ID
    push eax
    call 0x006B7D20; __strnicmp
    add esp, 0Ch
    test eax, eax
    jz .AssignCountryIndex

    inc esi

    push 3
    push 0x006FCEB4; offset "Nod"
    lea eax, [edi+14h]; AbstractTypeClass::ID
    push eax
    call 0x006B7D20; __strnicmp
    add esp, 0Ch
    test eax, eax
    jz .AssignCountryIndex

    mov esi, [edi+64h]; HouseTypeClass::ArrayIndex

  .AssignCountryIndex:
    mov [ebp+0C0h], esi; HouseClass::ActsLike
    jmp 0x004BAE20

@CLEAR 0x004BADE2, 0x90, 0x004BAE20

; Always check for ConYard of required Owner
@LJMP 0x004BC077, 0x004BC082

; AITriggerTypes no longer assume not-GDI means Nod and vice versa
@SET 0x004109EF, {mov eax, [esi+74h]}; AITriggerTypeClass::SideIndex
@SET 0x004109F2, {test eax, eax}
@SJZ 0x004109F4, 0x00410A1F; 0 means all houses pass
@SET 0x004109F6, {dec eax}
@SET 0x004109F7, {cmp eax, [ebp+0C0h]}; HouseClass::ActsLike
@SJZ 0x004109FD, 0x00410A1F; Only specific side matches (1-based)
@SET 0x004109FF, {nop}
@CLEAR 0x00410A09, 0x90, 0x00410A1F
