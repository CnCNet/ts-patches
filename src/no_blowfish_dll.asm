%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

@CLEAR 0x00600F76, 0xEB, 0x00600F77 ; ; Change jz to jmp to prevent Windows message box from appearing because BLOWFISH.DLL isn't registered

%ifdef  NOFISH
@CLEAR 0x005FFE8A, 0x90, 0x005FFEA5 ; skip loading blowfish.dll NOPs UNTIL (not including) memory location 0x005FFEA5
@CLEAR 0x005FFEC2, 0x90, 0x005FFEC9 ; skip freeing loaded blowfish.dll NOPs UNTIL (not including) memory location 0x005FFEC9

hack 0x00600F76
_Continue_When_BlowFish_COM_Object_Cant_Be_Loaded:
    jmp     0x00600FA3
%endif
