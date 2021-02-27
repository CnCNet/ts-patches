%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Keeps sidebar icons sorted. Each category (buildings, vehicles, infantry, aircraft, SWs)
; is sorted in the order of the objects' appearance in the respective object type lists in Rules.ini.
; The non-building categories (as buildings are alone on the left strip) are sorted into the
; right sidebar strip in the following order:
; infantry, vehicles, aircraft, superweapons.

; Technically this implementation simply calls the C standard library qsort function
; each time when the game has added cameos to the sidebar.
; The comparison function used for the sorting is in sidebar_cameo_sort_helper.c.
; -------------------
; Author: Rampastring


cextern BuildType_Comparison


; Helper macro for sorting a sidebar strip and returning
; Takes the sidebar strip ID as a parameter,
; 0 for left strip, 1 for right strip,
; anything higher will likely cause world peace in the great 
; global conflict between GDI and Nod by overflowing the strip array.
%macro Sort_Sidebar_Strip 1
    ; get sidebar strip, code from 0x005F2E49
    
    mov  esi, MouseClass_Map ; MouseClass derives from ScrollClass which derives
                             ; from HelpClass which derives from TabClass which derives 
                             ; from SidebarClass... so MouseClass contains the sidebar strips.
                             ; Weird class design, but okay.
                             ; Maybe it made more sense in the resource-constrained 90s.

    mov  edx, 1              ; 0 for first strip, 1 for second strip
                             ; Applied for unit strip only as vanilla building list isn't readily suitable for this.
    lea  eax, [edx+edx*2]
    shl  eax, 4
    add  eax, edx
    lea  eax, [eax+eax*4]
    lea  edx, [esi+eax*4+152Ch]
    ; Now we should have the sidebar strip in edx
    mov  ecx, [edx+4Ch] ; Get count of buildables
    lea  eax, [edx+50h] ; Get array of buildables
    push BuildType_Comparison ; our comparison function in sidebar_cameo_sort_helper.c
    push 0Ch            ; sizeof(BuildType)
    push ecx            ; number of items to sort
    push eax            ; pointer to first element
    call 0x006B5D0C     ; qsort it!
    add  esp, 10h       ; clear qsort's arguments from the stack
                        ; (qsort is cdecl so cleaning is our responsibility)
    pop  esi
    retn
%endmacro


; building types
hack 0x0042DA40
    inc  esi
    cmp  esi, eax
    jl   0x0042DA12 ; replace instructions that our jump destroyed
    Sort_Sidebar_Strip 0


; infantry types
hack 0x0042DAC6
    inc  esi
    cmp  esi, eax
    jl   0x0042DA97 ; replace instructions that our jump destroyed
    Sort_Sidebar_Strip 1


; unit types
hack 0x0042DA85
    inc  esi
    cmp  esi, eax
    jl   0x0042DA56 ; replace instructions that our jump destroyed
    Sort_Sidebar_Strip 1


; aircraft types
hack 0x0042DB06
    inc  esi
    cmp  esi, eax
    jl   0x0042DAD8
    Sort_Sidebar_Strip 1

