%include "macros/patch.inc"
%include "macros/datatypes.inc"

;const WaveClass::Laser_Draw_It(int,int) crash - Force DetailLevel to 1

@SET 0x006715F3, { mov eax, 1 }

@PATCH 0x004FC417
    mov ecx, 1
    nop
@ENDPATCH 
