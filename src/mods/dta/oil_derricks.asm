%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Oil derrick implementation for the Tiberian Sun engine.
; Oil derricks are structures popularized by RA2 that give their
; owner free credits at specific intervals.
; -------------------
; Author: Rampastring

sstring str_ProduceCashAmount, "ProduceCashAmount"
gint ProduceCashFrameDelay, 180

; BuildingTypeClass::Read_INI_Replace_ICBMLauncher_With_ProduceCashAmount
hack 0x0044148A
    mov [ebp+89Bh], al ; Save value of PlaceAnywhere=
    push str_ProduceCashAmount
    push ebx
    call 0x004DD140 ; INIClass::Get_Int
    mov [ebp+828h], al ; it can only take 8 bits
    jmp 0x004414A1


; BuildingClass::AI_Update_Oil_Derrick_Logic
hack 0x00429A60
    mov eax, [ecx+0x220] ; get BuildingTypeClass instance
    mov dx, [eax+0x828] ; ICBMLauncher / ProduceCashAmount
    cmp dx, 0
    jg .Check_Frame_Give_Credits_To_Owner
    jmp .Reg
    

.Check_Frame_Give_Credits_To_Owner:
    push ecx
    mov eax, [Frame]
    cdq
    mov ecx, [ProduceCashFrameDelay]
    idiv ecx
    pop ecx
    cmp edx, 0
    je .Give_Credits
    jmp .Reg

.Give_Credits:
    push ebx             ; as far as I can see, BuildingClass::AI doesn't use ebx at all...
                         ; but I'm too afraid to change it because I'm not sure if the caller could rely on its value,
                         ; so we save and restore it
                         
    mov ebx, [ecx+0x220] ; get BuildingTypeClass instance
    xor eax, eax
    mov al, [ebx+828h]  ; ICBMLauncher / ProduceCashAmount
    mov edx, [ecx+0ECh] ; get TechnoClass of the building pointed to by ecx, 0ECh = pointer to owning house
    mov ebx, [edx+1A4h] ; get current number of credits to ebx
    add ebx, eax        ; add credits
    mov [edx+1A4h], ebx
    pop ebx
    
.Reg:

    ; Replace instructions that our jump-to-hack destroyed
    sub esp, 1Ch
    push esi
    mov esi, ecx
    jmp 0x00429A66
    