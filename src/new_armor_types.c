/* Guarding still doesn't work right
   need to wort out weapontypeclass::compute_crc
   Crashes at Eip:00460200
 */
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

#define ArmorNameMAX 10
char *ArmorTypes[64];
char ArmorNames[64 * ArmorNameMAX] = {0};

SETDWORD(0x0044AF67, _ArmorTypes);
SETDWORD(0x0044AFA7, _ArmorTypes);
SETDWORD(0x00487071, _ArmorTypes);
SETDWORD(0x0068132C, _ArmorTypes);
SETDWORD(0x00681346, _ArmorTypes + 64 * 4);

CALL(0x005C6A19, _RulesClass__ArmorTypes);

void __thiscall
RulesClass__ArmorTypes(void *this, INIClass ini) {

  int count = INIClass__EntryCount(ini, "ArmorTypes");

  if (count == 0) {
    ArmorTypes[0] = "none";
    ArmorTypes[1] = "wood";
    ArmorTypes[2] = "light";
    ArmorTypes[3] = "heavy";
    ArmorTypes[4] = "concrete";
  }

  char number[4] = "1";
  char *dest;

  for (int i = 0; i < 64; i++) {
    if (ArmorTypes[i])
      continue;
    _sprintf(number, "%d", i);
    dest = &ArmorNames[i*ArmorNameMAX];

    INIClass__GetString(ini, "ArmorTypes", number, number, dest,
                        ArmorNameMAX);
    WWDebug_Printf("armor[%d] = %s\n",i,dest);
    dest[ArmorNameMAX] = '\0';
    ArmorTypes[i] = dest;
  }

  return RulesClass__Objects(this, ini);
}

//CLEAR(0x0066EEE1, 0x4D, 0x0066EEE2);//lea ecx, [ebp+0x68]
//CLEAR(0x0066EEE8, 0x90, 0x0066EEF4);
//CALL(0x0066EEE3, _WarheadTypeClass__init_versus);

void __thiscall
WarheadTypeClass__init_versus(double **versus) {

  WWDebug_Printf("Warhead versus @ %00000000x\n", versus);
  double *versus_buf =  operator_new(64*sizeof(double));
  for (int i = 0; i < 64; i++)
    versus_buf[i] = 1.0;
  *versus = versus_buf;
}
void
WTF(char *warhead) {
  WWDebug_Printf("Basename = %s, UIName = %s\n", warhead[0x14],
                 warhead[0x2D]);
}
