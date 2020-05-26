; Allow usage of TileSet of 255 and above without making NE-SW broken bridges unrepairable

; When TileSet number crosses 255 in temperat/snow INI files, the NE-SW broken bridges 
; become non-repairable. The reason is that the location where the values of BridgeTopRight1 
; and BridgeBottomLeft2 are parsed into, from the terrain INI files, gets into trouble.
; This patch allocates new addresses for those variables.

%include "macros/patch.inc"

section .data

BridgeTopRight_1 dd -1
BridgeBottomLeft_2 dd -1

@SET 0x004F4581, {mov dword [BridgeTopRight_1], eax}
@SET 0x00512A09, {cmp ebx, dword [BridgeTopRight_1]}
@SET 0x00512D20, {cmp eax, dword [BridgeTopRight_1]}
@SET 0x005131E0, {cmp eax, dword [BridgeTopRight_1]}
@SET 0x00517C5D, {mov edx, dword [BridgeTopRight_1]}
@SET 0x00518166, {mov ecx, dword [BridgeTopRight_1]}
@SET 0x005188AD, {cmp eax, dword [BridgeTopRight_1]}
@SET 0x00519736, {cmp eax, dword [BridgeTopRight_1]}
@SET 0x0051B16D, {mov edx, dword [BridgeTopRight_1]}
@SET 0x0051B676, {mov ecx, dword [BridgeTopRight_1]}
@SET 0x0051BDC7, {cmp eax, dword [BridgeTopRight_1]}
@SET 0x0051CF8E, {cmp eax, dword [BridgeTopRight_1]}

@SET 0x004F45CC, {mov dword [BridgeBottomLeft_2], eax}
@SET 0x005118DB, {cmp esi, dword [BridgeBottomLeft_2]}
@SET 0x005121EB, {cmp esi, dword [BridgeBottomLeft_2]}
@SET 0x00517B5A, {cmp eax, dword [BridgeBottomLeft_2]}
@SET 0x00517DA7, {cmp eax, dword [BridgeBottomLeft_2]}
@SET 0x0051905A, {cmp eax, dword [BridgeBottomLeft_2]}
@SET 0x0051B06A, {cmp eax, dword [BridgeBottomLeft_2]}
@SET 0x0051B2B7, {cmp eax, dword [BridgeBottomLeft_2]}
@SET 0x0051C8BA, {cmp eax, dword [BridgeBottomLeft_2]}

