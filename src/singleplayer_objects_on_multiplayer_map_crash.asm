%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; 0062E6F6 - Do not spawn singleplayer objects in multiplayer games

sstring Nod, "Nod"
sstring GDI, "GDI"

%macro ApplyFix 2 
hack %1
    add esp, 8
    mov ecx, eax
    
    cmp dword [SessionType], 0 ; no fix for singleplayer
    jz hackend
    pushad
    mov esi, eax
    
    push esi
    push Nod
    call __strcmpi
    add esp, 8
    test eax, eax
    jz .skip
    
    push esi
    push GDI
    call __strcmpi
    add esp, 8
    test eax, eax
    jz .skip
    
    popad
    jmp hackend

.skip:
    popad
    jmp %2
%endmacro

ApplyFix 0x00658653, 0x006589B0 ; UnitClass::Read_INI(CCINIClass &)
ApplyFix 0x004D7B95, 0x004D7F30 ; InfantryClass::Read_INI(CCINIClass &)
ApplyFix 0x0043483E, 0x00434D64 ; BuildingClass::Read_INI(CCINIClass &)
ApplyFix 0x0040E801, 0x0040EAAC ; AircraftClass::Read_INI(CCINIClass &)
;ApplyFix 0x, 0x ; 
