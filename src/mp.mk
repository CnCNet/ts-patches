
MP_OBJS = \
                    src/chat_ignore.o \
                    src/online_optimizations.o \
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
                    src/spawner/is_ally_or_spec.o \
                    src/spawner/spawner.o \
                    src/spawner/protocol_zero.o \
                    src/spawner/protocol_zero_c.o \
                    src/spawner/nethack.o \
                    src/spawner/selectable_spawns.o \
                    src/spawner/spectators.o \
                    src/spawner/statistics.o \
                    src/spawner/auto-surrender.o \
                    src/spawner/build_off_ally.o \
                    src/spawner/auto_ss.o \
                    src/spawner/random_map.o \
                    src/coach_mode.o \
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
                    src/EventClass.o \
                    src/event_declarations.o \
                    src/new_events_s.o \
                    src/log_more_oos.o \
                    src/record_rng_func.o \
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
                    src/guard_mode_patch2.o \
                    src/random_loop_delay.o \
                    src/rage_quit.o \
                    src/move_team_group_number.o \
                    src/skip_score.o \
                    src/hide_names_qm.o \
                    src/minimum_burst.o \
                    src/cache_alot.o \
                    src/no_charge_power_needed.o\
                    src/fix_allied_decloaking.o \
                    src/config.o \
                    src/multiple_factory_hack.o \
                    src/vinifera_unhardcode.o \
                    src/freeunit_enhancements.o \

# The following should NOT be in Vinifera compatable builds.
ifndef VINIFERA

ifdef EXPERIMENTAL
#MP_OBJS += \        src/new_armor_types.o \
#                    src/new_armor_types_s.o

endif

MP_OBJS += \
                    src/isomappack5_limit_extend.o \
                    3rdparty/s_floorf.o \
                    3rdparty/lodepng.o \
                    src/write_jpg_png.o \
                    src/mods/oil_derricks.o

ifdef WWDEBUG

MP_OBJS +=  \       src/debugging_help.o \
	                src/tactical_zoom.o

endif

endif
