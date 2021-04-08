#include "macros/patch.h"
#include "TiberianSun.h"
#include <windows.h>
#include "patch.h"
#include <string.h>
#include <stdbool.h>

/* To call Cell_Is_Shrouded, we need to convert the xy mouse coords to
   xyz cell coords.
*/
bool __thiscall
is_coord_shrouded(MouseClass *Map, wCoordStruct *xy_coords) {
  xyzCoordStruct xyz;
  xyz.x = (xy_coords->x << 8) + 128;
  xyz.y = (xy_coords->y << 8) + 128;
  xyz.z = 0;
  xyz.z = MapClass__GetCellFloorHeight(Map, &xyz);
  CellClass *cell = MapClass__Get_Target_Coord(Map, &xyz);

  if (cell->VisibilityFlags & 0x1000)
    xyz.z += dword_7B3304;

  return MapClass__Cell_Is_Shrouded(Map, &xyz);
}


HouseClass * __stdcall //HouseClass *
GetHouseByUserName(char *name) {

  if (name == 0)
    return 0;

  HouseClass **house = HouseClassArray.Vector;
  for (int i = 0; i < HouseClassArray.ActiveCount; i++) {
    char *this_name = house[i]->Name;

    if (__strcmpi(this_name, name) == 0)
      return house[i];

  }
  return 0;
}


bool
sidebar_has_cameo(int RTTI, int HeapID)
{
    CameoType c;
    int i;
    for (i = 0; i < LEFT_STRIP.CameoCount; ++i)
    {
        c = LEFT_STRIP.CameoList[i];
        WWDebug_Printf("in_RTTI = %d, in_HeapID = %d, ItemType = %d, ItemIndex = %d\n", RTTI, HeapID, c.ItemType, c.ItemIndex);
        if (c.ItemType == RTTI && c.ItemIndex == HeapID)
            return true;
    }
    for (i = 0; i < RIGHT_STRIP.CameoCount; ++i)
    {
        c = RIGHT_STRIP.CameoList[i];
        WWDebug_Printf("in_RTTI = %d, in_HeapID = %d, ItemType = %d, ItemIndex = %d\n", RTTI, HeapID, c.ItemType, c.ItemIndex);
        if (c.ItemType == RTTI && c.ItemIndex == HeapID)
            return true;
    }
    return false;
}


bool __thiscall
Tactical__In_Viewport(TacticalClass *this, CoordStruct *coord)
{
    XYCoord a1;
    XYCoord v47;

    XYCoord *v16 = Tactical_60F0F0(&a1, coord->x, coord->y);
    int32_t v19 = Tactical_AdjustForZ(coord->z);
    v47.x = v16->x / 256;
    v47.y = v16->y / 256 - v19;
    //Tactical_618050(&v47, &this->TacticalViewLocation); // Not sure if this function call is needed.

    if (v47.x > this->TacticalViewLocation.x && v47.x < this->TacticalViewLocation.x + ViewPort_Dimensions.width
        &&
        v47.y > this->TacticalViewLocation.y && v47.y < this->TacticalViewLocation.y + ViewPort_Dimensions.height)
        return true;

    return false;
}
