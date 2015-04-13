@CLEAR 0x004B6D04 0x90 0x004B6D0D
@JMP 0x004B6D04 ForceSurrenderOnAbort
@JMP 0x00494F08 AutoSurrenderOnConnectionLost

ForceSurrenderOnAbort:
    cmp dword[var.SpawnerActive], 1
    jnz .out
    cmp dword[SessionType], 3
    jnz .out
    mov dword[0x7E4940], 2
    jmp 0x004B6D2A

.out:
    cmp dword[SessionType], 4
    jne 0x004B6D20
    jmp 0x004B6D0D

    
AutoSurrenderOnConnectionLost:
    cmp dword[var.SpawnerActive], 1
    jnz .out
    cmp dword[SessionType], 3
    jnz .out
    jmp 0x00494F16

.out:
    cmp eax, 4
    jne 0x00494F28
    jmp 0x00494F0D
