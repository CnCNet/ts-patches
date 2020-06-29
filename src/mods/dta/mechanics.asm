%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Converts the unused key Thief= to Mechanic=. Infantry with this key set
; to true cannot heal infantry, but they can repair vehicles instead.
; Author: Rampastring

sstring str_Mechanic, "Mechanic"


; Hack InfantryClass::What_Action to show the heal cursor for vehicles
hack 0x004D716C
    call    [eax+2Ch] ; AbstractClass::What_Am_I()
    mov     edx, eax
    mov     ecx, edi
    call    0x004D7B20 ; InfantryClass::Class_Of
    mov     ecx, [eax+4B3h] ; 4B3h = Thief (Mechanic)
    and     ecx, 1 ; Use only 1 bit of the byte
    cmp     ecx, 1
    jne     .Normal_Code
    ; Repair vehicles instead
    cmp     edx, 01h ; RTTI_UNIT
    jne     0x004D71B0
    jmp     0x004D7174

.Normal_Code:
    ; Heal infantry
    cmp     edx, 0Fh ; RTTI_INFANTRY
    jne     0x004D71B0
    jmp     0x004D7174


; Read Mechanic= instead of Thief=
hack 0x004DAB30
    push    str_Mechanic
    jmp     0x004DAB35


; Hack InfantryClass::Can_Fire to cast the object to ObjectClass instead of 
; InfantryClass so the cast does not fail for non-infantry objects
; Push address to ObjectClass type info instead of InfantryClass type info as parameter for __RTDynamicCast
@SET 0x004D5AB6, { push 0x006F2B00 }


; Hack TechnoClass::Greatest_Threat to make mechanics auto-target vehicles and air instead of infantry
hack 0x0062DD70
    and  ebx, 3 ; method & (THREAT_RANGE | THREAT_AREA)
                ; THREAT_RANGE = 1, THREAT_AREA = 2, so (THREAT_RANGE | THREAT_AREA) = 3
    mov  ecx, esi
    call 0x004D7B20 ; InfantryClass::Class_Of
    mov  ecx, [eax+4B3h] ; 4B3h = Thief (Mechanic)
    and  ecx, 1 ; Use only 1 bit of the byte
    cmp  ecx, 1
    jne  .Medic

    ; Mechanic logic
    or   ebx, 14h   ; THREAT_VEHICLES | THREAT_AIR
    jmp  0x0062DDB1
    
.Medic:
    or   ebx, 4008h ; (THREAT_INFANTRY | something else (0x4000) that doesn't exist in RA)
    jmp  0x0062DDB1
    