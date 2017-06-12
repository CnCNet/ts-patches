#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

//Movies are getting scaled too big and parts are out of the screen on certain resolutions (e.g. 1280x600)

void ScaleMovieFix(int *finalWidth, int *finalHeight, int *posX, int *posY)
{
    if (*finalHeight > VisibleRect__Height)
    {
        *finalWidth = ((float)*finalWidth / *finalHeight) * VisibleRect__Height;
        *finalHeight = VisibleRect__Height;
        
        int diffWidth = VisibleRect__Width - *finalWidth;
        *posX = (diffWidth > 0) ? diffWidth / 2 : 0;
    
        int diffHeight = VisibleRect__Height - *finalHeight;
        *posY = (diffHeight > 0) ? diffHeight / 2 : 0;
    }
}
