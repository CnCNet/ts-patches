[org 0x0086922B]

retn ; For some reason the game executes the first function found in the extended EXE space during exit

%include "src/def.asm"
%include "src/var.asm"
%include "src/data.inc"

; macros
%include "src/macros/INIClass_macros.asm"
%include "src/macros/string_macros.asm"

; loading
%include "src/loading.asm"

; savegame
%include "src/savegame.asm"

;fixes
;%include "src/fix_wce_errors.asm"
%include "src/alt_scout_fix.asm"
%include "src/aircraft_passenger_fix.asm"
%include "src/fix_mouse_not_found_error.asm"
%include "src/single-proc-affinity.asm"

; spawner
%include "src/spawner.asm"
%include "src/spawner/tunnel.asm"
%include "src/spawner/nethack.asm"
%include "src/spawner/selectable_spawns.asm"
%include "src/spawner/spectators.asm"
%include "src/spawner/statistics.asm"
%include "src/spawner/build_off_ally.asm"
;%include "src/spawner/auto_ss.asm"
%include "src/only_the_host_may_change_gamespeed.asm"
%include "src/spawner/auto-surrender.asm"


; other
%include "src/trigger_actions_extended.asm"
%include "src/nco_bug_fix.asm"
%include "src/briefing_screen_mission_start.asm"
;%include "src/no_blowfish_dll.asm"
%include "src/briefing_restate_map_file.asm"
;%include "src/dta_hacks.asm"
%include "src/no-cd.asm"
%include "src/display_messages_typed_by_yourself.asm"
;%include "src/remove_16bit_windowed_check.asm"
%include "src/graphics_patch.asm"
%include "src/multiplayer_units_placing.asm"
%include "src/reinforcements_player_specific.asm"
%include "src/no_options_menu_animation.asm"
%include "src/internet_cncnet.asm"
%include "src/tiberium_stuff.asm"
%include "src/no_window_frame.asm"

