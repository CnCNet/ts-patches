#pragma once

#pragma pack(push, 1)
typedef struct TacticalClass
{
  AbstractClass a;
  char field_14;
  char gap_15[63];
  int field_54;
  char field_58;
  char field_59;
  char gap_5A[2];
  XYCoord TacticalViewLocation;
  int field_64;
  int field_68;
  char gap_6C[12];
  int field_78;
  Point3DStruct field_7C;
  int field_88;
  int field_8C;
  int field_90;
  int VisibleCellCount;
  int VisibleCells[800];
  Rect ViewPort;
  int field_D28;
  int field_D2C;
  char field_D30;
  char IsRedrawing;
  char field_D32;
  char gap_D33[1];
  Rect field_D34;
  Rect DragSelection;
  int CurrentMouseFrame;
  int StartTime;
  int field_D5C;
  int field_D60;
  Matrix3D Matrices;
  int field_D94;
  int field_D98;
  int field_D9C;
  int field_DA0;
  int field_DA4;
  int field_DA8;
  int field_DAC;
  int field_DB0;
  int field_DB4;
  int field_DB8;
  int field_DBC;
  int field_DC0;
  int field_DC4;
} TacticalClass;

#pragma pack(pop)

XYCoord *__thiscall Tactical_60F0F0(XYCoord *this, int32_t X, int32_t Y);
int32_t __fastcall Tactical_AdjustForZ(int32_t Z);
CoordStruct *__thiscall Tactical_618050(XYCoord *a1, XYCoord *a2);
bool __thiscall Tactical__In_Viewport(TacticalClass *this, CoordStruct *coord);

extern int32_t CellWidth;
extern int32_t CellHeight;
extern TacticalClass *TacticalClassMap;

extern Rect ViewPort_Dimensions;
