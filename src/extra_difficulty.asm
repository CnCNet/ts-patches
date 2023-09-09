%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Adds more difficulty levels.
; Author: Rampastring

; sizeof(DifficultyClass) == 80
section .bss
    ExtremelyEasyDifficultyData RESB 80
    VeryEasyDifficultyData RESB 80
    AINormalDifficultyData RESB 80

sstring str_ExtremelyEasy, "ExtremelyEasy"
sstring str_VeryEasy, "VeryEasy"
sstring str_AINormal, "AINormal"
sstring str_Easy, "Easy"


; Hack RulesClass::Difficulty to read in the new difficulty setting
hack 0x005CE198
    push str_ExtremelyEasy
    mov  ecx, edi   ; CCINIClass pointer
    mov  edx, ExtremelyEasyDifficultyData
    call 0x005CE1E0 ; Difficulty_Get(CCINIClass & ini, DifficultyClass & diff, char const * section)

    push str_VeryEasy
    mov  ecx, edi   ; CCINIClass pointer
    mov  edx, VeryEasyDifficultyData
    call 0x005CE1E0 ; Difficulty_Get(CCINIClass & ini, DifficultyClass & diff, char const * section)

    push str_AINormal
    mov  ecx, edi   ; CCINIClass pointer
    mov  edx, AINormalDifficultyData
    call 0x005CE1E0 ; Difficulty_Get(CCINIClass & ini, DifficultyClass & diff, char const * section)

    push str_Easy
    jmp  0x005CE19D


; Hack HouseClass::Assign_Handicap to actually assign our new difficulty setting
hack 0x004BB479
    
    ; Macro for setting difficulty modifiers of the house
    ; Takes address of difficulty data as parameter
