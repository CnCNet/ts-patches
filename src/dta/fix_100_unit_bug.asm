%include "macros/patch.inc"

; Turns the 100 unit bug into a 1000 unit bug
; http://ppmforums.com/viewtopic.php?p=547837#547837

@SET 0x004C1650, {sub esp, 2F0Ch}
@SET 0x004C173D, {add esp, 2F0Ch}
@SET 0x004C1744, {mov ecx, 3E8h}
@SET 0x004C1753, {mov ecx, 3E8h}
@SET 0x004C175D, {lea edi, [esp+0FDCh]}
@SET 0x004C1812, {mov ecx, [esp+eax+0FDCh]}
@SET 0x004C1820, {lea eax, [esp+eax+0FDCh]}
@SET 0x004C1952, {mov [esp+ebx*4+1F7Ch], esi}
@SET 0x004C1963, {mov eax, [esp+esi*4+0FDCh]}
@SET 0x004C196E, {mov eax, [esp+esi*4+0FDCh]}
@SET 0x004C19E8, {add esp, 2F0Ch}
@SET 0x004C1A07, {mov ecx, [esp+eax*4+1F7Ch]}
@SET 0x004C1A1D, {add esp, 2F0Ch}
