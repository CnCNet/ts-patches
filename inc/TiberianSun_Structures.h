typedef struct int_ll {
  int32_t v;
  struct int_ll *next;
} int_ll;

typedef struct Hotkey {
  uint32_t KeyCode;
  void *Command;
} Hotkey;

typedef struct TypeList
{
  void *base;
  void *Vector;
  int VectorMax;
  char IsValid;
  char IsAllocated;
  char VectorClassPad[2];
  int ActiveCount;
  int GrowthStep;
  int field_18;
} TypeList;

typedef struct DifficultyClass
{
  LARGE_INTEGER FirePower;
  LARGE_INTEGER Groundspeed;
  LARGE_INTEGER Airspeed;
  LARGE_INTEGER Armor;
  LARGE_INTEGER ROF;
  LARGE_INTEGER Cost;
  LARGE_INTEGER BuildTime;
  LARGE_INTEGER RepairDelay;
  LARGE_INTEGER BuildDelay;
  char BuildSlowdown;
  char DestroyWalls;
  char ContentScan;
  char field_4B;
  char field_4C;
  char field_4D;
  char field_4E;
  char field_4F;
} DifficultyClass;

typedef struct vtCommandClass {
  void *Destroy;
  void *Name;
  void *INIname;
  void *Category;
  void *Description;
  void *Execute;
  void *unknown;
} vtCommandClass;

typedef struct CommandClass {
  vtCommandClass *vftable;
  void *a;
  int32_t b;
  int32_t c;
} CommandClass;

#pragma pack(push, 1)
typedef struct DynamicVectorClass
{
  void *vftble;
  char **Vector;
  int VectorMax;
  char IsValid;
  char IsAllocated;
  char VectorClassPad[2];
  int ActiveCount;
  int GrowthStep;
} DynamicVectorClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct TutorialStruct {
  int32_t ID;
  char *Text;
} TutorialStruct;
#pragma pack(pop)

typedef struct MouseClass_struct {
  char v[0x1D30];
} MouseClass;

typedef struct CellClass_struct {
  char v1[0xA4];
  int VisibilityFlags;
} CellClass;


#pragma pack(push, 1)
typedef struct FrameTimerClass_struct
{
  int32_t TimerStart;
  int32_t Step_fix_me;
  int32_t TimerLeft;
} FrameTimerClass;
#pragma pack(pop)


