#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>

CALL(0x00631732, _has_control);
CALL(0x00631895, _has_control);
CALL(0x006318D6, _has_control);
CALL(0x00631903, _has_control);
CALL(0x00631944, _has_control);
CALL(0X00631A7B, _has_control);

CALL(0x00631C90, _has_control);
CALL(0x00631D15, _has_control);
CALL(0x00631EB8, _has_control);

CALL(0x00631FF9, _has_control);
CALL(0x00632319, _has_control);

CALL(0x0065619D, _has_control);
CALL(0x006561FC, _has_control);
CALL(0x00656294, _has_control);
CALL(0x00656456, _has_control);

CALL(0x006564AF, _has_control);
CALL(0x00656504, _has_control);

CALL(0x004D78BF, _has_control);
CALL(0x004D6FF4, _has_control);

// AircraftClass::What_action
CALL(0x0040B810, _has_control);
CALL(0x0040B8F1, _has_control);
CALL(0x0040B9E9, _has_control);

//Mouse_Left_Release_check_Foot_Bandbox
CALL(0X00479176, _has_control_or_spectator);

// ObjectClass::Select
CALL(0x0058526B, _has_control_or_spectator);
CALL(0x00585278, _has_control_or_spectator);
CALL(0x00585288, _has_control_or_spectator);

//Tactical::Render
CALL(0x00611B9E, _has_control_or_spectator);

//CreateTeamCommandClass::Execute
CALL(0x004E8C69, _has_control);
//SelectTeamCommandClass
CALL(0x004E8E4C, _has_control);
//AddTeamCommandClass::
CALL(0x004E8FC9, _has_control);
//CenterTeamCommandClass::
CALL(0x004E916C, _has_control);

uint32_t Controlling_Houses[8];

bool __thiscall
has_control(HouseClass *h)
{
    if (h == PlayerPtr) return true;
    if (PlayerPtr->Defeated)
    {
        return HouseClass__Is_Player(h);
    }
    uint32_t me_mask = 1 << PlayerPtr->ID;
    if ((Controlling_Houses[h->ID] & me_mask)
        &&
        HouseClass__Is_Ally(h, PlayerPtr->ID))
        return true;
    else
        return false;
}

bool __thiscall
has_control_or_spectator(HouseClass *h)
{
    if (IsSpectatorArray[PlayerPtr->ID])
        return true;
    else
        return has_control(h);
}


void __thiscall
GrantControl_Execute()
{
    if (SessionType.GameSession && !PlayerPtr->Defeated)
    {
        if (CurrentObjectsArray.ActiveCount > 0)
        {
            ObjectClass *first = *CurrentObjectsArray.Vector;
            int32_t his_id = first->vftable->Owning_HouseID(first);
            if (PlayerPtr->ID != his_id
                &&
                HouseClass__Is_Ally(PlayerPtr, his_id))
            {

                EventClass e;
                EventClass__EventClass_PlayerID(&e, PlayerPtr->ID,
                                                EVENTTYPE_GRANTCONTROL, his_id);
                WWDebug_Printf("Enqueing event %s => %d, %d\n", "GRANTCONTROL",
                               PlayerPtr->ID, his_id);
                EnqueueEvent(&e);
            }
        }
    }

}

void
Toggle_Control(EventClass *e)
{
    WWDebug_Printf("offset = 0x%x\n", offsetof(HouseClass, RecheckItems));

    char message[128];
    uint32_t grantee = Controlling_Houses[e->ID];
    uint32_t target_mask = 1 << (e->Target_ID);
    if (grantee ^ target_mask)
        sprintf(message, "Player %s has shared control with player %s\n",
                HouseClassArray.Vector[e->ID]->Name,
                HouseClassArray.Vector[e->Target_ID]->Name
                );
    else
        sprintf(message, "Player %s has revoked control from %s\n",
                HouseClassArray.Vector[e->ID]->Name,
                HouseClassArray.Vector[e->Target_ID]->Name
                );

    Controlling_Houses[e->ID] = grantee ^ target_mask;
    WWDebug_Printf("Control = %x %x %x %x %x %x %x %x\n",
                   Controlling_Houses[0],
                   Controlling_Houses[1],
                   Controlling_Houses[2],
                   Controlling_Houses[3],
                   Controlling_Houses[4],
                   Controlling_Houses[5],
                   Controlling_Houses[6],
                   Controlling_Houses[7]
                   );

    MessageListClass__Add_Message(&MessageListClass_this, 0, 0, message,
                                  HouseClassArray.Vector[e->ID]->ColorSchemeType,
                                  0x4046,
                                  (int)(Rules->MessageDuration * FramesPerMinute));

}


void    __thiscall GrantControl_nothing(void *a) { }
char *  __thiscall GrantControl_Description(void *a) { return "Grant's shared unit control to an ally. Select a unit of your ally and press this key to grant unit control"; }
char *  __thiscall GrantControl_INIname(void *a)     { return "GrantControl"; }
char *  __thiscall GrantControl_Category(void *a)    { return "Control"; }
char *  __thiscall GrantControl_Name(void *a)        { return "GrantControl"; }

vtCommandClass vtGrantControlCommand = {
  CommandDestroy,
  GrantControl_INIname,
  GrantControl_Name,
  GrantControl_Category,
  GrantControl_Description,
  GrantControl_Execute,
  GrantControl_nothing
};
CommandClass GrantControlCommand = { &vtGrantControlCommand,0,17,17 };
