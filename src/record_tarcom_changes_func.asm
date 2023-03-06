%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Records TarCom changes for sync logging

cextern record_tarcom_void

section .bss
    argument              RESD 1
    return_addr           RESD 1

; Record TarCom changes for vehicles and aircraft
hack 0x0062FD70
        mov  eax, [esp+4] ; fetch argument
        mov  dword [argument], eax
        mov  eax, [esp]
        mov  dword [return_addr], eax

        push ecx
        push edx

        mov  edx, ecx

        ; Only record if we are not an infantry or building
        mov  eax, [ecx]      ; get object vtbl
        call dword [eax+2Ch] ; AbstractClass::What_Am_I()
        cmp  eax, 0xF        ; RTTI_INFANTRY
        je   .Past_Record

        cmp  eax, 0x6        ; RTTI_BUILDING
        je   .Past_Record

        ; push last argument: return address
        mov  eax, [return_addr]
        push eax

        mov  eax, [argument]
        cmp  eax, 0
        je   .Record_Null_Target

        ; fetch target ID
        mov  ecx, eax
        push ecx
        call 0x00405BB0 ; __stdcall AbstractClass::Fetch_ID(void)

        push eax ; target ID

        mov  ecx, [argument]
        mov  eax, [ecx]      ; vtable
        call dword [eax+2Ch] ; AbstractClass::What_Am_I()
        push eax ; target RTTI
        jmp  .Do_Record

.Record_Null_Target:

        push 0 ; target ID
        push 0 ; target RTTI


.Do_Record:

        push edx
        call 0x00405BB0 ; __stdcall AbstractClass::Fetch_ID(void)
        push eax ; my ID

        mov  ecx, edx
        mov  eax, [ecx]      ; vtable
        call dword [eax+2Ch] ; AbstractClass::What_Am_I()
        push eax ; my RTTI

        call record_tarcom_void

        ; clean up all of our passed arguments from the stack
        pop  eax
        pop  eax
        pop  eax
        pop  eax
        pop  eax

.Past_Record:
        pop edx
        pop ecx

.Reg:
        ; Original code, replace bytes that we took for our jump-to-hack
        sub  esp, 0Ch
        push esi
        mov  esi, ecx
        jmp  0x0062FD76




; Record TarCom changes for infantry
hack 0x004D4770
        mov  eax, [esp+4] ; fetch argument
        mov  dword [argument], eax
        mov  eax, [esp]
        mov  dword [return_addr], eax

        push ecx
        push edx

        mov  edx, ecx

        ; push last argument: return address
        mov  eax, [return_addr]
        push eax

        mov  eax, [argument]
        cmp  eax, 0
        je   .Record_Null_Target

        ; fetch target ID
        mov  ecx, eax
        push ecx
        call 0x00405BB0 ; __stdcall AbstractClass::Fetch_ID(void)

        push eax ; target ID

        mov  ecx, [argument]
        mov  eax, [ecx]      ; vtable
        call dword [eax+2Ch] ; AbstractClass::What_Am_I()
        push eax ; target RTTI
        jmp  .Do_Record

.Record_Null_Target:

        push 0 ; target ID
        push 0 ; target RTTI


.Do_Record:

        push edx
        call 0x00405BB0 ; __stdcall AbstractClass::Fetch_ID(void)
        push eax ; my ID

        mov  ecx, edx
        mov  eax, [ecx]      ; vtable
        call dword [eax+2Ch] ; AbstractClass::What_Am_I()
        push eax ; my RTTI

        call record_tarcom_void

        ; clean up all of our passed arguments from the stack
        pop  eax
        pop  eax
        pop  eax
        pop  eax
        pop  eax

.Past_Record:
        pop edx
        pop ecx

.Reg:
        ; Original code, replace bytes that we took for our jump-to-hack
        push esi
        mov  esi, ecx
        push edi
        mov  edi, [esp+0Ch]
        jmp  0x004D4778

