%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

;;; Force RandomLoopDelay to use ScenarioClass.CriticalRandomNumber to keep everything in sync.
hack 0x00415AE7
        mov  eax, [0x007E2438]  ; ScenarioClass
        lea  ecx, [eax+0x218]   ; CriticalRandomNumber
        call 0x005BE080         ; Random2Class::Operator
        jmp hackend
