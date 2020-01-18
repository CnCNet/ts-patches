#include <windows.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"

CALL(0x00462EEB, _fake_MessageListClass__Concat_Message);

bool IgnoredColors[256];

static const char Whitelist[][24] = {
    "tl ", "ml ", "bl ", "bm ", "br ", "mr ", "tr ", "tm ", "base ", "main ", "home ", "help ",
    "sos ", "cy ", "mcv ", " north ", "south ", "east ", "west ", "top left", "middle left",
    "bottom left", "bottom middle", "bottom right ", "middle right ", "top right ", "top middle",
    "top ", "middle ", "bottom ", "mid ", "left ", "right ", "up ", "down ", "go ", "wait ", "stop ",
    "hurry ", "yellow ", "blue ", "green ", "sky blue", "light blue ", "purple ", "pink ", "orange",
    "gold ", "red ", "nod ", "gdi ", "ally ", "me ", "titan ", "tank ", "harpy ", "orca ", "dis ",
    "disruptor ", "engie ", "eng ", "cyborg ", "light ", "infantry ", "medic ", "rocket ", "man ",
    "men ", "you ", "wolv", "wolverine ", "art ", "artillery ", "mlrs ", "hover ", "bike ", "msa ",
    "mobile sensor array ", "spare ", "make ",  "eco ", "economy ", "1 ", "2 ", "3 ", "4 ", "5 ",
    "6 ", "many ", "lot ", "ton ", "refinery ", "pp ", "power ", "plant ", "bar ", "barracks ", 
    "laser ", "obelisk ", "tower ", "turret ", "rpg ", "spec ", "specs ", "gate ", "pave ", 
    "pavement ", "sam ", "sams ", "carry  ", "carryall ", "air ", "ban ",  "banshee ", "bans ", 
    "bomb ", "bombs ", "bomber ", "bombers ", "buggy ", "scout ", "scouts ", "some ", "many ", "lots ", 
    "small ", "little ", "massive ", "massa ", "n1 ", "nice ", "one ", "two ", "three ", "four ", "five ", 
    "six ", "quick ", "fast ", "good ", "good job", "need ", "amazing ", "wonderful ", "well done ", 
    "gg ", "good game ", "well played ", "wp ", "laser fence ", "firestorm ", "fs", "wall ", "walls ", 
    "break ", "sell ", "repair ", "expand ", "exp ", "expo ", "send ", "send all ", "send out ", "out ", 
    "in ", "take ", "hijack ", "hijacker ", "hj ", "apc ", "sub ", "sub apc", "water ", "bridge ", 
    "river ", "vein ", "veins ", "chem ", "chems ", "chemical ", "missile ", "ion ", "seeker ", 
    "upgrade center ", "upgrade ", "tech ", "tech center ", "service ", "service depot ", "depot ", 
    "pave ", "pavement ", "fly ", "stellar ", "ref ", "hand ", "hand of nod", "hon ", "barr ", "arts ", 
    "deploy ", "dep ", "use ", "your ", "my ", "you ", "me ", "gs ", "ghost ", "ghost stalker ", 
    "stalker ", "cc ", "cyborg commando ", "commando ", "jj ", "jump jet", "mk ", "mammoth ", "mk2 ", 
    "mkii ", "mam ", "mamm ", "mammy ", "tits ", "tit ", "harv ", "harvester ", "harvy ", "harvys ", 
    "retreat ", "back ", "purp ", "sensor ", "med ", "bug ", "shroud ", "ton ", "temple ", 
    "temple of nod ", "teched ", "pad ", "wf ", "war factory ", "war ", "bunk ", "spares ", "disc ", 
    "discmen ", "disc throwers ", "discs ", "light infantry ", "light inf ", "wow ", "don't ", "dont ", 
    "give up ", "try ", "trying ", "keep ", "long ", "short ", "rush ", "mass ", "grant ", "control ", 
    "give ", "defend ", "def ", "defence ",  "low ", "all ", "idle ", "\0" };


BOOL __thiscall fake_MessageListClass__Concat_Message(
    MessageListClass *this, char *name, int color, char *message, int unknown)
{
    if (MessageListClass__Concat_Message(this, name, color, message, unknown))
        return TRUE;
    
    uint8_t col = (uint8_t)color;

    if (IgnoredColors[col])
    {
        char *mes = message;

        if(strstr(message, &str_ToAllies) == message)
            mes += strlen(&str_ToAllies);
        else if(strstr(message, &str_ToAll) == message)
            mes += strlen(&str_ToAll);
        else if(strstr(message, &str_ToOne) == message)
            mes += strlen(&str_ToOne);
        else if(strstr(message, &str_ToSpectators) == message)
            mes += strlen(&str_ToSpectators);
        
        for (int i = 0; Whitelist[i][0]; i++)
        {
            if (__strcmpi(mes, Whitelist[i]) == 0)
                return FALSE;
        }
        
        return TRUE;
    }
    
    return FALSE;
}
