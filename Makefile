-include config.mk

INPUT       = Game.exe
OUTPUT      = tibsun.exe
LDS         = tibsun.lds
IMPORTS     = 0x2EC050 280
LDFLAGS     = --file-alignment=0x1000 --section-alignment=0x1000 --subsystem=windows --enable-stdcall-fixup
NFLAGS      = -f elf -Iinc/
CFLAGS      = -std=c99 -Iinc/
CPPFLAGS    = -Iinc/
REV         = $(shell git describe --tag)
VERSION     = "CnC-Patch $(REV) (based off WW SOFT_VERSION)"
WINDRES_FLAGS = --preprocessor-arg -DVERSION=$(VERSION)

OBJS        = \
              src/tiberium_on_slope_crash.o \
              src/no_movie_and_score_mix_dependency.o \
              src/IonBlastClass_crash.o \
              src/singleplayer_objects_on_multiplayer_map_crash.o \
              src/laser_draw_it_crash.o \
              src/no_blowfish_dll.o \
              src/high_res_crash.o \
              src/disable_max_windowed_mode.o \
              src/disable_dpi_scaling.o \
              src/sun.ini.o \
              src/remove_16bit_windowed_check.o \
              src/hp03.o \
              src/fix_mouse_not_found_error.o \
              src/single-proc-affinity.o \
              src/graphics_patch.o \
              src/no_window_frame.o \
              res/res.o \
              sym.o

ifdef SINGLEPLAYER
    CFLAGS      += -D SINGLEPLAYER
    OBJS        += \
                    src/no-cd_tfd.o
else
    OBJS        += \
                    src/no-cd_iran.o \
                    src/in-game_message_background.o \
                    src/savegame.o \
                    src/only_the_host_may_change_gamespeed.o \
                    src/trigger_actions_extended.o \
                    src/briefing_screen_mission_start.o \
                    src/briefing_restate_map_file.o \
                    src/multiplayer_units_placing.o \
                    src/display_messages_typed_by_yourself.o \
                    src/reinforcements_player_specific.o \
                    src/internet_cncnet.o \
                    src/tiberium_stuff.o \
                    src/short_connection_timeout.o \
                    src/no_options_menu_animation.o \
                    src/spawner/spawner.o \
                    src/spawner/nethack.o \
                    src/spawner/selectable_spawns.o \
                    src/spawner/spectators.o \
                    src/spawner/statistics.o \
                    src/spawner/auto-surrender.o \
                    src/spawner/build_off_ally.o \
                    src/spawner/auto_ss.o \
                    src/jj_barracks_glitch_fix.o \
                    src/ts_util.o \
                    src/alt_scout_fix.o \
                    src/aircraft_not_reloading_fix.o \
                    src/carryall_click_under_glitch.o \
                    src/disable_edge_scrolling.o \
                    src/harvester_block_ref_exploit.o \
                    src/fix_depot_explosion_glitch.o \
                    src/harvester_truce.o \
                    src/crate_patches.o \
                    src/mpdebug.o \
                    src/Hook_Main_Loop.o \
                    src/hotkeys.o \
                    src/chatallies.o \
                    src/disable_alt_tab.o \
                    src/spawner/auto_ally_by_spawn_loc.o \
                    src/mumblelink.o \
                    src/wcsncpy.o \
                    src/manual_aim_sams.o \
                    src/gamespeed.o \
                    src/drag_distance.o \
                    src/override_colors.o
endif
ifdef DTA
    OBJS        +=  src/dta/dta_hacks.o
endif
ifdef WWDEBUG
    NFLAGS += -D WWDEBUG
    CFLAGS += -D WWDEBUG
    OBJS        +=  src/debugging_help.o
endif

PETOOL     ?= petool
STRIP      ?= strip
NASM       ?= nasm
WINDRES    ?= windres

all: $(OUTPUT)

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<
  
%.o: %.rc
	$(WINDRES) $(WINDRES_FLAGS) $< $@

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
