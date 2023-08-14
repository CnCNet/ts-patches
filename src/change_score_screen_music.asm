; Hack for changing the in-game score screen music depending on the player's side
; Author: Rampastring

%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern PlayerSide

sstring str_Score, "SCORE"
sstring str_RAScore, "RASCORE"

section .text

hack 0x005E2F1C ; Hack_Score_Screen_Music:
   call Theme__Stop
   
   cmp dword [PlayerSide], 2
   jl .Tiberian_Dawn_Music
   
   jmp .Red_Alert_Music
   
.Tiberian_Dawn_Music:

   ; For GDI and Nod (sides 0 and 1) we use the normal score screen music
   push str_Score
   jmp .out
   
.Red_Alert_Music:
   
   ; For Allies and Soviet (sides 2 and 3) we use the Red Alert score screen music
   push str_RAScore
   
.out:
    jmp 0x005E2F26
