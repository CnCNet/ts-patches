/* int the .map/mpr file
   [AllyBySpawnLocation1]
   Description="East vs West"
   A=0,2
   B=1,3

   [AllyBySpawnLocation2]
   Description="North vs Sounth"
   A=0,3
   B=2,1

   In the spawn.ini
   [Settings]
   AllyBySpawnLocation=1
*/


#include "macros/patch.h"
#include "TiberianSun.h"
#include "macros/utlist.h"
#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

typedef struct house_ll {
  HouseClass *house;
  struct house_ll *next;
} house_ll;

house_ll *spawn_locations[8] = {0};
char TeamName_a[128] = {0};
wchar_t TeamName[128] = {0};

void __stdcall
store_house_spawn_location(HouseClass *house, int spawn) {
  if (!SpawnerActive)
    return;
  WWDebug_Printf("Storing house [0x%x] = %d\n", house, spawn);
  house_ll *new = (house_ll *)operator_new(sizeof(house_ll));
  new->house = house;
  new->next = 0;
  LL_APPEND(spawn_locations[spawn], new);
}

void __stdcall
ally_by_spawn_location(INIClass scenario) {
  // We're intercepting a call to Random2Class__operator(a1,a2,a3);
  // just passing those args right through in the return statement of this function

  if (!SpawnerActive)
    return;

  WOL_SERVER_PORT = (char **)&TeamName;
  char buf[128] = {0};
  char AllyEntry[128] = {0};
  WWDebug_Printf("Starting Auto Allier\n");

  int id = INIClass__GetInt(INIClass_SPAWN, "Settings", "AllyBySpawnLocation",-1);
  if (id == -1) {
    WWDebug_Printf("AllyBySpawnLocation= not found in spawn.ini [Settings]\n");
    return;
  }

  _sprintf(AllyEntry, "AllyBySpawnLocation%d",id);

  WWDebug_Printf("Allier using [%s]\n",AllyEntry);

  for (
       int i = INIClass__EntryCount(scenario, AllyEntry);
       i-->0;
       ) {

    char *EntryName  = INIClass__GetEntry(scenario, AllyEntry, i);
    int len = INIClass__GetString(scenario, AllyEntry, EntryName, 0, buf, 128);

    if (len == 0)
      continue;

    if (strcmp(EntryName, "Description") == 0) {
      WWDebug_Printf("[AllyBySpawn] Description Seen\n");
      continue;
    }
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

            if (house1->house == PlayerPtr) {
              _sprintf(TeamName_a, "TS-%d-%s", GameIDNumber, EntryName);
              MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, TeamName_a, 128, TeamName, 128);
              WWDebug_Printf("My team name string = %s\n", TeamName_a);
            }

            HouseClass__Make_Ally_House(house1->house, house2->house);
          }
        }
      }
    }

  }
  // Could have some operator_delete (aka free()) here but it's not much memory
  // spawn_locations[] and spawn_ll leak
  return;
}
void __stdcall
set_team_spec() {
  _sprintf(TeamName_a, "TS-%d-%s", GameIDNumber, "Spectator");
  MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, TeamName_a, 128, TeamName, 128);
  WWDebug_Printf("Set TeamName to %s\n", TeamName_a);
}

void __stdcall
set_team_name(char *s) {
  _sprintf(TeamName_a, "TS-%d-%s", GameIDNumber, s);
  MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, TeamName_a, 128, TeamName, 128);
  WWDebug_Printf("Set TeamName to %s\n", TeamName_a);
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
