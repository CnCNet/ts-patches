#pragma once
#include <stdint.h>
#include "Enums/EventTypes.h"

#pragma pack(push, 1)

#define LOSS_MODE_BEST 1
#define LOSS_MODE_MEDIUM 2
#define LOSS_MODE_WORST 3

typedef struct EventClass {
    char Type;
    uint32_t Frame;
    char Is_Exec;
    int32_t ID;
    union {
        uint32_t Target_ID;
        struct {
            int8_t MaxAhead;
            int8_t FrameSendRate;
            int8_t HighLossMode;
        };
        char data[36];
    };
} EventClass;

typedef struct QueueClassEvent4096 {
    int32_t Count;
    int32_t Head_idx;
    int32_t Tail_idx;
    EventClass Events[4096];
} QueueClassEvent4096;

extern QueueClassEvent4096 DoList;
extern volatile uint32_t DoList_Mask;

typedef struct QueueClassEvent64 {
    int32_t Count;
    int32_t Head_idx;
    int32_t Tail_idx;
    EventClass Events[64];
} QueueClassEvent64;

extern QueueClassEvent64 OutList;
extern volatile uint32_t OutList_Mask;

#pragma pack(pop)

void __thiscall EventClass__EnqueueEvent(EventClass *this);
void __thiscall EventClass__EventClass_Execute(EventClass *this);
EventClass * __thiscall EventClass__EventClass_PlayerID(EventClass *e, int my_id, EventType t, int his_id);
EventClass * __thiscall EventClass__EventClass_noarg(EventClass *e, int my_id, EventType t);
EventClass * __thiscall EventClass__EventClass_produce(EventClass *e, int my_id, EventType t, int RTTI, int heapid);
void Toggle_Control(EventClass *e);

void __stdcall Extended_Events(EventClass *e);
void __thiscall Handle_Timing_Change(EventClass *e);

extern volatile uint8_t EventLengths[];
extern volatile char *EventNames[];
extern int CountEvents;
