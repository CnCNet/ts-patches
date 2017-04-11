#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>



//CALL(0x0064D187, _show_stats);
//CALL(0x004B966C, _MessageListClass__Draw_show_stats);
CALL(0x0060E681, _MessageListClass__Draw_show_stats);
extern int32_t PlayerEventCounts[8];
extern int32_t PlayerEventLastFrame[8];

extern Rect InfoPrintLocation;
bool FlagToReInit;

typedef struct SidebarClass {
    char gap_0[0x14C1];
    char Redraw_Radar2;
    char Redraw_Radar1;
    char gap_14C3[0x31];
    char Redraw_Power1;
    char gap_14F5[0x7E0];
    char Redraw_Sidebar1;
    char field_1CD6;
    char Redraw_Sidebar2;
    char Redraw_Sidebar3;
} SidebarClass;

void __fastcall
show_stats(int32_t *width, char *str, void *surface, Rect *s_coord, Rect *coord,
           int32_t *color, int32_t bg_color, int32_t TextPrintType, int32_t a9)
{
    WWDebug_Printf("%x,%s, surface = %x, s_coord = (%d,%d,%d,%d),",
                   width,str, surface, s_coord->left, s_coord->top, s_coord->right, s_coord->bottom);
    WWDebug_Printf("coord = (%d,%d,%d,%d),",
                   coord->left, coord->top, coord->right, coord->bottom);
    WWDebug_Printf(" color = %d, bg_color = %x, TextPrintType = %x, a9 = %x\n",
                   *color, bg_color, TextPrintType, a9);

}

typedef struct CC_Draw_Shape_Args
{
    DSurface *surface; void *palette; Image *image;
    int32_t frame; XYCoord *a5; Rect *position;
    int32_t a6; int32_t a7; int32_t a8; int32_t a9;
    int32_t tint; Image *z_shape; int32_t z_frame;
    int32_t a13; int32_t where;
} CC_Draw_Shape_Args;

CC_Draw_Shape_Args IPanelArgs;

void __thiscall
MessageListClass__Draw_show_stats(MouseClass *this, char a2)
{
    if (FlagToReInit)
    {
        FlagToReInit = 0;
        SidebarLoc.bottom += 153;
        SidebarClass__Init_IO(&MouseClass_Map);
        SidebarClass__Init_For_House(&MouseClass_Map);
    }
    if ((Frame % 45) == 0)
    {
        SidebarClass *sidebar = (SidebarClass *)&MouseClass_Map;
        //sidebar->Redraw_Sidebar1 = true;
        //sidebar->Redraw_Sidebar3 = true;
        sidebar->Redraw_Sidebar2 = true; //*
        //sidebar->Redraw_Radar2 = true;
        //sidebar->Redraw_Radar1 = true;
        //sidebar->Redraw_Power1 = true;
        //sidebar->field_1CD6 = true;
        //SidebarClass_Redraw_Buttons = true;
        //WWDebug_Printf("Call CC_Draw_Shape\n");
    }
    SidebarClass__Draw_It(this, a2);
}

enum InfoPanelTypes {
    INFO_NONE = -1,
    INFO_HOTKEYS = 0,
    INFO_UNIT = 1,
    INFO_PERFORMANCE = 2,
    INFO_NETWORK = 3,
};

uint32_t ShowNetwork(char **out, char **col2, int *width);
uint32_t ShowSelection(char **out, char **col2, int *width);
uint32_t ShowPerformance(char **out, char **col2, int *width);
uint32_t ShowHotkeys(char **out, char **col2, int *width);
vtCommandClass vtToggleInfoPanelCommand;

void
ShowInfo(DSurface *surface, Rect *location)
{
    XYCoord out_dim;
    Rect zero_loc = {0,0,0,0};

    char *info = "";
    char *col2 = "";
    int width = 0;
    uint32_t tpt;

    switch(InfoPanel)
    {
    case INFO_NONE: return;
    case INFO_HOTKEYS: tpt = ShowHotkeys(&info, &col2, &width); break;
    case INFO_UNIT: tpt = ShowSelection(&info, &col2, &width); break;
    case INFO_PERFORMANCE: tpt = ShowPerformance(&info, &col2, &width); break;
    case INFO_NETWORK: tpt = ShowNetwork(&info, &col2, &width); break;
    default: break;
    }

    //WWDebug_Printf(info);
    if (info[0])
        Simple_Text_Print(&out_dim, info, surface, location,
                          &zero_loc, 0, 0, tpt, 1);
    Rect location2 = *location;
    location2.left = width;
    if (col2[0])
        Simple_Text_Print(&out_dim, col2, surface, &location2,
                          &zero_loc, 0, 0, tpt, 1);
}


