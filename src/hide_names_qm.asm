%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/string.inc"

cextern QuickMatch
cextern HiddenSurface
StringZ str_Player, "Player"

hack 0x005B97F8, 0x005B97FE
RadarClass__DrawPlayers_Hide_Name:
    cmp byte[QuickMatch], 0
    jz  .Reg

    mov edx, [edi+0x24]         ; HouseClass.HouseTypeClass
    lea edi, [edx+0x2D]         ; HouseTypeClass.abstracttypeclass.UIName
    jmp hackend

 .Reg:
    add edi, 0x10DE4            ; HouseClass.Name
    jmp hackend


hack 0x005ADB65, 0x005ADB6D
ProgressMgrClass__Draw_It_Hide_Names:
    mov ecx, [HiddenSurface]

    cmp byte[QuickMatch], 0
    jz  .Reg

    mov edx, str_Player
    jmp hackend

 .Reg:
    mov edx, [esi]
    jmp hackend
