

typedef  int32_t __thiscall (*fnObjectClass__OwningHouseID)(void *this);

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
typedef struct vtObjectClass vtObjectClass;

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

#pragma pack(push, 1)
typedef struct vtObjectClass
{
  vtAbstractClass a;
  int Is_Players_Army;
  int field_64;
  void *field_68;
  int Get_Image_Data;
  int (__thiscall *What_Action)(ObjectClass *this, int32_t,int32_t,int32_t,int32_t);
  int What_Action_Object;
  int (*In_Which_Layer)(void);
  int field_7C;
  int field_80;
  int (*Class)(void);
  ObjectTypeClass *__thiscall (*Class_Of)(ObjectClass *this);
  int field_8C;
  int field_90;
  int field_94;
  int field_98;
  int (__thiscall *Can_Player_Fire)(ObjectClass *this);
  int (__thiscall *Can_Player_Move)(ObjectClass *this);
  int field_A4;
  int field_A8;
  int field_AC;
  int field_B0;
  int field_B4;
  int field_B8;
  int field_BC;
  int field_C0;
  int field_C4;
  int Unlimbo;
  int Detach_All;
  int Record_The_Kill;
  int field_D4;
  int field_D8;
  int field_DC;
  int field_E0;
  int Detach;
  int (__thiscall *Do_Shimmer)(ObjectClass *this);
  int field_EC;
  int field_F0;
  int field_F4;
  int field_F8;
  int Draw_It;
  int field_100;
  int field_104;
  int field_108;
  int field_10C;
  int Mark;
  int field_114;
  int field_118;
  int field_11C;
  int field_120;
  int (__thiscall *Active_Click_With)(int32_t, int32_t);
  int field_128;
  int field_12C;
  int Select;
  int Unselect;
  int (__thiscall *In_Range)(int32_t, int32_t, int32_t);
  int field_13C;
  int Take_Damage;
  int Scatter;
  int field_148;
  int field_14C;
  int Value;
  int Get_Mission;
  int (__thiscall *Assign_Mission)(int32_t, int32_t);
  int field_15C;
  int field_160;
  int field_164;
  int field_168;
  int field_16C;
  int field_170;
  int field_174;
  int field_178;
  int Can_Enter_Cell;
  int field_180;
  int Get_Coord_Cell;
  int SetPosition;
  int Get_Distance;
  int GetCell;
  int field_194;
  int field_198;
  int Get_Position;
  int field_1A0;
  int Get_Z_Coord;
} vtObjectClass;
#pragma pack(pop)
