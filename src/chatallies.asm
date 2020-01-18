%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

gstring str_ToAllies, "(Allies): "
gstring str_ToAll, "(All): "
gstring str_ToOne, "(one): "
gstring str_ToSpectators, "(Specs): "

gbool ChatToAlliesFlag, 0
gbool ChatToAllFlag, 0
gbool ChatToOneFlag, 0
gbool ChatToSpectatorsFlag, 0

cextern IsSpectatorArray

;;; ChatToAllies will be set in hotkeys.c
;;; Chatting is hardcoded to look for 0x70 - 0x77 keys by default
;;; Our chat to allies hack will check for the chattoalliesenabled
;;; var before setting up a global "F8" style message which gets
;;; hacked down below.
;;; Also allow an alternate key for chatting to all players
hack 0x005098F1, 0x005098FD
        cmp     byte [ChatToAlliesFlag], 1
        je      .set_chat_allies

        cmp     byte [ChatToSpectatorsFlag], 1
        je      .set_chat_spec

        cmp     byte [ChatToAllFlag], 1
        je      .set_chat_all

        mov     eax, [SessionClass_this]
        mov     ecx, [ebp+0]    ; Regular Code
        cmp     ecx, 0x70       ; F1 Key
        jl      0x00509A6C
        jmp     hackend

 .set_chat_allies:
        mov     edi, str_ToAllies
        jmp     .set_broadcast

.set_chat_spec:
        mov     edi, str_ToSpectators
        jmp     .set_broadcast

 .set_chat_all:
        mov     edi, str_ToAll
        mov     ecx, 0xC5
 .set_broadcast:
        mov     DWORD [MessageToIPaddr], 0xFFFFFFFF
        mov     DWORD [MessageToPort], 0xFFFFFFFF
        mov     DWORD [MessageToAFI], 0xFFFF
        jmp     0x00509A20

hack 0x005738B3, 0x005738B9
        cmp     byte [ChatToAlliesFlag], 1
        je      .zero_message_start

        cmp     byte [ChatToAllFlag], 1
        je      .zero_message_start

        cmp     byte [ChatToSpectatorsFlag], 1
        je      .zero_message_start


        mov     dword [ebp+0x170], ecx
        jmp     hackend

 .zero_message_start:
        mov     dword [ebp+0x170], 0
        jmp     hackend


;;; Unset chattoallies if the user presses esc or if the message has been
;;; transmitted
hack 0x00509D36, 0x00509D3D
        mov     byte [ChatToAlliesFlag], 0
        mov     byte [ChatToAllFlag], 0
        mov     byte [ChatToSpectatorsFlag], 0
        push    2
        mov     ecx, MouseClass_Map
        jmp     hackend


;;; This is the entry point into the broadcast message to all peers loop
;;; if we're chatting to allies we'll get the other guys houseclass and
;;; check for alliedness.
hack 0x00509BDF, 0x00509BE5
        lea     ecx, [IPXManagerClass_this+0x20] ; ConnectionArray
        mov     ecx, [ecx+esi*4]                 ; esi is the loop index
        lea     eax, [ecx+0x64]                  ; 0x64 is the Name string
        push    eax
        call    GetHouseByUserName               ; defined in ts_util.c

        mov     cl, [ChatToSpectatorsFlag]
        test    cl, cl
        jnz     .spectators

        mov     cl, [ChatToAlliesFlag]
        test    cl, cl
        jz      .out

        push    eax
        mov     ecx, [PlayerPtr]
        call    0x004BDA20                       ; HouseClass::Is_Ally(HouseClass *)

        test    al, al
        jz      0x00509C16                       ; Jump over tx message parts
        jmp     .out

 .spectators:
        mov     eax, [eax+0x20]                  ; HouseClass.ID
        cmp     dword [IsSpectatorArray+eax*4], 1
        jne     0x00509C16                       ; Jump over tx message parts

 .out:
        push    esi                              ; Restore clobbered code
        mov     ecx, IPXManagerClass_this
        jmp     hackend
