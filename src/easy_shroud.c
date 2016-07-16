#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"


//HalfShroud
bool EasyShroud = 0;
#define FOGGED 0x4000000

CALL(0x005C6A39, _RulesClass__Hack_AudioVisual);
CALL(0x004E1375, _RulesClass__Hack_AudioVisual);
CALL(0x005DDF7C, _Read_Scenario_INI_refog);
CALL(0x004A84BE, _MapClass__Cell_Is_Fogged);
CALL(0x004A859F, _MapClass__Cell_Is_Fogged);
CALL(0x004A88AF, _MapClass__Cell_Is_Fogged);

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

bool __thiscall
MapClass__Cell_Is_Fogged(MouseClass *map, CoordStruct *coord) {

  bool result;
  if (result = MapClass__Cell_Is_Shrouded(map, coord))
    return result;

  int height = 0;
  if (EasyShroud) {
    CellClass *cell = MapClass__Get_Target_Coord(map, coord);
    result = (cell->VisibilityFlags & FOGGED) != 0;
  }
  return result;
}
