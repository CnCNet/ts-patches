%include "TiberianSun.inc"
%include "macros/patch.inc"

;;; Shift + N = AddTeamCommand N
;;; This patch will make it so that AddTeamCommandClass N puts the newly selected group of units in the
;;; team N group.
;;; (Default TS doesn't do this, instead it just adds team N to the selected units)
cextern AddTeamStyle2

hack 0x004E8FF5
_AddTeamCommandClass_Execute_after:
        cmp  byte[AddTeamStyle2], 0
        jz   .Reg

        mov  ecx, ebp
        call CreateTeamCommandClass_Execute ; Give all the selected units group team N
 .Reg:
        pop  edi
        pop  ebp
        retn
