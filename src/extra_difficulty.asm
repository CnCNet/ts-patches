%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Adds an extra AI difficulty level.
; Author: Rampastring

section .bss
    DifficultyData RESB 80

sstring str_VeryEasy, "VeryEasy"
sstring str_Easy, "Easy"

; Hack RulesClass::Difficulty to read in the new difficulty setting
hack 0x005CE198
    push str_VeryEasy
    mov  ecx, edi
    mov  edx, DifficultyData
    call 0x005CE1E0 ; Difficulty_Get(CCINIClass & ini, DifficultyClass & diff, char const * section)
    push str_Easy
    jmp  0x005CE19D


; Hack HouseClass::Assign_Handicap to actually assign our new difficulty setting
hack 0x004BB479

    ; Skip this logic for singleplayer
    mov  eax, dword [SessionType]
    test eax, eax
    jz   0x004BB570 
    
    ; For MP, check if the requested difficulty type is 3
    cmp  edi, 3
    jne  0x004BB486 ; if not, jump to original code
    
    ; Set the 'difficulty index' of the house to 0 (Hard AI)
    mov  dword [ecx+58h], 0
    
    mov  edi, [0x0074C488] ; RulesClass pointer
    mov  eax, 0
    
    ; Set up required registers for filling in data
    ; Taken from 0004BB48B
    mov  esi, [ecx+24h]
    lea  edx, [eax+eax*4]
    shl  edx, 4
    
    ; We can't expand RulesClass to include new difficulties, so we must replicate
    ; the original game's code but read the data from our own memory instead from
    ; the RulesClass instance
    mov  eax, DifficultyData ; FirepowerBias
    fld  qword [eax]
    fmul qword [esi+70h]
    fstp qword [ecx+60h]
    
    mov  eax, DifficultyData ; GroundpseedBias
    fld  qword [eax+08h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fmul qword [esi+78h]
    fstp qword [ecx+68h]
    
    mov  eax, DifficultyData ; AirspeedBias
    fld  qword [eax+10h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fmul qword [esi+80h]
    fstp qword [ecx+70h]
    
    mov  eax, DifficultyData ; ArmorBias
    fld  qword [eax+18h]
    fmul qword [esi+88h]
    fstp qword [ecx+78h]
    
    mov  eax, DifficultyData ; ROFBias
    fld  qword [eax+20h]
    fmul qword [esi+90h]
    fstp qword [ecx+80h]
    
    mov  eax, DifficultyData ; CostBias
    fld  qword [eax+28h]
    fmul qword [esi+98h]
    fstp qword [ecx+88h]
    
    mov  eax, DifficultyData ; RepairDelay
    lea  eax, [eax+38h]
    mov  ebx, [eax]
    mov  [ecx+98h], ebx
    mov  eax, [eax+4]
    mov  [ecx+9Ch], eax
    
    mov  eax, DifficultyData ; BuildDelay
    lea  eax, [eax+40h]
    mov  ebx, [eax]
    mov  [ecx+0A0h], ebx
    mov  eax, [eax+4]
    mov  [ecx+0A4h], eax
    
    mov  eax, DifficultyData ; BuildSpeedBias
    fld  qword [eax+30h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fmul qword [esi+0A0h]
    
    mov  eax, [0x0074C488] ; RulesClass pointer
    mov  edi, 0            ; Hard difficulty
    jmp  0x004BB654        ; let the original game code handle the rest

