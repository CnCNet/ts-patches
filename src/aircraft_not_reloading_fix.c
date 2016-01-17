#include "macros/patch.h"
#include "TiberianSun.h"


/* When an aircraft is reloading on a helipad with 0 bullets and told to attack
   it will not lift off of the pad, but it will stop loading.
   This fix works most of the time. Better than nothing.
*/

// AircraftClass::vftable
SETDWORD(0x006CAE94, _AircraftClass__Can_Player_Fire);

int __thiscall
AircraftClass__Can_Player_Fire(AircraftClass *me) {
  if (me->p.f.t.Ammo == 0
      && !ObjectClass__InAir(me))
    return 0;
  return TechnoClass__Can_Player_Fire(me);
}
