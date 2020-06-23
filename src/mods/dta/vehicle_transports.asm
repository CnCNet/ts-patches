%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Red Alert 1 -style vehicle transport implementation
; for Dawn of the Tiberium Age / Tiberian Sun.
; *******************
; Author: Rampastring


sstring str_IsVehicleTransport, "IsVehicleTransport"

; Hack TechnoTypeClass::Read_INI to read IsVehicleTransport=
; Repurposes DoubleOwned
hack 0x0063BA43
    push str_IsVehicleTransport
    jmp  0x0063BA48
    

; Hack UnitClass::What_Action to send a radio message RADIO_CAN_LOAD to the transport
hack 0x0065648B
    mov  eax, [esp+20h+8]   ; restore code destroyed by jump
    cmp  eax, 5             ; if ACTION_ATTACK, then just return (player might be force-firing on the transport)
    je   .End
    cmp  eax, 4             ; ACTION_SELF, don't override deploying / unloading
    je   .End
    cmp  eax, 8             ; Allow the player to shift-select
    je   .End
    
    ; We act politely, so don't allow telling the transports to enter themselves
    cmp  esi, ebx
    je   .End
    
    mov  ecx, [esi+0ECh]    ; get our house
    call HouseClass__Is_Player ; check that we're a player? WW does this a lot, not sure why
    cmp  eax, 1
    jne  .End
    
    ; Check if the object under the cursor is a unit
    mov  edx, [ebx]      ; object vtbl
    mov  ecx, ebx        ; object pointer
    call dword [edx+2Ch] ; What_Am_I()
    cmp  eax, 1          ; RTTI_UNIT
    jne  .Restore_Original_Value_And_Return
    
    ; Is the object under the cursor a transport?
    mov  eax, [ebx+360h] ; Get UnitTypeClass instance
    mov  ecx, [eax+31Ch] ; TechnoTypeClass.Passengers
    test ecx, ecx
    jle  .Restore_Original_Value_And_Return
    ; Is it a vehicle transport?
    mov  ecx, [eax+449h] ; TechnoTypeClass.DoubleOwned (now actually TechnoTypeClass.IsVehicleTransport)
    and  ecx, 1          ; Only use 1 bit of the byte
    cmp  ecx, 1
    jl   .Restore_Original_Value_And_Return
    
    ; Infantry code has the following unknown check:
    ; mov  eax, [ebx+298h]
    ; test eax, eax
    
    ; Is the object moving?
    mov  eax, [ebx+32Ch] ; Get locomotor
    test eax, eax   ; COM error handling (smart locomotor pointer)
    jnz  .Cont
    push 80004003h
    call 0x006C61E0 ; _com_issue_error
    
.Cont:
    mov  eax, [esi+32Ch]
    push eax
    mov  ecx, [eax]
    call dword [ecx+10h] ; DriveLocomotionClass_Is_Moving
    test al, al
    jz .PostCheckMovingTransport
    ; The transport was moving, return ACTION_NO_ENTER
    jmp .NoEnter

.PostCheckMovingTransport:
    ; Transmit message
    mov  edx, [esi]
    push ebx              ; pointer to object to transfer message to
    push 0Fh              ; RADIO_CAN_LOAD
    mov  ecx, esi
    call dword [edx+218h] ; RadioClass::Transmit_Message
    cmp  eax, 1           ; RADIO_ROGER
    jne  .NoEnter
    mov  eax, 3           ; ACTION_ENTER
    mov  [esp+20h+8], eax
    jmp .End
    
.NoEnter:
    mov  eax, 1Eh ; ACTION_NO_ENTER
    mov  [esp+20h+8], eax
    jmp .End
    
    ; Our jump destroyed a part of the function return procedure, so let's rebuild it
.Restore_Original_Value_And_Return:
    mov  eax, [esp+20h+8]
    
.End:
    pop  edi
    pop  esi
    pop  ebp
    pop  ebx
    add  esp, 10h
    retn 8


