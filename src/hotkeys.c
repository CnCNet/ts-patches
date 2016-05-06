#include "TiberianSun.h"
#include "macros/patch.h"

/* Use MapSnapshot as an example of how to create a new hotkey.
 * All CommandClass ptrs put in the NewHotKeys array will be loaded
 * into the global CommandClass vector and those are then loaded in
 * Load_Keyboard_Hotkeys
 */
CALL(0x004E6FA9, _HookInitCommands);

void __stdcall
HookInitCommands() {
  CommandClass *NewHotkeys[] = { &ChatToAlliesCommand,
                                 &ChatToAllCommand,
                                 &ChatToPlayerCommand,
                                 &TextBackgroundColorCommand,
#ifdef WWDEBUG
                                 &MultiplayerDebugCommand,
                                 &MapSnapshotCommand
#endif
                               };
  size_t len = sizeof(NewHotkeys)/sizeof((NewHotkeys)[0]);

  for (int i = 0; i < len; i++) {
    DynamicVectorClass__CommandClass__Add(&DynamicVectorClass__CommandClass, &(NewHotkeys[i]));
  }
  Load_Keyboard_Hotkeys();

  bool seen_all = 0, seen_allies = 0, seen_return = 0, seen_backspace = 0;
  // Loop through hotkeys and if chattoallis is not enabled then set it to backspace
  for (int i = 0; i < Hotkeys_ActiveCount; i++) {
    Hotkey key = Hotkeys_Vector[i];
    if (key.Command == &ChatToAlliesCommand) {
      seen_allies = 1;
      WWDebug_Printf("****************************Seen ChatToAllies\n");
    }

    if (key.Command == &ChatToAllCommand) {
      seen_all = 1;
      WWDebug_Printf("****************************Seen ChatToAll\n");
    }

    if (key.KeyCode == 0x8)
      seen_backspace = 1;

    if (key.KeyCode == 0xD)
      seen_return = 1;
  }
  if (!seen_allies && !seen_backspace) {
    WWDebug_Printf("****************************didn't see ChatToAllies adding as hotkey[%d]\n",Hotkeys_ActiveCount);
    if (Hotkeys_VectorMax <= Hotkeys_ActiveCount+1)
      CCINIClass_Vector_Resize(&Hotkeys, 10);
    Hotkeys_Vector[Hotkeys_ActiveCount].Command = &ChatToAlliesCommand;
    Hotkeys_Vector[Hotkeys_ActiveCount].KeyCode = 0x8;
    ++Hotkeys_ActiveCount;
  }

  if (!seen_all && !seen_return) {
    WWDebug_Printf("****************************didn't see ChatToAll adding as hotkey[%d]\n",Hotkeys_ActiveCount);
    Hotkeys_Vector[Hotkeys_ActiveCount].Command = &ChatToAllCommand;
    Hotkeys_Vector[Hotkeys_ActiveCount].KeyCode = 0x0D;
    ++Hotkeys_ActiveCount;
  }
}

void  __thiscall CommandDestroy(void *a, char b) { }

/* Start MapSnapshot */
void    __thiscall MapSnapshot_nothing(void *a) { }
char *  __thiscall MapSnapshot_Description(void *a) { return "Makes a .map file from the current game state."; }
char *  __thiscall MapSnapshot_INIname(void *a)     { return "MapSnapshot"; }
char *  __thiscall MapSnapshot_Category(void *a)    { return "Debug"; }
char *  __thiscall MapSnapshot_Name(void *a)        { return "MapSnapshot"; }

int     __thiscall MapSnapshot_Execute(void *a)     {
  char buf[100];
  _sprintf(buf, "MapSnapshot_%d_%d.map", GameIDNumber, Frame);
  MapSnapshot(buf, 1);
  return 1;
}

vtCommandClass vtMapSnapshotCommand = {
  CommandDestroy,
  MapSnapshot_INIname,
  MapSnapshot_Name,
  MapSnapshot_Category,
  MapSnapshot_Description,
  MapSnapshot_Execute,
  MapSnapshot_nothing
};
CommandClass MapSnapshotCommand = { &vtMapSnapshotCommand,0,17,17 };

/* End MapSnapshot */


/* Start ChatAllies */
void    __thiscall ChatToAllies_nothing(void *a)  { }
char *  __thiscall ChatToAllies_Description(void *a) { return "Send a message to all of your allies"; }
char *  __thiscall ChatToAllies_INIname(void *a)     { return "ChatToAllies"; }
char *  __thiscall ChatToAllies_Category(void *a)    { return "Chat"; }
char *  __thiscall ChatToAllies_Name(void *a)        { return "ChatToAllies"; }
int     __thiscall ChatToAllies_Execute(void *a)     { if (!PlayerPtr[0xCB]) ChatToAlliesFlag = 1; return 1; } // Defined in chatallies.asm

