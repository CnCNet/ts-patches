#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

void
ApplyUserColorOverrides() {
  PlayerColorMap[0] = SunIni_GetInt("ColorOverrides","Color0",3) |1;  // Only odd numbers.
  PlayerColorMap[1] = SunIni_GetInt("ColorOverrides","Color1",21) |1; // The even numbered
  PlayerColorMap[2] = SunIni_GetInt("ColorOverrides","Color2",47) |1; // colors show up in
  PlayerColorMap[3] = SunIni_GetInt("ColorOverrides","Color3",73) |1; // the shroud. Weird
  PlayerColorMap[4] = SunIni_GetInt("ColorOverrides","Color4",27) |1;
  PlayerColorMap[5] = SunIni_GetInt("ColorOverrides","Color5",55) |1;
  PlayerColorMap[6] = SunIni_GetInt("ColorOverrides","Color6",39) |1;
  PlayerColorMap[7] = SunIni_GetInt("ColorOverrides","Color7",33) |1;
}
