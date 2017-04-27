#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>



//CALL(0x0064D187, _show_stats);
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
                   width,str, surface, s_coord->left, s_coord->top, s_coord->width, s_coord->height);
    WWDebug_Printf("coord = (%d,%d,%d,%d),",
                   coord->left, coord->top, coord->width, coord->height);
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
        SidebarLoc.height += 153;
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
    INFO_PERFORMANCE = 0,
    INFO_UNIT = 1,
    INFO_NETWORK = 2,
};

uint32_t ShowNetwork(char **out, char **col2, int *width);
uint32_t ShowSelection(char **out, char **col2, int *width);
uint32_t ShowPerformance(char **out, char **col2, int *width);
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
    case INFO_UNIT: tpt = ShowSelection(&info, &col2, &width); break;
    case INFO_PERFORMANCE: tpt = ShowPerformance(&info, &col2, &width); break;
    case INFO_NETWORK: tpt = ShowNetwork(&info, &col2, &width); break;
    default: break;
    }

    Rect info_location = *location;
    info_location.width = width;
    if (info[0])
        Simple_Text_Print(&out_dim, info, surface, &info_location,
                          &zero_loc, 0, 0, tpt, 1);
    Rect location2 = *location;
    location2.left = location2.left + width + 4;
    location2.width = location->width - (width + 4);
    if (col2[0])
        Simple_Text_Print(&out_dim, col2, surface, &location2,
                          &zero_loc, 0, 0, tpt, 1);
}


uint32_t
ShowPerformance(char **out, char **col2, int *width)
{
    static char buf[256] = {0};
    static int32_t last_actions = 0;

    static char *col1 = "Time:\nFPS:\nAPM:\nEff:\n\nHotkeys:\n";
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

    static char KeyName[64];
    PrettyPrintKey(ShowHelpKey, KeyName);

    if (!ShowHelpKey)
        strcpy(KeyName, "<unset>");

    strncat(buf, "\n", 512);
    strncat(buf, KeyName, 512);
    return 0x6046;
}

uint32_t
ShowNetwork(char **out, char **col2, int *width)
{
    static char players[512];
    static char stats[512];
    static char pbuf[128];
    static char sbuf[128];
    strcpy(players, "Network\n");
    strcpy(stats, "rtt/loss\n");
    char *fmt = "%4d/%d\n";
    int32_t i = IPXManagerClass_this.NumConnections;

    for (; i-->0;)
    {
        IPXGlobalConnClass *p = IPXManagerClass_this.ConnectionArray[i];
        sprintf(pbuf, "%s\n", p->Name, 256);
        strncat(players, pbuf, 512);
        sprintf(sbuf, fmt,
                ResponseTimeFunc(p->CommBufferClass->AverageResponseTime),
                p->PercentLost);
        strncat(stats, sbuf, 512);
    }

    *out = players;
    *col2 = stats;
    *width = 70;
    return 0x6046;
}

uint32_t
ShowSelection(char **out, char **col2, int *width)
{
    static char buf[256] = {0};
    static char buf2[256] = {0};

    *width = 148;
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

void    __thiscall ToggleInfoPanel_nothing(void *a) { }
char *  __thiscall ToggleInfoPanel_Description(void *a) { return "Toggles the state of the information panel"; }
char *  __thiscall ToggleInfoPanel_INIname(void *a)     { return "ToggleInfoPanel"; }
char *  __thiscall ToggleInfoPanel_Category(void *a)    { return "Interface"; }
char *  __thiscall ToggleInfoPanel_Name(void *a)        { return "Toggle InfoPanel"; }

int     __thiscall ToggleInfoPanel_Execute(void *a)     {
    if (InfoPanel == -1)
    {
        FlagToReInit = 1;
    }

    if (InfoPanel >= 2)
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
