%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

%define facCount 0x0C
%define buildSpeed 8

sint two_thousand, 2000
sstring adjusted, "12345678", 8

;;; Taken from RA2.
;;; Hack TechnoClass::Time_To_Build, change the factory bonus to be cumulative like RA2
hack 0x0062AA62
    dec  ecx
    mov  [esp+facCount], ecx    ; Save the factory count


    ;; Adjust the factory bonus to the cost of the building
    mov ecx, esi
    push 1
    push 1
    call 0x00586640             ; Who_Can_Build_Me (to find the building)

    mov  ecx, [esp+facCount]    ; Recall the factory count

    test eax, eax
    jz   .full_bonus            ; The player can't build this item, so just go back to regular code

    mov  eax, [eax+0x220]       ; BuildingTypeClass
    mov  edx, dword [two_thousand]
    cmp  dword [eax+0x324], edx ; Cap the cost adjustment to $2000
    jge  .full_bonus

    mov  edx, [0x0074C488]      ; RulesClass
    fld  qword [0x006CB920]     ; 1.0
    fsub qword [edx+0x2B0]      ; FactoryMultiplier

    fild  dword [two_thousand]
    fidiv dword [eax+0x324]     ; Cost
    fdiv                        ; Adjust the multiplier by 2000/Cost
    fsubr qword [0x006CB920]    ; 1.0

    jmp   .multiply
    ;; End Adjustment


 ;; The RA2 Factory Multiplier hack
 .full_bonus:
    mov  edx, [0x0074C488]      ; RulesClass
    fld qword [edx+0x2B0]       ; Multiple factory bonus

 .multiply:
    fld  st0
    fild dword [esp+buildSpeed]
    fmul                        ; buildSpeed * multiplier
    call 0x006B2330             ; Float_To_Int

    mov  edi, eax
    dec  ecx
    mov  [esp+buildSpeed], edi
    jnz  .multiply              ; Repeat for each factory


    mov  edx, [0x0074C488]      ; RulesClass
    fstp qword [adjusted]

    jmp  0x0062AA86
