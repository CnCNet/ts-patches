%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern VideoWindowed
cextern UsingTSDDRAW

hack 0x0048B6C1, 0x0048B6CE
    cmp byte[UsingTSDDRAW], 0
    jz .out

    jmp hackend

.out:
    cmp byte[VideoWindowed], 1
    jnz hackend
    xor al, al
    jmp 0x0048B6D5


;;; Setup th main window to be the requested size (reg TS always tries to do 640x480 in the menus)
hack 0x006013DE
    cmp byte[UsingTSDDRAW], 0
    jz  .Reg

    mov edx, [ScreenWidth]
    jmp hackend

 .Reg:
    mov edx, 640
    jmp hackend

;;; Setup th main window to be the requested size (reg TS always tries to do 640x480 in the menus)
hack 0x00601335
    cmp byte[UsingTSDDRAW], 0
    jz  .Reg

    mov  esi, [ScreenHeight]
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp  0x006013A5

 .Reg:
    mov  esi, 480
    jmp  hackend


;;; Don't reset video mode on Win or Lose
hack 0x005DCCB7, 0x005DCCBD
    cmp byte[UsingTSDDRAW], 0
    jnz 0x005DCD06

    cmp byte[0x007E4902], bl
    jz  0x005DCD06
    jmp hackend

hack 0x005DC96B
    cmp byte[UsingTSDDRAW], 0
    jnz 0x005DC9BB

    mov al, byte[0x007E4902]
    jmp hackend
