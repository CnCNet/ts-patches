/*
 * Copyright (c) 2012, 2013, 2014 Toni Spets <toni.spets@iki.fi>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <winsock2.h>
#include <windows.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x006A2525, _NetHack_SendTo);
CALL(0x006A25F9, _NetHack_RecvFrom);

struct ListAddress
{
    unsigned int port;
    unsigned int ip;
};

// globals referenced in spawner
struct ListAddress AddressList[8];
int TunnelId;
int TunnelIp;
int TunnelPort;
int PortHack;

WINAPI int Tunnel_SendTo(int sockfd, const void *buf, size_t len, int flags, struct sockaddr_in *dest_addr, int addrlen)
{
    char TempBuf[1024 + 4];
    unsigned short *BufFrom = (void *)TempBuf;
    unsigned short *BufTo = (void *)TempBuf + 2;

    // no processing if no tunnel
    if (!TunnelPort)
        return sendto(sockfd, buf, len, flags, (struct sockaddr *)dest_addr, addrlen);

    // copy packet to our buffer
    memcpy(TempBuf+4, buf, len);

    // pull dest port to header
    *BufFrom = TunnelId;
    *BufTo = dest_addr->sin_port;

    dest_addr->sin_port = TunnelPort;
    dest_addr->sin_addr.s_addr = TunnelIp;

    return sendto(sockfd, TempBuf, len + 4, flags, (struct sockaddr *)dest_addr, addrlen);
}

WINAPI int Tunnel_RecvFrom(int sockfd, void *buf, size_t len, int flags, struct sockaddr_in *src_addr, int *addrlen)
{
    char TempBuf[1024 + 4];
    unsigned short *BufFrom = (void *)TempBuf;
    unsigned short *BufTo = (void *)TempBuf + 2;

    // no processing if no tunnel
    if (!TunnelPort)
        return recvfrom(sockfd, buf, len, flags, (struct sockaddr *)src_addr, addrlen);

    // call recvfrom first to get the packet
    int ret = recvfrom(sockfd, TempBuf, sizeof TempBuf, flags, (struct sockaddr *)src_addr, addrlen);

    // no processing if returning error or less than 5 bytes of data
    if (ret < 5 || *BufTo != TunnelId)
        return -1;

    memcpy(buf, TempBuf + 4, ret - 4);

    src_addr->sin_port = *BufFrom;
    src_addr->sin_addr.s_addr = 0;

    return ret - 4;
}

WINAPI int NetHack_SendTo(int sockfd, const void *buf, size_t len, int flags, const struct sockaddr_in *dest_addr, int addrlen)
{
    struct sockaddr_in TempDest;

    // pull index
    int i = dest_addr->sin_addr.s_addr - 1;

    // validate index
    if (i >= 8 || i < 0)
        return -1;

    TempDest.sin_family         = AF_INET;
    TempDest.sin_port           = AddressList[i].port;
    TempDest.sin_addr.s_addr    = AddressList[i].ip;

    // do call to sendto
    return Tunnel_SendTo(sockfd, buf, len, flags, &TempDest, addrlen);
}

WINAPI int NetHack_RecvFrom(int sockfd, void *buf, size_t len, int flags, struct sockaddr_in *src_addr, int *addrlen)
{
    // call recvfrom first to get the packet
    int ret = Tunnel_RecvFrom(sockfd, buf, len, flags, src_addr, addrlen);

    // bail out if error
    if (ret == -1)
        return ret;

    // now, we need to map src_addr ip/port to index by reversing the search!
    for (int i = 0; i < 8; i++) {
        // compare ip
        if (src_addr->sin_addr.s_addr == AddressList[i].ip) {
            // compare port
            if (!PortHack && src_addr->sin_port != AddressList[i].port)
                continue;

            // found it, set this index to source addr
            src_addr->sin_addr.s_addr = i + 1;
            src_addr->sin_port = 0;
            break;
        }
    }

    return ret;
}
