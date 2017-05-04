;;; Hack FootClass_Draw_Action_Lines function to add a loop over the Navlist dynamic vector
;;; 1. First iteration through the loop draw line from unit to Navcom or Target (aka Move or Attack)
;;; 2. a) When attacking, draw a line from the unit to the q-move location in Navlist
;;;    b) When Moving, draw a line from the previous navcom/destination to the new navlist destination
;;; 3. Increment Navlist index
;;; 2017-05-03 - dkeeton

%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/hack.inc"


@SET  0x004A6A40, { sub esp, dword 0x94 } ; Add 4 more dwords to the stack space: self, length, counter, loopstate
@LJZ  0x004A6A5C, out_footclass_draw_lines
@LJGE 0x004A6A7C, _FootClass_Draw_Action_Lines_check_for_q
@LJLE 0x004A6A86, out_footclass_draw_lines

hack 0x004A6B02, 0x004A6B08
_FootClass_Draw_ActionLines_setup_loop_move:
        mov eax, dword [esi+0x280+0x10] ; FootClass.NavList.ActiveCount
        mov [esp+0x8C], eax             ; Store ActiveCount
        mov [esp+0x90], esi             ; Save "this"
        mov dword [esp+0x94], 0         ; LoopCounter
        mov dword [esp+0x98], 0         ; Movement

 .Reg:
        mov eax, dword [esi+0x270]; FootClass.PathfindingCells.ActiveCount
        jmp hackend

hack 0x004A6ADA
_FootClass_Draw_ActionLines_setup_loop_attack:
        mov eax, dword [esi+0x280+0x10] ; FootClass.NavList.ActiveCount
        mov [esp+0x8C], eax             ; Store ActiveCount
        mov [esp+0x90], esi             ; Save "this"
        mov dword [esp+0x94], 0         ; LoopCounter
        mov dword [esp+0x98], 1         ; Attack
        jmp 0x004A6BBB


hack 0x004A6DD2, 0x004A6DDA
_FootClass_Draw_ActionLines_loop_at_end:
        mov  esi, [esp+0x90]     ; Restore "this"

        cmp  dword [esp+0x98], 1
        jne .loop_over_navlist

        mov  dword [esp+0x98], 2 ; make state 2 for the next iteration (aka no_swap)

        cmp dword [esi+0x278], 0 ; Navcom is not null?
        jnz 0x004A6ADF           ; Then let's draw the navcom line

 .loop_over_navlist:
        mov  eax, dword [esp+0x94]
        cmp  eax, dword [esp+0x8C]
        jge  out_footclass_draw_lines

        mov  ecx, [esi+0x280+4]  ; FootClass.NavList.Vector
        mov  ecx, [ecx+eax*4]    ; Vector[eax]
        mov  edx, [ecx]

        inc  eax
        mov  dword [esp+0x94], eax

        cmp  dword [esp+0x98], 2
        je   .no_swap

        mov  eax, [esp+20]       ; Swap Destination in to the source position
        mov  [esp+80], eax
        mov  eax, [esp+20+4]
        mov  [esp+80+4], eax
        mov  eax, [esp+20+8]
        mov  [esp+80+8], eax

 .no_swap:
        mov  dword [esp+0x98], 0 ; state 0 for the next iteration (aka swap)
        lea  eax, [esp+8]        ; Destination Coord pointer
        jmp  0x004A6B2A          ; Loop

 out_footclass_draw_lines:
        pop edi
        pop esi
        add esp, 0x94            ; Changed from 0x84
        retn



_FootClass_Draw_Action_Lines_check_for_q:
        push  edi

        mov   edx, [QMove_Key1]
        mov   ecx, [WWKeyboard]
        push  edx
        call  WWKeyboardClass__Down

        test al, al
        jnz  .show_lines

        mov   edx, [QMove_Key2]
        mov   ecx, [WWKeyboard]
        push  edx
        call  WWKeyboardClass__Down

        test al, al
        jz   .no_show

 .show_lines:
        pop  edi
        jmp  0x004A6A8C

 .no_show:
        pop  edi
        jmp  out_footclass_draw_lines
