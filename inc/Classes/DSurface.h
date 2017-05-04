typedef struct {
    void *Dsurface_BlitWhole;
    void *BlitPart;
    void *Blit;
    void *FillRectEx;
    void *FillRect;
    void *Fill;
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
    void *Lock;
    void *Unlock;
    void *sub48B450;
    void *Has_Focus;
    void *Is_Locked;
    void *Get_BitsPerPixel;
    void *Get_Pitch;
    void *Get_Rect;
    void *Get_Width;
    void *Get_Height;
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
    // More Stuff here FIXME
} DSurface;
