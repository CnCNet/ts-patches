#pragma pack(push, 1)

typedef struct PropertiesAbstractClass
{
  int RTTI;
  int HeapID;
  int field_C;
  char IsActive;
  char field_11;
  char field_12;
  char field_13;
} PropertiesAbstractClass;

typedef struct vtAbstractClass vtAbstractClass;

typedef struct AbstractClass
{
    vtAbstractClass *vftable;
    PropertiesAbstractClass p;
} AbstractClass;

#pragma pack(pop)

#pragma pack(push, 1)
typedef struct vtAbstractClass
{
  int QueryInterface;
  int AddRef;
  int Release;
  int field_C;
  int IsDirty;
  int Load;
  int field_18;
  int GetMaxSize;
  int SDDTOR;
  int field_24;
  int Detach;
  int (*What_Am_I)(void);
  int field_30;
  int Name;
  int Compute_CRC;
  int32_t __thiscall (*Owning_HouseID)(AbstractClass *this);
  int Owning_House;
  int Get_Heap_ID;
  int Is_Dead;
  int (__thiscall *Center_Coord)(int32_t, int32_t);
  int (__thiscall *Target_Coord)(int32_t, int32_t);
  int OnFloor;
  int InAir;
  int AI;
} vtAbstractClass;
#pragma pack(pop)
