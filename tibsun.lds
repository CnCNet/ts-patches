/* GNU ld linker script for Game.exe */
start = 0x6B7E21;
ENTRY(start);
SECTIONS
{
    .text             0x401000 : { input.dat(.text); }
    .rdata            0x6CA000 : { input.dat(.rdata); }
    .data             0x6EE000 : { input.dat(.data); . = ALIGN(0x1000); }
    .bss         ALIGN(0x1000) : { . = . + 0x120F74; }
    /DISCARD/                  : { input.dat(.rsrc); }

    .idata       ALIGN(0x1000) : { *(.idata); }
    .eh_frame    ALIGN(0x1000) : { *(.eh_frame); }

    /DISCARD/                  : { *(.drectve); *(.rdata$zzz); }
    .p_text      ALIGN(0x1000) : { *(.text); }
    .p_rdata     ALIGN(0x1000) : { *(.rdata); }
    .p_data      ALIGN(0x1000) : { *(.data); }
    .p_bss       ALIGN(0x1000) : { *(.bss) *(COMMON); }
    .rsrc        ALIGN(0x1000) : { *(.rsrc); }

    .patch       ALIGN(0x1000) : { *(.patch); }
}
