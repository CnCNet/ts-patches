#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"


//HalfShroud
bool EasyShroud = 0;

CALL(0x005C6A39, _RulesClass__Hack_AudioVisual);
CALL(0x004E1375, _RulesClass__Hack_AudioVisual);
CALL(0x005DDF7C, _Read_Scenario_INI_refog);

int32_t __thiscall
RulesClass__Hack_AudioVisual(RulesClass *this, INIClass ini) {
  RulesClass__AudioVisual(this, ini);

  if (EasyShroud)
    this->FogRate = (double) 0.0;

  return 1;
}


void __thiscall
Read_Scenario_INI_refog(MouseClass *map) {


  if (EasyShroud)
    MapClass__Reveal_The_Map();
  MapClass__Fill_Map_With_Fog(map);
}

