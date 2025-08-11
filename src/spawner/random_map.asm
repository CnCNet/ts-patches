%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/string.inc"
%include "TiberianSun.inc"
%include "ini.inc"

%ifdef SPAWNER

gbool RandomMap, 0

sstring str_Basic, "Basic"
sstring str_RandomMap, "RandomMap"
cextern MapSeed

;;; Don't create units twice.
@CLEAR 0x005DBE83, 0x90, 0x005DBE88

;;; First, read a little bit of Scenario INI, if RandomMap=Yes then jump to generate random map
hack 0x005DBEBD
    call 0x005DD100             ; Read_Scenario_INI

    cmp  byte[RandomMap], 0
    jz   hackend

    jmp 0x005DBE5E

;;; Read RandomMap by intercepting call to Get_Bool(Scenario, Basic, Official)
hack 0x005DD5CB
    call 0x004DE140
    cmp  byte[RandomMap], 1
    je   hackend

    mov  bl, al

    INIClass_Get_Bool ebp, str_Basic, str_RandomMap, 0
    mov byte[RandomMap], al

    test al, al
    mov  al, bl
    jz   hackend

    mov  ecx, [Scen]
    mov  byte[ecx+0x1D93], 1

    xor al, al
    jmp 0x005DD623

;;; Something here causes a crash
@CLEAR 0x0053DBF9, 0x90, 0x0053DC3C

;;; Hack rmg to read the scenario for unit mods and stuff
sstring ScenarioFile, "", 0x64
hack 0x0053DB55
   mov  ecx, ScenarioFile
   push ScenarioName
   call 0x004497B0              ;CCFileClass::CCFileClass

   lea  ecx, [esp+0x130]
   push 0
   push 1
   push ScenarioFile
   call 0x00449F30              ;CINIClass::Load

 .Ret:
   add esp, 8
   jmp hackend


;;; Use the Seed value from spawn.ini rather than the one in the spawnmap.ini file
hack 0x0053C828
   add esp, 12
   mov eax, [Seed]
   jmp hackend

%endif
