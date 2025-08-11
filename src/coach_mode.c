#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

#ifdef SPAWNER

/* Coach mode allows a spectator to be on the same team as someone and private message them
 * and view the same shroud as them. It also doesn't reveal the whole map for dead players.
 */

// Don't reveal the map when dead
CALL(0x004BF5D6, _MapClass__Reveal_The_Map_CoachMode);
bool CoachMode = false;

void __thiscall
MapClass__Reveal_The_Map_CoachMode(MouseClass *map)
{
    if (!CoachMode)
        MapClass__Reveal_The_Map(map);
}


uint32_t unspecialMask = 0;

uint32_t const make_unspecial_mask()
{
    void *housetype = HouseTypeClass__From_Name("Special");
    HouseClass *house = HouseClass__House_From_HouseType(housetype);
    return ~(1 << house->ID);
}


bool __thiscall
HouseClass__Is_Coach(HouseClass *this)
{
    if (unspecialMask == 0)
        unspecialMask = make_unspecial_mask();

    // You're a coach if your Dead/Spectator and CoachMode is enabled and you have an ally.
    if (!CoachMode)
        return false;
    else
        return HouseClass__Is_Spectator(this) && (this->AlliesBitfield & unspecialMask) != 0;
}

bool __thiscall
HouseClass__Is_Spectator(HouseClass *this)
{
    if (SessionType.GameSession != 0)
        return IsSpectatorArray[this->ID] > 0;
    else
        return false;
}

#endif // SPAWNER
