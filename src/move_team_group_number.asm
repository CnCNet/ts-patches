%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; TechnoClass::Draw_Pips
@SET 0x00637CE3, { mov ebx, 0xfffffff4 }
;@SET 0x00637CE3, { lea ebx, [GroupYAdjustment] }

;@SET 0x00637D11, { lea eax, [ebx-24] }
;@SET 0x00637D27, { sub ecx, 10 }
