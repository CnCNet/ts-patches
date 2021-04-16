; Allow usage of TileSet of 255 and above without making NE-SW broken bridges unrepairable

; When TileSet number crosses 255 in temperat/snow INI files, the NE-SW broken bridges 
; become non-repairable. The reason is that the NonMarbleMadnessTile array of size 256
; at 0x007F6168 overflows when filled and affects the variables like BridgeTopRight1 and 
; BridgeBottomLeft2 that come after it. This patch removes the filling of the unused 
; NonMarbleMadnessTile array and its references.

%include "macros/patch.inc"

@CLEAR 0x004F46A9, 0x90, 0x004F46B0 

hack 0x004F54CF
    jmp 0x004F5535
