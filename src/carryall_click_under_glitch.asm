%include "TiberianSun.inc"
%include "macros/patch.inc"

;;; This bug allowed a player to prevent an enemy carryall from landing
;;; by constantly clicking it's landing zone with another aircraft
;;; The fix is to skip over the section of code that makes sure no other
;;; Aircraft has selected the same landing zone. -dkeeton
@SJNZ 0x004A83E2, 0x004A8423
