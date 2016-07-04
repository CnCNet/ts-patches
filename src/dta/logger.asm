%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
%include "ini.inc"

@LJMP 0x004082D0, WriteToLog
@LJMP 0x004735C0, WriteToLog
;@LJMP 0x005BE38C, ExtraLogging

section .bss
  log_data resb 4
  log_data2 resb 4
  extra_log_data resd 1
  extra_log_byte resb 0
  
section .text

sstring str_a, "a"
sstring str_DTALog, "DTA.LOG"
sstring str_OK, "OK?\n"
sstring str_Error, "ERROR!\n"
sstring str_LoadFile, "Loading file %s|"

WriteToLog:
    push str_a
    push str_DTALog
    call 0x006B6A2E ; _fopen
    add esp, 8
    mov [log_data], eax
    test eax, eax
    jz .Ret
    mov eax, [esp+0]
    mov [log_data2], eax
    mov eax, [log_data]
    mov [esp+0], eax
    call 0x006B69C1 ; _fprintf
    mov eax, [log_data2]
    mov [esp+0], eax
    mov eax, [log_data]
    push eax
    call 0x06B6944 ; _fclose
    add esp, 4
    
.Ret:
    retn
    
ExtraLogging:
    mov [esi+14h], eax
    cmp dword [extra_log_data], 1
    jz ExtraLog_2
    push ebx
    mov ebx, eax
    push eax
    push ebx
    push str_LoadFile
    lea ebx, [extra_log_byte]
    push ebx
    call 0x006B52EE ; _sprintf
    add esp, 0Ch
    push extra_log_byte
    call 0x004082D0 ; Redirects to WriteToLog
    add esp, 4
    pop eax
    pop ebx
   
ExtraLog_2:
    test eax,eax
    jnz ExtraLog_OK
    cmp dword [extra_log_data], 1
    jnz Skip_Error_Logging
    push str_Error
    call 0x004082D0 ; Redirects to WriteToLog
    add esp, 4
    
Skip_Error_Logging:
    mov eax, [esi]
    push edi
    push 0
    push 0Ch
    mov ecx, esi
    call dword [eax+40h]
    xor eax,eax
    jmp Finish
   
ExtraLog_OK:
    cmp dword [extra_log_data], 1
    jnz Skip_Writing
    push str_OK
    call 0x004082D0 ; Redirects to WriteToLog
    add esp, 4
    
Skip_Writing:
    mov byte [esi+1Ch], 1

Finish:
    pop edi
    pop esi
    retn 4