#pragma pack(push, 1)
typedef struct StageClass
{
  int field_0;
  int field_4;
  int field_8;
  int field_C;
  int field_10;
  int field_14;
} StageClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct CargoClass
{
  int Count;
  int Object;
} CargoClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct ProgressTimerClass
{
  int Value;
  FrameTimerClass Timer;
  int Step;
  int field_14;
  int field_18;
} ProgressTimerClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct StorageClass
{
  int Riparius;
  int Cruentus;
  int Vinifera;
  int Aboreus;
} StorageClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct DoorClass
{
  char gap_0[8];
  FrameTimerClass DoorTimer;
  int Rate2;
  char IsClosed;
  char IsOpen;
  int field_1A;
  char field_1E;
  char field_1F;
} DoorClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct FacingClass_struct
{
  int field_0;
  int field_4;
  FrameTimerClass FacingTimer;
  __int16 Facing;
  __int16 field_16;
} FacingClass;
#pragma pack(pop)

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
typedef struct PropertiesRadioClass_struct
{
  PropertiesMissionClass m;
  int NextMessage;
  int CurrentMessage;
  int PreviousMessage;
  struct RadioClass *TarCom;
} PropertiesRadioClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct RadioClass
{
  void *vt;
  PropertiesRadioClass p;
} RadioClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct PropertiesTechnoClass_struct
{
  PropertiesRadioClass r;
  int FlashFrames;
  int field_80;
  StageClass field_84;
  int Side;
  CargoClass Cargo;
  float Veterancy;
  char gap_A8[4];
  int64_t field_B0;
  int64_t field_B8;
  FrameTimerClass AnimationTimer;
  float field_CC;
  int field_D0;
  int field_D4;
  int field_D8;
  int field_DC;
  int OwningHouse;
  int Group;
  int FocusOn;
  int Owner;
  int CloakState;
  ProgressTimerClass CloakProgress;
  FrameTimerClass CloakDelayTimer;
  int Target;
  int SuspendedTarCom;
  int PitchAngle;
  FrameTimerClass RearmTimer;
  int Ammo;
  int Value;
  float FireParticleSys;
  int SparkParticleSys;
  int NaturalParticleSys;
  int DamageParticleSys;
  int RailgunParticleSys;
  int WaveObject;
  int AngleRotatedSideways;
  int AngleRotatedForwards;
  int RockingSidewaysPerFrame;
  int RockingForwardsPerFrame;
  int InfiltratedInfType;
  StorageClass CreditLoad;
  DoorClass UnloadDoor;
  FacingClass BarrelFacing;
  FacingClass BodyFacing;
  FacingClass TurretFacing;
  int CurrentBurst;
  FrameTimerClass TargetLaserTimer;
  __int16 Seed;
  __int16 field_1F2;
  char field_1F4;
  char field_1F5;
  char Useless;
  char TickedOff;
  char Cloakable;
  char Primary;
  char Loaner;
  char Locked;
  char Recoil;
  char Tethered;
  char PlayerOwned;
  char PlayerAware;
  char AIAware;
  char field_201;
  char field_202;
  char field_203;
  char SightIncrease;
  char Recruitable;
  char AIRecruitable;
  char IsRadarTracked;
  char IsOnCarryall;
  char field_209;
  char IsPatroling;
  char field_20B;
  int ObjectNearToMe_fix_me;
  int field_210;
  int field_214;
  int RandomSeed;
  char field_21C;
  char field_21D;
  char field_21E;
  char field_21F;
} PropertiesTechnoClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct IFlyControl_struct
{
  void *vftble;
  void *AircraftType;
  char field_8;
  char HasCargo;
  char field_A;
  char field_B;
  char IsAttacking;
  char field_D;
  char field_E;
  char field_F;
} IFlyControl;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct PropertiesFootClass_struct
{
  PropertiesTechnoClass t;
  int PlanningPathIdx;
  int field_224;
  int field_228;
  char field_22C;
  char field_22D;
  char field_22E;
  char field_22F;
  char gap_22C[8];
  int CurrentWalkingFrame;
  wCoordStruct LastMapCoords;
  wCoordStruct field_240;
  wCoordStruct field_244;
  int field_248;
  int field_24C;
  int64_t SpeedPercentage;
  int64_t SpeedMultiplier;
  DynamicVectorClass PathfindingCells;
  int NavCom;
  int LastDestination;
  DynamicVectorClass NavList;
  int Team;
  int NextTeamMember;
  int field_2A0;
  int field_2A4;
  int field_2A8;
  int field_2AC;
  char field_2B0;
  char field_2B1;
  char field_2B2;
  char field_2B3;
  char field_2B4;
  char field_2B5;
  char field_2B6;
  char field_2B7;
  char field_2B8;
  char field_2B9;
  char field_2BA;
  char field_2BB;
  char field_2BC;
  char field_2BD;
  char field_2BE;
  char field_2BF;
  char field_2C0;
  char field_2C1;
  char field_2C2;
  char field_2C3;
  char field_2C4;
  char field_2C5;
  char field_2C6;
  char field_2C7;
  char field_2C8;
  char field_2C9;
  char field_2CA;
  char field_2CB;
  char field_2CC;
  char field_2CD;
  char field_2CE;
  char field_2CF;
  char field_2D0;
  char field_2D1;
  char field_2D2;
  char field_2D3;
  char field_2D4;
  char field_2D5;
  char field_2D6;
  char field_2D7;
  char field_2D8;
  char field_2D9;
  char field_2DA;
  char field_2DB;
  char field_2DC;
  char field_2DD;
  char field_2DE;
  char field_2DF;
  char field_2E0;
  char field_2E1;
  char field_2E2;
  char field_2E3;
  char field_2E4;
  char field_2E5;
  char field_2E6;
  char field_2E7;
  char field_2E8;
  char field_2E9;
  char field_2EA;
  char field_2EB;
  char field_2EC;
  char field_2ED;
  char field_2EE;
  char field_2EF;
  char field_2F0;
  char field_2F1;
  char field_2F2;
  char field_2F3;
  char field_2F4;
  char field_2F5;
  char field_2F6;
  char field_2F7;
  char field_2F8;
  char field_2F9;
  char field_2FA;
  char field_2FB;
  char field_2FC;
  char field_2FD;
  char field_2FE;
  char field_2FF;
  char field_300;
  char field_301;
  char field_302;
  char field_303;
  FrameTimerClass PathDelayTimer;
  int field_310;
  FrameTimerClass SightTimer;
  FrameTimerClass BlockagePathTimer;
  int Locomotor;
  CoordStruct Position;
  char TunnelIndex;
  char TunnelCellNumber;
  char WaypointIndex;
  char field_33F;
  char field_340;
  char IsTeamLeader;
  char field_342;
  char field_343;
  char Deployed;
  char Firing;
  char TurretSpins;
  char field_347;
  char field_348;
  char field_349;
  char field_34A;
  char field_34B;
  char field_34C;
  char IsMoving_fix_me;
  char field_34E;
  char field_34F;
} PropertiesFootClass;
#pragma pack(pop)


