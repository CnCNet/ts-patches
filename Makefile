# =========================================================
#
# ts-patches makefile
#
# =========================================================
.DEFAULT_GOAL := all

ifeq ($(ARCH),LINUX)
include config.mk
endif


# =========================================================
# Defines
# =========================================================
INPUT       = input.dat
OUTPUT      = game.exe
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

# Use these for checking for more than one definition.
ifndef_any_of = $(filter undefined,$(foreach v,$(1),$(origin $(v))))
ifdef_any_of = $(filter-out undefined,$(foreach v,$(1),$(origin $(v))))


# =========================================================
# Build types
# =========================================================

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

ifdef TIBSUN
$(info TIBSUN defined)
NFLAGS += -DTIBSUN
CFLAGS += -DTIBSUN
endif

ifdef SINGLEPLAYER
$(info SINGLEPLAYER defined)
NFLAGS += -DSINGLEPLAYER
CFLAGS += -DSINGLEPLAYER
endif

ifdef TSCLIENT
$(info TSCLIENT defined)
NFLAGS += -DTSCLIENT
CFLAGS += -DTSCLIENT
endif

ifdef MOD_DTA
$(info MOD_DTA defined)
NFLAGS += -DMOD_DTA
CFLAGS += -DMOD_DTA
endif

ifdef MOD_TI
$(info MOD_TI defined)
NFLAGS += -DMOD_TI
CFLAGS += -DMOD_TI
endif

ifdef MOD_TO
$(info MOD_TO defined)
NFLAGS += -DMOD_TO
CFLAGS += -DMOD_TO
endif

ifdef MOD_RUBICON
$(info MOD_RUBICON defined)
NFLAGS += -DMOD_RUBICON
CFLAGS += -DMOD_RUBICON
endif

ifdef MOD_FD
$(info MOD_FD defined)
NFLAGS += -DMOD_FD
CFLAGS += -DMOD_FD
endif

ifdef MOD_TM
$(info MOD_TM defined)
NFLAGS += -DMOD_TM
CFLAGS += -DMOD_TM
endif

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


# =========================================================
# Source files
# =========================================================

# Global symbols.
OBJS = sym.o

# Source files included in ALL builds.
OBJS += src/sun.ini.o
OBJS += src/disable_dpi_scaling.o
OBJS += src/disable_max_windowed_mode.o
OBJS += src/no_window_frame.o
OBJS += src/scrollrate_fix.o
OBJS += src/single-proc-affinity.o
OBJS += src/win8_compat-func.o

# -- Single player condition start -- 
# The vast majority of patches should not be in the
# singleplayer build, so everything on here on down is
# omitted from singleplayer  builds.
ifndef SINGLEPLAYER

OBJS += src/EventClass.o
OBJS += src/Hook_Main_Loop.o
OBJS += src/IonBlastClass_crash.o
OBJS += src/add_animation_to_factories_without_weaponsfactory.o
OBJS += src/add_team_better.o
OBJS += src/ai_target_emp_like_multimissile.o

# Only include in: MOD_TI MOD_RUBICON
ifneq ($(call ifdef_any_of,MOD_TI MOD_RUBICON),)
OBJS += src/ai_target_droppods_like_multimissile.o
endif

