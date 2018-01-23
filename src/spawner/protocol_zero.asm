%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

@CLEAR 0x00508B0C, 0x90, 0x00508B19
@CLEAR 0x005B1A2D, 0x90, 0x005B1A3B

;;; Use compressed packets for all protocols
@CLEAR 0x005B3751, 0x90, 0x005B3753
@CLEAR 0x005B3313, 0x90, 0x005B3319

; Don't set framesend rate to 10 in Generate_Process_Time_Event
hack 0x005B1C28
    mov al, byte[FrameSendRate]
    push ecx
    jmp hackend

hack 0x005B1BAF
    cmp dword[ProtocolVersion], 0
    jnz .proto_2

    mov edx, [MaxAhead]
    and edx, 0xffff

 .proto_2:
    mov [esp+0x34], dx
    jmp hackend
