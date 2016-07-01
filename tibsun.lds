/* GNU ld linker script for Game.exe */
start = 0x6B7E21;
ENTRY(start);
SECTIONS
{
    .text             0x401000 : { Game.exe(.text); }
    .rdata            0x6CA000 : { Game.exe(.rdata); }
    .data             0x6EE000 : { Game.exe(.data); . = ALIGN(0x1000); }
    .bss         ALIGN(0x1000) : { . = . + 0x120F74; }
    /DISCARD/                  : { Game.exe(.rsrc); }

    .idata       ALIGN(0x1000) : { *(.idata); }

    /DISCARD/                  : { *(.drectve); }
    .p_text      ALIGN(0x1000) : { *(.text); }
    .p_rdata     ALIGN(0x1000) : { *(.rdata); }
    .p_data      ALIGN(0x1000) : { *(.data); }
    .p_bss       ALIGN(0x1000) : { *(.bss) *(COMMON); }
    .rsrc        ALIGN(0x1000) : { *(.rsrc); }

    .patch       ALIGN(0x1000) : { *(.patch) }
    /DISCARD/                  : { *(.eh_frame) }
}
