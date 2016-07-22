-include config.mk

INPUT       = Game.exe
OUTPUT      = tibsun.exe
LDS         = tibsun.lds
IMPORTS     = 0x2EC050 280
LDFLAGS     = --file-alignment=0x1000 --section-alignment=0x1000 --subsystem=windows
NFLAGS      = -f elf

OBJS        = \
              src/hp03.o \
              src/loading.o \
              src/savegame.o \
              src/no-cd.o \
              src/single-proc-affinity.o \
              src/no_blowfish_dll.o \
              src/briefing_restate_map_file.o \
              src/sym.o \
              rsrc.o

PETOOL     ?= petool
STRIP      ?= strip
NASM       ?= nasm

all: $(OUTPUT)

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<

rsrc.o: $(INPUT)
	$(PETOOL) re2obj $(INPUT) $@

$(OUTPUT): $(LDS) $(INPUT) $(OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(OBJS)
ifneq (,$(IMPORTS))
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
endif
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

clean:
	$(RM) $(OUTPUT) $(OBJS)