uint32_t
ShowPerformance(char **out, char **col2, int *width)
{
    static char buf[256] = {0};
    static int32_t last_actions = 0;

    static char *col1 = "Game:\nFPS:\nAPM:\nEff:\n";
    static char *sfmt =
        "%d:%02d:%02d\n"
        "%d\n"
        "%.f\n"
        "%.f\n";

    *out = col1;
    *col2 = buf;
    *width = 70;

    if ((Frame % 45) != 0)
        return 0x6046;


    int32_t gameSeconds = Frame/45;
    int32_t gameMinutes = gameSeconds/60;
    int32_t gameHours = gameMinutes/60;

    // Calculate average APM
    double apm = (double)PlayerEventCounts[PlayerPtr->ID]/(Frame+1) * 3600;
    double eff = (double)PlayerPtr->PointsScoredMaybe/(Frame+1) * 3600;

    double p_apm = apm - 27 <= 0 ? 0 : apm - 27.0;

    sprintf(buf, sfmt, gameHours, gameMinutes % 60, gameSeconds % 60,
            FramesPerSecond, p_apm, eff);

    return 0x6046;
}

uint32_t
ShowNetwork(char **out, char **col2, int *width)
{
    static char players[512];
    static char stats[512];
    static char pbuf[128];
    static char sbuf[128];
    strcpy(players, "Net  latency/lost\n");
    strcpy(stats, "\n");
    char *fmt = "%4d/%d\n";
    int32_t i = IPXManagerClass_this.NumConnections;

    for (; i-->0;)
    {
        IPXGlobalConnClass *p = IPXManagerClass_this.ConnectionArray[i];
        sprintf(pbuf, "%-6.6s\n", p->Name, 256);
        strncat(players, pbuf, 512);
        //strncat(bigbuf, p->Name, 256);
        sprintf(sbuf, fmt,
                ResponseTimeFunc(p->CommBufferClass->AverageResponseTime),
                p->PercentLost);
        strncat(stats, sbuf, 512);
    }

    *out = players;
    *col2 = stats;
    *width = 78;
    return 0x6046;
}

uint32_t
ShowSelection(char **out, char **col2, int *width)
{
    static char buf[256] = {0};
    static char buf2[256] = {0};

    ObjectClass *unit;
    if (CurrentObjectsArray.ActiveCount > 0)
    {
        unit = CurrentObjectsArray.Vector[0];
        char *name = "";
        ObjectTypeClass *type = (ObjectTypeClass *)unit->vftable->Class_Of(unit);
        if (type)
            name = type->a.UIName;

        char *fmt = "%.17s\n"
            "HP: %d/%d\n"
            "Speed: %.2f\n"
            "Weapon: %.2f\n"
            "WpnBonus: %.2f\n"
            "AmrType: %%s\n"
            "ArmorBonus: %%.2f\n"
            "Veteran: %%.2f\n";
        sprintf(buf, fmt, name, unit->p.Strength, type->Strength);
        if (Is_Techno((AbstractClass *)unit))
        {
            TechnoTypeClass *technotype = (TechnoTypeClass *)type;
            TechnoClass *techno = (TechnoClass *)unit;
            double p_speed = (double)technotype->Speed/2.5;

            if (Is_Foot((AbstractClass *)unit))
                p_speed *= ((FootClass *)techno)->p.SpeedMultiplier;

            if (technotype->Primary.WeaponType)
            {

                sprintf(buf, fmt, name, techno->p.r.m.o.Strength,
                        technotype->o.Strength,
                        p_speed,
                        (double)
                        technotype->Primary.WeaponType->Damage *
                        technotype->Primary.WeaponType->Burst /
                        technotype->Primary.WeaponType->ROF * 45,
                        techno->p.FirePowerBonus - 1.0);
                sprintf(buf2, buf, ArmorNames[type->Armor],
                        techno->p.ArmorBonus - 1.0,
                        techno->p.Veterancy);
            }
            else {
                sprintf(buf, fmt, name, techno->p.r.m.o.Strength,
                        technotype->o.Strength,
                        p_speed, 0,
                        techno->p.FirePowerBonus - 1
                        );
                sprintf(buf2, buf, ArmorNames[type->Armor],
                        techno->p.ArmorBonus - 1.0,
                        techno->p.Veterancy);
            }
        }
        else {
            sprintf(buf2, fmt, name, unit->p.Strength, type->Strength,
                    0.0, 0.0, 0.0, ArmorNames[type->Armor], 0.0, 0.0);
        }
        *out = buf2;
    }
    else {
        static char *empty = "Nothing Selected\n"
            "HP:    /\n"
            "Speed:\n"
            "Weapon:\n"
            "WpnBonus:\n"
            "AmrType:\n"
            "ArmorBonus:\n"
            "Veteran:\n";
        *out = empty;
    }
    return 0x6046;
}


