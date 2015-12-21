
struct ColorSchemeType {
  char unknown[0x304];
  char *ColorSchemeName;
  struct { uint8_t h; uint8_t s; uint8_t v; uint8_t pad; } HSV;
  int32_t LightConvertObject;
  int32_t SchemeIndex;
  char unknown2[0x24];
};

struct ColorSchemeVector {
  char dont_care[4];
  struct ColorSchemeType **Vector;
  int32_t VectorMax;
  int8_t IsValid;
  int8_t IsAllocated;
  int16_t VectorClassPad;
  int32_t ActiveCount;
  int32_t GrowthStep;
};
extern struct ColorSchemeVector ColorSchemesArray;
