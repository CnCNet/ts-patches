%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Clean up some MPDEBUG weirdness and
;;; allow MPDEBUG mode to work with any resolution
@SJMP 0x00601316, 0x00601335
gbool already_filled_rect, false

section .text
_set_bg_color:
        mov     DWORD [esp+0x1C], 0xC
        jmp     0x00474E70
__SECT__

@CALL 0x004F113C, _set_bg_color
@CALL 0x004F11BC, _set_bg_color
@CALL 0x004F1229, _set_bg_color
@CALL 0x004F12F0, _set_bg_color
@CALL 0x004F13B7, _set_bg_color
@CALL 0x004F1445, _set_bg_color
@CALL 0x004F14D3, _set_bg_color
@CALL 0x004F153A, _set_bg_color
@CALL 0x004F15AB, _set_bg_color
@CALL 0x004F1612, _set_bg_color
@CALL 0x004F16D5, _set_bg_color
@CALL 0x004F1742, _set_bg_color
@CALL 0x004F17B2, _set_bg_color
@CALL 0x004F181F, _set_bg_color


hack 0x00601470
        mov     esi, [ScreenHeight]
        sub     esi, 80
        mov     [ScreenHeight], esi
        jmp     hackend

hack 0x004f1101, 0x004F1109
        mov     eax, [ScreenHeight]
        sub     eax, 32
        mov     [esp+0x18], eax
        jmp     hackend
hack 0x004F1181, 0x004F1189
        mov     eax, [ScreenHeight]
        sub     eax, 24
        mov     [esp+0x18], eax
        jmp     hackend
hack 0x004F11EE, 0x004F11F6
        mov     eax, [ScreenHeight]
        sub     eax, 18
        mov     [esp+0x18],eax
        jmp     hackend
hack 0x004F12B5, 0x004F12BD
        mov     eax, [ScreenHeight]
        sub     eax, 10
        mov     [esp+0x18],eax
        jmp     hackend
hack 0x004F1378, 0x004F1380
        mov     ecx, [ScreenHeight]
        sub     ecx, 80
        mov     [esp+0x78], ecx
        jmp     hackend
hack 0x004F1407, 0x004F140F
        mov     ecx, [ScreenHeight]
        sub     ecx, 72
        mov     [esp+0x50], ecx
        jmp     hackend
hack 0x004F1495, 0x004F149D
        mov     ecx, [ScreenHeight]
        sub     ecx, 64
        mov     [esp+0x38], ecx
        jmp     hackend
hack 0x004F14FC, 0x004F1504
        mov     ecx, [ScreenHeight]
        sub     ecx, 56
        mov     [esp+0x48], ecx
        jmp     hackend
hack 0x004F156D, 0x004F1575
        mov     ecx, [ScreenHeight]
        sub     ecx, 48
        mov     [esp+0x70],ecx
        jmp     hackend
hack 0x004F15D4,0x004F15DC
        mov     ecx, [ScreenHeight]
        sub     ecx, 40
        mov     [esp+0x60], ecx
        jmp     hackend
hack 0x004F1696, 0x004F169E
        mov     edx, [ScreenHeight]
        sub     edx, 32
        mov     [esp+0x40],edx
        jmp     hackend
hack 0x004F1703, 0x004F170B
        mov     edx, [ScreenHeight]
        sub     edx, 24
        mov     [esp+0x58], edx
        jmp     hackend
hack 0x004F1773, 0x004F177B
        mov     eax, [ScreenHeight]
        sub     eax, 16
        mov     [esp+0x68],eax
        jmp     hackend
hack 0x004F17E0, 0x004F17E8
        mov     edx, [ScreenHeight]
        sub     edx, 8
        mov     [esp+0x1C], edx
        jmp     hackend
hack 0x00509D50, 0x0050A05C
        sub    esp,0x128
	push   ebx
	xor    ebx,ebx
	cmp    cl,bl
	jne    .loc_509d6d
	mov    eax,[0x7e4924]
	and    eax,0x7
	cmp    al,0x7
	jne    .loc_50a055
