; Hack for changing the in-game menu text color based on the player's side
; Author: Rampastring

%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

@LJMP 0x00591367, Set_Color
@LJMP 0x005DD7A2, Store_Side

section .bss
    PlayerSide RESD 1

section .text

Store_Side:
   ; Read the side when the game calls Prep_For_Side 
   ; and store the side index in a variable
   mov dword [PlayerSide], ecx
   call 0x004E7EB0 ; Prep_For_Side()
   jmp 0x005DD7A7 ; original code after Prep_For_Side call

Set_Color:
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
