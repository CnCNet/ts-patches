; Hack for changing the in-game menu text color based on the player's side
; Author: Rampastring

%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

section .text

hack 0x00591367

   mov dword [0x00808B7C], 0FF70h
   
   cmp byte [0x007E2500], 2
   jz .Allied_Color
   
   cmp byte [0x007E2500], 3
   jz .Soviet_Color
   
.Default_Color:

   ; For GDI and Nod (sides 0 and 1) we'll use the usual color
   jmp .out
   
.Allied_Color:
   
   ; For Allies, we use 76,163,255, also known as 0FFA349h
   mov dword [0x00808B7C], 0FFA349h
   jmp .out
   
.Soviet_Color:

    ; For Soviet, we use 255,0,0
    mov dword [0x00808B7C], 0FFh
  
.out:
    ; the game has a jnz for this comparison at 0x005913AD, our code breaks it
    cmp eax, ebx
    jmp 0x00591371
