#include "macros/patch.h"
#include "TiberianSun.h"


/* When an aircraft is reloading on a helipad with 0 bullets and told to attack
   it will not lift off of the pad, but it will stop loading.
   The problem appears to be that the tethered property is not being set when the
   aircraft is reloading.
   This fix here is a terrible hack, but it does work.
   The real fix should be to find the appropriate place where tethered should be set.
*/

// AircraftClass::vftable
SETDWORD(0x006CB104, _Intercept_AircraftClass__What_Weapon_Should_I_Use);

int __thiscall
Intercept_AircraftClass__What_Weapon_Should_I_Use(AircraftClass *me,void *w) {
  // check to see if this aircraft looks like it's reloading
  if (!me->p.f.t.Tethered
      && me->p.f.t.Ammo == 0
      && me->p.f.t.r.TarCom
      && me->p.f.t.r.TarCom->p.TarCom == (RadioClass *)me
      && me->p.f.t.r.TarCom->p.m.CurrentMission == 0x13   // Repair or Reload
      ) {
    me->p.f.t.Tethered = 1;
  }
  return TechnoClass_What_Weapon_Should_I_Use(me,w);
}

