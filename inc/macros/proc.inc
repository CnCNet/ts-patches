%macro PROC 1
    %ifctx __proc
        %error "can't nest procedures"
    %else
        [section .text]
        align   16, db 0xCC
        %1:
        %push __proc
    %endif
%endmacro

%macro ENDPROC 0
    %ifctx __proc
        align   16, db 0xCC
        %pop
        __SECT__
    %else
        %error "no corrosponding `PROC'"
    %endif
%endmacro
