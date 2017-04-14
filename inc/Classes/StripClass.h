#pragma pack(push, 1)
typedef struct CameoType
{
  int ItemIndex;
  int ItemType;
  void * Factory;
} CameoType;
#pragma pack(pop)

#pragma pack(push, 1)
typedef struct StripClass
{
  float field_0;
  int field_4;
  int field_8;
  int field_C;
  int field_10;
  int field_14;
  int field_18;
  int field_1C;
  Rect Rect;
  int WhichColumn;
  char Redraw;
  char field_35;
  char field_36;
  char field_37;
  int field_38;
  int CurrentRow;
  int field_40;
  int field_44;
  int field_48;
  int CameoCount;
  CameoType CameoList[75];
} StripClass;
#pragma pack(pop)
