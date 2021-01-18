%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Red Alert 1 -style vehicle transport implementation
; for Dawn of the Tiberium Age / Tiberian Sun.
; *******************
; Author: Rampastring


sstring str_IsVehicleTransport, "IsVehicleTransport"

; Remove functionality of DoubleOwned= in two locations
; HouseClass::Can_Build
@SJMP 0x004BBC39, 0x004BBC4F
@CLEAR 0x004BBC3B, 0x90, 0x004BBC43

; TechnoTypeClass::Get_Ownable
@SJMP 0x0063B890, 0x0063B8A8
@CLEAR 0x0063B892, 0x0063B89A


; Hack TechnoTypeClass::Read_INI to read IsVehicleTransport=
; Repurposes DoubleOwned
hack 0x0063BA43
    push str_IsVehicleTransport
    jmp  0x0063BA48
    
; Hack an exit point of UnitClass::What_Action to point to our new code below
hack 0x0065645F
    mov  dword [esp+24h], 2
    mov  eax, 2
    jmp  0x0065648F
    
; Hack UnitClass::What_Action to send a radio message RADIO_CAN_LOAD to the transport
hack 0x0065648F
.UnitClass__What_Action_Send_Radio_Message_To_Transport:
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
    
    ; Check that we're controlling our own unit
    mov  ecx, [esi+0ECh]       ; get house of the selected object
    call HouseClass__Is_Player
    cmp  eax, 1
    jne  .Restore_Original_Value_And_Return
    
    ; Check that the object under the cursor is owned by us
    mov  ecx, [esi+0ECh] ; 0ECh = Owner
    mov  eax, [ebx+0ECh]
    cmp  ecx, eax
    je   .Post_Ally_Check
    
    ; If it's not owned by us, check whether it's allied to us
    push ebx
    mov  ecx, [esi+0ECh]
    call HouseClass__Is_Ally_Techno
    cmp  eax, 1
    jne  .Restore_Original_Value_And_Return
    
.Post_Ally_Check
    ; Check if the object under the cursor is a unit
    mov  edx, [ebx]      ; object vtbl
    mov  ecx, ebx        ; object pointer
    call dword [edx+2Ch] ; AbstractClass::What_Am_I()
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
    push eax
    mov  ecx, [eax]
    call dword [ecx+10h] ; DriveLocomotionClass_Is_Moving
    test al, al
    jnz .NoEnter         ; The transport was moving, jump out


.PostCheckMovingTransport:
    ; Check that we're not commanding a transport to prevent transport-in-transport
    ; First check if we're commanding a vehicle (UnitType)
    mov  edx, [esi]      ; object vtbl
    mov  ecx, esi        ; object pointer
    call dword [edx+2Ch] ; AbstractClass::What_Am_I()
    cmp  eax, 1
    jne  .Transmit_Message ; we're not commanding a vehicle, proceed
    
    ; If we are commanding a vehicle, check if it's a vehicle transport
    mov  eax, [esi+360h] ; Get UnitTypeClass instance
    mov  ecx, [eax+449h] ; TechnoTypeClass.DoubleOwned (now actually TechnoTypeClass.IsVehicleTransport)
    and  ecx, 1          ; Only use 1 bit of the byte
    cmp  ecx, 1
    je   .NoEnter        ; We're commanding a vehicle transport, jump out
    
.Transmit_Message
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
    cmp  ecx, 0
    je   .Check_If_Talking_To_Transport ; Our NavCom is null, move on
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
    mov  ecx, esi ; esi = object we're in radio contact with
    mov  eax, [ecx] ; vtable
    call [eax+2Ch]  ; What_Am_I()
    cmp  eax, 1     ; RTTI_UNIT
    jne  0x006515A4
    mov  [ebp+278h], esi
    jmp  .Post_Radio_Check
    
    
; Hack UnitClass::Mission_Unload
; Tiberian Sun assumes that all objects unloaded from a vehicle are infantry,
; and so assigns the objects to sub-cells like they were infantry.
; This causes unloaded vehicles to be stuck in wrong sub-cell positions
; which causes a graphical issue and also issues with object interactions,
; such as movement collisions and docking into repair bays for repair (the repair bays
; don't realize that the unit is standing on the bay if the unit is on a wrong sub-cell position).
; Normally vehicles are always on the center sub-cell spot.
;
; Red Alert 1 does not have this bug due to its different unload logic and
; Yuri's Revenge also has the bug fixed. To fix it here, we hack the return value
; of DisplayClass::Closest_Free_Spot to force unloaded vehicles
; to be in the center of the cell instead of a sub-cell reserved for infantry.
; It's a hacky fix, but the easiest way to solve it with ASM and limited knowledge of the engine.
hack 0x006542B6
    ; restore original code
    mov  [ScenarioInit], ebx
    mov  [esp+38h], eax
    
    mov  ecx, ebp   ; move unloaded object to "this" pointer
    mov  eax, [ebp] ; vtable
    call [eax+2Ch]  ; What_Am_I()
    cmp  eax, 0Fh   ; RTTI_INFANTRY
    jne   .NonInfantry
    
.Infantry:
    mov  ecx, MouseClass_Map
    jmp  0x006542C5

.NonInfantry:
    mov  ecx, MouseClass_Map
    call DisplayClass__Closest_Free_Spot
    mov  ecx, [eax]     ; gets X coord
    and  ecx, 0xFFFFFF00    ; erase the sub-cell information (last 8 bits of the integer)
    add  ecx, 0x80      ; add coord for center of the sub-cell 
                        ; (128 = 0x80, an entire sub-cell being 255 = 0xFF in length)
    mov  [esp+2Ch], ecx ; save X coord
    lea  ecx, [esp+10h]
    mov  edx, [eax+4]   ; get Y coord, perform the same operation as for the X coord above
    and  edx, 0xFFFFFF00
    add  edx, 0x80
    mov  [esp+30h], edx
    mov  eax, [eax+8]   ; Z coord, at least we don't need to mess with it :)
    mov  [esp+34h], eax
    push ecx
    mov  ecx, MouseClass_Map
    jmp 0x006542E8

