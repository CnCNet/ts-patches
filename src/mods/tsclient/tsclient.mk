
TSCLIENT_OBJS = \
                    src/mods/tsclient/res/res.o \
                    src/main_menu_cursor_bug.o \
                    src/tiberium_on_slope_crash.o \
                    src/chat_ignore.o \
                    src/no_movie_and_score_mix_dependency.o \
                    src/IonBlastClass_crash.o \
                    src/singleplayer_objects_on_multiplayer_map_crash.o \
                    src/laser_draw_it_crash.o \
                    src/no_blowfish_dll.o \
                    src/high_res_crash.o \
                    src/disable_max_windowed_mode.o \
                    src/disable_dpi_scaling.o \
                    src/remove_16bit_windowed_check.o \
                    src/hp03.o \
                    src/fix_mouse_not_found_error.o \
                    src/single-proc-affinity.o \
                    src/graphics_patch.o \
                    src/no_window_frame.o \
                    src/exception_catch.o \
                    sym.o \
                    src/win8_compat-func.o \
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
                    src/spawner/protocol_zero_c.o \
                    src/spawner/nethack.o \
                    src/spawner/selectable_spawns.o \
                    src/spawner/spectators.o \
                    src/spawner/statistics.o \
                    src/spawner/auto-surrender.o \
                    src/spawner/build_off_ally.o \
                    src/spawner/auto_ss.o \
                    src/spawner/is_ally_or_spec.o \
                    src/coach_mode.o \
                    src/EventClass.o \
                    src/event_declarations.o \
                    src/new_events_s.o \
                    src/log_more_oos.o \
                    src/record_rng_func.o \
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
                    src/mouse_behavior.o \
                    src/text_triggers.o \
                    src/attack_neutral_units.o \
                    src/mouse_always_in_focus.o \
                    src/mods/tsclient/waypoint_enhancements.o \
                    src/easy_shroud.o \
                    src/new_search_dir.o \
                    src/override_colors.o \
                    src/minimap_crash.o \
                    src/factory_rallypoints.o \
                    src/shared_control.o \
                    src/recon_kick.o \
                    src/hover_show_health.o \
                    src/autosave.o \
                    src/fix_100_unit_bug.o \
                    src/veterancy_crate_check_trainable.o \
                    src/buildingtype_initialization.o \
                    src/destroytrigger_crash.o \
                    src/guard_mode_patch.o \
                    src/guard_mode_patch2.o \
                    src/harvesters_autoharvest.o \
                    src/whiteboy_cameo_bugfix.o \
                    src/voxelanim_damage_bug.o \
                    src/load_more_movies.o \
                    src/scale_movie_fix.o \
                    src/scale_movie_fix_hack.o \
                    src/ionstorm_jumpjet_crash.o \
                    src/aircraft_repair.o \
                    src/tactical_zoom.o \
                    src/response_time_func.o \
                    src/show_stats.o \
                    src/sidebar.o \
                    src/alt_to_undeploy.o \
                    src/place_building_hotkey.o \
                    src/repeat_last_building_hotkey.o \
                    src/center_team.o \
                    src/hotkey_help.o \
                    src/buildlimit_fix.o \
                    src/random_loop_delay.o \
                    src/draw_all_action_lines.o \
                    src/radar_event_hacks.o \
                    src/rage_quit.o \
                    src/scrollrate_fix.o \
                    src/rules_process.o \
                    src/mods/airtransport_undeployable_on_helipads.o \
                    src/mods/multi_engineer_ignore_neutral.o \
                    src/mods/no_insignificant_death_announcement.o \
                    src/mods/saved_games_in_subdir.o \
                    src/mods/screenshots_in_subdir.o \
                    src/mods/disable_file_checks.o \
                    src/mods/fix_score_logging_typo.o \
                    src/mods/dta/scrap_metal_explosion.o \
                    src/mods/sideindex_improvements_v2.o \
                    src/mods/buildconst_harvesterunit_baseunit.o \
                    src/mods/horv_via_undeploysinto.o \
                    src/mods/tsclient/ts_hacks.o \
                    src/mods/dta/auto_deploy_mcv.o \
                    src/mods/tsclient/logger.o \
                    src/mods/tsclient/filename_hacks.o \
                    src/mods/tsclient/disable_intro_movie.o \
                    src/fix_allied_decloaking.o \
                    src/force_conversion_type.o \
                    src/fix_mission_restart_difficulty_bug.o \
                    src/cache_alot.o \
                    src/config.o \
                    src/multiple_factory_hack.o \
                    src/freeunit_enhancements.o \
                    src/isomappack5_limit_extend.o \
                    src/tileset255_bridgerepairfix.o \
                    src/mods/tsclient/move_team_group_number.o \
                    src/mods/smarter_harvesters.o \
                    src/mods/sidebar_cameo_sort_helper.o \
                    src/mods/tsclient/sidebar_cameo_sort.o \
                    3rdparty/s_floorf.o \
                    3rdparty/lodepng.o \
                    src/write_jpg_png.o \
                    src/mods/dont_save_without_all_players.o \
                    src/basic_theme_fix.o \
                    src/harvesters_guardcommand.o \
                    src/flickering_shadow_fix.o \
                    src/veterancy_from_allies.o \
                    src/mods/tiberium4_blocks_infantry.o \
                    src/spy_fix.o \
                    src/paradrop.o \
                    src/hack_house_from_house_type.o \
                    src/minimum_burst.o \
                    src/mods/dta/cloakstop_to_toobigforcarryalls.o \
                    src/mods/oil_derricks.o \
                    src/mods/dta/add_animation_to_factories_without_weaponsfactory.o \
                    src/mods/dta/unit_self_heal_repair_step.o \
                    src/mods/dta/fix_ai_unit_scatter_for_factories_without_weaponsfactory.o \
                    src/mods/mechanics.o \
                    src/mods/dta/no_guard_cursor_for_repair_vehicles.o \
                    src/mods/smarter_firesale.o \
                    src/mods/dont_replace_player_name_with_computer.o \
                    src/mods/no_crate_respawn_with_crates_disabled.o \
                    src/mods/max_pip_counts.o \
                    src/mods/ai_target_emp_like_multimissile.o \
                    src/mods/fix_burst_exploit.o \
                    src/mods/fix_building_damage_state_crash.o \
                    src/mods/fix_infantryclass_take_damage_null_warhead_crash.o \
                    src/c4_repairable_fix.o \
                    src/no_charge_power_needed.o\
                    src/video_mode_hacks.o \
                    src/binkmovie/bink_load_dll.o \
                    src/binkmovie/bink_patches.o \
                    src/binkmovie/bink_asm_patches.o \
                    src/binkmovie/binkmovie.o \
					
ifdef WWDEBUG
                    NFLAGS += -D WWDEBUG
                    CFLAGS += -D WWDEBUG

                    TSCLIENT_OBJS +=  src/ts_debug.o
endif