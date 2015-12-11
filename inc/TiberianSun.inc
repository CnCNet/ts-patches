%include "macros/extern.inc"

; This header works with sym.asm which defines the Vanilla symbols
; This header will be split up as it becomes larger

; ### Functions ###

cextern INIClass__GetBool

; ### imports ###

cextern _imp__GetCommandLineA
cextern _imp__timeGetTime
cextern _imp__LoadLibraryA
cextern _imp__GetProcAddress
cextern _imp__GetCurrentProcess
