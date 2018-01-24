#include "macros/patch.h"
#include "TiberianSun.h"
#include "Classes/EventClass.h"
#include "patch.h"
#include <stdbool.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <float.h>

unsigned int __cdecl __MINGW_NOTHROW _controlfp (unsigned int unNew, unsigned int unMask);

CALL(0x005B5AD2, _fprintf_log_more_stuff);
CALL(0x005B5CA0, _fprintf_no_name_localization);

void print_OutList(FILE * restrict stream, int32_t count);
void print_DoList(FILE * restrict stream, int32_t count);
void print_RNG(FILE * restrict stream, int32_t count);

int32_t
fprintf_log_more_stuff(FILE * restrict stream, const char * restrict format, int32_t pct_lost)
{
    // Perform the original call, we already know the argument so no need for va_arg
    int32_t ret = fprintf(stream, format, pct_lost);

    //print_OutList(stream, 64);
    fprintf(stream, "FPU State: %x\n", _controlfp(0, 0));
    print_DoList(stream, 4096);
    print_RNG(stream, 4096);
    return ret;
}

void
printEvent_OneLine(FILE * restrict stream, EventClass *e)
{
    if (e->Type <= CountEvents)
        fprintf(stream, "Event: %-14s ", EventNames[e->Type]);
    else
        fprintf(stream, "Event: 0x%-14x ", e->Type);

    fprintf(stream, "Frame: %-8d Is_Exec: %d  ID: %-4d ", e->Frame, e->Is_Exec, e->ID);

    int length = 36;
    if (e->Type <= CountEvents)
        length = EventLengths[e->Type];

    for (int i = 0; i < length; ++i)
    {
        if (i % 4 == 0)
            fprintf(stream, " %02x", 0xff & e->data[i]);
        else
            fprintf(stream, "%02x", 0xff & e->data[i]);
    }
}

void
print_OutList(FILE * restrict stream, int32_t count)
{
    fprintf(stream, "\n--- BEGIN OutList ---\n", //"Count = %d, Head = %d, Tail = %d\n",
            OutList.Count, OutList.Head_idx, OutList.Tail_idx);

    int idx = OutList.Tail_idx - 1;
    do
    {
        EventClass *e = &OutList.Events[idx];

        if (e->Type > 0 && e->Type != EVENTTYPE_FRAMEINFO && e->Type != EVENTTYPE_PROCESS_TIME && e->Type != EVENTTYPE_RESPONSE_TIME2)
        {
            fprintf(stream, "idx = %-4d ", idx);
            printEvent_OneLine(stream, e);

            if (idx == OutList.Tail_idx || idx == OutList.Head_idx)
                fprintf(stream, "\n", 0); //Hackaround fprintf macro
            else
                fprintf(stream, " *\n", 0);
        }
        idx = (idx - 1) & OutList_Mask;
    } while(0 <--count);
}

void
print_DoList(FILE * restrict stream, int32_t count)
{
    fprintf(stream, "\n--- BEGIN DoList ---\n", //"Count = %d, Head = %d, Tail = %d\n",
            DoList.Count, DoList.Head_idx, DoList.Tail_idx);

    int idx = DoList.Tail_idx - 1;
    do
    {
        EventClass *e = &DoList.Events[idx];

        if (e->Type > 0 && e->Type != EVENTTYPE_FRAMEINFO && e->Type != EVENTTYPE_PROCESS_TIME && e->Type != EVENTTYPE_RESPONSE_TIME2)
        {
            //fprintf(stream, "idx = %-4d ", idx);
            printEvent_OneLine(stream, e);

            if (idx == (DoList.Tail_idx -1) || idx == DoList.Head_idx)
                fprintf(stream, " *\n", 0); //Hackaround fprintf macro
            else
                fprintf(stream, "\n", 0);
        }
        idx = (idx - 1) & DoList_Mask;
    } while(0 <--count);
    fprintf(stream, "\n", 0);
}

