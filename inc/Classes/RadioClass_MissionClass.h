
#pragma pack(push, 1)
typedef struct PropertiesMissionClass
{
  PropertiesObjectClass o;
  int CurrentMission;
  int QueuedMission;
  int RequestedMission;
  int MyStatus;
  char MissionStatus;
  char field_5D;
  char field_5E;
  char field_5F;
  FrameTimerClass MissionTimer;
} PropertiesMissionClass;
#pragma pack(pop)


struct RadioClass;

#pragma pack(push, 1)
typedef struct PropertiesRadioClass
{
  PropertiesMissionClass m;
  int NextMessage;
  int CurrentMessage;
  int PreviousMessage;
  struct RadioClass *TarCom;
} PropertiesRadioClass;

typedef struct RadioClass
{
  void *vt;
  PropertiesRadioClass p;
} RadioClass;

typedef struct vtMissionClass
{
  vtObjectClass o;
  int Commence;
  int Is_Busy_On_Mission;
  int Mission_Statue;
  int Mission_Sleep;
  int Mission_Ambush;
  int Mission_Attack;
  int Mission_Capture;
  int Mission_Guard;
  int Mission_Guard_Area;
  int Mission_Harvest;
  int Mission_Hunt;
  int Mission_Move;
  int Mission_Retreat;
  int Mission_Return;
  int Mission_Stop;
  int Mission_Unload;
  int Mission_Enter;
  int Mission_Construction;
  int Mission_Deconstruction;
  int Mission_Repair;
  int Mission_Missile;
  int Mission_Open;
  int Mission_Rescue;
  int Mission_Patrol;
  int Override_Mission;
  int Restore_Mission;
  int Has_Queued_Mission;
} vtMissionClass;

typedef struct vtRadioClass
{
  vtMissionClass m;
  int Transmit_Message;
  int Transmit_Message_LParam;
} vtRadioClass;

#pragma pack(pop)
