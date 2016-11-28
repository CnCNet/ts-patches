; Voxel Animations Deal Damage Without Checking Warhead and Modify Their Type

; The update method does not check whether a warhead is actually set before
; using it. This is allowed, because ReceiveDamage does have null pointer
; checks, but Westwood didn't check correctly for infantry. Thus, the pointer is
; dereferenced before being checked when applying ProneDamage.
;
; The update method passes the address of the Damage value on the type to the
; ReceiveDamage function, which actually does modify it to return how much
; damage was dealt. Thus, the Damage would potentially be reduced each time an
; object is hit. This patch uses a local copy of the Damage value.

; Author: AlexB
; Date: 2016-03-29, 2016-11-24

%include "macros/patch.inc"

@LJMP 0x0065EF27, _VoxelAnimClass_Update_Warhead
@LJMP 0x0065EF42, _VoxelAnimClass_Update_Damage

_VoxelAnimClass_Update_Warhead:
    mov edx, [eax+18Ch]; VoxelAnimTypeClass::Warhead
    test edx, edx
    jz 0x0065EF50
    jmp 0x0065EF2D


_VoxelAnimClass_Update_Damage:
    mov ecx, [eax+184h]; VoxelAnimTypeClass::Damage
    mov [esp+98h], ecx
    lea eax, [esp+98h]
    jmp 0x0065EF47
