%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

%ifdef SPAWNER

;;; Don't create a radar event for a new unit or building being placed
@CLEAR 0x004BED18, 0x90, 0x004BED1E

@LJZ 0x004BD438, _HouseClass__Attacked_spectator_events

cextern IsSpectatorArray
section .text
_HouseClass__Attacked_spectator_events:
        mov edx, [eax+0x20]
        cmp dword [IsSpectatorArray+edx*4], 1
        jz  0x004BD43E

        jmp 0x004BD4C5

%endif ; SPAWNER
