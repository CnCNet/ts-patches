#ifndef TOPLEVELTYPES_H
#define TOPLEVELTYPES_H

#pragma pack(push, 1)
typedef struct int_ll {
  int32_t v;
  struct int_ll *next;
} int_ll;

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

typedef struct Rect {
    int32_t left;
    int32_t top;
    int32_t width;
    int32_t height;
} Rect;
typedef struct XYCoord {
    int32_t x;
    int32_t y;
} XYCoord;
typedef struct Image {
    int16_t field_0;
    int16_t Width;
    int16_t Height;
    // More Stuff here FIXME
} Image;


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
  char *(__thiscall *ININame)(void *);
  char *(__thiscall *Name)(void *);
  char *(__thiscall *Category)(void *);
  char *(__thiscall *Description)(void *);
  int  (__thiscall *Execute)(void *a);
  void *unknown;
} vtCommandClass;

typedef struct CommandClass {
  vtCommandClass *vftable;
  void *a;
  int32_t b;
  int32_t c;
} CommandClass;

typedef struct Hotkey {
  uint32_t KeyCode;
  CommandClass *Command;
} Hotkey;


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
typedef struct VoxelCacheClass
{
  int field_0;
  int field_4;
  int field_8;
  char field_C;
  char field_D[3];
  int field_10;
} VoxelCacheClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct AbilityStruct
{
  char Faster;
  char Stronger;
  char Firepower;
  char Scatter;
  char ROF;
  char Sight;
  char Cloak;
  char TiberiumProof;
  char VeinProof;
  char SelfHeal;
  char Explodes;
  char RadarInvisible;
  char Sensors;
  char Fearless;
  char C4;
  char TiberiumHeal;
  char GuardArea;
  char Crusher;
} AbilityStruct;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct TS_CLSID
{
  int Data1;
  __int16 Data2;
  __int16 Data3;
  __int64 Data4;
} TS_CLSID;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct FLHStruct
{
  int F;
  int L;
  int H;
} FLHStruct;
#pragma pack(pop)

#pragma pack(push, 1)

typedef struct xyzCoordStruct_struct {
  uint32_t x;
  uint32_t y;
  uint32_t z;
} xyzCoordStruct;
typedef xyzCoordStruct CoordStruct;
typedef xyzCoordStruct Point3DStruct;

typedef struct wCoordStruct_struct {
  uint16_t x;
  uint16_t y;
} wCoordStruct;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct RGB
{
  char r;
  char g;
  char b;
} RGB;
#pragma pack(pop)

#endif //TOPLEVELTYPES_H
