%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Patches to make it possible to view ingame videos
; in multiplayer.
; *******************
; Author: Rampastring

cextern PlayMoviesInMultiplayer

sint NextNetworkRefreshTime, 0
gbool NetworkRefreshStarted, false


; Display lose movies in multiplayer.
hack 0x005DCDB7
    cmp byte [PlayMoviesInMultiplayer], 0
    je   .Normal_Code

    ; allow skipping the movie, network communication isn't relevant at this stage anymore
    mov  byte [PlayMoviesInMultiplayer], 0

    push 1
    push 1
    or   edx, 0xFFFFFFFF
    mov  ecx, [Scen]
    mov  ecx, [ecx+93Ch] ; ScenarioClass.LoseMovie
    call Play_Movie_VQType

.Normal_Code:
    mov  ecx, [WWMouseClas_Mouse]
    mov  byte [GameActive], 0
    mov  eax, [ecx] ; vtable
    call [eax+10h]  ; virtual call for Show_Mouse
    jmp  0x005DCDC8


; Display win movies in multiplayer.
hack 0x005DC9F9
    cmp byte [PlayMoviesInMultiplayer], 0
    je   .Normal_Code

    ; allow skipping the movie, network communication isn't relevant at this stage anymore
    mov  byte [PlayMoviesInMultiplayer], 0

    push 1
    push 1
    or   edx, 0xFFFFFFFF
    mov  ecx, [Scen]
    mov  ecx, [ecx+938h] ; ScenarioClass.WinMovie
    call Play_Movie_VQType

.Normal_Code:
    mov  ecx, [WWMouseClas_Mouse]
    mov  byte [GameActive], 0
    mov  eax, [ecx] ; vtable
    call [eax+10h]  ; virtual call for Show_Mouse
    jmp  0x005DCA0B


; Players skipping movies in multiplayer leads to disconnects.
; Prevent players from skipping movies in MP.
hack 0x0066BB61
    cmp  byte [PlayMoviesInMultiplayer], 1
    je   0x0066BA30 ; don't allow skipping movie

    mov  ecx, [0x007482C0] ; WWKeyboardClass* Keyboard
    jmp  0x0066BB67 ; jump back to keyboard check


; Hack VQA playback loop to do some network communication in MP
; so the tunnel server doesn't forget about us
hack 0x0066BA56
    cmp  byte [PlayMoviesInMultiplayer], 1
    jl   .No_Network_Processing

    cmp  dword [SessionType], 0 ; Spawner might set session type to either 3 or 4, so it
                                ; might be cleanest if we just don't check it that precisely
    je   .No_Network_Processing

    ; Check if we should send a message on this FMV frame
    ; we don't do it each frame to avoid flooding the other player(s)

    call [_imp__timeGetTime]
    mov  ecx, eax

    cmp  eax, [NextNetworkRefreshTime]
    jl   .No_Network_Processing

    ; Update network refresh time, only update
    ; once every 1 second
    add  ecx, 1000
    mov  [NextNetworkRefreshTime], ecx

    ; Skip first iteration
    cmp  byte [NetworkRefreshStarted], 0
    jne  .Send_Message

    mov  al, 1
    mov  byte [NetworkRefreshStarted], al
    jmp  .No_Network_Processing


.Send_Message:
    ; Send message
    ; TODO could do something else to send a message here
    ; instead of abusing the session loading message
    push 64h
    mov  ecx, SessionClass_this
    call 0x005EF930 ; SessionClass::Loading_Callback(int)

    ; Handle incoming network messages
    call 0x00462C60 ; Call_Back()

.No_Network_Processing:
    ; Restore bytes / code that we destroyed with our jump to this hack
    push ebx
    push ebx
    push ebx
    lea  edx, [esp+28h]
    jmp  0x0066BA5D