#pragma pack(push, 1)
typedef struct PropertiesAircraftClass_struct
{
  PropertiesFootClass f;
  IFlyControl IFlyControl;
  FrameTimerClass LookTimer;
  int field_36C;
  char HasPassengers;
  char field_371;
  char field_372;
  char field_373;
  char field_374;
  char field_375;
  char field_376;
  char field_377;
} PropertiesAircraftClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct AircraftClass_struct
{
  void *vt;
  PropertiesAircraftClass p;
} AircraftClass;
#pragma pack(pop)


#pragma pack(push, 1)
typedef struct MessageListClass
{
  int field_0;
  int CoordFromLeft;
  int CoordFromTop;
  int MaxMessages;
  int field_10;
  int LineSpacingInPixels;
  char field_18;
  char field_19;
  char field_1A;
  char field_1B;
  int field_1C;
  int field_20;
  int TextLabels;
  char field_28;
  char gap_29[3];
  int field_2C;
  int field_30;
  int field_34;
  int field_38;
  int field_3C;
  int field_40;
  int field_44;
  int field_48;
  int field_4C;
  int field_50;
  int field_54;
  int field_58;
  int field_5C;
  char gap_60[106];
  char field_CA;
  char gap_CB[161];
  int field_16C;
  int field_170;
  char field_174;
  char gap_175[3];
  int field_178;
  int field_17C;
  int field_180;
  char gap_184[2268];
  int field_A60;
  int field_A64;
  int field_A68;
  __int16 field_A6C;
  __int16 field_A6E;
} MessageListClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct EventClass {
    char Type;
    uint32_t Frame;
    char Is_Exec;
    uint32_t ID;
    union {
        uint32_t Target_ID;
        char data[36];
    };
} EventClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct CounterClass
{
  void *base;
  void *Vector;
  int CountMax;
  char IsValid;
  char IsAllocated;
  char CounterClassPad[2];
} CounterClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct DropshipLoadoutClass
{
  int field_0;
  char field_4;
  char field_5;
  char field_6;
  char field_7;
  int field_8;
  char field_C;
  char field_D;
  char field_E;
  char field_F;
  int field_10;
  int field_14;
  char field_18;
  char field_19;
  char field_1A;
  char field_1B;
  char field_1C;
  char field_1D;
  char field_1E;
  char field_1F;
  char field_20;
  char field_21;
  char field_22;
  char field_23;
  char field_24;
  char field_25;
  char field_26;
  char field_27;
  int field_28;
} DropshipLoadoutClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct RGB
{
  char r;
  char g;
  char b;
} RGB;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct IPAddressClass
{
  char field_0;
  char field_1;
  char field_2;
  char field_3;
  char field_4;
  char field_5;
  char field_6;
  char field_7;
  char field_8;
  char field_9;
} IPAddressClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct Buffer
{
  int BufferPtr;
  int Size;
  char IsAllocated;
  char field_9[3];
} Buffer;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct FileClass
{
  void *vftable;
} FileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct RawFileClass
{
  FileClass f;
  int Rights;
  int BiasStart;
  int BiasLength;
  int Handle;
  void *Filename;
  int16_t Date;
  int16_t Time;
  char FilenameSet;
  char Pad[3];
} RawFileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct BufferIOFileClass
{
  RawFileClass r;
  char IsBufferOwner;
  char BoolOne;
  char IsFileOpen;
  char BoolThree;
  char Uncommitted;
  char Cached;
  char __Pad[2];
  int FileRights;
  float BufferPointer;
  int Size2;
  int BufferPosition;
  int Start2;
  int UncommittedStart;
  int UncommittedEnd;
  int BufferSize;
  int BiasStart;
  int Dword8;
} BufferIOFileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct CDFileClass
{
  BufferIOFileClass b;
  char SkipSearchDrives;
  char Padding[3];
} CDFileClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct CCFileClass
{
  CDFileClass cd;
  Buffer CacheBuffer;
  int CachedSize;
} CCFileClass;
#pragma pack(pop)


#pragma pack(push, 1)
typedef struct EventQueueType
{
    int32_t Count;
    int32_t Head;
    int32_t Tail;
    EventClass Array[64];
} EventQueueType;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct WWKeyboardClass
{
  int MouseQX;
  int MouseQY;
  int field_8;
  int field_C;
  char KeyboardState[256];
  int16_t Elements[256];
  void *field_310;
  void *field_314;
  int SomeBool;
} WWKeyboardClass;
#pragma pack(pop)
