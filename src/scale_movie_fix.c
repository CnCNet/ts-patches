#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

//Movies are getting scaled too big and parts are out of the screen on certain resolutions (e.g. 1280x600)

extern int VisibleRect__Width;
extern int VisibleRect__Height;

void ScaleMovieFix(int *finalWidth, int *finalHeight, int *posX, int *posY)
{
    if (*finalHeight > VisibleRect__Height)
    {
        *finalWidth = ((float)*finalWidth / *finalHeight) * VisibleRect__Height;
        *finalHeight = VisibleRect__Height;
        
        int diffWidth = VisibleRect__Width - *finalWidth;
        if (diffWidth > 0)
            *posX = diffWidth / 2;
        else
            *posX = 0;
    
        int diffHeight = VisibleRect__Height - *finalHeight;
        if (diffHeight > 0)
            *posY = diffHeight / 2;
        else
            *posY = 0;
    }
}