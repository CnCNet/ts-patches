%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern VideoWindowed
cextern UsingTSDDRAW

;;; Setup th main window to be the requested size (reg TS always tries to do 640x480 in the menus)
hack 0x006013DE
    mov edx, [ScreenWidth]
    jmp hackend

 .Reg:
    mov edx, 640
    jmp hackend

;;; Setup th main window to be the requested size (reg TS always tries to do 640x480 in the menus)
hack 0x00601335
    mov  esi, [ScreenHeight]
    push esi
    push dword[ScreenWidth]
    jmp  0x006013A5

 .Reg:
    mov  esi, 480
    jmp  hackend



;;; Don't set the screen to 640x480 while in fullscreen mode.
hack 0x006015AD
    mov edx, [ScreenWidth]
    jmp hackend

 .Reg:
    mov edx, 0x280
    jmp hackend

;;; Don't set the screen to 640x480 while in fullscreen mode.
hack 0x006015E6
    mov edx, [ScreenWidth]
    jmp hackend

 .Reg:
    mov edx, 0x280
    jmp hackend

hack 0x0060161C
    add esp, 4
    push dword[ScreenHeight]
    mov  edx, dword[ScreenWidth]
    call 0x00472DF0
    jmp  0x0060141C


;;; Don't reset video mode on Win or Lose
hack 0x005DCCB7, 0x005DCCBD
    jmp 0x005DCD06

 .Reg:
    cmp byte[0x007E4902], bl
    jz  0x005DCD06
    jmp hackend

hack 0x005DC96B
    jmp 0x005DC9BB

 .Reg:
    mov al, byte[0x007E4902]
    jmp hackend

;; Do_Abort
hack 0x005DD070
    pop edi
    jmp 0x005DD0C1

 .Reg:
    mov al, byte[0x007E4902]
    jmp hackend

;;; This will force the game to always use ddraw's blit function rather than WW blit.
;;; We're avoiding ww blit functions because they are not thread safe
@SET 0x0048B70E, { mov bl, 0 }
