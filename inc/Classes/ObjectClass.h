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



typedef  int32_t __thiscall (*fnObjectClass__OwningHouseID)(void *this);

#pragma pack(push, 1)
typedef struct vtObjectClass
{
    char gap[0x3C];
    fnObjectClass__OwningHouseID Owning_HouseID;
} vtObjectClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct PropertiesObjectClass
{
  PropertiesAbstractClass a;
  int field_14;
  int field_18;
  int FallingHeight;
  int Next;
  int AttachedTag;
  int Strength;
  char IsDown;
  char ToDamage;
  char ToDisplay;
  char InLimbo;
  char Selected;
  char AnimAttached;
  char OnBridge;
  char Falling;
  char IsABomb;
  char IsActive;
  char field_36;
  char field_37;
  int Layer;
  char Submitted;
  char field_3D;
  char field_3E;
  char field_3F;
  Point3DStruct CenterCoords;
} PropertiesObjectClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct ObjectClass
{
    vtObjectClass *vftable;
    PropertiesObjectClass p;
} ObjectClass;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct DynamicVectorClass_Objects
{
  void *vftble;
  ObjectClass **Vector;
  int VectorMax;
  char IsValid;
  char IsAllocated;
  char VectorClassPad[2];
  int ActiveCount;
  int GrowthStep;
} DynamicVectorClass_Objects;
#pragma pack(pop)
