#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"

int32_t WorstMaxAhead = 24;

int32_t LastSentResponseTime = 100;

bool UseProtocolZero = false;
uint8_t HighLossMode = 0;

int32_t __thiscall
Hack_Response_Time(IPXManagerClass *this)
{
    return WorstMaxAhead;
}


void __thiscall IPXManagerClass__Set_Timing(IPXManagerClass *this, int NewRetryDelta, int a3, int NewRetryTimeout, bool SetGlobalConnClass);
void __thiscall
Hack_Set_Timing(IPXManagerClass *this, int NewRetryDelta, int a3, int NewRetryTimeout, bool SetGlobalConnClass)
{

    IPXManagerClass__Set_Timing(this, NewRetryDelta, a3, NewRetryTimeout, SetGlobalConnClass);
    WWDebug_Printf("NewRetryDelta = %d,  NewRetryTimeout = %d, FrameSendRate = %d, HighLossMode = %d\n",
                   NewRetryDelta, NewRetryTimeout, FrameSendRate, HighLossMode);
}

int SendResponseTimeFrame = 240;
int SendResponseTimeInterval = 30;

void
Send_Response_Time()
{
    if (UseProtocolZero)
    {
        int32_t rspTime = IPXManagerClass__Response_Time(&IPXManagerClass_this);
        rspTime = (int32_t) rspTime;

        uint8_t setHighLossMode = LOSS_MODE_WORST;

        if (rspTime <= 9)
            setHighLossMode = LOSS_MODE_BEST;
        else if (rspTime <= 15)
            setHighLossMode = LOSS_MODE_MEDIUM;


        if (rspTime > -1 && (Frame > SendResponseTimeFrame))
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
            WWDebug_Printf("Player %d sending response time of %d, HighLossMode = %d\n", PlayerPtr->ID, e.MaxAhead, e.HighLossMode);
        }
    }
}


int NextDecreaseFrame = 90;
int DecreaseInterval = 450;
int TrackHighLossMode = 0;

int32_t PlayerMaxAheads[8] = {0};
uint8_t PlayerHighLossMode[8] = {0};
int32_t PlayerLastTimingFrame[8] = {0};
int TimingTimeout = 120;

extern uint8_t NewFrameSendRate;

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

    uint8_t setHighLossMode = 0;
    int max = 0;
    for (int i = 0; i < 8; ++i)
    {
        if (PlayerLastTimingFrame[i] + TimingTimeout < Frame)
        {
            PlayerMaxAheads[i] = 0;
            PlayerHighLossMode[i] = 0;
        }
        else
        {
            max = PlayerMaxAheads[i] > max ? PlayerMaxAheads[i] : max;
            if (PlayerHighLossMode[i] > setHighLossMode)
                setHighLossMode = PlayerHighLossMode[i];
        }
    }
    WorstMaxAhead = max;

    WWDebug_Printf("Player %d, Loss mode (%d, %d)\n", PlayerPtr->ID, setHighLossMode, HighLossMode);
    if (setHighLossMode > HighLossMode && (SessionClass_this.GameSession == 3 || SessionClass_this.GameSession == 4))
    {
        HighLossMode = setHighLossMode;

        switch(HighLossMode)
        {
        case LOSS_MODE_BEST:
            NewFrameSendRate = 2;
            MessageListClass__Add_Message(&MessageListClass_this, 0, 0, "Latency mode set to BEST!",
                                          4,0x4096,(int)(Rules->MessageDuration * FramesPerMinute)/2);
            max = 6;
            break;
        case LOSS_MODE_MEDIUM:
            NewFrameSendRate = 3;
            MessageListClass__Add_Message(&MessageListClass_this, 0, 0, "Latency mode set to MEDIUM!",
                                          4,0x4096,(int)(Rules->MessageDuration * FramesPerMinute)/2);
            max = 12;
            break;
        default:
            NewFrameSendRate = 4;
            MessageListClass__Add_Message(&MessageListClass_this, 0, 0, "Latency mode set to WORST!",
                                          4,0x4096,(int)(Rules->MessageDuration * FramesPerMinute)/2);
            max = 16;
        }
        PreCalcMaxAhead = max;
        PreCalcFrameRate = 60;
    }
}
