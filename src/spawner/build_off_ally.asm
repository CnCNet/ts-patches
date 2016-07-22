@JMP 0x004762EA _Build_Off_Ally

; returns 1 or 0 in EAX
Is_Mutual_Ally:

    mov edx, [esp+4]
    mov eax, [esp+8]
    
    mov esi, [HouseClassArray] ; HouseClassArray
    mov edi, [esi+4*edx]
    
    push edx
    push eax
    
    push eax
    mov ecx, edi
    call HouseClass__Is_Ally
    cmp al, 0
    
    pop edx
    pop eax
       
    jz .Return_False
    
    mov esi, [HouseClassArray] ; HouseClassArray
    mov edi, [esi+4*edx]
    
    push eax
    mov ecx, edi
    call HouseClass__Is_Ally
    cmp al, 0
    jz .Return_False
    
.Return_True:
    mov eax, 1
    retn 8
    
.Return_False:
    mov eax, 0
    retn 8

_Build_Off_Ally:
    mov ecx, [esp+0x38]
    
    cmp byte [var.BuildOffAlly], 1
    jz .Check_Ally

    cmp [edx+20h], ecx
    jnz 0x476308
 
    jmp 0x004762F3
    
.Check_Ally:
    
    push eax
    
    push ecx
    mov eax, dword [edx+0x20]
    push eax
    call Is_Mutual_Ally
    cmp eax, 0
    
    pop eax
    
    jz 0x00476308
    
    jmp 0x004762F3