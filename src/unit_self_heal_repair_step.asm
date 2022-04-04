%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Adds UnitSelfHealRepairStep and makes TechnoClass::AI use it when 
; self-healing instead of just incrementing the unit's HP by 1.
; -------------------
; Author: Rampastring


sstring str_UnitSelfHealRepairStep, "UnitSelfHealRepairStep"

gint UnitSelfHealRepairStep, 1


; RulesClass::Read_General_Read_UnitSelfHealRepairStep
hack 0x005CB7D7
    mov [esi+0E74h], eax    ; Save value of RepairStep
    mov eax, [UnitSelfHealRepairStep]
    mov ecx, [0x006D5FEC]     ; address of string "General"
    push eax
    push str_UnitSelfHealRepairStep
    push ecx
    mov ecx, edi
    call INIClass__GetInt
    mov [UnitSelfHealRepairStep], eax
    jmp 0x005CB7DD
    
    
; TechnoClass::AI_Use_UnitSelfHealRepairStep
hack 0x0062E9EF
    mov eax, [esi+28h]      ; get object HP
    mov ecx, [UnitSelfHealRepairStep]
    add eax, ecx
    mov ecx, esi            ; "this" pointer for following ObjectClass::Health_Ratio call
    jmp 0x0062E9F5

