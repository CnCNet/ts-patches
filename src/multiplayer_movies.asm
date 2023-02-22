%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Patches to make it possible to view ingame videos
; in multiplayer.
; *******************
; Author: Rampastring

cextern PlayMoviesInMultiplayer

sint NextNetworkRefreshTime, 0

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

    ; Update network refresh time
    add  ecx, 1000
    mov  [NextNetworkRefreshTime], ecx

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
