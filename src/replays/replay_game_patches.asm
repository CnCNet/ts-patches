%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern ReplayPlayback

; Move cursor causes desync in replay recording and playback as it creates an animation which increment the global unique ID for the next objects
; Westwood hacked around it for non-skirmish and non-singleplayer games, this patch also enables their hack for skirmish and single player
@CLEAR 0x004A3746, 0x90, 0x004A374D
@CLEAR 0x004A37B7, 0x90, 0x004A37C6

;Don't use, doesn't work
; Don't filter out the EXIT event in the event do list handling code, so make sure it gets executed
;@CLEAR 0x005B5098, 0x90, 0x005B509C

hack 0x005B1550, 0x005B1556
_Queue_AI_Add_Compute_CRC_For_Skirmish_For_LAN_Replay_Compatibility:
	call 0x005B5550 ; Compute_Game_CRC

	mov edx, [PlayerPtr]
	jmp hackend


; record other player's chat (your own chat is hooked in display_messaged_typed_by_yourself.asm)
hack 0x00462F38, 0x00462F3D
_IPX_Callback_Record_Other_Player_Chat:
	call MessageListClass__Add_Message
	push 0x007E3AD0
	call Write_Chat_To_Replay


	jmp hackend

;Patch normalize delay so when playing back a replay it uses a special variable NormalizedDelayGameSpeed
hack 0x0058A608, 0x0058A60D
_OptionsClass_Normalize_Delay_Use_Special_Variable_When_In_Replay_Playback:
	cmp dword [ReplayPlayback], 0
	jz .Normal_Code

	mov dword ecx, [NormalizedDelayGameSpeed]
	jmp .Ret

.Normal_Code:
	mov     ecx, [ecx]

.Ret:
	cmp     eax, 5
	jmp		hackend

;Record EXIT event in Execute_DoList()
hack 0x005B50AD, 0x005B50B3
_Execute_DoList_Record_EXIT_Event:
	jnz 0x005B51F5
	pushad
	
	lea eax, [eax+0x0C]
	push eax
	call Write_Event_To_Replay_File

	popad
	jmp hackend

; We made the game execute the EXIT event for other players (so we can record it and during playback send it to the do list queue)
; But EXIT event execute handler can't handle this yet, so filter out other houses
hack 0x00494CDF, 0x00494CE6
_EventClass__Execute_Exit_Event_Handler_Check_And_Filter_Out_Other_Players:
	mov     eax, [esi+0x06]
	mov     edi, [ecx+eax*4]
	mov     dword eax, [PlayerPtr]
	cmp     edi, eax
	jnz		.Destroy_Connection

	mov BYTE [0x007E2280], 1
	jmp hackend

.Destroy_Connection:
	mov ecx, [esi+0x06] ; ID of player...
	mov edx, 0 ; Toggles please left versus connection lost message?
	call 0x00575020 ; Destroy_Connection
	jmp hackend



hack 0x005F4D74, 0x005F4D79
_SidebarClass__StripClass__AI__Dont_Execute_PLACE_For_Produced_Units2:
	push    eax
	mov     eax, [esi]

	cmp BYTE [ReplayPlayback], 0
	jz .No_Empty_Event

	push 0x0
	jmp hackend

.No_Empty_Event:
	push 0x0A
	jmp hackend



hack 0x005F4D41, 0x005F4D46
_SidebarClass__StripClass__AI__Dont_Execute_PLACE_For_Produced_Units:
	push    eax
	mov     eax, [esi]

	cmp BYTE [ReplayPlayback], 0
	jz .No_Empty_Event

	push 0x0
	jmp hackend

.No_Empty_Event:
	push 0x0A
	jmp hackend

; start of EventClass::Execute()
hack 0x00494280, 0x00494286
_EventClass__Execute_Hook:
	sub esp, 0x1a8
	pushad
	push ecx
	call Write_Event_To_Replay_File
	cmp al, 0
	popad
	jz 0x00495114 ; out
	jmp 0x00494286

; Patch so game thinks other human players are loaded in replay playback

hack 0x005DB758, 0x005DB761
_LoadingScreen_Loading_Progress_Hack_Human_Players_Progress:
	cmp BYTE [ReplayPlayback], 1
	jz 0x005DB98E

	cmp DWORD eax, 5
	jz 0x005DB98E
	jmp hackend