vtCommandClass vtChatToAlliesCommand = {
  CommandDestroy,
  ChatToAllies_INIname,
  ChatToAllies_Name,
  ChatToAllies_Category,
  ChatToAllies_Description,
  ChatToAllies_Execute,
  ChatToAllies_nothing
};
CommandClass ChatToAlliesCommand = { &vtChatToAlliesCommand,0,17,17 };
/* End ChatAllies */


/* Start ChatToAll */
void    __thiscall ChatToAll_nothing(void *a)  { }
char *  __thiscall ChatToAll_Description(void *a) { return "Send a message to all players, this setting doesn not override F8"; }
char *  __thiscall ChatToAll_INIname(void *a)     { return "ChatToAll"; }
char *  __thiscall ChatToAll_Category(void *a)    { return "Chat"; }
char *  __thiscall ChatToAll_Name(void *a)        { return "ChatToAll"; }
int     __thiscall ChatToAll_Execute(void *a)     { ChatToAllFlag = 1; return 1; } // Defined in chatallies.asm

vtCommandClass vtChatToAllCommand = {
  CommandDestroy,
  ChatToAll_INIname,
  ChatToAll_Name,
  ChatToAll_Category,
  ChatToAll_Description,
  ChatToAll_Execute,
  ChatToAll_nothing
};
CommandClass ChatToAllCommand = { &vtChatToAllCommand,0,17,17 };
/* End ChatAll */


/* Start ChatToPlayer */
void    __thiscall ChatToPlayer_nothing(void *a)  { }
char *  __thiscall ChatToPlayer_Description(void *a) { return "To send a message to a specific player press F1-F7. Changing this hotkey will not do anything."; }
char *  __thiscall ChatToPlayer_INIname(void *a)     { return "ChatToPlayer"; }
char *  __thiscall ChatToPlayer_Category(void *a)    { return "Chat"; }
char *  __thiscall ChatToPlayer_Name(void *a)        { return "ChatToPlayer"; }
int     __thiscall ChatToPlayer_Execute(void *a)     { return 1; }

vtCommandClass vtChatToPlayerCommand = {
  CommandDestroy,
  ChatToPlayer_INIname,
  ChatToPlayer_Name,
  ChatToPlayer_Category,
  ChatToPlayer_Description,
  ChatToPlayer_Execute,
  ChatToPlayer_nothing
};
CommandClass ChatToPlayerCommand = { &vtChatToPlayerCommand,0,17,17 };
/* End ChatAll */

/* Start MPDebugPrint */
void    __thiscall MultiplayerDebug_nothing(void *a)  { }
char *  __thiscall MultiplayerDebug_Description(void *a) { return "Enable Multiplayer debugging information"; }
char *  __thiscall MultiplayerDebug_INIname(void *a)     { return "MultiplayerDebug"; }
char *  __thiscall MultiplayerDebug_Category(void *a)    { return "Debug"; }
char *  __thiscall MultiplayerDebug_Name(void *a)        { return "MultiPlayerDebug"; }
int     __thiscall MultiplayerDebug_Execute(void *a)     { MultiplayerDebug ^= 1; return 1; }

vtCommandClass vtMultiplayerDebugCommand = {
  CommandDestroy,
  MultiplayerDebug_INIname,
  MultiplayerDebug_Name,
  MultiplayerDebug_Category,
  MultiplayerDebug_Description,
  MultiplayerDebug_Execute,
  MultiplayerDebug_nothing
};
CommandClass MultiplayerDebugCommand = { &vtMultiplayerDebugCommand,0,17,17 };
/* End MultiplayerDebug */

/* TextBackgroundColor */
void    __thiscall TextBackgroundColor_nothing(void *a)  { }
char *  __thiscall TextBackgroundColor_Description(void *a) { return "Toggle chat text background between clear and black"; }
char *  __thiscall TextBackgroundColor_INIname(void *a)     { return "TextBackgroundColor"; }
char *  __thiscall TextBackgroundColor_Category(void *a)    { return "Chat"; }
char *  __thiscall TextBackgroundColor_Name(void *a)        { return "TextBackgroundColor"; }
int     __thiscall
TextBackgroundColor_Execute(void *a)     {
  if (TextBackgroundColor == 0xC)
    TextBackgroundColor = 0;
  else
    TextBackgroundColor = 0xC;
  return 1;
}

vtCommandClass vtTextBackgroundColorCommand = {
  CommandDestroy,
  TextBackgroundColor_INIname,
  TextBackgroundColor_Name,
  TextBackgroundColor_Category,
  TextBackgroundColor_Description,
  TextBackgroundColor_Execute,
  TextBackgroundColor_nothing
};
CommandClass TextBackgroundColorCommand = { &vtTextBackgroundColorCommand,0,17,17 };
/* End */