.loc_509d6d:
	mov    eax,[0x7e2458]
	cmp    eax,ebx
	je     .loc_50a055
	cmp    eax, 1
	je     .loc_50a055
	cmp    eax, 2
	je     .loc_50a055
	mov    ecx,DWORD [0x74c8f0]
	mov    edx,DWORD [ecx]
	call   DWORD [edx+0xC]
        mov    al, [already_filled_rect]
        test   al, al
        jnz    .already_filled

	mov    ecx,DWORD [0x74c5d8]
	mov    DWORD [esp+0xC],ebx

        mov     eax, [ScreenHeight]
        sub     eax, 80
        mov     DWORD [esp+0x10], eax
        mov     eax, [ScreenWidth]
        sub     eax, 1
        mov     DWORD [esp+0x14], eax
	mov    DWORD [esp+0x18],0x50
	mov    eax,DWORD [ecx]
	lea    edx,[esp+0xc]
        push   ebx
	push   edx
	call   DWORD [eax+0x14]
        mov    BYTE [already_filled_rect], 1

.already_filled:
	mov    eax,[0x7e4924]
	lea    ecx,[esp+0x2c]
	push   eax
	push   0x700794
	push   ecx
	call   0x6b52ee
	add    esp,0xc
	mov    edx,0x1
	mov    ecx,0x6f8cd4     ; aGrey
	mov    DWORD [esp+0x4],ebx
	push   0x19
	push   ebx

        mov     eax, [ScreenHeight]
        sub     eax, 78
        mov     [esp+0x10], eax
;;; mov    DWORD [esp+0x10],0x192
	call   0x5e2840
	mov    ecx,DWORD [0x74c5d8]
	lea    edx,[esp+0xc]
	push   eax
	push   edx
	mov    eax,DWORD [ecx]
	lea    edx,[esp+0x2c]
	push   edx
	call   DWORD [eax+0x74] ;Get_Rect

	lea    ecx,[esp+0x3c]
	lea    edx,[esp+0x1c]
	push   eax              ; Rect
	mov    eax,[0x74c5d8]
	push   eax              ; DSurface
	push   ecx              ; x
	push   edx              ; y
        mov    DWORD [esp+0x18], 0xC
	call   0x474e70
	mov    eax,[0x804d2c]
	lea    ecx,[esp+0x4c]
	push   eax
	push   0x700788
	push   ecx
	call   0x6b52ee
	add    esp,0x2c
	mov    edx,0x1
	mov    ecx,0x6f8cd4
	mov    DWORD [esp+0x4],ebx
	push   0x19
	push   ebx

        mov     eax, [ScreenHeight]
        sub     eax, 70
        mov     [esp+0x10], eax
;;; mov    DWORD [esp+0x10],0x19a
	call   0x5e2840
	mov    ecx,DWORD [0x74c5d8]
	lea    edx,[esp+0xc]
	push   eax
	push   edx
	mov    eax,DWORD [ecx]
	lea    edx,[esp+0x2c]
	push   edx
	call   DWORD [eax+0x74]
	lea    ecx,[esp+0x3c]
	lea    edx,[esp+0x1c]
	push   eax
	mov    eax,[0x74c5d8]
	push   eax
	push   ecx
	push   edx
        mov    DWORD [esp+0x18], 0xC
	call   0x474e70
	mov    eax,[0x7e250c]
	lea    ecx,[esp+0x4c]
	push   eax
	push   0x700778
	push   ecx
	call   0x6b52ee
	add    esp,0x2c
	mov    DWORD [esp+0x4],ebx
	push   0x19
	push   ebx
	mov    edx,0x1
	mov    ecx,0x6f8cd4

        mov     eax, [ScreenHeight]
        sub     eax, 62
        mov     [esp+0x10], eax