%macro Set_Difficulty_Modifiers_Multiplayer 1
    ; Set up required registers for filling in data
    ; Taken from 0004BB48B
    
    mov  edi, [0x0074C488] ; RulesClass pointer
    mov  eax, 0

    mov  esi, [ecx+24h] ; HouseClass.Class
    ; these below are used as an offset for accessing Rules data
    ; we don't need them because we have our difficulty data outside of Rules
    ; lea  edx, [eax+eax*4]
    ; shl  edx, 4
    
    ; We can't expand RulesClass to include new difficulties, so we must replicate
    ; the original game's code but read the data from our own memory instead from
    ; the RulesClass instance

    ; This still works with saves because the game applies the difficulty values to
    ; house data on scenario initialization, iow. the game saves and loads
    ; the difficulty modifiers from the houses

    mov  eax, %1 ; FirepowerBias
    fld  qword [eax]
    fmul qword [esi+70h]
    fstp qword [ecx+60h]
    
    mov  eax, %1 ; GroundspeedBias
    fld  qword [eax+08h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fmul qword [esi+78h]
    fstp qword [ecx+68h]
    
    mov  eax, %1 ; AirspeedBias
    fld  qword [eax+10h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fmul qword [esi+80h]
    fstp qword [ecx+70h]
    
    mov  eax, %1 ; ArmorBias
    fld  qword [eax+18h]
    fmul qword [esi+88h]
    fstp qword [ecx+78h]
    
    mov  eax, %1 ; ROFBias
    fld  qword [eax+20h]
    fmul qword [esi+90h]
    fstp qword [ecx+80h]
    
    mov  eax, %1 ; CostBias
    fld  qword [eax+28h]
    fmul qword [esi+98h]
    fstp qword [ecx+88h]
    
    mov  eax, %1 ; RepairDelay
    lea  eax, [eax+38h]
    mov  ebx, [eax]
    mov  [ecx+98h], ebx
    mov  eax, [eax+4]
    mov  [ecx+9Ch], eax
    
    mov  eax, %1 ; BuildDelay
    lea  eax, [eax+40h]
    mov  ebx, [eax]
    mov  [ecx+0A0h], ebx
    mov  eax, [eax+4]
    mov  [ecx+0A4h], eax
    
    mov  eax, %1 ; BuildSpeedBias
    fld  qword [eax+30h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fmul qword [esi+0A0h]
    ; missing FSTP instruction here, but
    ; the game has one at 0x004BB654
%endmacro

    ; Separate macro for singleplayer
    ; In singleplayer, the house type's modifiers are ignored
    ; (see Red Alert source code, Assign_Handicap function, works the same in TS)
    ; macro copied and edited from above, see above for more documentation comments
%macro Set_Difficulty_Modifiers_Singleplayer 1
    mov  edi, [0x0074C488] ; RulesClass pointer
    mov  eax, 0

    ; when copying a doubles, we need to do it in two steps
    ; because we only have 4-byte registers :(
    mov  eax, %1 ; FirepowerBias
    mov  esi, [eax]
    mov  [ecx+60h], esi
    mov  esi, [eax+04h]
    mov  [ecx+64h], esi

    mov  eax, %1 ; GroundspeedBias
    fld  qword [eax+08h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fstp qword [ecx+68h]

    mov  eax, %1 ; AirspeedBias
    fld  qword [eax+10h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    fstp qword [ecx+70h]

    mov  eax, %1 ; ArmorBias
    mov  esi, [eax+18h]
    mov  [ecx+78h], esi
    mov  esi, [eax+1Ch]
    mov  [ecx+7Ch], esi

    mov  eax, %1 ; ROFBias
    mov  esi, [eax+20h]
    mov  [ecx+80h], esi
    mov  esi, [eax+24h]
    mov  [ecx+84h], esi

    mov  eax, %1 ; CostBias
    mov  esi, [eax+28h]
    mov  [ecx+88h], esi
    mov  esi, [eax+2Ch]
    mov  [ecx+8Ch], esi

    ; RepairDelay and BuildDelay work identically in SP and MP
    mov  eax, %1 ; RepairDelay
    lea  eax, [eax+38h]
    mov  ebx, [eax]
    mov  [ecx+98h], ebx
    mov  eax, [eax+4]
    mov  [ecx+9Ch], eax

    mov  eax, %1 ; BuildDelay
    lea  eax, [eax+40h]
    mov  ebx, [eax]
    mov  [ecx+0A0h], ebx
    mov  eax, [eax+4]
    mov  [ecx+0A4h], eax

    mov  eax, %1 ; BuildSpeedBias
    fld  qword [eax+30h]
    fmul qword [edi+0BF0h]   ; Rules.GameSpeedBias
    ; missing FSTP instruction here, but
    ; the game has one at 0x004BB654
%endmacro

    ; Check if the requested difficulty type matches any the difficulty
    ; values that we should process
    ; (4 = Extremely Easy, 3 = Very Easy, 1 = AINormal only if the house is an AI house)
    cmp  edi, 4
    je   .Extremely_Easy_Diff
    cmp  edi, 3
    je   .Very_Easy_Diff
    cmp  edi, 1
    je   .AINormal_Diff
    jmp  .Normal_Code     ; if not, jump to original code

.Extremely_Easy_Diff:
    ; Set the 'difficulty index' of the house to 0 (Hard AI)
    mov  dword [ecx+58h], 0

    ; This difficulty level can only show up in MP
    Set_Difficulty_Modifiers_Multiplayer ExtremelyEasyDifficultyData

    mov  eax, [0x0074C488] ; RulesClass pointer
    mov  edi, 0            ; Hard difficulty
    jmp  0x004BB654        ; let the original game code handle the rest

.Very_Easy_Diff:

    ; Set the 'difficulty index' of the house to 0 (Hard AI)
    mov  dword [ecx+58h], 0

    ; This difficulty level can only show up in MP
    Set_Difficulty_Modifiers_Multiplayer VeryEasyDifficultyData

    mov  eax, [0x0074C488] ; RulesClass pointer
    mov  edi, 0            ; Hard difficulty
    jmp  0x004BB654        ; let the original game code handle the rest

.AINormal_Diff:

    call 0x004CB990 ; bool __thiscall HouseClass::Is_Human_Control(void)
                    ; we already have the house pointer in ecx here
    cmp  al, 1
    je   .Normal_Code ; this house is human-controlled, use regular game logic for it

    ; Set the 'difficulty index' of the house to 1 (Medium AI)
    mov  dword [ecx+58h], 1

    mov  eax, [SessionType]
    cmp  eax, 0
    je   .Set_Modifiers_Singleplayer

    Set_Difficulty_Modifiers_Multiplayer AINormalDifficultyData
    jmp  .Past_Modifiers

.Set_Modifiers_Singleplayer:

    Set_Difficulty_Modifiers_Singleplayer AINormalDifficultyData

.Past_Modifiers:

    mov  eax, [0x0074C488] ; RulesClass pointer
    mov  edi, 1            ; Normal difficulty
    jmp  0x004BB654        ; let the original game code handle the rest

    ; Use original game difficulty-assignment code for this case
.Normal_Code:
    mov  eax, [SessionType]
    test eax, eax
    jz   0x004BB570
    jmp  0x004BB486
