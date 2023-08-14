%include "macros/patch.inc"
%include "macros/datatypes.inc"

sstring str_MPMapsINI, "MPMAPS.INI"

@SET 0x005EE8B0, push str_MPMapsINI
@SET 0x005EEB82, push str_MPMapsINI

