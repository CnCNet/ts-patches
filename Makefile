NFLAGS=-I./include/
CC?=gcc
DAT=dta.dat
EXE=dta.exe
NASM?=nasm$(EXT)
REV=$(shell sh -c 'git rev-parse --short @{0}')
CFLAGS=-m32 -pedantic -O2 -Wall -DREV=\"$(REV)\"

all: dta.exe build

tools: linker$(EXT) extpe$(EXT)

dta.exe: $(DAT) extpe$(EXT)
	cp $(DAT) $(EXE)

build: linker$(EXT)
	./linker$(EXT) src/main.asm src/main.inc $(EXE) $(NASM) $(NFLAGS)

$(DAT):
	@echo "You are missing the required cnc95.dat from 1.06c patch"
	@false

linker$(EXT): tools/linker.c
	$(CC) $(CFLAGS) -o linker$(EXT) tools/linker.c

extpe$(EXT): tools/extpe.c tools/pe.h
	$(CC) $(CFLAGS) -o extpe$(EXT) tools/extpe.c

clean:
	rm -rf extpe$(EXT) linker$(EXT) $(EXE) src/*.map src/*.bin src/*.inc
