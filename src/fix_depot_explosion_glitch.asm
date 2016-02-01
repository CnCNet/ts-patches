%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; If you pressed 's' to stop a unit while it was repairing on a service
;;; depot the unit would explode. This patch fixes that by running executing
;;; the scatter function rather than the explode the unit function.
;;; This also might fix the problem of viscroids blowing up randomly
;;; when they cross paths with harvesters. Viscroids hit this code path alot

hack 0x00651D0B, 0x00651DF7
_UnitClass__Per_Cell_Process_dont_explode_my_units:
        mov     edx, [ebp]
        push    1
        push    1
        push    0x0080F910
        mov     ecx, ebp
        call    [edx+0x144]     ; Scatter
        jmp     hackend
