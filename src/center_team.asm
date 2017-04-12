%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Double tap the team selection key to center team on screen.
;;; Current way is to press alt+1 or alt+2 etc, to center team

gint DoubleTapFrame, 0x7fffffff
gint LastTeamNumber, 0

hack 0x004E8E80, 0x004E8E86
_SelectTeamCommandClass_Execute_after:
        mov  eax, [Frame]
        mov  ecx, [ebp+4]

        cmp  ecx, [LastTeamNumber]
        jne  .Out

        cmp  eax, [DoubleTapFrame]
        jg   .Out

        pusha
        mov  ecx, ebp
        call CenterTeamCommandClass_Execute
        popa

 .Out:
        add  eax, 30
        mov  [DoubleTapFrame], eax ; Set DoubleTapFrame to Frame + 30
        mov  [LastTeamNumber], ecx ; Set LastTeamNumber to the current team number
 .Reg:
        pop  ebp
        jmp  0x00639C30
