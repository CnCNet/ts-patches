%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern SpawnerActive
;;; Set Game Speed 6 to 55 FPS rather than 45 FPS
@SET 0x005B1AAA, dd 55
hack 0x005B1A9F
        cmp DWORD [SpawnerActive], 1
        je  .speed_1

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
