@JMP 0x00686210 SetNoWindowFrame

SetNoWindowFrame:
    cmp byte [var.NoWindowFrame], 1
    jnz .out
    push 0x860A0000
    jmp 0x00686215
    
.out:
    push 0x02CA0000
    jmp 0x00686215
