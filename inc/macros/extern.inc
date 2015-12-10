%ifndef EXTERN_INC
%define EXTERN_INC

%macro cglobal 1
    global  _%1
    _%1 equ %1
%endmacro

%macro cextern 1
    extern  _%1
    %1 equ _%1
%endmacro

%endif
