%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern IsHost

hack 0x004AA5D2, 0x004AA5DB ; only the host may change gamespeed
        cmp byte[0x7E4580], 1
	jnz 0x004AA64B
	cmp byte[IsHost], 1
	jnz 0x004AA651
	jmp hackend
