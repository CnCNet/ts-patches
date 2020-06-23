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

; Turns the 100 infantry bug into a 1000 infantry bug

@SET 0x004C1A30, {sub esp, 2F0Ch}
@SET 0x004C1A4C, {add esp, 2F0Ch}
@SET 0x004C1A56, {mov ecx, 3E8h}
@SET 0x004C1A63, {mov ecx, 3E8h}
@SET 0x004C1A6D, {lea edi, [esp+0FDCh]}
@SET 0x004C1B27, {mov ecx, [esp+eax+0FDCh]}
@SET 0x004C1B35, {lea eax, [esp+eax+0FDCh]}
@SET 0x004C1C6A, {mov [esp+ebx*4+1F7Ch], esi}
@SET 0x004C1C7B, {mov eax, [esp+esi*4+0FDCh]}
@SET 0x004C1C86, {mov eax, [esp+esi*4+0FDCh]}
@SET 0x004C1D00, {add esp, 2F0Ch}
@SET 0x004C1D1F, {mov ecx, [esp+eax*4+1F7Ch]}
@SET 0x004C1D35, {add esp, 2F0Ch}

; Turns the 100 aircraft bug into a 1000 aircraft bug

; @SET 0x004C1D40, {sub esp, 2F0Ch}
; @SET 0x004C1D5C, {add esp, 2F0Ch}
; @SET 0x004C1D66, {mov ecx, 3E8h}
; @SET 0x004C1D73, {mov ecx, 3E8h}
; @SET 0x004C1D7D, {lea edi, [esp+0FDCh]}
; @SET 0x004C1E37, {mov ecx, [esp+eax+0FDCh]}
; @SET 0x004C1E45, {lea eax, [esp+eax+0FDCh]}
; @SET 0x004C1F7A, {mov [esp+ebx*4+1F7Ch], esi}
; @SET 0x004C1F8B, {mov eax, [esp+esi*4+0FDCh]}
; @SET 0x004C1F96, {mov eax, [esp+esi*4+0FDCh]}
; @SET 0x004C2010, {add esp, 2F0Ch}
; @SET 0x004C202F, {mov ecx, [esp+eax*4+1F7Ch]}
; @SET 0x004C2045, {add esp, 2F0Ch}

