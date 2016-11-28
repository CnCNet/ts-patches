; "Destroy Trigger" Map Action Bugfix

; This fixes a crash that happens because of a bug in the code for map action 12
; (Destroy Trigger). It manifests itself in an Internal Error whenever the last
; trigger stored in the game's internal lists is destroyed using this map
; action. If you look at an except.txt and the first line of the stack dump says
; 0061A53C, that's the thing.

; Author: AlexB
; Date: 2016-03-10, 2016-11-24

%include "macros/patch.inc"

@SET 0x0061A533, dec ebp
@SET 0x0061A534, nop
