@JMP 0x00509D2F _Message_Input_Display_Messages_Typed_By_Yourself

_Message_Input_Display_Messages_Typed_By_Yourself:
%push
    push ebp
    mov ebp,esp
    sub esp,512

%define TempBuf ebp-512

    mov ecx, edx
    and ecx, 3
    rep movsb
    
; Create <player name>: <message> string
    mov esi, 0x007E36AE     ; text to sent
    push esi
    mov esi, [PlayerPtr]
    lea esi, [esi+10DE4h]   ; our name
    push esi
    push str_message_fmt    ; %s: %s
    lea esi, [TempBuf]
    push esi
    call _sprintf
    add esp, 10h

; Calculate message duration
    mov eax, [0x0074C488]   ; eax, RulesClass?
    fld qword [eax+0C68h]
    fmul qword [0x006CB1B8]
    call Get_Message_Delay_Or_Duration
    
; Push arguments
    push eax                ; Message delay/duration 
    push 4046h              ; Very likely TextPrintType 
    mov ecx, MessageListClass_this
    mov edx, [PlayerPtr]
    mov edx, [edx+10DFCh]
    push edx ; Color to use?
    lea edx, [TempBuf]
    push edx
    push 0 
    push 0 
    call MessageListClass__Add_Message
    
.Ret:
    mov esp,ebp
    pop ebp
    jmp 0x00509D36
%pop
