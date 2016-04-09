/* file spawn.ini
   [AllyBySpawnLocation]
   A=0,1
   B=2
   C=3,4,5
   D=7,6
*/




#include "macros/patch.h"
#include "TiberianSun.h"
#include "macros/utlist.h"
#include <stdio.h>
#include <stdlib.h>

typedef struct house_ll {
  HouseClass *house;
  struct house_ll *next;
} house_ll;

house_ll *spawn_locations[8] = {0};

void __stdcall
store_house_spawn_location(HouseClass *house, int spawn) {
  WWDebug_Printf("Storing house [0x%x] = %d\n", house, spawn);
  house_ll *new = (house_ll *)operator_new(sizeof(house_ll));
  new->house = house;
  new->next = 0;
  LL_APPEND(spawn_locations[spawn], new);
}
CALL(0x005DEF40,_ally_by_spawn_location);

int32_t __thiscall
ally_by_spawn_location(void *a1, int32_t a2, int32_t a3) {
  // We're intercepting a call to Random2Class__operator(a1,a2,a3);
  // just passing those args right through in the return statement of this function

  char *str_AllyBySpawn = "AllyBySpawnLocation";
  char buf[128] = {0};
  WWDebug_Printf("Starting Auto Allier\n");

  for (
       int i = INIClass__EntryCount(INIClass_SPAWN, str_AllyBySpawn);
       i-->0;
       ) {

    char *EntryName  = INIClass__GetEntry(INIClass_SPAWN, str_AllyBySpawn, i);
    int len = INIClass__GetString(INIClass_SPAWN, str_AllyBySpawn, EntryName, 0, buf, 128);

    if (len == 0)
      continue;

    int_ll *loc1, *loc2, *loc1_tmp, *loc2_tmp, *spawn_ll = NULL;;
    house_ll *house1, *house2, *h1_tmp, *h2_tmp;

    // Parse the integer list from char *buf into spawn_ll
    ParseIntLL(buf, &spawn_ll);

    /* This seems overly complicated but considering there can be more than one house
     * at each spawn location and ::Make_Ally_House is a unidirectional function so it
     * needs to be executed twice for a complete allyship
     */
    LL_FOREACH_SAFE(spawn_ll, loc1, loc1_tmp) {

      LL_FOREACH_SAFE(spawn_ll, loc2, loc2_tmp) {

        LL_FOREACH_SAFE(spawn_locations[loc1->v], house1, h1_tmp) {

          LL_FOREACH_SAFE(spawn_locations[loc2->v], house2, h2_tmp) {

            if (house1->house == house2->house)
              continue;
            HouseClass__Make_Ally_House(house1->house, house2->house);
          }
        }
      }
    }

  }
  // Could have some operator_delete (aka free()) here but it's not much memory
  // spawn_locations[] and spawn_ll leak

  // Finish the intercepted call
  return Random2Class__operator(a1,a2,a3);
}

void
ParseIntLL(char *ent, int_ll **head) {

  ent[128]='\0';
  WWDebug_Printf("AutoAlly String = %s\n", ent);
  int32_t val;
  char *sep = ",";

  for (char *number = strtok(ent, sep);
       number != NULL;
       number = strtok(NULL, sep)) {
    WWDebug_Printf("Tokenized = %s\n", number);
    int_ll *n = (int_ll *) operator_new(sizeof(int_ll));
    n->v = atoi(number);
    LL_APPEND(*head, n);
  }
}