OBJS += src/aircraft_not_reloading_fix.o
OBJS += src/aircraft_repair.o
OBJS += src/airtransport_undeployable_on_helipads.o
OBJS += src/alt_scout_fix.o
OBJS += src/alt_to_undeploy.o
OBJS += src/attack_neutral_units.o
OBJS += src/auto_deploy_mcv.o
OBJS += src/autosave.o
OBJS += src/briefing_restate_map_file.o
OBJS += src/briefing_screen_mission_start.o
OBJS += src/buildconst_harvesterunit_baseunit.o
OBJS += src/buildlimit_fix.o
OBJS += src/c4_repairable_fix.o
OBJS += src/carryall_click_under_glitch.o
OBJS += src/center_team.o
OBJS += src/chat_ignore.o
OBJS += src/chatallies.o
OBJS += src/coach_mode.o
OBJS += src/config.o
OBJS += src/crate_patches.o
OBJS += src/destroytrigger_crash.o
OBJS += src/disable_alt_tab.o
OBJS += src/disable_edge_scrolling.o
OBJS += src/dont_replace_player_name_with_computer.o
OBJS += src/dont_save_without_all_players.o
OBJS += src/draw_all_action_lines.o
OBJS += src/easy_shroud.o
OBJS += src/event_declarations.o
OBJS += src/factory_rallypoints.o
OBJS += src/fix_100_unit_bug.o
OBJS += src/fix_ai_unit_scatter_for_factories_without_weaponsfactory.o
OBJS += src/fix_ai_retaliating_against_its_own_stuff.o
OBJS += src/fix_allied_decloaking.o
OBJS += src/fix_building_damage_state_crash.o
OBJS += src/fix_burst_exploit.o
OBJS += src/fix_depot_explosion_glitch.o
OBJS += src/fix_houseclass_checksws_crash.o
OBJS += src/fix_infantryclass_take_damage_null_warhead_crash.o
OBJS += src/fix_unitclass_can_enter_cell_ignoring_terraintype_immunity.o
OBJS += src/fix_score_logging_typo.o
OBJS += src/flickering_shadow_fix.o
OBJS += src/force_firestorm_installed.o
OBJS += src/freeunit_enhancements.o
OBJS += src/gamespeed.o
OBJS += src/guard_mode_patch.o
OBJS += src/guard_mode_patch2.o
OBJS += src/hack_house_from_house_type.o
OBJS += src/harvester_block_ref_exploit.o
OBJS += src/harvester_truce.o
OBJS += src/harvesters_guardcommand.o
OBJS += src/hide_names_qm.o
OBJS += src/high_res_crash.o
OBJS += src/hotkey_help.o
OBJS += src/hotkeys.o
OBJS += src/hotkeys_asm.o
OBJS += src/hover_show_health.o
OBJS += src/hp03.o
OBJS += src/ionstorm_jumpjet_crash.o
OBJS += src/jj_barracks_glitch_fix.o
OBJS += src/laser_draw_it_crash.o
OBJS += src/log_more_oos.o
OBJS += src/main_menu_cursor_bug.o
OBJS += src/manual_aim_sams.o
OBJS += src/max_pip_counts.o
OBJS += src/minimap_crash.o
OBJS += src/minimum_burst.o
OBJS += src/mouse_always_in_focus.o
OBJS += src/mouse_behavior.o

# Only include in: MOD_TO MOD_RUBICON MOD_FD MOD_TM TSCLIENT
ifneq ($(call ifdef_any_of,MOD_TO MOD_RUBICON MOD_FD MOD_TM TSCLIENT),)
OBJS += src/move_team_group_number.o
endif

OBJS += src/multi_engineer_ignore_neutral.o
OBJS += src/multiplayer_ai_base_nodes.o
OBJS += src/multiplayer_movies.o
OBJS += src/multiplayer_units_placing.o
OBJS += src/multiple_factory_hack.o
OBJS += src/mumblelink.o
OBJS += src/new_events_s.o
OBJS += src/no_charge_power_needed.o
OBJS += src/no_crate_respawn_with_crates_disabled.o
OBJS += src/no_guard_cursor_for_repair_vehicles.o
OBJS += src/no_options_menu_animation.o
OBJS += src/online_optimizations.o
#OBJS += src/only_the_host_may_change_gamespeed.o
OBJS += src/override_colors.o
OBJS += src/paradrop.o
OBJS += src/place_building_hotkey.o
OBJS += src/radar_event_hacks.o
OBJS += src/rage_quit.o
OBJS += src/recon_kick.o
OBJS += src/record_rng_func.o
OBJS += src/record_anim_constructor_func.o
OBJS += src/record_facing_changes_func.o
OBJS += src/record_tarcom_changes_func.o
OBJS += src/record_override_mission_func.o
OBJS += src/reinforcements_player_specific.o
OBJS += src/repeat_last_building_hotkey.o
OBJS += src/response_time_func.o

# Only include in: MOD_TO MOD_TI
ifneq ($(call ifdef_any_of,MOD_TO MOD_TI),)
OBJS += src/reveal_crate_reshroud.o
endif

OBJS += src/saved_games_in_subdir.o
OBJS += src/savegame.o
OBJS += src/scrap_metal_explosion.o

OBJS += src/shared_control.o
OBJS += src/short_connection_timeout.o
OBJS += src/show_stats.o
OBJS += src/sidebar.o
OBJS += src/sidebar_cameo_sort.o
OBJS += src/sidebar_cameo_sort_helper.o
OBJS += src/sideindex_improvements_v2.o
OBJS += src/singleplayer_objects_on_multiplayer_map_crash.o
OBJS += src/smarter_firesale.o
OBJS += src/smarter_harvesters.o
OBJS += src/spy_fix.o
OBJS += src/unit_self_heal_repair_step.o
OBJS += src/text_triggers.o
OBJS += src/tiberium_on_slope_crash.o

# Only include in: MOD_TO MOD_TI MOD_RUBICON MOD_FD MOD_TM TSCLIENT
ifneq ($(call ifdef_any_of,MOD_TO MOD_TI MOD_RUBICON MOD_FD MOD_TM TSCLIENT),)
OBJS += src/tiberium_stuff.o
endif