char hk_buf[512];
char hk_descr_buf[512];
uint32_t
ShowHotkeys(char **out, char **out2, int *width)
{
    *out = hk_descr_buf;
    *out2 = hk_buf;
    *width = 86;
    return 0x6049;
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
        &ToggleSellCommandClass,
        &DeployCommandClass,
        &StopCommandClass,
        &CenterBaseCommandClass,
        &SelectViewCommandClass,
        &ToggleRepairCommandClass,
        &WaypointCommandClass,
        &SelectSameTypeCommandClass,
    };
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

    strncat(hk_descr_buf,
            "SpeedScroll\n"
            "ForceAttack\n"
            "ForceMove\n"
            "GuardArea\n"
            "QueueMoves\n",
            512);
    strncat(hk_buf,
            "R_Click+Drag\n"
            "Ctrl+L_Click\n"
            "Alt+L_Click\n"
            "Ctrl+Alt+Click\n"
            "Q\n",
            512);

    char KeyName[64];
    char fmtKey[128];
    char fmtDescr[128];
    for (int i = 0; i < search_keys_len; i++)
    {
        if (found_keys[i])
        {
            PrettyPrintKey(found_keys[i]->KeyCode, KeyName);

            sprintf(fmtKey, "%s\n", KeyName);
            strncat(hk_buf, fmtKey, 512);
        }
        else {
            sprintf(fmtKey, "<unset>\n", KeyName);
            strncat(hk_buf, fmtKey, 512);
        }
        sprintf(fmtDescr, "%-14.14s\n", search_keys[i]->ININame('\0'));
        strncat(hk_descr_buf, fmtDescr, 512);
    }
}

void    __thiscall ToggleInfoPanel_nothing(void *a) { }
char *  __thiscall ToggleInfoPanel_Description(void *a) { return "Toggles the state of the information panel"; }
char *  __thiscall ToggleInfoPanel_INIname(void *a)     { return "ToggleInfoPanel"; }
char *  __thiscall ToggleInfoPanel_Category(void *a)    { return "Interface"; }
char *  __thiscall ToggleInfoPanel_Name(void *a)        { return "ToggleInfoPanel"; }

int     __thiscall ToggleInfoPanel_Execute(void *a)     {
    if (InfoPanel == -1)
    {
        FlagToReInit = 1;
    }

    if (InfoPanel >= 3)
    {
        InfoPanel = -1;
        FlagToReInit = 1;
    }
    else {
        InfoPanel++;
    }

    ((SidebarClass *)&MouseClass_Map)->Redraw_Sidebar2 = true;
}

vtCommandClass vtToggleInfoPanelCommand = {
  CommandDestroy,
  ToggleInfoPanel_INIname,
  ToggleInfoPanel_Name,
  ToggleInfoPanel_Category,
  ToggleInfoPanel_Description,
  ToggleInfoPanel_Execute,
  ToggleInfoPanel_nothing
};
CommandClass ToggleInfoPanelCommand = { &vtToggleInfoPanelCommand,0,17,17 };
