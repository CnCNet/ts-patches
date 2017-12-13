-include config.mk

INPUT       = Game.exe
LDS         = tibsun.lds
IMPORTS     = 0x2EC050 280
LDFLAGS     = --file-alignment=0x1000 --section-alignment=0x1000 --subsystem=windows --enable-stdcall-fixup
NFLAGS      = -f elf -Iinc/
CFLAGS      = -std=c99 -Iinc/
REV         = $(shell git rev-parse --short @{0})
VERSION     = SOFT_VERSION-CnCNet-patch-$(REV)
WINDRES_FLAGS = --preprocessor-arg -DVERSION="$(VERSION)"

COMMON_OBJS = \
              src/wndproc.o \
              src/scale_movie_fix.o \
              src/scale_movie_fix_hack.o \
              src/scrollrate_fix.o \
              src/tiberium_on_slope_crash.o \
              src/no_movie_and_score_mix_dependency.o \
              src/IonBlastClass_crash.o \
              src/singleplayer_objects_on_multiplayer_map_crash.o \
              src/laser_draw_it_crash.o \
              src/no_blowfish_dll.o \
              src/high_res_crash.o \
              src/disable_max_windowed_mode.o \
              src/disable_dpi_scaling.o \
              src/win8_compat-func.o \
              src/remove_16bit_windowed_check.o \
              src/hp03.o \
              src/fix_mouse_not_found_error.o \
              src/single-proc-affinity.o \
              src/graphics_patch.o \
              src/no_window_frame.o \
              src/exception_catch.o \
              src/force_conversion_type.o \
              res/res.o \
              sym.o

SP_OBJS = src/no-cd_tfd.o src/sun.ini.sp.o

MP_OBJS          = \
                    src/mods/dont_save_without_all_players.o \
                    src/sun.ini.o \
                    src/no-cd_iran.o \
                    src/in-game_message_background.o \
                    src/savegame.o \
                    src/trigger_actions_extended.o \
                    src/briefing_screen_mission_start.o \
                    src/briefing_restate_map_file.o \
                    src/multiplayer_units_placing.o \
                    src/display_messages_typed_by_yourself.o \
                    src/reinforcements_player_specific.o \
                    src/internet_cncnet.o \
                    src/tiberium_stuff.o \
                    src/no_options_menu_animation.o \
                    src/short_connection_timeout.o \
                    src/spawner/spawner.o \
                    src/spawner/protocol_zero.o \
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
                    src/Hook_Main_Loop.o \
                    src/hotkeys.o \
                    src/chatallies.o \
                    src/disable_alt_tab.o \
                    src/spawner/auto_ally_by_spawn_loc.o \
                    src/mumblelink.o \
                    src/wcsncpy.o \
                    src/manual_aim_sams.o \
                    src/gamespeed.o \
                    src/mouse_behavior.o \
                    src/text_triggers.o \
                    src/attack_neutral_units.o \
                    src/mouse_always_in_focus.o \
                    src/waypoint_enhancements.o \
                    src/easy_shroud.o \
                    src/new_search_dir.o \
                    src/only_the_host_may_change_gamespeed.o \
                    src/override_colors.o \
                    src/mods/dta/scrap_metal_explosion.o \
                    src/mods/dta/auto_deploy_mcv.o \
                    src/minimap_crash.o \
                    src/new_events.o \
                    src/new_events_s.o \
                    src/shared_control.o \
                    src/recon_kick.o \
                    src/hover_show_health.o \
                    src/autosave.o \
                    src/show_stats.o \
                    src/sidebar.o \
                    src/response_time_func.o \
                    src/fix_100_unit_bug.o \
                    src/veterancy_crate_check_trainable.o \
                    src/alt_to_undeploy.o \
                    src/factory_rallypoints.o \
                    src/harvesters_autoharvest.o \
                    src/harvesters_guardcommand.o \
                    src/veterancy_from_allies.o \
                    src/flickering_shadow_fix.o \
                    src/voxelanim_damage_bug.o \
                    src/buildingtype_initialization.o \
                    src/destroytrigger_crash.o \
                    src/basic_theme_fix.o \
                    src/aircraft_repair.o \
                    src/add_team_better.o \
                    src/center_team.o \
                    src/hack_house_from_house_type.o \
                    src/place_building_hotkey.o \
                    src/repeat_last_building_hotkey.o \
                    src/spy_fix.o \
                    src/hotkey_help.o \
                    src/draw_all_action_lines.o \
                    src/radar_event_hacks.o \
                    src/guard_mode_patch.o \
                    src/random_loop_delay.o \
                    src/rage_quit.o \
                    src/move_team_group_number.o \
                    src/skip_score.o \
                    src/hide_names_qm.o \


ifdef WWDEBUG
    NFLAGS += -D WWDEBUG
    CFLAGS += -D WWDEBUG
    MP_OBJS        +=  src/debugging_help.o \
	                   src/tactical_zoom.o
endif

ifdef STATS
   # stats causes savegames to crash. Use STATS only for cncnet online.
   NFLAGS += -D STATS
   CFLAGS += -D STATS
endif

ifdef EXPERIMENTAL
    NFLAGS += -D EXPERIMENTAL
    CLFAGS += -D EXPERIMENTAL
#    OBJS        +=  src/new_armor_types.o \
#                    src/new_armor_types_s.o \

endif


PETOOL     ?= petool
STRIP      ?= strip
NASM       ?= nasm
WINDRES    ?= windres

-include custom.mk

all: tibsun.exe dta.exe ti.exe singleplayer.exe tsclientgame.exe

clean:
	$(RM) $(OUTPUT) $(COMMON_OBJS)
	$(RM) $(SP_OBJS) $(MP_OBJS) $(DTA_OBJS) $(TI_OBJS) $(TSCLIENT_OBJS)

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<

%.o: %.rc
	$(WINDRES) $(WINDRES_FLAGS) $< $@

src/sun.ini.sp.o: src/sun.ini.c
	$(CC) $(CFLAGS) -DSINGLEPLAYER=1 -c -o $@ $<

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

include src/mods/dta/dta.mk
src/mods/dta/res/res.o: src/mods/dta/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/dta/res/ -Ires/  $< $@

dta.exe: $(LDS) $(INPUT) $(DTA_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(DTA_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

include src/mods/ti/ti.mk
src/mods/ti/res/res.o: src/mods/ti/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/ti/res/ -Ires/  $< $@

ti.exe: $(LDS) $(INPUT) $(TI_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(TI_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@

include src/mods/tsclient/tsclient.mk
src/mods/tsclient/res/res.o: src/mods/tsclient/res/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Isrc/mods/tsclient/res/ -Ires/  $< $@

tsclientgame.exe: $(LDS) $(INPUT) $(TSCLIENT_OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $@ $(TSCLIENT_OBJS)
	$(PETOOL) setdd $@ 1 $(IMPORTS) || ($(RM) $@ && exit 1)
	$(PETOOL) patch $@ || ($(RM) $@ && exit 1)
	$(STRIP) -R .patch $@ || ($(RM) $@ && exit 1)
	$(PETOOL) dump $@
