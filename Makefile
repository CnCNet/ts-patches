-include config.mk
-include custom.mk

#
# defines
#
INPUT       = Game.exe
LDS         = tibsun.lds
IMPORTS     = 0x2EC050 280
LDFLAGS     = --file-alignment=0x1000 --section-alignment=0x1000 --subsystem=windows --enable-stdcall-fixup
NFLAGS      = -f elf -Iinc/
CFLAGS      = -std=c99 -Iinc/ -I3rdparty/ -DLODEPNG_NO_COMPILE_DISK
REV         = $(shell git rev-parse --short @{0})
VERSION     = SOFT_VERSION-CnCNet-patch-$(REV)
WINDRES_FLAGS = --preprocessor-arg -DVERSION="$(VERSION)"

PETOOL     ?= petool
STRIP      ?= strip
NASM       ?= nasm
WINDRES    ?= windres

#
# conditions
#
ifdef VINIFERA
$(info VINIFERA defined)
NFLAGS += -DVINIFERA
CFLAGS += -DVINIFERA
endif

ifdef WWDEBUG
$(info WWDEBUG defined)
NFLAGS += -DWWDEBUG
CFLAGS += -DWWDEBUG
endif

# stats causes savegames to crash. Use STATS only for cncnet online.
ifdef STATS
$(info STATS defined)
NFLAGS += -DSTATS
CFLAGS += -DSTATS
endif

ifdef EXPERIMENTAL
$(info EXPERIMENTAL defined)
NFLAGS += -DEXPERIMENTAL
CLFAGS += -DEXPERIMENTAL
endif

#
# includes
#
include src/common.mk
include src/mp.mk
include src/sp.mk

include src/mods/dta/dta.mk
include src/mods/ti/ti.mk
include src/mods/to/to.mk
include src/mods/tsclient/tsclient.mk
include src/mods/rubicon/rubicon.mk

#
# targets
#
all:
	tibsun.exe singleplayer.exe dtagame.exe tigame.exe togame.exe tsclientgame.exe rubicongame.exe

clean:
	$(RM) $(OUTPUT)
	$(RM) $(COMMON_OBJS)
	$(RM) $(SP_OBJS) $(MP_OBJS)
	$(RM) $(DTA_OBJS) $(TI_OBJS) $(TO_OBJS) $(TSCLIENT_OBJS) $(RUBICON_OBJS)

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<

%.o: %.rc
	$(WINDRES) $(WINDRES_FLAGS) $< $@

src/sun.ini.sp.o: src/sun.ini.c
	$(CC) $(CFLAGS) -DSINGLEPLAYER=1 -c -o $@ $<

src/write_jpg_png.o: src/write_jpg_png.c 3rdparty/tiny_jpeg.h
	$(CC) $(CFLAGS) -c -o $@ $<

tibsun.exe: $(LDS) $(INPUT) $(COMMON_OBJS) $(MP_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(COMMON_OBJS) $(MP_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

singleplayer.exe: $(LDS) $(INPUT) $(COMMON_OBJS) $(SP_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(COMMON_OBJS) $(SP_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

src/mods/dta/res/res.o: src/mods/dta/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/dta/res/ -Ires/  $< $@

dtagame.exe: $(LDS) $(INPUT) $(DTA_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(DTA_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

src/mods/ti/res/res.o: src/mods/ti/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/ti/res/ -Ires/  $< $@

tigame.exe: $(LDS) $(INPUT) $(TI_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(TI_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

src/mods/to/res/res.o: src/mods/to/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/to/res/ -Ires/  $< $@

togame.exe: $(LDS) $(INPUT) $(TO_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(TO_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

src/mods/tsclient/res/res.o: src/mods/tsclient/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/tsclient/res/ -Ires/  $< $@

tsclientgame.exe: $(LDS) $(INPUT) $(TSCLIENT_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(TSCLIENT_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

src/mods/rubicon/res/res.o: src/mods/rubicon/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/rubicon/res/ -Ires/  $< $@

rubicongame.exe: $(LDS) $(INPUT) $(RUBICON_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(RUBICON_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@
