<<<<<<< HEAD

@JMP 0x005DB794 _short_timeout
_short_timeout:
    mov ecx, 1200
    jmp 0x005DB799
=======
%include "macros/patch.inc"
%include "macros/datatypes.inc"

@SET 0x005DB794, {mov ecx, 1200}
>>>>>>> 24f5242... bug fix - use cextern and cglobal - remove var.
