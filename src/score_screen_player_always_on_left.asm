%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Normally the position of the player on the score screen
; depends on whether they are playing as GDI or Nod.
; As everything else in the game, this check is coded in a
; "two-factions-only" way, which causes pain for mods
; that add new factions, or even new houses in singleplayer maps.
; (a player playing as GDI that isn't housetype #0 gets their
; score screen bars in red)

; This hack makes it so that the player is always displayed on the
; left side of the score screen, like they were GDI from the perspective
; of the original game.
; *******************
; Author: Rampastring
@CLEAR 0x005E51D2, 0x90, 0x005E51D6
