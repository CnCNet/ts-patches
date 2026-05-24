%include "macros/patch.inc"
%include "macros/datatypes.inc"

%ifdef SPAWNER

cextern SkipBriefingOnMissionStart

; Fixes [Basic]Theme= so it does not stop playing
; music after the track has been played once
; AlexB's original hack: http://ppmforums.com/viewtopic.php?p=547837#547837

; @CALL 0x005DB3FD, 0x00643F20

; Rewrite by Rampastring
hack 0x005DB3F7
    ; Don't play scenario intro music if we're loading a saved game
    cmp byte [SkipBriefingOnMissionStart], 1
    je  .Queue_Random_Track

    push eax ; play song defined in scenario Intro=
    jmp .Cont

.Queue_Random_Track:
    push 0FFFFFFFEh ; THEME_PICK_ANOTHER

.Cont:
    mov  ecx, 0x007E2248 ; initialize ThemeClass "this" pointer
    call 0x00643F20 ; ThemeClass::Queue_Song(ThemeType), fix by AlexB
    jmp  0x005DB410 ; continue initializing game options

%endif // SPAWNER