int32_t
fprintf_no_name_localization(FILE * restrict stream, const char * restrict format, char *name,
                             bool isHuman, int32_t color, int32_t id, char *houseType)
{
    if (!isHuman)
        name = "Computer";

    return fprintf(stream, format, name, isHuman, color, id, houseType);
}

typedef enum RngCallType {
    RngCallType_None = 0,
    RngCallType_Unranged = 1,
    RngCallType_Ranged = 2
} RngCallType;

typedef struct RngCallNode {
    RngCallType type;
    bool Critical;
    uint32_t Seed;
    uint32_t Index;
    uint32_t Caller;
    uint32_t Frame;
    uint32_t Min;
    uint32_t Max;
} RngCallNode;

#define RNGCALLBUFFER_SZ 4096
#define RNGCALLBUFFER_MASK RNGCALLBUFFER_SZ - 1

typedef struct RngCallBuffer {
    uint32_t Index;
    RngCallNode CallHistory[RNGCALLBUFFER_SZ];
} RngCallBuffer;

RngCallBuffer rngCallBuffer = {0};

void __cdecl
record_rng_ii(Random2Class *rc, uint32_t caller, int32_t min, int32_t max)
{
    RngCallNode *node = &rngCallBuffer.CallHistory[rngCallBuffer.Index];
    node->type = RngCallType_Ranged;
    node->Critical = rc == &ScenarioStuff->CriticalRandomNumber;
    node->Seed = rc->Seed;
    node->Index = rc->Index;
    node->Caller = caller;
    node->Frame = Frame;
    node->Min = min;
    node->Max = max;

    rngCallBuffer.Index = (rngCallBuffer.Index + 1) & RNGCALLBUFFER_MASK;
}

void __cdecl
record_rng_void(Random2Class *rc, uint32_t caller)
{
    RngCallNode *node = &rngCallBuffer.CallHistory[rngCallBuffer.Index];
    node->type = RngCallType_Unranged;
    node->Critical = rc == &ScenarioStuff->CriticalRandomNumber;
    node->Seed = rc->Seed;
    node->Index = rc->Index;
    node->Caller = caller;
    node->Frame = Frame;

    rngCallBuffer.Index = (rngCallBuffer.Index + 1) & RNGCALLBUFFER_MASK;
}

void
print_RNG(FILE * restrict stream, int32_t count)
{
    fprintf(stream, "--- BEGIN RANDOM ---\n", 0);

    int index = (rngCallBuffer.Index - 1) & RNGCALLBUFFER_MASK;
    while (index != rngCallBuffer.Index && count-- > 0)
    {
        switch (rngCallBuffer.CallHistory[index].type)
        {
        case RngCallType_None:
            continue;

        case RngCallType_Unranged:
            fprintf(stream, "RNG: %s UNRANGED CALLER: %08x  FRAME: %-10d MIX1: %3d MIX2: %3d\n",
                    rngCallBuffer.CallHistory[index].Critical ? "CRITICAL" : "NONCRIT ",
                    rngCallBuffer.CallHistory[index].Caller, rngCallBuffer.CallHistory[index].Frame,
                    rngCallBuffer.CallHistory[index].Seed,
                    rngCallBuffer.CallHistory[index].Index);
            break;

        case RngCallType_Ranged:
            fprintf(stream, "RNG: %s RANGED   CALLER: %08x  FRAME: %-10d MIX1: %3d MIX2: %3d MIN: %d  MAX: %d\n",
                    rngCallBuffer.CallHistory[index].Critical ? "CRITICAL" : "NONCRIT ",
                    rngCallBuffer.CallHistory[index].Caller, rngCallBuffer.CallHistory[index].Frame,
                    rngCallBuffer.CallHistory[index].Seed, rngCallBuffer.CallHistory[index].Index,
                    rngCallBuffer.CallHistory[index].Min, rngCallBuffer.CallHistory[index].Max);
            break;

        default:
            break;
        }
        index = (index - 1) & RNGCALLBUFFER_MASK;
    }
    fprintf(stream, "\n", 0);
}