;;; mov    DWORD [esp+0x10],0x1a2
	call   0x5e2840
	mov    ecx,DWORD [0x74c5d8]
	lea    edx,[esp+0xc]
	push   eax
	push   edx
	mov    eax,DWORD [ecx]
	lea    edx,[esp+0x2c]
	push   edx
	call   DWORD [eax+0x74]
	lea    ecx,[esp+0x3c]
	lea    edx,[esp+0x1c]
	push   eax
	mov    eax,[0x74c5d8]
	push   eax
	push   ecx
	push   edx
        mov    DWORD [esp+0x18], 0xC
	call   0x474e70
	add    esp,0x20
	mov    ecx,0x7e45a0
	call   0x4f0f00
	lea    eax,[eax+eax*4]
	lea    eax,[eax+eax*4]
	lea    ecx,[eax+eax*4]
	mov    eax,0x88888889
	shl    ecx,0x3
	imul   ecx
	add    edx,ecx
	lea    ecx,[esp+0x2c]
	sar    edx,0x5
	mov    eax,edx
	shr    eax,0x1f
	add    edx,eax
	push   edx
	push   0x700764
	push   ecx
	call   0x6b52ee
	add    esp,0xc
	mov    edx,0x1
	mov    ecx,0x6f8cd4
	mov    DWORD [esp+0x4],ebx
	push   0x19
	push   ebx

        mov     eax, [ScreenHeight]
        sub     eax, 54
        mov     [esp+0x10], eax
;;; mov    DWORD [esp+0x10],0x1aa
	call   0x5e2840
	mov    ecx,DWORD [0x74c5d8]
	lea    edx,[esp+0xc]
	push   eax
	push   edx
	mov    eax,DWORD [ecx]
	lea    edx,[esp+0x2c]
	push   edx
	call   DWORD [eax+0x74]
	lea    ecx,[esp+0x3c]
	lea    edx,[esp+0x1c]
	push   eax
	mov    eax,[0x74c5d8]
	push   eax
	push   ecx
	push   edx
        mov    DWORD [esp+0x18], 0xC
	call   0x474e70
	mov    eax,[0x7e2514]
	lea    ecx,[esp+0x4c]
	push   eax
	push   0x700754
	push   ecx
	call   0x6b52ee
	add    esp,0x2c
	mov    edx,0x1
	mov    ecx,0x6f8cd4
	mov    DWORD [esp+0x4],ebx
	push   0x19
	push   ebx

        mov     eax, [ScreenHeight]
        sub     eax, 48
        mov     [esp+0x10], eax

;;; 	mov    DWORD [esp+0x10],0x1b2
	call   0x5e2840
	lea    edx,[esp+0xc]
	push   eax
	mov    ecx,DWORD [0x74c5d8]
	push   edx
	lea    edx,[esp+0x2c]
	mov    eax,DWORD [ecx]
	push   edx
	call   DWORD [eax+0x74]
	lea    ecx,[esp+0x3c]
	lea    edx,[esp+0x1c]
	push   eax
	mov    eax,[0x74c5d8]
	push   eax
	push   ecx
	push   edx
        mov    DWORD [esp+0x18], 0xC
	call   0x474e70
	mov    eax,[0x7e3e94]
	mov    ecx,DWORD [eax]
	lea    eax,[esp+0x4c]
	mov    edx,DWORD [ecx+0x41]
	push   edx
	push   0x6ff508
	push   eax
	call   0x6b52ee
	add    esp,0x2c
	mov    edx,0x1
	mov    ecx,0x6f8cd4
	mov    DWORD [esp+0x4],ebx
	push   0x19
	push   ebx

        mov     eax, [ScreenHeight]
        sub     eax, 40
        mov     [esp+0x10], eax

;;; mov    DWORD [esp+0x10],0x1ba
	call   0x5e2840
	lea    ecx,[esp+0xc]
	push   eax
	push   ecx
	mov    ecx,DWORD [0x74c5d8]
	lea    eax,[esp+0x2c]
	push   eax
	mov    edx,DWORD [ecx]
	call   DWORD [edx+0x74]
	mov    ecx,DWORD [0x74c5d8]
	lea    edx,[esp+0x3c]
	push   eax
	push   ecx
	lea    eax,[esp+0x24]
	push   edx
	push   eax
        mov    DWORD [esp+0x18], 0xC
	call   0x474e70
	add    esp,0x20
	mov    ecx,0x7e45a0
	call   0x4f10b0
	mov    ecx,DWORD [0x74c8f0]
	mov    edx,DWORD [ecx]
	call   DWORD [edx+0x10]
.loc_50a055:
	pop    ebx
	add    esp,0x128
	ret




