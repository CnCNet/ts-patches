#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"

SETDWORD(0x006D2D54, _IPXManagerClass__ResponseTime_hack);

int32_t WorstMaxAhead = 40;

int32_t __thiscall _IPXManagerClass__ResponseTime(IPXManagerClass *this);
int32_t __thiscall
IPXManagerClass__ResponseTime_hack(IPXManagerClass *this)
{
    if (ProtocolVersion == 0)
    {
        return WorstMaxAhead;
    }
    return IPXManagerClass__Response_Time(this);
}

void
Send_Response_Time()
{
    if (ProtocolVersion == 0)
    {
        int32_t rspTime = IPXManagerClass__Response_Time(&IPXManagerClass_this);
        if (rspTime > -1)
        {
            rspTime = rspTime > 120 ? 120 : rspTime;
            EventClass e;
            e.Frame = Frame;
            //e.Type = 0x1A;
            e.Type = 0x25;
            e.ID = PlayerPtr->ID;
            e.MaxAhead = (int8_t)rspTime;
            EventClass__EnqueueEvent(&e);
            //WWDebug_Printf("Player %d sending response time of %d\n", PlayerPtr->ID, e.MaxAhead);
        }
    }
}


int NextIncreaseFrame = 7;
int FrameIncreaseInterval = 4;

int NextDecreaseFrame = 7;
int FrameDecreaseInterval = 30;

int MinimumDecrease = 3;
int32_t PlayerMaxAheads[8] = {0};


void __thiscall
Handle_Timing_Change(EventClass *e)
{
    //WWDebug_Printf("e->ID = %d, e->MaxAhead = %d, MaxAhead = %d, NextIncreaseFrame = %d, NextDecreaseFrame = %d\n", e->ID, e->MaxAhead, MaxAhead, NextIncreaseFrame, NextDecreaseFrame);
    if (e->MaxAhead == 0)
    {
        WWDebug_Printf("Returning because e->MaxAhead == 0\n");
        return;
    }

    //WWDebug_Printf("Set PlayerMaxAheads[%d] to %d\n", e->ID, e->MaxAhead);
    PlayerMaxAheads[e->ID] = (int32_t)e->MaxAhead;

    int max = 0;
    for (int i = 0; i < 8; ++i)
    {
        max = PlayerMaxAheads[i] > max ? PlayerMaxAheads[i] : max;
    }
    //WWDebug_Printf("Setting WorstMaxAhead to %d\n",  WorstMaxAhead);

    if (max > MaxAhead && Frame > NextIncreaseFrame)
    {
        WWDebug_Printf("Increasing\n");
        PreCalcMaxAhead = max;
        PreCalcFrameRate = 60;
        WorstMaxAhead = max;
        NextIncreaseFrame = Frame + MaxAhead + FrameIncreaseInterval;
        NextDecreaseFrame = Frame + e->MaxAhead + FrameDecreaseInterval;
    }
    else if (max < MaxAhead - MinimumDecrease && Frame > NextDecreaseFrame)
    {
        WWDebug_Printf("Decreasing\n");
        PreCalcMaxAhead = max;
        PreCalcFrameRate = 60;
        WorstMaxAhead = max;
        NextDecreaseFrame = Frame + e->MaxAhead + FrameDecreaseInterval;
        NextIncreaseFrame = Frame + MaxAhead + FrameIncreaseInterval;
    }
}
