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
