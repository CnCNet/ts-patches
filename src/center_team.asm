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
        dec  ecx

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



;;; Make sure that we don't center the team if no team member was already selected
hack 0x004E8DE6
        mov  eax, dword[CurrentObjectsArray_Count]
        test eax, eax
        jnz  .Compare_Group

        mov dword[LastTeamNumber], -1
        jmp 0x004E8E18

 .Compare_Group:
        mov eax, dword[CurrentObjectsArray_Vector]
        mov ecx, [eax]
        mov eax, dword[LastTeamNumber]
        cmp dword[ecx+0xE4], eax     ; TechnoClass.Group
        mov eax, dword[CurrentObjectsArray_Count]
        je  hackend

        mov dword[LastTeamNumber], -1
        jmp hackend
