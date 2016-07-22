;
; Copyright (c) 2013 Toni Spets <toni.spets@iki.fi>
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

@CALL 0x006A2525 NetHack_SendTo
@CALL 0x006A25F9 NetHack_RecvFrom

NetHack_SendTo:
%push
    push ebp
    mov ebp, esp
    sub esp, sockaddr_in_size
    push esi
    push edi

%define TempDest    ebp-sockaddr_in_size

%define addrlen     ebp+28
%define dest_addr   ebp+24
%define flags       ebp+20
%define len         ebp+16
%define buf         ebp+12
%define sockfd      ebp+8

    ; pull index
    mov ecx, [dest_addr]
    mov ecx, [ecx + sockaddr_in.sin_addr]

    ; validate index
    cmp ecx, 1
    jl .error
    cmp ecx, AddressList_length
    jg .error

    ; change to zero based
    dec ecx

    ; sin_family
    lea edx, [TempDest + sockaddr_in.sin_family]
    mov word [edx], 2

    ; sin_port
    mov ax, word [ecx * ListAddress_size + var.AddressList + ListAddress.port]
    lea edx, [TempDest + sockaddr_in.sin_port]
    mov word [edx], ax

    ; sin_addr
    mov eax, dword [ecx * ListAddress_size + var.AddressList + ListAddress.ip]
    lea edx, [TempDest + sockaddr_in.sin_addr]
    mov dword [edx], eax

    ; sin_zero
    xor eax, eax
    lea edx, [TempDest + sockaddr_in.sin_zero]
    mov dword [edx], eax
    add edx, 4
    mov dword [edx], eax

    ; do call to sendto
    mov eax, [addrlen]
    push eax
    lea eax, [TempDest]
    push eax
    mov eax, [flags]
    push eax
    mov eax, [len]
    push eax
    mov eax, [buf]
    push eax
    mov eax, [sockfd]
    push eax
    call Tunnel_SendTo

    jmp .exit
.error:
    mov eax,-1
.exit:
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    retn 24
%pop

NetHack_RecvFrom:
%push
    push ebp
    mov ebp, esp
    push esi
    push edi

%define addrlen     ebp+28
%define src_addr    ebp+24
%define flags       ebp+20
%define len         ebp+16
%define buf         ebp+12
%define sockfd      ebp+8

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
    call Tunnel_RecvFrom

    ; bail out if error
    cmp eax, -1
    je .exit

    ; now, we need to map src_addr ip/port to index by reversing the search!
    xor ecx,ecx
.nextaddr:

    ; compare ip
    mov edx, [src_addr]
    mov edx, [edx + sockaddr_in.sin_addr]
    cmp edx, [ecx * ListAddress_size + var.AddressList + ListAddress.ip]
    jne .next

    cmp dword [var.PortHack], 1
    je .skipPort
    ; compare port
    mov edx,[src_addr]
    mov dx, [edx + sockaddr_in.sin_port]
    and edx, 0xffff
    cmp dx, [ecx * ListAddress_size + var.AddressList + ListAddress.port]
    jne .next
.skipPort:

    ; found it, set this index to source addr
    inc ecx
    mov edx, [src_addr]
    mov [edx + sockaddr_in.sin_addr], ecx

    mov edx, [src_addr]
    mov word [edx + sockaddr_in.sin_port], 0

    jmp .exit

.next:
    inc ecx
    cmp ecx, 7
    jg .exit
    jmp .nextaddr

.exit:
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    retn 24
%pop
