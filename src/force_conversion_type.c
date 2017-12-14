#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x00502AA6, _DSurface_Conversion_Type_hack);
extern int32_t ForceConversionType4;

int32_t __thiscall
DSurface_Conversion_Type_hack()
{
    if (ForceConversionType4)
        return 4;
    else
        return DSurface_Conversion_Type();
}
