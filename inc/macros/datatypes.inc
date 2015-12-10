%include "macros/extern.inc"

%assign true 1
%assign false 0

;; global const string -> arg1 = name, arg2 = value
%macro gstring 2 
    cglobal %1
    sstring %1, %2
%endmacro

;; static (local) const string -> arg1 = name, arg2 = value
%macro sstring 2 
    [section .rdata]
    %1 db %2,0
    __SECT__
%endmacro

;; global string -> arg1 = name, arg2 = value, arg3 = length
%macro gstring 3
    cglobal %1
    sstring %1, %2, %3
%endmacro

;; static (local) string -> arg1 = name, arg2 = value, arg3 = length
%macro sstring 3
    %strlen ___StringLength %2
    
    %if ___StringLength > 0
        [section .data]
        %1 db %2
        times ((%3) - (___StringLength)) db 0
        __SECT__
    %else
        [section .bss]
        %1 resb %3
        __SECT__
    %endif
%endmacro

;; global int -> arg1 = name, arg2 = value
%macro gint 2
    cglobal %1
    sint %1, {%2}
%endmacro

;; static (local) int -> arg1 = name, arg2 = value
%macro sint 2
    %ifidni %2,0
        [section .bss]
        %1 resd 1
        __SECT__
    %else
        [section .data]
        %1 dd %2
        __SECT__
    %endif
%endmacro

;; global short -> arg1 = name, arg2 = value
%macro gshort 2
    cglobal %1
    sshort %1, {%2}
%endmacro

;; static (local) short -> arg1 = name, arg2 = value
%macro sshort 2
    %ifidni %2,0
        [section .bss]
        %1 resw 1
        __SECT__
    %else
        [section .data]
        %1 dw %2
        __SECT__
    %endif
%endmacro

;; global bool -> arg1 = name, arg2 = value
%macro gbool 2
    cglobal %1
    sbyte %1, {%2}
%endmacro

;; static (local) bool -> arg1 = name, arg2 = value
%macro sbool 2
    sbyte %1, {%2}
%endmacro

;; global byte -> arg1 = name, arg2 = value
%macro gbyte 2
    cglobal %1
    sbyte %1, {%2}
%endmacro

;; static (local) byte -> arg1 = name, arg2 = value
%macro sbyte 2
    %ifidni %2,0
        [section .bss]
        %1 resb 1
        __SECT__
    %else
        [section .data]
        %1 db %2
        __SECT__
    %endif
%endmacro

;; global byte array -> arg1 = name, arg2 = value, arg3 = length
%macro gbyte 3
    cglobal %1
    sbyte %1, {%2}, %3
%endmacro

;; static (local) byte array -> arg1 = name, arg2 = value, arg3 = length
%macro sbyte 3
    %ifidni %2,0
        [section .bss]
        %1 resb %3
        __SECT__
    %else
        [section .data]
        %1 times %3 db %2
        __SECT__
    %endif
%endmacro

;; global function -> arg1 = name
%macro gfunction 1
    cglobal %1
    sfunction %1
%endmacro

;; static (local) function -> arg1 = name
%macro sfunction 1
    [section .text]
    align 16, db 0xCC
    %1:
%endmacro

;; global file (const byte array) -> arg1 = name, arg2 = filePath
%macro gfile 2
    cglobal %1
    cglobal %1Length
    sfile %1, %2
%endmacro

;; static (local) file (const byte array) -> arg1 = name, arg2 = filePath
%macro sfile 2
    [section .rdata]
    %1 incbin %2
    %1Length dd $-%1
    __SECT__
%endmacro
