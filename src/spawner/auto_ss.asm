%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern SpawnerActive
gbool RunAutoSS, 0
gint DoingAutoSS, 0

sstring str_AutoSSDir, "AutoSS"
sstring str_AutoSSFileNameFormat, "AutoSS/AutoSS-%d-%d_%d.PCX"
sstring str_AutoSSFileNamePng,    "AutoSS/AutoSS-%d-%d_%d.png"
sstring str_AutoSSFileNameJpg,    "AutoSS/AutoSS-%d-%d_%d.jpg"
sstring str_SCRN_png,             "SCRN%04d.png"

hack 0x004EAC39
_ScreenCaptureCommand__Activate_AutoSS_File_Name:
    lea ecx, [esp+0x114]

    cmp dword [SessionType], 3
    jne .Normal_Code

    cmp byte[RunAutoSS], 1
    jnz .Normal_Code

.AutoSS_File_Name:

    push 0
    push str_AutoSSDir
    call [0x006CA0D0] ; CreateDirectoryA

    lea ecx, [esp+0x114]

    push esi
    push dword [Frame]
    push dword [GameIDNumber]

    cmp byte[RunAutoSS], 1      ;Always use png format with autoss
    je  .jpg

    cmp byte[UsePNG], 1
    jne .pcx

 .png:
    push str_AutoSSFileNamePng
    jmp .past_pcx

 .jpg:
    push str_AutoSSFileNameJpg
    jmp .past_pcx

 .pcx:
    push str_AutoSSFileNameFormat ; "AutoSS\\AutoSS-%d-%d_%d.PCX"

 .past_pcx:
    push ecx
    call _sprintf
    add esp, 0x14 ; AFTER PUSHING
    jmp 0x004EAC4F

.Normal_Code:

    cmp byte[UsePNG], 1
    jne .Reg_pcx

    push esi
    push str_SCRN_png
    jmp  0x004EAC46

 .Reg_pcx
    jmp 0x004EAC40

; DoingAutoSS
