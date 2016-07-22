copy Game.dat Game.exe
tools\linker.exe src\data.asm src\data.inc Game.exe tools\nasm.exe
tools\linker.exe src\code.asm src\code.inc Game.exe tools\nasm.exe
