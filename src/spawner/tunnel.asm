;
; Copyright (c) 2012, 2013 Toni Spets <toni.spets@iki.fi>
;
; Permission to use, copy, modify, and distribute this software for any
; purpose with or without fee is hereby granted, provided that the above
; copyright notice and this permission notice appear in all copies.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;

Tunnel_SendTo:
%push
    push ebp
    mov ebp,esp
    sub esp,1024
    push esi
    push edi

%define TempBuf     (ebp-1024)

%define addrlen     ebp+28
%define dest_addr   ebp+24
%define flags       ebp+20
%define len         ebp+16
%define buf         ebp+12
%define sockfd      ebp+8

    ; no processing if no tunnel
    cmp dword [var.TunnelPort], 0
    je .notunnel

    ; copy packet to our buffer
    mov esi, [buf]
    lea edi, [TempBuf + 4]
    mov ecx, [len]
    cld
    rep movsb

    ; pull dest port to header
    lea eax, [TempBuf]

    mov ecx, [dest_addr]
    lea ecx, [ecx + sockaddr_in.sin_port]
    mov edx, [ecx]
    shl edx, 16
    mov [eax], edx

    mov edx, [var.TunnelId]
    shr edx, 16
    or [eax], edx

    and edx,0xffff
    or [eax], edx

    ; set dest_addr to tunnel address
    mov eax, [dest_addr]
    lea eax, [eax + sockaddr_in.sin_port]
    mov edx, [var.TunnelPort]
    shr edx, 16
    mov word [eax],dx

    mov eax, [dest_addr]
    lea eax, [eax + sockaddr_in.sin_addr]
    mov edx, [var.TunnelIp]
    mov dword [eax], edx

    mov eax, [addrlen]
    push eax
    mov eax, [dest_addr]
    push eax
    mov eax, [flags]
    push eax
    mov eax, [len]
    add eax, 4
    push eax
    lea eax, [TempBuf]
    push eax
    mov eax, [sockfd]
    push eax
    call sendto
    jmp .exit

.notunnel:
    mov eax, [addrlen]
    push eax
    mov eax, [dest_addr]
    push eax
    mov eax, [flags]
    push eax
    mov eax, [len]
    push eax
    mov eax, [buf]
    push eax
    mov eax, [sockfd]
    push eax
    call sendto

.exit:
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    retn 24
%pop

Tunnel_RecvFrom:
%push
    push ebp
    mov ebp, esp
    sub esp, 1024
    push esi
    push edi

%define TempBuf     (ebp-1024)

%define addrlen     ebp+28
%define src_addr    ebp+24
%define flags       ebp+20
%define len         ebp+16
%define buf         ebp+12
%define sockfd      ebp+8

    ; no processing if no tunnel
    cmp dword [var.TunnelPort], 0
    je .notunnel

    ; call recvfrom first to get the packet
    mov eax, [addrlen]
    push eax
    mov eax, [src_addr]
    push eax
    mov eax, [flags]
    push eax
    mov eax, 1024        ; len
    push eax
    lea eax, [TempBuf]
    push eax
    mov eax, [sockfd]
    push eax
    call recvfrom

    ; no processing if returnng error
    cmp eax, -1
    je .exit

    ; no processing if less than 5 bytes of data
    cmp eax, 5
    jl .error

    ; remove header from return length
    sub eax, 4

    ; copy real packet after header to game buf
    lea esi, [TempBuf + 4]
    mov edi, [buf]
    mov ecx, eax
    cld
    rep movsb

    ; pull our header
    lea edx, [TempBuf]
    mov edx, [edx]

    ; fixme: going to assume packets are meant for me, someone can validate the "to" part later...
    ; leaving just from here
    and edx, 0xffff

    ; set from port to header identifier
    mov ecx, [src_addr]
    lea ecx, [ecx + sockaddr_in.sin_port]
    mov word [ecx],dx

    xor edx,edx
    mov ecx,[src_addr]
    lea ecx,[ecx + sockaddr_in.sin_addr]
    mov dword [ecx],edx

    jmp .exit

.notunnel:
    ; call recvfrom first to get the packet
    mov eax, [addrlen]
    push eax
    mov eax, [src_addr]
    push eax
    mov eax, [flags]
    push eax
    mov eax, [len]
    push eax
    mov eax, [buf]
    push eax
    mov eax, [sockfd]
    push eax
    call recvfrom
    jmp .exit

.error:
    mov eax, -1
.exit:
    pop edi
    pop esi
    mov esp,ebp
    pop ebp
    retn 24
%pop
