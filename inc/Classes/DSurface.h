#include "ddraw.h"


typedef struct DSurface DSurface;

typedef struct {
    void *DSurface__Destroy;
    void *Dsurface_BlitWhole;
    void (__thiscall *BlitPart)(DSurface *this, RECT *torect, DSurface *fromsurface, RECT *fromrect, bool a4, bool a5);
    void *Blit;
    void *FillRectEx;
    void *FillRect;
    void (__thiscall *Fill)(DSurface *this, int color);
    void *sub48BCE0;
    void *sub6A7910;
    void *Put_Pixel;
    void *Get_Pixel;
    void *DrawLineEx;
    void *DrawLine;
    void *Draw_Brackets;
    void *sub48C150;
    void *Draw_Circle;
    void *sub6A7150;
    void *Draw_Dotted_Line;
    void *Draw_Moving_Dashed_Line;
    void *sub48FB90;
    void *DrawRectEx;
    void *DrawRect;
    char *(__thiscall *Lock)(DSurface *this, int32_t X, int32_t Y);
    void *(__thiscall *Unlock)(DSurface *this);
    void *sub48B450;
    void *Has_Focus;
    void *Is_Locked;
    int32_t (__thiscall *Get_BytesPerPixel)(DSurface *this);
    int32_t (__thiscall *Get_Pitch)(DSurface *this);
    RECT (__thiscall *Get_Rect)(DSurface *this, RECT *__hidden_ret);
    int32_t (__thiscall *Get_Width)(DSurface *this);
    int32_t (__thiscall *Get_Height)(DSurface *this);
    void *sub4901C0;
    void *sub6A7550;
    void *sub6A74D0;
    void *sub48E4B0;
    void *Get_Blit_Status;
} vtDSurface;


typedef struct DSurface {
    vtDSurface *vtable;
    int32_t Width;
    int32_t Height;
    int32_t LockLevel;
    int32_t BitsPerPixel;
    char *  Buffer;
    char    Allocated;
    char    InVideoMemory;
    char    Unknown;
    char    Unknown2;
	LPDIRECTDRAWSURFACE VideoSurfacePtr; // Pointer to the related direct draw surface.
	LPDDSURFACEDESC VideoSurfaceDescription; // Description of the said surface.
} DSurface;

extern DSurface *PrimarySurface;
