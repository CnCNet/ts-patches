; Hack for changing the in-game menu text color based on the player's side
; Author: Rampastring

%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

section .bss
    PlayerSide RESD 1

section .text

hack 0x004E7EC2 ; Store_Side:
   ; Read the side when the game calls prepares mixfiles for the side
   mov dword [PlayerSide], ecx
   call 0x004082D0 ; logging function, log the "Preparing Mixfiles for Side %02d" line
                 ; that we're skipping by replacing the call instruction at
                 ; 0x004E7EC2 with jmp
   jmp 0x004E7EC7 ; original code after logging function call

hack 0x00591367 ; Set_Color:
   pushad
   
   cmp dword [PlayerSide], 0
   jz .Default_Color
   
   cmp dword [PlayerSide], 1
   jz .Default_Color
   
   cmp dword [PlayerSide], 2
   jz .Allied_Color
   
   cmp dword [PlayerSide], 3
   jz .Soviet_Color
   
.Default_Color:

   ; For GDI and Nod (sides 0 and 1) we'll use the usual color
   mov dword [0x00808B7C], 0FF70h
   jmp .out
   
.Allied_Color:
   
   ; For Allies, we use 76,163,255, also known as 0FFA349h
   mov dword [0x00808B7C], 0FFA349h
   jmp .out
   
.Soviet_Color:

    ; For Soviet, we use 255,0,0
    mov dword [0x00808B7C], 0FFh
  
.out:
    popad
    jmp 0x00591371
