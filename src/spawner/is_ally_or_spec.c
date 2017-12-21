#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

extern bool CoachMode;


bool __thiscall
HouseClass__Is_Ally_Or_Spec_HH(HouseClass *me, HouseClass *him)
{
    bool is_ally = HouseClass__Is_Ally_HH(me, him);

    if (is_ally)
    {
        return is_ally;
    }
    else if (CoachMode)
    {
        return HouseClass__Is_Coach(me) || HouseClass__Is_Coach(him);
    }
    else
        return HouseClass__Is_Spectator(me) || HouseClass__Is_Spectator(him);
}
