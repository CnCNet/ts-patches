%include "TiberianSun.inc"
%include "macros/patch.inc"

@SET 0x0066EEE0, {lea ecx, [ebp+0x68]}
@CLEAR 0x0066EEE8, 0x90, 0x0066EEF4
@CALL 0x0066EEE3, WarheadTypeClass__init_versus
@SET 0x0066F435, {mov eax, [esi+0x68]}
@SET 0x0066F43F, {mov dword [esp+0x10], 64}


;;; Hack WarheadTypeClass::Read_INI
;;; If 64 versus armor types are not defined
;;; then just repeat the last value for all
;;; the remaining versus armortypes
hack 0x0066F489, 0x0066F48F
        mov     ecx, [esp+0x1C]
        test    eax, eax
        jz     .Reg

        mov     edi, eax
.Reg:
        jmp     hackend

@LJMP 0x0066F4CD, 0x0066F566



cextern WTF
;;; Modify_Damage
hack 0x0045EBA6
        push    esi
        mov     eax, [edi+0x68]
        test    eax, eax
        jnz     .Reg
        push    edi
        call    WTF
        add     esp, 4
        jmp     hackend
.Reg:
        fmul    qword [eax+ecx*8]
        jmp     hackend
