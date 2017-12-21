
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

typedef struct Random2Class
{
    uint32_t Seed;
    uint32_t Index;
    uint32_t NumberArray[250];
} Random2Class;

typedef struct ScenarioClass
{
    char data[0x218];
    Random2Class CriticalRandomNumber;
} ScenarioClass;

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
