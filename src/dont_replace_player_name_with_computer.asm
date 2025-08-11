%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

%ifdef SPAWNER

cextern AutoSurrender

; Patch HouseClass_Force_AI_Take_Control so it doesn't replace the player's 
; name with "Computer" if auto-surrender is enabled
hack 0x004CA8DC
	cmp byte[AutoSurrender], 1
	je 0x004CA91A
	call Fetch_String
	jmp 0x004CA8E1

%endif ; SPAWNER
