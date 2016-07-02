#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

/*
  typedef struct TutorialStruct {
    int32_t ID;
    char *Text;
  } TutorialStruct;
*/

size_t resize_tut_vector(size_t addElems);
size_t upsert_tut(int32_t ID, char *Text);

void __stdcall
read_tut_from_map(INIClass scenario) {

  if (!SpawnerActive)
    return;

  char buf[300];

  for (int i = INIClass__EntryCount(scenario, "Tutorial");
       i-->0; ) {
    char *EntryName  = INIClass__GetEntry(scenario, "Tutorial", i);
    int32_t ID = atoi(EntryName);

    int len = INIClass__GetString(scenario, "Tutorial", EntryName, 0, buf, 300);
    char *Text = strdup(buf);

    int el = upsert_tut(ID, Text);

    WWDebug_Printf("New Tutorials[%d] = { %d, %s }\n",el, ID, Text);
  }
}

size_t
upsert_tut(int32_t ID, char *Text) {
  // Update the tutorial at ID or insert new tutorial with ID,Text
  int index, i = 0;
  TutorialStruct *tuts = Tutorials;
  for (i = 0; i < TutorialActiveCount; i++) {
    if (tuts[i].ID == ID) {
      tuts[i].Text = Text;
      index = i;
      break;
    }
  }
  if (i >= TutorialActiveCount) {
    if (TutorialActiveCount + 1 > TutorialMax) {
      resize_tut_vector(10);
      tuts = Tutorials;
    }
    index = TutorialActiveCount + 1;
    tuts[index].ID = ID;
    tuts[index].Text = Text;
  }
  return index;
}

size_t
resize_tut_vector(size_t addElems) {

  size_t new_size = sizeof(TutorialStruct) * (TutorialMax + addElems);

  TutorialStruct *new_tutorials = operator_new(new_size);

  for (int i = 0; i < TutorialActiveCount; i++) {
    new_tutorials[i].ID = Tutorials[i].ID;
    new_tutorials[i].Text = Tutorials[i].Text;
  }

  Tutorials = new_tutorials;
  TutorialMax = new_size;
  return new_size;

}
