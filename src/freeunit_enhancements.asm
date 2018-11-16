%include "TiberianSun.inc"
%include "macros/patch.inc"

cextern RefundFreeUnit

hack 0x006380A8, 0x006380AE
_TechnoClass__Refund_Amount_use_raw_cost:
    cmp byte[RefundFreeUnit], 0
    jnz .Reg
    pop  eax
    call 0x0063B880
    jmp  hackend

 .Reg:
    call [edx+0x88]
    jmp  hackend

hack 0x0042E55D, 0x0042E563
_BuildingClass__Grand_Opening__compare_cost:
    cmp byte[RefundFreeUnit], 0
    jnz .Reg
    jmp 0x0042E56F

 .Reg:
    call [edx+0xA8]
    jmp hackend


hack 0x0042E6BB, 0x0042E6C1
_BuildingClass__Grand_Opening__get_class_of:
    push eax                    ;Save calculation
    mov  ecx, edi
    mov  edx, [edi]
    call [edx+0x88]             ;Class_Of

    mov  edx, eax
    pop  eax                    ;Recover calculation
    jmp  hackend

hack 0x00440F71
_AircraftTypeClass__Read_INI_hack_free_unit:
    cmp dword[ebp+0x508], 0            ;FatoryType
    jz  .UnitType

    mov  eax, [ebp+0x508]
    cmp  eax, 3
    je   .AircraftType

    cmp  eax, 16
    je   .InfantryType
    jmp  .UnitType

 .AircraftType:
    call 0x00410020             ;Find_Or_Make(AircraftTypeClass *)
    jmp  hackend

 .InfantryType:
    call 0x004DB040             ;Find_Or_Make(AircraftTypeClass *)
    jmp  hackend

 ;; Original Code
 .UnitType:
    call 0x0065C690             ;Find_Or_Make(UnitTypeClass *)
    jmp  hackend



hack 0x0042E57D
_BuildingClass__Grand_Opening_hack_unit_size:
    pusha
    mov ecx, dword[esi+0x220]
    mov ecx, dword[ecx+0x4FC]
    mov eax, [ecx]
    call [eax+0x2C]             ;Class_ID

    cmp eax, 3
    je  .AircraftType

    cmp eax, 16
    je  .InfantryType
    jmp .Reg

 .InfantryType:
    popa
    push 0x388                  ;InfantryClass size
    jmp  hackend

 .AircraftType:
    popa
    jmp  0x0042E909             ;Aircraft will get made in the HoverPad code

 .Reg:
    popa
    push 0x380                  ;UnitClass size
    jmp  hackend



hack 0x0042E5E6
_BuildingClass__Grand_Opening_hack_free_unit:
    push ecx                    ;Save memory
    mov  ecx, edx
    mov  eax, [ecx]
    call [eax+0x2C]             ;Class_ID
    pop  ecx                    ;Restore memory

    cmp  eax, 3
    je   .AircraftType

    cmp  eax, 16
    je   .InfantryType
    jmp  .UnitType

 .AircraftType:
    pop eax
    pop eax
    jmp 0x0042E909

 .InfantryType:
    call 0x004D1FD0             ;InfantryClass::
    jmp  hackend

 ;; Original code
 .UnitType:
    call 0x0064D4B0             ;UnitClass::
    jmp  hackend


;;; Aircraft Specific hacks
hack 0x0042E909, 0x0042E90F
_BuildingClass__Grand_Opening_hack_hoverpad:
    mov  edx, [esi+0x220]       ;BuildingTypeClass
    mov  eax, [edx+0x4FC]       ;FreeUnit
    test eax, eax
    jz   .Reg

    mov  al, byte[edx+0x806]    ;HoverPad
    test al, al
    jz   0x0042E9DF

    mov  ebx, [0x007E4394]      ;??
    push 0x378
    inc  ebx
    mov  dword[0x007E4394], ebx
    call 0x006B51D7             ;new
    add  esp, 4

    test eax, eax
    jz   0x0042E9D9

    mov  ecx, [esi+0xEC]         ;Owner
    push ecx
    mov  edx, [esi+0x220]
    mov  edx, [edx+0x4FC]
    push edx
    mov  ecx, eax
    jmp  0x0042E973

 .Reg:
    mov ecx, [0x0074C488]       ;Rulesclass
    jmp hackend
