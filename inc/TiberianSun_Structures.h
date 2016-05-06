typedef struct int_ll {
  int32_t v;
  struct int_ll *next;
} int_ll;

typedef struct Hotkey {
  uint32_t KeyCode;
  void *Command;
} Hotkey;

typedef struct HouseClass  { // Fixme... define the real HouseClass
  char gap[0x10E4F];
} HouseClass;

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

typedef struct MouseClass_struct {
  char v[0x1D30];
} MouseClass;

typedef struct CellClass_struct {
  char v1[0xA4];
  int VisibilityFlags;
} CellClass;

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

/*
#pragma pack(push, 1)
struct HouseClass
{
  void *vt;
  int vtRTTI;
  char field_8;
  char field_9;
  char field_A;
  char field_B;
  char field_C;
  char field_D;
  char field_E;
  char field_F;
  char field_10;
  char field_11;
  char field_12;
  char field_13;
  int IHouse;
  int IPublicHouse;
  int IConnectionPointContainer;
  int ID;
  int HousesType;
  DynamicVectorClass Tags;
  DynamicVectorClass ConstructionYards;
  int AIDifficulty;
  char field_5C;
  char field_5D;
  char field_5E;
  char field_5F;
  double FirepowerMultiplier;
  double GroundspeedMultiplier;
  double AirspeedMultiplier;
  double ArmorMultiplier;
  double ROFMultiplier;
  double CostMultiplier;
  double BuildTimeMultiplier;
  double RepairDelay;
  double BuildDelay;
  int IQLevel;
  int TechLevel;
  int AltAllies;
  int Credits;
  int StartingEdge;
  int field_BC;
  int Side;
  char IsHuman;
  char IsPlayer;
  char ProductionBegun;
  char field_C7;
  char TriggersAreActive;
  char AutoBaseBuilding;
  char Discovered;
  char Defeated;
  char ToDie;
  char ToWin;
  char ToLose;
  char CiviliansEvacuated;
  char FirestormActive;
  char HasThreatNode;
  char RecalcNeeded;
  char field_D3;
  int field_D4;
  int field_D8;
  char Resigned_q;
  char field_DD;
  char field_DE;
  char field_DF;
  int SelectedWayPntPathIndex;
  void *WaypointPaths[12];
  char Visionary;
  char field_115;
  char field_116;
  char field_117;
  char Repairing;
  char field_119;
  char LostConnection;
  char Kicked;
  char AllToHunting;
  char IsParanoid;
  char field_11E;
  char field_11F;
  int CurrentIQ;
  int field_124;
  DynamicVectorClass Supers;
  int LastBuiltStructType;
  int LastBuiltInfantryType;
  int LastBuiltVehicleType;
  int LastBuiltAircraftType;
  int AllowWinBlocks;
  FrameTimerClass RepairTimer;
  FrameTimerClass SomeTimer1;
  FrameTimerClass BorrowedTime;
  FrameTimerClass SomeTimer3;
  int OwnedUnits;
  int OwnedBuildings;
  int OwnedInfantry;
  int OwnedAircraft;
  StorageClass Tiberiums;
  int Balance;
  int TotalStorage;
  StorageClass Weeds;
  int field_1BC;
  int AircraftTypeCount2;
  int InfantryTypeCount2;
  int UnitTypeCount2;
  int BuildingTypeCount3;
  int AircraftTypeCount;
  int InfantryTypeCount;
  int UnitTypeCount;
  int BuildingTypeCount2;
  int BuildingTypeCount;
  int CollectedPowerupCount;
  int InfantryFactoryCount;
  int BuildingFactoryCount;
  int UnitFactoryCount;
  int AircraftFactoryCount;
  int PowerBonus;
  int PowerDrain;
  int PrimaryAircraftFactory;
  int PrimaryInfantryFactory;
  int PrimaryUnitFactory;
  int PrimaryBuildingFactory;
  int FlagHolder;
  wCoord HomeCell;
  char field_218;
  char field_219;
  char field_21A;
  char field_21B;
  char field_21C;
  char field_21D;
  char field_21E;
  char field_21F;
  char field_220;
  char field_221;
  char field_222;
  char field_223;
  char field_224;
  char field_225;
  char field_226;
  char field_227;
  char field_228;
  char field_229;
  char field_22A;
  char field_22B;
  char field_22C;
  char field_22D;
  char field_22E;
  char field_22F;
  char field_230;
  char field_231;
  char field_232;
  char field_233;
  char field_234;
  char field_235;
  char field_236;
  char field_237;
  int field_238;
  char field_23C;
  char field_23D;
  char field_23E;
  char field_23F;
  wCoordStruct field_240;
  char field_244;
  char field_245;
  char field_246;
  char field_247;
  char field_248;
  char field_249;
  char field_24A;
  char field_24B;
  char field_24C;
  char field_24D;
  char field_24E;
  char field_24F;
  char field_250;
  char field_251;
  char field_252;
  char field_253;
  char field_254;
  char field_255;
  char field_256;
  char field_257;
  char field_258;
  char field_259;
  char field_25A;
  char field_25B;
  char field_25C;
  char field_25D;
  char field_25E;
  char field_25F;
  char field_260;
  char field_261;
  char field_262;
  char field_263;
  char field_264;
  char field_265;
  char field_266;
  char field_267;
  char field_268;
  char field_269;
  char field_26A;
  char field_26B;
  char field_26C;
  char field_26D;
  char field_26E;
  char field_26F;
  char field_270;
  char field_271;
  char field_272;
  char field_273;
  char field_274;
  char field_275;
  char field_276;
  char field_277;
  char field_278;
  char field_279;
  char field_27A;
  char field_27B;
  char field_27C;
  char field_27D;
  char field_27E;
  char field_27F;
  char field_280;
  char field_281;
  char field_282;
  char field_283;
  char field_284;
  char field_285;
  char field_286;
  char field_287;
  char field_288;
  char field_289;
  char field_28A;
  char field_28B;
  char field_28C;
  char field_28D;
  char field_28E;
  char field_28F;
  char field_290;
  char field_291;
  char field_292;
  char field_293;
  char field_294;
  char field_295;
  char field_296;
  char field_297;
  char field_298;
  char field_299;
  char field_29A;
  char field_29B;
  char field_29C;
  char field_29D;
  char field_29E;
  char field_29F;
  char field_2A0;
  char field_2A1;
  char field_2A2;
  char field_2A3;
  char field_2A4;
  char field_2A5;
  char field_2A6;
  char field_2A7;
  char field_2A8;
  char field_2A9;
  char field_2AA;
  char field_2AB;
  char field_2AC;
  char field_2AD;
  char field_2AE;
  char field_2AF;
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
  CoordStruct PositionOnMap;
  int field_2D0;
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
  char field_304;
  char field_305;
  char field_306;
  char field_307;
  char field_308;
  char field_309;
  char field_30A;
  char field_30B;
  char field_30C;
  char field_30D;
  char field_30E;
  char field_30F;
  int field_310;
  char field_314;
  char field_315;
  char field_316;
  char field_317;
  char field_318;
  char field_319;
  char field_31A;
  char field_31B;
  int HasRadar;
  int field_320;
  char field_324;
  char field_325;
  char field_326;
  char field_327;
  CounterClass TotalOwned_Buildings;
  CounterClass TotalOwned_Units;
  CounterClass TotalOwned_Infantry;
  CounterClass TotalOwned_Aircraft;
  CounterClass CurrentOwned_Building;
  CounterClass CurrentOwned_Unit;
  CounterClass CurrentOwned_Infantry;
  CounterClass CurrentOwned_Aircraft;
  CounterClass FactoryProduced_Buildings;
  CounterClass FactoryProduced_Units;
  CounterClass FactoryProduced_Infantry;
  CounterClass FactoryProduced_Aircraft;
  int CreationFrame;
  int field_3EC;
  int AttackDelayA;
  int AttackDelayB;
  int CurrentEnemyIndex;
  DynamicVectorClass AngerNodes;
  DynamicVectorClass ScoutNodes;
  FrameTimerClass ExpertTimer;
  FrameTimerClass AttackTimer;
  int SuggestedBuildingTypeToProduce;
  int SuggestedUnitTypeToProduce;
  int SuggestedInfantryTypeToProduce;
  int SuggestedAircraftTypeToProduce;
  int RatioAITriggerTeam;
  int RatioTeamAircraft;
  int RatioTeamInfantry;
  int RatioTeamBuildings;
  int BaseDefenseTeamCount;
  DropshipLoadoutClass DropshipClass;
  char gap_494[88];
  int field_4EC;
  char HasCloakGenerator;
  RGB RGBColor;
  BaseClass BaseNodes;
  char RecheckItems;
  char RadarOutage;
  wCoordStruct EMPTarget;
  wCoordStruct NukeTarget;
  char field_576;
  char field_577;
  int AlliesBitfield;
  FrameTimerClass field_57C;
  FrameTimerClass field_588;
  FrameTimerClass field_594;
  FrameTimerClass field_5A0;
  FrameTimerClass field_5AC;
  FrameTimerClass field_5B8;
  FrameTimerClass field_5C4;
  int AI_CLSID;
  char ThreatStuff[16900];
  char field_47D8;
  char gap_47D9[50699];
  char MyOpponent[5];
  char gap_10DE9[4];
  char field_10DED;
  char field_10DEE;
  char field_10DEF;
  char field_10DF0;
  char field_10DF1;
  char field_10DF2;
  char field_10DF3;
  char field_10DF4;
  char field_10DF5;
  char field_10DF6;
  char field_10DF7;
  char field_10DF8;
  char field_10DF9;
  char field_10DFA;
  char field_10DFB;
  int ColorSchemeType;
  int field_10E00;
  DynamicVectorClass ConnectionPointArray;
  int ConnectionPoint;
  int field_10E20;
  char field_10E24;
  char field_10E25;
  char field_10E26;
  char field_10E27;
  int field_10E28;
  int field_10E2C;
  int field_10E30;
  int field_10E34;
  char field_10E38;
  char field_10E39;
  char field_10E3A;
  char field_10E3B;
  int field_10E3C;
  int field_10E40;
  int field_10E44;
  int field_10E48;
  char field_10E4C;
  char field_10E4D;
  char field_10E4E;
  char field_10E4F;
};
#pragma pack(pop)
*/
