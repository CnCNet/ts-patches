#include "TiberianSun.h"
#include "macros/patch.h"

void    __thiscall PlaceBuilding_nothing(void *a) { }
char *  __thiscall PlaceBuilding_Description(void *a) { return "Selects the currently ready to be placed building."; }
char *  __thiscall PlaceBuilding_INIname(void *a)     { return "PlaceBuilding"; }
char *  __thiscall PlaceBuilding_Category(void *a)    { return "Interface"; }
char *  __thiscall PlaceBuilding_Name(void *a)        { return "PlaceBuilding"; }

int     __thiscall PlaceBuilding_Execute(void *a)     {
    void *fac = PlayerPtr->PrimaryBuildingFactory;
    if (fac && FactoryClass__Has_Completed(fac))
    {
        void *product = FactoryClass__Get_Product(fac);
        if (product)
        {
            void *facility = ObjectClass__Who_Can_Build_Me(product, 0, 0);
            HouseClass__Manual_Place(PlayerPtr, facility, product);
        }
    }
    return 1;
}

vtCommandClass vtPlaceBuildingCommand = {
  CommandDestroy,
  PlaceBuilding_INIname,
  PlaceBuilding_Name,
  PlaceBuilding_Category,
  PlaceBuilding_Description,
  PlaceBuilding_Execute,
  PlaceBuilding_nothing
};
CommandClass PlaceBuildingCommand = { &vtPlaceBuildingCommand,0,17,17 };
