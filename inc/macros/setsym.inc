; for C
%macro setcglob 2
    global _%2
    _%2 equ %1
%endmacro

; for c++
%macro setxglob 3
    setcglob {%1}, {%2}
    global %3
    %3 equ _%2
%endmacro
