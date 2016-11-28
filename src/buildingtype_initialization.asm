; Deterministic BuildingTypes Initialization

; BuildingTypes do not set certain members when constructed, thus keeping
; uninitialized memory around. When doing CRC checks, this uninitialized memory
; is incorporated and will thus give random results for each player, making the
; check always fail and thus useless and making it more difficult to compare
; sync logs by potentially hiding real problems.

; Author: AlexB
; Date: 2016-11-21

%include "macros/patch.inc"
%include "macros/hack.inc"

@LJMP 0x0043F850, _BuildingTypeClass_CTOR_Initialize

section .text

_BuildingTypeClass_CTOR_Initialize:
    mov [esi+55Ch], ebx; BuildingTypeClass::BuildingAnims[3]
    mov [esi+560h], ebx; ebx is 0
    mov [esi+564h], ebx

    lea edi, [esi+858h]; BuildingTypeClass::VoxelBarrelOffsetToPitchPivotPoint
    mov ecx, 12; 4 * sizeof(Point3D) / sizeof(DWORD)
    xor eax, eax
    rep stosd

    xor edx, edx
    lea eax, [esi+590h]
    mov ecx, 0Dh
    jmp 0x0043F85B
