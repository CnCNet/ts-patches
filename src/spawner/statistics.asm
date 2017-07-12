%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern SpawnerActive
cextern IsSpectatorArray
cextern SpawnLocationsArray

@LJMP 0x004BAC2C, _HouseClass__HouseClass_Allocate_UnitTrackerClass_Stuff
@LJMP 0x0060A79C, _Send_Statistics_Packet_Write_Statistics_Dump
@LJMP 0x005B4333, _sub_5B4290_Send_Statistics_Spawner
@LJMP 0x005B1E94, _Queue_AI_Multiplayer_Send_Statistics_Spawner
@LJMP 0x00509220, _sub_508A40_Send_Statistics_Spawner1
@LJMP 0x0050927A, _sub_508A40_Send_Statistics_Spawner2

@LJMP 0x005B4FAE, _Execute_DoList_Send_Statistics_Game_Leave
@LJMP 0x005B4FD3, _Execute_DoList_Send_Statistics_Game_Leave2

@LJMP 0x00609810, UseInternalMapNameInsteadFilename
@LJMP 0x006097FD, AddACCNField
@LJMP 0x00609D73, AddMyIdField

@LJMP 0x00609F40, _Send_Statistics_Packet_Write_New_Fields

section .rdata
    str_MyIdField db "MYID",0
    str_AccountNameField db "ACCN",0
    str_stats_dmp: db "stats.dmp",0

section .text

_Send_Statistics_Packet_Write_New_Fields:

	push    eax
	lea     ecx, [esp+0x18]
	call    0x005A22D0 ; PacketClass::Add_Field(FieldClass *)

	; write 'SPC'
	mov     byte [0x0070FD0C], 0x53
	mov     byte [0x0070FD0D], 0x50
	mov     byte [0x0070FD0E], 0x43

	; player number
	mov     byte [0x0070FD0F], bl

	mov     edi, [esi+0x20] ; value
	mov		edi, [IsSpectatorArray+edi*4]

	push    10h
	call    0x006B51D7 ; operator new(uint)
	add     esp, 4
	test    eax, eax
	jz      .new_failed1
	push    edi
	push    0x0070FD0C
	mov     ecx, eax
	call    0x00498A70  ; FieldClass::FieldClass(char *,ulong)
	jmp     short .Write_Alliances


.new_failed1:
	xor     eax, eax

.Write_Alliances:

	push    eax
	lea     ecx, [esp+0x18]
	call    0x005A22D0 ; PacketClass::Add_Field(FieldClass *)

	; write 'ALY'
	mov     byte [0x0070FD0C], 0x41
	mov     byte [0x0070FD0D], 0x4c
	mov     byte [0x0070FD0E], 0x59

	; player number
	mov     byte [0x0070FD0F], bl

	mov     edi, [esi+0x578] ; value

	push    10h
	call    0x006B51D7 ; operator new(uint)
	add     esp, 4
	test    eax, eax
	jz      .new_failed2
	push    edi
	push    0x0070FD0C
	mov     ecx, eax
	call    0x00498A70  ; FieldClass::FieldClass(char *,ulong)
	jmp     short .Write_Spawns

.new_failed2:
	xor     eax, eax

.Write_Spawns:

	push    eax
	lea     ecx, [esp+0x18]
	call    0x005A22D0 ; PacketClass::Add_Field(FieldClass *)

	; write 'SPA'
	mov     byte [0x0070FD0C], 0x53
	mov     byte [0x0070FD0D], 0x50
	mov     byte [0x0070FD0E], 0x41

	; player number
	mov     byte [0x0070FD0F], bl

	mov     edi, [esi+0x20] ; value
	mov		edi, [SpawnLocationsArray+edi*4]

	push    10h
	call    0x006B51D7 ; operator new(uint)
	add     esp, 4
	test    eax, eax
	jz      .new_failed3
	push    edi
	push    0x0070FD0C
	mov     ecx, eax
	call    0x00498A70  ; FieldClass::FieldClass(char *,ulong)
	jmp     short .ret

.new_failed3:
	xor     eax, eax

.ret:

	; Reset field name to 'COL'
	mov     byte [0x0070FD0C], 0x43
	mov     byte [0x0070FD0D], 0x4f
	mov     byte [0x0070FD0E], 0x4c

	push    eax
	lea     ecx, [esp+0x18]
	jmp		0x00609F45


AddMyIdField:
    add bl, 0x30

    mov eax, dword[PlayerPtr]
    cmp eax, esi
    jnz .out

    push 0x10
    call 0x006B51D7 ; OperatorNew
    add esp, 4
    test eax, eax
    jz .fail

    xor ecx, ecx
    mov cl, bl
    sub cl, '0'
    push ecx
    push str_MyIdField
    mov ecx, eax
    call 0x00498A70 ; FieldClass::FieldClass
    jmp .noFail

.fail:
    xor eax, eax

.noFail:
    push eax
    lea ecx, [esp+0x18]
    call 0x005A22D0 ;PacketClass__Add_Field

.out:
    push 0x10
    jmp 0x00609D78

AddACCNField:
    call 0x005A22D0

    push 0x10
    call 0x006B51D7 ; OperatorNew
    add esp, 4
    cmp eax, edi
    je .fail
    mov ecx, dword[PlayerPtr]
    lea ecx, [ecx+0x10DE4] ; 0x10DE4 = HC_PLAYER_NAME
    push ecx
    push str_AccountNameField
    mov ecx, eax
    call 0x00498AD0 ; FieldClass__FieldClass_String
    jmp .noFail

.fail:
    xor eax, eax

.noFail:
    push eax
    lea ecx, [esp+0x18]
    call 0x005A22D0 ;PacketClass__Add_Field
    jmp 0x00609802


UseInternalMapNameInsteadFilename:
    mov ecx, dword[0x7E2438]
    add ecx, 0x904
    push ecx
    jmp 0x00609815


_Execute_DoList_Send_Statistics_Game_Leave2:
    mov edx, [SessionType]

    cmp dword [SpawnerActive], 0
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

    cmp dword [SpawnerActive], 0
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
    cmp dword [SpawnerActive], 0
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
    cmp dword [SpawnerActive], 0
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
    cmp dword [SpawnerActive], 0
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
    cmp dword [SpawnerActive], 0
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
    cmp dword [SpawnerActive], 0
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
    cmp dword [SpawnerActive], 0
    jz .Normal_Code

    cmp dword [SessionType], 0
    jz .Normal_Code

    jmp .Allocate

.Normal_Code:
    jmp .Allocate

.Allocate:
    jmp 0x004BAC39

.Dont_Allocate:
    jmp 0x004BADB0

%ifdef STATS
@SET 0x0042F79E, { cmp eax, 3 }
@SET 0x00457E7A, { cmp dword[SessionType], 3 }
@SET 0x004C220B, { cmp dword[SessionType], 3 }
@SET 0x004C2255, { cmp dword[SessionType], 3 }
@SET 0x004C229F, { cmp dword[SessionType], 3 }
@SET 0x004C22E5, { cmp dword[SessionType], 3 }
@SET 0x0063388A, { cmp dword[SessionType], 3 }
@SET 0x006338F4, { cmp dword[SessionType], 3 }
@SET 0x0063395C, { cmp dword[SessionType], 3 }
@SET 0x00633928, { cmp dword[SessionType], 3 }
%endif
