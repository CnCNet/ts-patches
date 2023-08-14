%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern UsedSpawnsArray
sstring HouseNameNeutral, "Neutral"

hack 0x004C4733, 0x004C4739
_HouseClase__House_From_HouseType:
        cmp  ecx, 50
        jge  .house_by_spawn

        mov  edi, [0x007E1568]
        jmp  hackend

 .house_by_spawn:
        sub  ecx, 50
        cmp  ecx, 8
        jg   .set_neutral

        mov eax, [UsedSpawnsArray+ecx*4]
        cmp eax, -1
        je  .set_neutral

        mov edi, [HouseClassArray_Vector]
        mov eax, [edi+eax*4]

        jmp .out

 .set_neutral:
        mov  ecx, HouseNameNeutral
        call HouseType_From_Name
        mov  ecx, eax
        mov  edi, [0x007E1568]
        jmp  hackend
 .out:
        jmp 0x004C4759


;hack 0x006428B8
;_TEventClass__operator_paren_check_null1:
;        call 0x004C4730         ; HouseClass__HouseFrom_HousesType

;        test eax, eax
;        jz   0x0064285C         ; Return False

;        jmp  hackend
