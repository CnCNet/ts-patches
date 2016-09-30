%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Remove hardcoded Power=17 from "Vinifera" by changing the last character of the string
@SET 0x00711143, {db "."}

; The damage inflicted by the tiberium is Power= divided by the number at 000D3F75 (originally 0A)
; Also makes tiberium do 0 damage with Power=0 and at least 1 for anything higher
; original author of hack: AlexB
; ported to ASM from a byte hack by Rampastring

@SET 0x004D3F66, {mov eax, [edx+84h]}
@SET 0x004D3F6C, {test eax, eax}
;@SET 0x004D3F6E, jle 0x004D409C
@SET 0x004D3F74, {mov ecx, 2}
@SET 0x004D3F79, cdq
@SET 0x004D3F7A, idiv ecx
@SET 0x004D3F7C, {test eax, eax}
@SJGE 0x004D3F7E, 0x004D3F85
@SET 0x004D3F80, {mov eax, 1}
@SET 0x004D3F85, {mov [esp+10h], eax}
@CLEAR 0x004D3F89, 0x90, 0x004D3F8E

hack 0x004D3F6E ; replacement for lack of @JLE macro
    jle 0x004D409C
    jmp 0x004D3F74

    