OBJS += src/tiberium4_blocks_infantry.o
OBJS += src/tileset255_bridgerepairfix.o
OBJS += src/trigger_actions_extended.o
OBJS += src/ts_util.o
OBJS += src/veterancy_from_allies.o
OBJS += src/voxelanim_damage_bug.o
OBJS += src/waypoint_enhancements.o
OBJS += src/wcsncpy.o
OBJS += src/whiteboy_cameo_bugfix.o
OBJS += src/basic_theme_fix.o

# Sources included in mods but NOT the client.
ifndef TSCLIENT
OBJS += src/tiberium_damage.o
endif 

# Only include in: MOD_DTA MOD_FD
ifneq ($(call ifdef_any_of,MOD_DTA MOD_FD),)
OBJS += src/vehicle_transports.o
endif

# DTA only sources.
ifdef MOD_DTA
OBJS += src/allow_building_placement_over_overlay.o
OBJS += src/change_projectile_degeneration_speed.o
OBJS += src/change_score_screen_music.o
OBJS += src/dump_globals.o
OBJS += src/extra_difficulty.o
OBJS += src/ingame_ui_text_color.o
OBJS += src/remove_ion_storm_effects.o
endif

# TI only sources.
ifdef MOD_TI
OBJS += src/team_number_position.o
endif

# TO only sources.
ifdef MOD_TO
#OBJS += 
endif


# =========================================================
# These sources will be omitted from Vinifera compatible builds.
# =========================================================
ifndef VINIFERA
OBJS += src/buildingtype_initialization.o
OBJS += src/cache_alot.o

# Only included in: MOD_TI
ifdef MOD_TI
OBJS += src/cloakstop_to_empimmunity.o
OBJS += src/vinifera_unhardcode.o
endif

OBJS += src/cloakstop_to_toobigforcarryalls.o
OBJS += src/disable_file_checks.o
OBJS += src/disable_intro_movie.o
OBJS += src/display_messages_typed_by_yourself.o
OBJS += src/exception_catch.o
OBJS += src/fix_mission_restart_difficulty_bug.o
OBJS += src/fix_mouse_not_found_error.o
OBJS += src/force_conversion_type.o
OBJS += src/graphics_patch.o
OBJS += src/harvesters_autoharvest.o
OBJS += src/horv_via_undeploysinto.o
OBJS += src/in-game_message_background.o
OBJS += src/internet_cncnet.o
OBJS += src/isomappack5_limit_extend.o
OBJS += src/load_more_movies.o
OBJS += src/mechanics.o
OBJS += src/new_search_dir.o
OBJS += src/no-cd_iran.o
OBJS += src/no_blowfish_dll.o
OBJS += src/no_insignificant_death_announcement.o
OBJS += src/no_movie_and_score_mix_dependency.o
OBJS += src/no_sidecd_mix.o
OBJS += src/oil_derricks.o
OBJS += src/random_loop_delay.o
OBJS += src/remove_16bit_windowed_check.o

# The logger is needed for certain client features
ifneq ($(call ifdef_any_of,MOD_DTA MOD_TI MOD_TO MOD_RUBICON MOD_FD MOD_TM TSCLIENT),)
OBJS += src/logger.o
endif

# Only included in: MOD_DTA MOD_TO
ifneq ($(call ifdef_any_of,MOD_DTA MOD_TO),)
OBJS += src/remove_iscoredefender_emp_immunity.o
endif

OBJS += src/rules_process.o
OBJS += src/scale_movie_fix.o
OBJS += src/scale_movie_fix_hack.o
OBJS += src/screenshots_in_subdir.o

# Only include in: MOD_TO MOD_TI
ifneq ($(call ifdef_any_of,MOD_TO MOD_TI),)
OBJS += src/scriptaction4.o
endif

OBJS += src/skip_score.o
OBJS += src/veterancy_crate_check_trainable.o
OBJS += src/video_mode_hacks.o
OBJS += src/wndproc.o
endif


# =========================================================
# Spawner sources.
# =========================================================
OBJS += src/spawner/auto-surrender.o
OBJS += src/spawner/auto_ally_by_spawn_loc.o
OBJS += src/spawner/auto_ss.o
OBJS += src/spawner/build_off_ally.o
OBJS += src/spawner/is_ally_or_spec.o
OBJS += src/spawner/nethack.o
OBJS += src/spawner/protocol_zero.o
OBJS += src/spawner/protocol_zero_c.o
OBJS += src/spawner/random_map.o
OBJS += src/spawner/selectable_spawns.o
OBJS += src/spawner/spawner.o
OBJS += src/spawner/spectators.o
OBJS += src/spawner/statistics.o


# =========================================================
# Experimental feature sources.
# =========================================================
ifdef EXPERIMENTAL

# Not to be included in Vinifera builds. 
ifndef VINIFERA
    #OBJS += src/new_armor_types.o
    #OBJS += src/new_armor_types_s.o
endif

endif


# =========================================================
# Debug only sources
# =========================================================

