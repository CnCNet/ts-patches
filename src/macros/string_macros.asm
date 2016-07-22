%macro strcmp_i 2
    push    %1             ; Str2
    push    %2             ; Str1
    call    __strcmpi
    add     esp, 8
%endmacro