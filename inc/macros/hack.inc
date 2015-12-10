;; requires that "macros/patch.inc" also be included

;; aligns a patch, and adds the long jump needed to get there
;; also adds a context for hack-local labels
;;
;; arg1 : address to COMEFROM
;; arg2 : name of patch (for ease of debugging)
;;
%macro @HACK 2
    %ifctx __hack
        %error "can't nest hacks"
    %else
        %push __hack

        %$begin equ %1

        @LJMP {(%1)}, {(%2)}
        [section .text]
        align 16, db 0xCC
        %2:
    %endif
%endmacro

%macro @ENDHACK 0
    %ifctx __hack
        align 16, db 0xCC
        __SECT__
        %pop
    %else
        %error "no corrosponding `@HACK'"
    %endif
%endmacro

;; everything that @HACK does, plus clears old code. %$end is bound for ease of making the final jump
;;
;; arg1 : address to COMEFROM & after start clearing
;; arg2 : address to clear to (exclusive)
;; arg3 : name of patch (for ease of debugging)
;;
%macro @REPLACE 3
    %ifctx __replace
        %error "can't nest replaces"
    %else
        %push __replace

        %if %2 - ((%1) + 5) < 0
            %error "end must be at least 5 bytes (the size of a long jump) after start"
        %endif

        @CLEAR {(%1) + 5}, 0xCC, {(%2)}
        @HACK {(%1)}, {%3}

        %$end equ %2
    %endif
%endmacro

%macro @ENDREPLACE 0
    %ifctx __hack
        @ENDHACK
        %ifctx __replace
            %pop
        %else
            %error "no corrosponding `@REPLACE'"
        %endif
    %else
        %error "no corrosponding `@REPLACE'"
    %endif
%endmacro

;; everything that @HACK does, plus: clears old code, saves registers, restores registers and jumps back to arg2
;;
;; arg1 : address to COMEFROM & after start clearing
;; arg2 : address to clear to (exclusive) and destination of the final jump
;; arg3 : number of params of the called function
;; arg4 : name of patch (for ease of debugging)
;;
%macro @CALLC 4
    %ifctx __callc
        %error "can't nest callcs"
    %else
        %push __callc

        %if %2 - ((%1) + 5) < 0
            %error "end must be at least 5 bytes (the size of a long jump) after start"
        %endif

        @CLEAR {(%1) + 5}, 0xCC, {(%2)}
        @HACK {(%1)}, {%4}
        push ecx
        push edx
        push eax
        push esi
        %$end equ %2
        %$argcount equ %3
    %endif
%endmacro

%macro @FINISHCALLC 0
    %ifctx __hack
        
        %ifctx __finishcallc
            %error "can't nest finishcallcs"
        %else
            add esp, (%$argcount * 4)
            pop esi
            pop eax
            pop edx
            pop ecx
            
            %push __finishcallc
        %endif
    %else
        %error "no corrosponding `@CALLC'"
    %endif
%endmacro

%macro @ENDCALLC 0
    %ifctx __finishcallc
        %pop
    %else
        %ifctx __hack
            add esp, (%$argcount * 4)
            pop esi
            pop eax
            pop edx
            pop ecx
        %endif
    %endif

    %ifctx __hack
        jmp %$end
        @ENDHACK
        %ifctx __callc
            %pop
        %else
            %error "no corrosponding `@CALLC'"
        %endif
    %else
        %error "no corrosponding `@CALLC'"
    %endif
%endmacro

