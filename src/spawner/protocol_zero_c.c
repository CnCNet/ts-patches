#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"

int32_t WorstMaxAhead = 40;

int32_t LastSentResponseTime = 100;

bool UseProtocolZero = false;
bool HighLossMode = false;

int32_t __thiscall
Hack_Response_Time(IPXManagerClass *this)
{
    return WorstMaxAhead;
}



void __thiscall IPXManagerClass__Set_Timing(IPXManagerClass *this, int NewRetryDelta, int a3, int NewRetryTimeout, bool SetGlobalConnClass);
void __thiscall
Hack_Set_Timing(IPXManagerClass *this, int NewRetryDelta, int a3, int NewRetryTimeout, bool SetGlobalConnClass)
{
    if (HighLossMode)
    {
        WWDebug_Printf("HighLossMode is true\n");
        IPXManagerClass__Set_Timing(this, (int)MaxAhead/2, a3, NewRetryTimeout, SetGlobalConnClass);
    }
    else
    {
        WWDebug_Printf("NewRetryDelta = %d,  NewRetryTimeout = %d, FrameSendRate = %d, HighLossMode = %d\n",
                       NewRetryDelta, NewRetryTimeout, FrameSendRate, HighLossMode);
        IPXManagerClass__Set_Timing(this, NewRetryDelta, a3, NewRetryTimeout, SetGlobalConnClass);
    }
}

int SendResponseTimeFrame = 15;
int SendResponseTimeInterval = 15;

void
Send_Response_Time()
{
    if (UseProtocolZero)
    {
        int32_t rspTime = IPXManagerClass__Response_Time(&IPXManagerClass_this);
        rspTime = (int32_t) rspTime * 2 / 3;

        if (rspTime > 36)
            rspTime = 36;

        bool setHighLossMode = false;

        int32_t i = IPXManagerClass_this.NumConnections;

        for (; i-->0;)
        {
            IPXGlobalConnClass *p = IPXManagerClass_this.ConnectionArray[i];
            if (p->PercentLost > 3)
            {
                setHighLossMode = true;
            }
        }

        if (rspTime > -1 && (Frame > SendResponseTimeFrame || setHighLossMode))
        {

            SendResponseTimeFrame = Frame + SendResponseTimeInterval;
            EventClass e;
            e.Frame = Frame + MaxAhead;
            e.Type = 0x25;
            e.ID = PlayerPtr->ID;
            e.MaxAhead = (int8_t)rspTime + 1;
            e.HighLossMode = setHighLossMode;
            EventClass__EnqueueEvent(&e);

            LastSentResponseTime = rspTime;
            //WWDebug_Printf("Player %d sending response time of %d\n", PlayerPtr->ID, e.MaxAhead);
        }
    }
}


int NextIncreaseFrame = 15;
int FrameIncreaseInterval = 1;

int NextDecreaseFrame = 90;
int FrameDecreaseInterval = 1;
int MaxDecrease = 8;

int MinimumDecrease = 2;
int32_t PlayerMaxAheads[8] = {0};
bool PlayerHighLossMode[8] = {0};
int32_t PlayerLastTimingFrame[8] = {0};
int TimingTimeout = 120;

void __thiscall
Handle_Timing_Change(EventClass *e)
{
    //WWDebug_Printf("e->ID = %d, e->MaxAhead = %d, MaxAhead = %d, NextIncreaseFrame = %d, NextDecreaseFrame = %d\n", e->ID, e->MaxAhead, MaxAhead, NextIncreaseFrame, NextDecreaseFrame);
    if (e->MaxAhead == 0)
    {
        WWDebug_Printf("Returning because e->MaxAhead == 0\n");
        return;
    }

    PlayerLastTimingFrame[e->ID] = e->Frame;
    PlayerMaxAheads[e->ID] = (int32_t)e->MaxAhead;
    PlayerHighLossMode[e->ID] = e->HighLossMode;

    //WWDebug_Printf("doing timing change (%d. %d)\n", e->ID, e->MaxAhead);

    bool setHighLossMode = false;
    int max = 0;
    for (int i = 0; i < 8; ++i)
    {
        if (PlayerLastTimingFrame[i] + TimingTimeout < Frame)
        {
            PlayerMaxAheads[i] = 0;
            PlayerHighLossMode[i] = false;
        }
        else
        {
            max = PlayerMaxAheads[i] > max ? PlayerMaxAheads[i] : max;
            if (PlayerHighLossMode[i])
                setHighLossMode = true;
        }
    }
    HighLossMode = setHighLossMode;

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
        PreCalcMaxAhead = max > MaxAhead - MaxDecrease ? max : MaxAhead - MaxDecrease;
        PreCalcFrameRate = 60;
        WorstMaxAhead = max;
        NextDecreaseFrame = Frame + e->MaxAhead + FrameDecreaseInterval;
        NextIncreaseFrame = Frame + MaxAhead + FrameIncreaseInterval;
    }
}
