%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; BuildingClass::Update_Spied
@SET 0x0043ADEF, {mov ecx, [eax+0x20]}

;;; Update_Spied_Radar
@SET 0x004C98F9, {mov ecx, [eax+0x20]}

;;; MapClass::Sight_From
@SET 0x00510D23, {mov ecx, [eax+0x20]}

;;; BuildingClass::Update_Spied_Power
@SET 0x004C3A33, {mov ecx, [ecx+0x20]}

;;; BuildingClass::Draw_Overlays
@CLEAR 0x00428A7B, 0x90, 0x00428A7E
@SET 0x00428A73, {mov ecx, [edx+0x20]}
@CLEAR 0x00428A3A, 0x90, 0x00428A3D
@SET 0x00428A32, {mov ecx, [edx+0x20]}

;;; BuildingClass::Captured
@SET 0x0042F69D, {mov ecx, [ebp+0x20]}
@SET 0x0042FBC2, {mov ecx, [ebp+0x20]}

;;; Draw_Health_Boxes
@CLEAR 0x0062C6E5, 0x90, 0x0062C6E8
@SET 0x0062C6DD, {mov ecx, [edx+0x20]}
@CLEAR 0x0062CA3D, 0x90, 0x0062CA40
@SET 0x0062CA35, {mov ecx, [edx+0x20]}


;;; Let the computer cheat and see disguised units
@LJNZ 0x0062D50F, _Evaluate_Object_threat_disguised
section .text
_Evaluate_Object_threat_disguised:
        mov ecx, [edi+0xEC] ; Owner
        mov al, [ecx+0xC4]  ; IsHuman

        test al, al
        jnz  0x0062D8C0

        jmp  0x0062D515
