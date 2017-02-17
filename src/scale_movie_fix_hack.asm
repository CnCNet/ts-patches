%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern ScaleMovieFix


hack 0x005637FD, 0x00563805 ; Play_Movie
    call 0x004082D0
    add esp, 0x14
    
    pushad
    lea eax, [esi+0x38]
    push eax
    lea eax, [esi+0x34]
    push eax
    lea eax, [esi+0x40]
    push eax
    lea eax, [esi+0x3C]
    push eax
    call ScaleMovieFix
    add esp, 16
    popad
    
    jmp hackend
