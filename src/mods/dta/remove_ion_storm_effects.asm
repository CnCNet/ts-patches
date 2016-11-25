%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Remove Ion Storm special effects: flight denial, immobile hover units, disabled radar,
; IonSensitive weapons
@SET 0x0040E115, {mov eax, 0}
@SET 0x0040E4BB, {mov eax, 0}
@SET 0x0042C6AC, {mov eax, 0}
@SET 0x0042C8F8, {mov eax, 0}
@SET 0x004322D1, {mov eax, 0}
@SET 0x004324B1, {mov eax, 0}
@SET 0x004A2CAC, {mov eax, 0}
@SET 0x004A88FC, {mov eax, 0}
@SET 0x004A893A, {mov eax, 0}
@SET 0x004C9580, {mov eax, 0} ; Remove disabled radar
@SET 0x004CF698, {mov eax, 0}
@SET 0x004D9B83, {mov eax, 0}
@SET 0x004EC95D, {mov ecx, 0}
@SET 0x004EC962, nop
@SET 0x004ECC80, {mov eax, 0}
@SET 0x004F96D6, {mov eax, 0}
@SET 0x004F976E, {mov eax, 0}
@SET 0x0062FA96, {mov eax, 0} ; Remove IonSensitive effect
@SET 0x0065834E, {mov eax, 0}
