#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x005DC9DA, _MultiScore__Present_hack);
CALL(0x005DCD98, _MultiScore__Present_hack);

extern bool SkipScoreScreen;

void
MultiScore__Present_hack()
{
    if (!SkipScoreScreen)
        MultiScore__Present();
}
