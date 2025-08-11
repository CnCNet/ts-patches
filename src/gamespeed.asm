%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern SpawnerActive

; Hack multiplayer game speed levels
;;; Set Game Speed 6 to 55 FPS rather than 45 FPS
@SET 0x005B1AAA, dd 55
hack 0x005B1A9F

%ifdef SPAWNER
        cmp DWORD [SpawnerActive], 1
        je  .speed_1
%endif ; SPAWNER

        mov eax, 60
        jmp 0x005B1AA4
.speed_1:
        cmp eax, 5
        jne .speed_2
        mov eax, 15             ;FPS
        jmp .out
.speed_2:
        cmp eax, 4
        jne .speed_3
        mov eax, 20
        jmp .out
.speed_3:
        cmp eax, 3
        jne .speed_4
        mov eax, 30
        jmp .out
.speed_4:
        cmp eax, 2
        jne .speed_5
        mov eax, 40
        jmp .out
.speed_5:
        cmp eax, 1
        jne .fail
        mov eax, 45
        jmp .out
.fail:
        mov eax, 10
.out:
        jmp 0x005B1AB5


; Hook the Main_Loop function
; Hack singleplayer game speed to behave like
; multiplayer game speed
@CLEAR 0x00508AFD, 0x90, 0x00508B0C
;@CLEAR 0x00508AFD, 0x90, 0x00508B19 to also skip over packet protocol check

; if in singleplayer or skirmish, assign DesiredFrameRate
hack 0x00508B47
    cmp dword [SessionType], 0
    je  .Process
    cmp dword [SessionType], 5
    je  .Process
    ; Not in singleplayer, don't perform special processing
    jmp .Out

.Process:
    mov eax, [0x007E4720] ; OptionsClass.GameSpeed,
                          ; OptionsClass instance is static at this address

    ; let's modify it to be...
    ; speed 0 (Fastest) = 1000 FPS, speed 1 (Faster) = 60 FPS,
    ; speed 2 (Fast) = 45 FPS, speed 3 (Medium) = 30 FPS,
    ; speed 4 (Slow) = 20 FPS, speed 5 (Slower) = 15 FPS, speed 6 (Slowest) = 10 FPS
    cmp eax, 0
    je  .speed_0
    cmp eax, 1
    je  .speed_1
    cmp eax, 2
    je  .speed_2
    cmp eax, 3
    je  .speed_3
    cmp eax, 4
    je  .speed_4
    cmp eax, 5
    je  .speed_5
    jmp .speed_6

.speed_0:
    mov eax, 5000
    jmp .Assign_Speed

.speed_1:
    mov eax, 60
    jmp .Assign_Speed

.speed_2:
    mov eax, 45
    jmp .Assign_Speed

.speed_3:
    mov eax, 30
    jmp .Assign_Speed

.speed_4:
    mov eax, 20
    jmp .Assign_Speed

.speed_5:
    mov eax, 15
    jmp .Assign_Speed

.speed_6:
    mov eax, 10
    jmp .Assign_Speed

.Assign_Speed:
    mov [0x007E2514], eax ; 0x007E2514 = DesiredFrameRate
    jmp .Out

.Out:
    mov  eax, 3Ch ; stolen bytes / code
    jmp  0x00508B4C


; Hack Sync_Delay to treat singleplayer similarly to multiplayer
@CLEAR 0x005094ED, 0x90, 0x005094F4
@CLEAR 0x00509544, 0x90, 0x0050955A
