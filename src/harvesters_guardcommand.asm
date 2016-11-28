; Allow Setting Harvesters to Area Guard Mission using Guard Keyboard Command

; Ordinary harvesters are unarmed and thus are not considered when executing
; the Guard Command. This hack adds exceptions for Harvester=yes and Weeder=yes.

; Author: AlexB
; Date: 2016-11-23

%include "macros/patch.inc"
%include "macros/hack.inc"

@LJMP 0x004E95DA, _GuardCommandClass_Execute_Harvester

section .text

_GuardCommandClass_Execute_Harvester:
    test al, al
    jnz .GoOn

    mov eax, [esi]
    mov ecx, esi
    call [eax+2Ch]; AbstractClass::WhatAmI

    cmp eax, 1; AbstractType::Unit
    jnz .Skip

    mov eax, [esi+360h]; UnitClass::Type
    mov ax, [eax+48Eh]; UnitClass::Harvester and UnitClass::Weeder
    test ax, ax
    jz .Skip

  .GoOn:
    mov edi, [esi]
    jmp 0x004E95E0

  .Skip:
    jmp 0x004E95FC
