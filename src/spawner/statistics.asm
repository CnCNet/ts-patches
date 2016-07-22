@JMP 0x004BAC2C _HouseClass__HouseClass_Allocate_UnitTrackerClass_Stuff
@JMP 0x0060A79C _Send_Statistics_Packet_Write_Statistics_Dump
@JMP 0x005B4333 _sub_5B4290_Send_Statistics_Spawner
@JMP 0x005B1E94 _Queue_AI_Multiplayer_Send_Statistics_Spawner
@JMP 0x00509220 _sub_508A40_Send_Statistics_Spawner1
@JMP 0x0050927A _sub_508A40_Send_Statistics_Spawner2

@JMP 0x005B4FAE _Execute_DoList_Send_Statistics_Game_Leave
@JMP 0x005B4FD3 _Execute_DoList_Send_Statistics_Game_Leave2

_Execute_DoList_Send_Statistics_Game_Leave2:
    mov edx, [SessionType]

    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp .Send
    
.Send:
 jmp 0x005B4FDE

.Dont_Send:
 jmp 0x005B500C
 
.Normal_Code:
    mov edx, [SessionType]
    cmp edx, 4
    jnz .Dont_Send
    jmp .Send


_Execute_DoList_Send_Statistics_Game_Leave:
    mov edx, [SessionType]

    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp 0x005B4FB9

.Dont_Send:
    jmp 0x005B500C
    
.Normal_Code:
    mov edx, [SessionType]
    cmp edx, 4
    jnz .Dont_Send
    jmp 0x005B4FB9


_sub_508A40_Send_Statistics_Spawner2:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp .Send
    
.Send:
 jmp 0x00509283

.Dont_Send:
 jmp 0x005092A5
 
.Normal_Code:
    cmp dword [SessionType], 4
    jnz .Dont_Send
    jmp .Send

_sub_508A40_Send_Statistics_Spawner1:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp .Send
    
.Send:
 jmp 0x00509229

.Dont_Send:
 jmp 0x0050924B
 
.Normal_Code:
    cmp dword [SessionType], 4
    jnz .Dont_Send
    jmp .Send

_Queue_AI_Multiplayer_Send_Statistics_Spawner:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp .Send
    
.Send:
 jmp 0x005B1EA0

.Dont_Send:
 jmp 0x005B1F21
 
.Normal_Code:
    cmp dword [SessionType], 4
    jnz .Dont_Send
    jmp .Send

_sub_5B4290_Send_Statistics_Spawner:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp .Send
    
.Send:
 jmp 0x005B433C

.Dont_Send:
 jmp 0x005B439F
 
.Normal_Code:
    cmp dword [SessionType], 4
    jnz .Dont_Send
    jmp .Send


_Send_Statistics_Packet_Write_Statistics_Dump:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code
    
    call Write_Stats_File
    mov dword [StatisticsPacketSent], 1
    jmp 0x0060A7DF
    
.Normal_Code:
    mov edx, [0x0080CA48]
    jmp 0x0060A7A2

Write_Stats_File:
    push ebp
    mov ebp, esp

%define stats_buf     EBP-4
%define stats_length  EBP-4-4
%define stats_file    EBP-4-4-256
    sub esp,4+4+256

    lea ebx, [stats_buf]
    mov [ebx], eax
    lea ebx,[stats_length]
    mov edx, [0x0080CA48] ; packet size
    mov [ebx],edx

    lea ecx,[stats_file]
    push str_stats_dmp
    call FileClass__FileClass

    push 3
    lea ecx, [stats_file]
    call FileClass__Open
    test eax, eax
    je .exit

    mov ebx, [stats_length]
    push ebx
    mov edx,[stats_buf]
    push edx

    lea ecx, [stats_file]
    CALL FileClass__Write

    lea ecx,[stats_file]
    CALL FileClass__Close

.exit:
    MOV eax,1

    mov esp,ebp
    pop ebp
    retn 
    
    
_HouseClass__HouseClass_Allocate_UnitTrackerClass_Stuff:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code

    cmp dword [SessionType], 0
    jz .Normal_Code
    
    jmp .Allocate

.Normal_Code:
    cmp dword [SessionType], 4
    jnz .Dont_Allocate
    jmp .Allocate

.Allocate:
    jmp 0x004BAC39
    
.Dont_Allocate:
    jmp 0x004BADB0

