#include "TiberianSun.h"
#include "macros/patch.h"

CALL(0x005F5DE9, _remember_last_building);

int LastBuilding_RTTI;
int LastBuilding_HeapID;

void __thiscall
remember_last_building(EventClass *e, int house_id, EventType t, int RTTI, int HeapID)
{
    if (RTTI == 6 || RTTI == 7)
    {
        LastBuilding_RTTI = RTTI;
        LastBuilding_HeapID = HeapID;
    }
    EventClass__EventClass_produce(e, house_id, t, RTTI, HeapID);
}

void    __thiscall RepeatBuilding_nothing(void *a) { }
char *  __thiscall RepeatBuilding_Description(void *a) { return "Repeat Last Building"; }
char *  __thiscall RepeatBuilding_INIname(void *a)     { return "RepeatBuilding"; }
char *  __thiscall RepeatBuilding_Category(void *a)    { return "Interface"; }
char *  __thiscall RepeatBuilding_Name(void *a)        { return "RepeatBuilding"; }

int     __thiscall RepeatBuilding_Execute(void *a)
{
    if (LastBuilding_RTTI)
    {
        if (sidebar_has_cameo(LastBuilding_RTTI, LastBuilding_HeapID))
        {
            EventClass e;
            EventClass__EventClass_produce(&e, PlayerPtr->ID, EVENTTYPE_PRODUCE,
                                           LastBuilding_RTTI, LastBuilding_HeapID);
            EnqueueEvent(&e);
        }
    }
}

vtCommandClass vtRepeatBuildingCommand = {
  CommandDestroy,
  RepeatBuilding_INIname,
  RepeatBuilding_Name,
  RepeatBuilding_Category,
  RepeatBuilding_Description,
  RepeatBuilding_Execute,
  RepeatBuilding_nothing
};
CommandClass RepeatBuildingCommand = { &vtRepeatBuildingCommand,0,17,17 };
