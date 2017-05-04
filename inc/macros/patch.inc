;
; Copyright (c) 2013 Toni Spets <toni.spets@iki.fi>
;
; Permission to use, copy, modify, and distribute this software for any
; purpose with or without fee is hereby granted, provided that the above
; copyright notice and this permission notice appear in all copies.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;

%macro @PATCH 1
    %ifctx __patch
        %error "can't nest patches"
    %else
        [section .patch]
        %push __patch
        dd (%1)                 ; patch addrss
        dd %$end - %$start      ; length of the patch
      %$start:
    %endif
%endmacro

%macro @ENDPATCH 0
    %ifctx __patch
      %$end:
        %pop
        __SECT__
    %else
        %error "no corrosponding `@PATCH'"
    %endif
%endmacro

%macro @SET 2
    @PATCH (%1)
    %2
    @ENDPATCH
%endmacro

;; arg1 : start address, will clear this
;; arg2 : what byte to put here. but be a byte long or shit breaks
;; arg3 : stop address, will NOT clear this.
%macro @CLEAR 3
    @PATCH (%1)
    %if ((%3) - (%1)) < 0
        %error "stop address is less than start address in @CLEAR"
    %endif
    times ((%3) - (%1)) db (%2) ; patch data
    @ENDPATCH
%endmacro

%macro @CLEAR 2
    @CLEAR %1, 0xCC, %2
%endmacro

%macro @SJMP 2
    @PATCH (%1)
    db 0xEB                     ; short jump
    db (%2) - (%1) - 2          ; relative offset
    @ENDPATCH
%endmacro

%macro @SJZ 2
    @PATCH (%1)
    db 0x74
    db (%2) - (%1) - 2
    @ENDPATCH
%endmacro

%macro @SJNZ 2
    @PATCH (%1)
    db 0x75
    db (%2) - (%1) - 2
    @ENDPATCH
%endmacro

%macro @SJGE 2
    @PATCH (%1)
    db 0x7D
    db (%2) - (%1) - 2
    @ENDPATCH
%endmacro

%macro @LJA 2
    @PATCH (%1)
    db 0x0F, 0x87
    dd (%2) - (%1) - 6
    @ENDPATCH
%endmacro

%macro @NJNB 2
    @PATCH (%1)
    db 0x0F, 0x83
    dd (%2) - (%1) - 6
    @ENDPATCH
%endmacro

%macro @LJNZ 2
    @PATCH (%1)
    db 0x0F, 0x85
    dd (%2) - (%1) - 6
    @ENDPATCH
%endmacro

%macro @LJZ 2
    @PATCH (%1)
    db 0x0F, 0x84
    dd (%2) - (%1) - 6
    @ENDPATCH
%endmacro

%macro @LJGE 2
    @PATCH (%1)
    db 0x0F, 0x8D
    dd (%2) - (%1) - 6
    @ENDPATCH
%endmacro

%macro @LJLE 2
    @PATCH (%1)
    db 0x0F, 0x8E
    dd (%2) - (%1) - 6
    @ENDPATCH
%endmacro

%macro @LJMP 2
    @PATCH (%1)
    db 0xE9                     ; far jump
    dd (%2) - (%1) - 5          ; relative offset
    @ENDPATCH
%endmacro

%macro @CALL 2
    @PATCH (%1)
    db 0xE8                     ; far call
    dd (%2) - (%1) - 5          ; relative offset
    @ENDPATCH
%endmacro

%macro hack 1
    global dest%1 ; Make it global to prevent bugs where 2 hacks were placed on the same location
    %define hackend (%1 + 5)
    @LJMP {(%1)}, dest%1
    [section .text]
    align 16, db 0xCC
    dest%1:
%endmacro

%macro hack 2
    global dest%1 ; Make it global to prevent bugs where 2 hacks were placed on the same location
    %define hackend %2
    %if %2 - ((%1) + 5) < 0
        %error "end must be at least 5 bytes (the size of a long jump) after start"
    %endif

    @CLEAR {(%1) + 5}, 0xCC, {(%2)}
    @LJMP {(%1)}, dest%1
    [section .text]
    align 16, db 0xCC
    dest%1:
%endmacro