; Hack UnitClass::Can_Enter_Cell
; Remove check for IsTethered and check for radio contact instead
; In TS the passenger and transport never form a tethered connection
; like they do in RA, but WW still kept the tether check in this function
hack 0x00655A51
    ; Get object in radio contact
    cmp  esi, [ebx+78h]
    je   0x006554A5
    jmp  0x00655A5F


; 004A64DC puts units to idle mode in certain unknown conditions, make it not do that
; watch out for bugs!
hack 0x004A64B6
    xor  eax, eax
    pop  esi
    pop  ebx
    pop  edi
    retn

; Hack UnitClass::Per_Cell_Process
; Check if we have radio contact with a transport.
; If we don't, ask the transport on NavCom if we can board in.
; If they return RADIO_ROGER and we're close enough, then just hop in.
; Don't require "actual" radio contact.
; If we have radio contact with the transport, proceed regularly, except
; allow boarding into transport from up to 2 cells away.
; Also, if our NavCom is not currently pointing to the transport but we're
; in radio contact with it, assign it as our NavCom.
hack 0x0065159C
    ; Only use our special behaviour if our NavCom is pointing to a unit
    mov  ecx, [ebp+278h] ; Unit destination (NavCom), pointer to AbstractClass
    mov  eax, [ecx] ; vtable
    call [eax+2Ch]  ; What_Am_I()
    cmp  eax, 1     ; RTTI_UNIT
    jne  .Check_If_Talking_To_Transport
    
    test esi, esi
    jnz  .Post_Radio_Check ; Radio contact is established, no need to check if we're allowed in
    mov  edx, [ebp]
    mov  esi, [ebp+278h]   ; Move NavCom to esi if esi == null
    push esi
    push 0Eh ; RADIO_DOCKING
    mov  ecx, ebp
    call dword [edx+218h]  ; RadioClass::Transmit_Message
    cmp  eax, 1
    jne  0x00651631        ; The transport doesn't want us in
                           ; (or we're not talking to a transport at all), abort

.Post_Radio_Check:

    ; Get object locations into registers
    mov  eax, [esi]
    lea  ecx, [esp+14h]
    push ecx
    mov  ecx, esi
    call dword [eax+18Ch]
    mov  edx, [ebp]
    mov  edi, eax
    lea  eax, [esp+10h]
    mov  ecx, ebp
    push eax
    call dword [edx+18Ch]
    
    ; Check X and Y coordinates separately
    
    mov cx, [eax]
    cmp cx, [edi]
    je .Check_y
    
    dec cx
    cmp cx, [edi]
    je .Check_y
    
    dec cx
    cmp cx, [edi]
    je .Check_y
    
    add cx, 3
    cmp cx, [edi]
    je .Check_y
    
    inc cx
    cmp cx, [edi]
    je .Check_y
    
    jmp .out

.Check_y:
    mov dx, [eax+2]
    cmp dx, [edi+2]
    je .Check_Radio_Contact
    
    dec dx
    cmp dx, [edi+2]
    je .Check_Radio_Contact
    
    dec dx
    cmp dx, [edi+2]
    je .Check_Radio_Contact
    
    add dx, 3
    cmp dx, [edi+2]
    je .Check_Radio_Contact
    
    inc dx
    cmp dx, [edi+2]
    je .Check_Radio_Contact

    jmp .out
    
.Check_Radio_Contact:
    ; We're on the same cell or within 2 cells
    
    ;jmp 0x006515D7 ; Check that NavCom matches radio linked unit
    jmp 0x006515DF ; Don't check that NavCom matches radio linked unit
    
.out:
    ; We're too far away from the transport
    jmp 0x00651631

.Check_If_Talking_To_Transport
    ; Check if we are in radio contact with a transport
    test esi, esi
    jz   0x00651631
    mov  ecx, [ebp+278h] ; Unit destination (NavCom), pointer to AbstractClass
    mov  eax, [ecx] ; vtable
    call [eax+2Ch]  ; What_Am_I()
    cmp  eax, 1     ; RTTI_UNIT
    jne  .Original_Code
    mov  [ebp+278h], esi
    jmp  .Post_Radio_Check
    
.Original_Code:
    test esi, esi
    jz   0x00651631
    jmp  0x006515A4
    
    