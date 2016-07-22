@JMP 0x00589D31 _Read_SUN_INI_InvisibleSouthDisruptorWave
@JMP 0x00671113 _WaveClass_Draw_South_Disruptor_Wave 

_WaveClass_Draw_South_Disruptor_Wave:
    push ebp
    push edx
    push eax
    mov ecx, esi
    
    cmp byte [var.InvisibleSouthDisruptorWave], 1
    jz .Dont_Draw_Southward
    
    jmp 0x00671118
    
.Dont_Draw_Southward:
    call 0x006704A0
    jmp 0x0067111D

_Read_SUN_INI_InvisibleSouthDisruptorWave:
    push eax
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Options, str_InvisibleSouthDisruptorWave, 0
    mov [var.InvisibleSouthDisruptorWave], al
    pop eax
    jmp 0x00589D3E
    

; Fixes for WaveClass errors related to laser and Ion Cannon ripple effect
@JMP 0x006715F0 _sub_6715F0_RETN_Patch
@JMP 0x004EEB26 _sub_4EEAC0_WCE_Fix_Patch

_sub_4EEAC0_WCE_Fix_Patch:
    jmp 0x004EEB43 ; jump to epilogue

_sub_6715F0_RETN_Patch:
    jmp 0x0067191F ; jump to RETN instruction
