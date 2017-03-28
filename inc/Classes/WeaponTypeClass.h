#pragma pack(push, 1)

typedef struct WeaponTypeClass
{
  AbstractTypeClass a;
  int AmbientDamage;
  int Burst;
  int Projectile;
  int Damage;
  int Speed;
  void *Warhead;
  int ROF;
  int Range;
  int ProjectileRange;
  int BurstDelay1;
  int BurstDelay2;
  int BurstDelay3;
  int BurstDelay4;
  int MinimumRange;
  TypeList Report;
  TypeList Anim;
  int AttachedParticleSystem;
  RGB LaserInnerColor;
  RGB LaserOuterColor;
  RGB LaserOuterSpread;
  char UseFireParticles;
  char UseSparkParticles;
  char IsRailgun;
  char Lobber;
  char Bright;
  char LaserDuration;
  char IsBigLaser;
  char IsSonic;
  char TurboBoost;
  char Supress;
  char Camera;
  char Charges;
  char IsLaser;
  char IonSensitive;
  char field_EB;
} WeaponTypeClass;

typedef struct WeaponStruct
{
  WeaponTypeClass *WeaponType;
  FLHStruct FireFLH;
  int BarrelLength;
  int BarrelThickness;
} WeaponStruct;

#pragma pack(pop)
