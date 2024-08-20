%include "macros/patch.inc"

; Refresh sidebar taking prerequisites into account when tech buildings are lost
; Patches the argument to the HouseClass::Can_Build in SidebarClass::StripClass::Recalc so that prerequisites are checked
; Credits: ZivDero, ported to ts-patches by Rampastring

@SET 0x005F5762, db {0x00}
