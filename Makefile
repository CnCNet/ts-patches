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
              src/fix_mouse_not_found_error.o \
              src/single-proc-affinity.o \
              src/spawner/tunnel.o \
              src/spawner/nethack.o \
              src/spawner/build_off_ally.o \
              src/anticheat_test.o \
              src/only_the_host_may_change_gamespeed.o \
              src/trigger_actions_extended.o \
              src/briefing_screen_mission_start.o \
              src/briefing_restate_map_file.o \
              src/no-cd.o \
              src/display_messages_typed_by_yourself.o \
              src/graphics_patch.o \
              src/multiplayer_units_placing.o \
              src/reinforcements_player_specific.o \
              src/no_options_menu_animation.o \
              src/internet_cncnet.o \
              src/tiberium_stuff.o \
              src/no_window_frame.o \
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
