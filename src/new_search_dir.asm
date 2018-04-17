%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"


sstring str_SearchDir, "MIX\\"
sstring str_SearchDir2, "INI\\"
%define STR_MAX 256

;;; The string and the SearchDirList structure must be malloc because TS will free() them later
hack 0x005ED005, 0x005ED00B
        mov     [ebp+0x12C8], eax

        push    edx
        push    ecx

        push    8               ; Allocate the structure for SearchDir
        call    new

        mov     dword[eax], 0
        mov     dword [0x00760920], eax

        push    STR_MAX         ; Allocate the string for SearchDir
        call    new

        push    str_SearchDir
        push    eax
        call    strcpy

        mov     edx, dword[0x00760920]
        mov     dword[edx+4], eax



        push    8               ; Allocate the structure for SearchDir2
        call    new

        mov     dword[eax], 0
        mov     edx, dword[0x00760920]
        mov     dword[edx], eax

        push    STR_MAX         ; Allocate the string for SearchDir2
        call    new

        push    str_SearchDir2
        push    eax
        call    strcpy

        mov     edx, dword[0x00760920]
        mov     edx, dword[edx]
        mov     dword[edx+4], eax

        add     esp, 32
        pop     ecx
        pop     edx
        jmp     hackend

;; Addon_Available() hack
@SET 0x004070CF, {mov bl, 1}

;;; Expand%02.mix
@CALL 0x004E3EAE, CCFileClass__CCFileClass
@CALL 0x004E3EC1, CCFileClass__Destroy

;;; patch.mix
@CALL 0x004E3D43, CCFileClass__CCFileClass
@CALL 0x004E3D58, CCFileClass__Destroy
