
COMMON_OBJS = \
                    src/main_menu_cursor_bug.o \
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
                    src/video_mode_hacks.o \
                    src/binkmovie/bink_load_dll.o \
                    src/binkmovie/bink_patches.o \
                    src/binkmovie/bink_asm_patches.o \
                    src/binkmovie/binkmovie.o \
                    res/res.o \
                    sym.o

# The following should NOT be in Vinifera compatable builds.
ifndef VINIFERA

ifdef WWDEBUG

COMMON_OBJS += \
	                src/ts_debug.o

endif

endif