#
# Standard debug
#
ifdef WWDEBUG

# Not to be included in Vinifera builds. 
ifndef VINIFERA
    OBJS += src/mpdebug.o
    OBJS += src/debugging_help.o
    OBJS += src/tactical_zoom.o
endif

#
# Debug console
#
ifdef WWDEBUG_CONSOLE

# Not to be included in Vinifera builds. 
ifndef VINIFERA
    OBJS += src/ts_debug.o
endif

endif

endif


# =========================================================
# Bink movie support
# =========================================================
OBJS += src/binkmovie/bink_load_dll.o
OBJS += src/binkmovie/bink_patches.o
OBJS += src/binkmovie/bink_asm_patches.o
OBJS += src/binkmovie/binkmovie.o


# =========================================================
# 3rd Party sources
# =========================================================
# Not to be included in Vinifera builds. 
ifndef VINIFERA
    OBJS += 3rdparty/s_floorf.o
    OBJS += 3rdparty/lodepng.o
    OBJS += src/write_jpg_png.o
endif

# -- Single player condition end --
endif


# =========================================================
# Mod specific hacks
# =========================================================
ifdef TSCLIENT
    OBJS += src/ts_hacks.o
endif
ifdef TIBSUN
    OBJS += src/ts_hacks.o
endif
ifdef SINGLEPLAYER
    #OBJS += src/ts_hacks.o
endif
ifdef MOD_DTA
    OBJS += src/dta_hacks.o
endif
ifdef MOD_TI
    OBJS += src/ti_hacks.o
endif
ifdef MOD_TO
    OBJS += src/to_hacks.o
endif
ifdef MOD_RUBICON
    OBJS += src/rubicon_hacks.o
endif
ifdef MOD_FD
    OBJS += src/fd_hacks.o
endif
ifdef MOD_TM
    OBJS += src/tm_hacks.o
endif


# =========================================================
# Resources
# =========================================================
ifdef TSCLIENT
    OBJS += res/tibsun/res.o
endif
ifdef TIBSUN
    OBJS += res/tibsun/res.o
endif
ifdef SINGLEPLAYER
    OBJS += res/tibsun/res.o
endif
ifdef MOD_DTA
    OBJS += res/dta/res.o
endif
ifdef MOD_TI
    OBJS += res/ti/res.o
endif
ifdef MOD_TO
    OBJS += res/to/res.o
endif
ifdef MOD_RUBICON
    OBJS += res/rubicon/res.o
endif
ifdef MOD_FD
    OBJS += res/fd/res.o
endif
ifdef MOD_TM
    OBJS += res/tm/res.o
endif


# =========================================================
# Build target
# =========================================================
all: $(LDS) $(INPUT) $(OBJS)
	$(LD) $(LDFLAGS) -T $(LDS) -o $(OUTPUT) $(OBJS)
	$(PETOOL) setdd $(OUTPUT) 1 $(IMPORTS) || ($(RM) $(OUTPUT) && exit 1)
	$(PETOOL) patch $(OUTPUT) || ($(RM) $(OUTPUT) && exit 1)
	$(STRIP) -R .patch $(OUTPUT) || ($(RM) $(OUTPUT) && exit 1)
	$(PETOOL) dump $(OUTPUT)

clean:
	$(RM) *.o res/*.o src/*.o src/spawner/*.o src/binkmovie/*.o

%.o: %.asm
	$(NASM) $(NFLAGS) -o $@ $<

%.o: %.rc
	$(WINDRES) $(WINDRES_FLAGS) $< $@

# Not to be included in Vinifera builds. 
ifndef VINIFERA
src/write_jpg_png.o: src/write_jpg_png.c 3rdparty/tiny_jpeg.h
	$(CC) $(CFLAGS) -c -o $@ $<
endif

ifdef TSCLIENT
res/tibsun/res.o: res/tibsun/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/tibsun/ $< $@
endif

ifdef TIBSUN
res/tibsun/res.o: res/tibsun/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/tibsun/ $< $@
endif

ifdef SINGLEPLAYER
res/tibsun/res.o: res/tibsun/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/tibsun/ $< $@
endif

ifdef MOD_DTA
res/dta/res.o: res/dta/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/dta/ $< $@
endif

ifdef MOD_TI
res/ti/res.o: res/ti/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/ti/ $< $@
endif

ifdef MOD_TO
res/to/res.o: res/to/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/to/ $< $@
endif

ifdef MOD_RUBICON
res/to/res.o: res/rubicon/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/rubicon/ $< $@
endif

ifdef MOD_FD
res/to/res.o: res/fd/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/fd/ $< $@
endif

ifdef MOD_TM
res/to/res.o: res/tm/res.rc
	$(WINDRES) $(WINDRES_FLAGS) -Ires/tm/ $< $@
endif
