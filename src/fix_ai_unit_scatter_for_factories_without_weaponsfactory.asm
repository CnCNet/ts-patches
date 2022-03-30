%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; When a unit is produced by the AI, the AI tells it to move on a random
; location on its base. This happens properly for barracks and vehicle factories
; with WeaponsFactory=yes, and while there is code for it, most of the time it
; fails for vehicle factories with WeaponsFactory=no. This causes the AI 
; to sometimes fill all the space around the factory with vehicles until
; the AI can't build anything anymore.
; This fixes the behaviour for WeaponsFactory=no factories
; by copying the implementation for barracks.
; *******************
; Author: Rampastring

hack 0x0042CEF6
    call 0x0050F280 ; MapClass::Coord_Cell
    push eax
    mov  ecx, edi
    call 0x00639130 ; TechnoClass_Assign_Destination_Cell
    lea  ecx, [esp+1Ch]
    push ecx
    mov  ecx, MouseClass_Map
    call 0x0050F280 ; MapClass::Coord_Cell
    push eax
    mov  ecx, edi
    call 0x004A5480 ; FootClass::Queue_Navigation_List
    jmp  0x0042CF07
    
    