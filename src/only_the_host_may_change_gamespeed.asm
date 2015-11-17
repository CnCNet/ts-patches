%include "src/patch.inc"

global var.IsHost

@CLEAR 0x004AA5D2, 0x90, 0x004AA5DB
@LJMP 0x004AA5D2, _only_the_host_may_change_gamespeed

section .bss
    var.IsHost resb 1

_only_the_host_may_change_gamespeed:
	cmp byte[0x7E4580], 1
	jnz 0x004AA64B
	cmp byte[var.IsHost], 1
	jnz 0x004AA651
	jmp 0x004AA5DB
