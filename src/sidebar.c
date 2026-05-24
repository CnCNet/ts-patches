#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

#ifdef SPAWNER

CALL(0x005F37BF, _SidebarClass__Draw_It_infopan_shp);
CALL(0x005F2A98, _SidebarClass__Init_For_House_infopan_shp);
// CALL(0x005F2725, _SidebarClass__Init_IO_infopan_shp);
extern Image *BottomInfoPanel;
char InfoPanelStr[] = "INFOPAN.SHP";
Rect InfoPrintLocation;
XYCoord IPanelLoc;
Rect zero_rect = {0};

typedef struct CC_Draw_Shape_Args
{
    DSurface *surface; void *palette; Image *image;
    int32_t frame; XYCoord *a5; Rect *position;
    int32_t a6; int32_t a7; int32_t a8; int32_t a9;
    int32_t tint; Image *z_shape; int32_t z_frame;
    int32_t a13; int32_t where;
} CC_Draw_Shape_Args;

CC_Draw_Shape_Args IPanelArgs;
void __fastcall
SidebarClass__Draw_It_infopan_shp(DSurface *surface, void *palette, Image *image,
                                  int32_t frame, XYCoord *a5, Rect *position,
                                  int32_t a6, int32_t a7, int32_t a8, int32_t a9,
                                  int32_t tint, Image *z_shape, int32_t z_frame,
                                  int32_t a13, int32_t where)
{
    if (InfoPanel > -1 && BottomInfoPanel)
    {
        CC_Draw_Shape(surface, palette, BottomInfoPanel, 0,
                      a5, position, a6, a7,
                      a8, a9, tint, z_shape,
                      z_frame, a13, where);
        IPanelLoc.x = a5->x;
        IPanelLoc.y = a5->y;

        IPanelArgs = (CC_Draw_Shape_Args) {
            surface, palette, BottomInfoPanel, 0,
            &IPanelLoc, &zero_rect, a6, a7,
            a8, a9, tint, z_shape,
            z_frame, a13, where
        };

        //WWDebug_Printf("Running ShowInfo (%d)\n", Frame);
        InfoPrintLocation = (Rect){20, a5->y + 4, surface->Width,
                                   surface->Height};
        ShowInfo(surface, &InfoPrintLocation);
        //InfoPrintLocation = (Rect){SidebarLoc.left + 20, a5->y + 4, surface->Width,
        //                           surface->Height};
        //ShowInfo(AlternateSurface, &InfoPrintLocation);
        a5->y += BottomInfoPanel->Height;
    }
    CC_Draw_Shape(surface, palette, image, frame,
                  a5, position, a6, a7,
                  a8, a9, tint, z_shape,
                  z_frame, a13, where);


}

Image * __thiscall
SidebarClass__Init_For_House_infopan_shp(char *str)
{
    BottomInfoPanel = MixFileClass__CCFileClass__Retrieve(InfoPanelStr);
    return MixFileClass__CCFileClass__Retrieve(str);
}
void __thiscall
SidebarClass__Init_IO_infopan_shp(void *this)
{
    if (!BottomInfoPanel)
        BottomInfoPanel = MixFileClass__CCFileClass__Retrieve(InfoPanelStr);
    return DisplayClass__Init_IO(this);
}

#endif // SPAWNER
