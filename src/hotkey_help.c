#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>

CALL(0x004B966C, _MessageListClass__Draw_show_stats2);

// Disable the help overlay when the menu has been openened
CALL(0x0050947D, _Queue_Options_No_Help);
CALL(0x00508E94, _Queue_Options_No_Help);
CALL(0x00509645, _Queue_Options_No_Help);
CALL(0x00509758, _Queue_Options_No_Help);
CALL(0x0060E9EC, _Queue_Options_No_Help);
CALL(0x0060EA76, _Queue_Options_No_Help);
LJMP(0x004EA230, _Queue_Options_No_Help);

char category[512];
char name[512];
char key[512];

bool ShowHelp = false;
bool Refresh = true;
Rect location;
Rect cat_loc;
Rect name_loc;
Rect key_loc;

#define HELP_PADDING 4
#define CAT_COL_WIDTH 80
#define NAME_COL_WIDTH 140
#define KEY_COL_WIDTH 120
#define HELP_TOTAL_WIDTH (CAT_COL_WIDTH + NAME_COL_WIDTH + KEY_COL_WIDTH)
#define HELP_TOTAL_HEIGHT 470

uint32_t ShowHotkeys(char **out, char **col2, int *width);
vtCommandClass vtShowHelpCommand;

int ShowHelpKey;
void Queue_Options_No_Help()
{
    ShowHelp = false;
    Queue_Options();
}

void __thiscall
MessageListClass__Draw_show_stats2(void *this)
{
    static Rect zero_loc = {0,0,0,0};

    XYCoord out_dim;
    int tpt = 0x6046;

    if (Refresh)
    {
        InfoPanelHotkeysInit();
        Refresh = false;
        //location = (Rect){ 0, 10, 492, 470 };
        cat_loc = (Rect){ location.left + HELP_PADDING, location.top + HELP_PADDING,
                          CAT_COL_WIDTH, location.height };

        name_loc = (Rect){ cat_loc.left + cat_loc.width, cat_loc.top, NAME_COL_WIDTH, cat_loc.height };

        key_loc = (Rect){ name_loc.left + name_loc.width, name_loc.top, KEY_COL_WIDTH, cat_loc.height };
    }
    if (ShowHelp)
    {
        DSurface_FillRect(TempSurface, &location, 0);
        if (category)
            Simple_Text_Print(&out_dim, category, TempSurface, &cat_loc,
                              &zero_loc, 0, 0, tpt, 1);
        if (name)
            Simple_Text_Print(&out_dim, name, TempSurface, &name_loc,
                              &zero_loc, 0, 0, tpt, 1);
        if (key)
            Simple_Text_Print(&out_dim, key, TempSurface, &key_loc,
                              &zero_loc, 0, 0, tpt, 1);
    }
    MessageListClass__Draw(this);
}

void
InfoPanelHotkeysInit()
{
    static vtCommandClass *search_keys[] = {
        &vtToggleInfoPanelCommand,
        &vtChatToAlliesCommand,
        &vtChatToAllCommand,
        &AllianceCommandClass,
        &GuardCommandClass,
        &DeployCommandClass,
        &StopCommandClass,
        &ScatterCommandClass,
        &SelectSameTypeCommandClass,
        &SelectViewCommandClass,
        &ToggleRepairCommandClass,
        &ToggleSellCommandClass,
        &TogglePowerCommandClass,
        &WaypointCommandClass,
        &DeleteWayPointCommandClass,
#ifndef VINIFERA
        &vtPlaceBuildingCommand,
        &vtRepeatBuildingCommand,
#endif
        &CenterBaseCommandClass,
        &SetView1CommandClass,
        &vtShowHelpCommand
    };

    location.left = MAX(0, (ViewPortRect.width/2) - (HELP_TOTAL_WIDTH/2));
    location.top =  MAX(0, (ViewPortRect.height/2) - (HELP_TOTAL_HEIGHT/2));
    location.width = MIN(ViewPortRect.width, HELP_TOTAL_WIDTH);
    location.height = MIN(ViewPortRect.height, HELP_TOTAL_HEIGHT);

    static int search_keys_len = sizeof(search_keys)/sizeof(vtCommandClass *);
    static Hotkey *found_keys[sizeof(search_keys)/sizeof(vtCommandClass *)];

    for (int i = 0; i < Hotkeys_ActiveCount; i++)
    {
        Hotkey *key = &(Hotkeys_Vector[i]);
        for (int j = 0; j < search_keys_len; j++)
        {
            if (key->Command->vftable == search_keys[j])
                found_keys[j] = key;
        }
    }

    sprintf(category, "%s",
            "Category\n"
             "Builtin\n"
             "Builtin\n"
             "Builtin\n"
             "Builtin\n"
             "Builtin\n"
             "Builtin\n"
             "Builtin\n");
    sprintf(name, "%s",
            "Name\n"
            "Action\n"
            "Speed Scroll\n"
            "Force Attack\n"
            "Force Move\n"
            "Guard Area At\n"
            "Queue Moves\n"
            "Moving Fire\n");
    sprintf(key, "%s",
            "Key\n"
            "L_Click\n"
            "R_Click+Drag\n"
            "Ctrl+L_Click\n"
            "Alt+L_Click\n"
            "Ctrl+Alt+Click\n"
            "Q\n"
            "Q\n");

    char KeyName[64];
    char fmtKey[128];
    char fmtName[128];
    char fmtCat[128];
    for (int i = 0; i < search_keys_len; i++)
    {
        if (found_keys[i])
        {
            PrettyPrintKey(found_keys[i]->KeyCode, KeyName);

            sprintf(fmtKey, "%s\n", KeyName);
            strncat(key, fmtKey, 512);
        }
        else {
            sprintf(fmtKey, "<unset>\n", KeyName);
            strncat(key, fmtKey, 512);
        }
        sprintf(fmtName, "%s\n", search_keys[i]->Name('\0'));
        strncat(name, fmtName, 512);

        sprintf(fmtCat, "%s\n", search_keys[i]->Category('\0'));
        strncat(category, fmtCat, 512);
    }
}


void    __thiscall ShowHelp_nothing(void *a) { }
char *  __thiscall ShowHelp_Description(void *a) { return "Toggles the help screen"; }
char *  __thiscall ShowHelp_INIname(void *a)     { return "ShowHelp"; }
char *  __thiscall ShowHelp_Category(void *a)    { return "Interface"; }
char *  __thiscall ShowHelp_Name(void *a)        { return "Toggle Help"; }

int     __thiscall ShowHelp_Execute(void *a)     {
    if (ShowHelp)
        ShowHelp = false;
    else {
        ShowHelp = true;
        Refresh = true;
    }
}

vtCommandClass vtShowHelpCommand = {
  CommandDestroy,
  ShowHelp_INIname,
  ShowHelp_Name,
  ShowHelp_Category,
  ShowHelp_Description,
  ShowHelp_Execute,
  ShowHelp_nothing
};
CommandClass ShowHelpCommand = { &vtShowHelpCommand,0,17,17 };


/* menu info:
   bar_ll.pcx
   bar_lr.pcx
   bar_ul.pcx
   bar_ur.pcx
   leftbar.pcx
   rightbar.pcx
   dbak6440.pcx
*/
