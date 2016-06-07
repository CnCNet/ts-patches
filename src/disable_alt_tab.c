#include <stdbool.h>
#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"


typedef HHOOK (WINAPI *SetWindowsHookExFunc)(int idHook, HOOKPROC lpfn, HINSTANCE hMod, DWORD dwThreadId);
typedef LRESULT (WINAPI *CallNextHookExFunc)(HHOOK hhk, int nCode, WPARAM wParam, LPARAM lParam);

LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam);
HHOOK hKeyboardHook;
SetWindowsHookExFunc SetWindowsHookEx_;
CallNextHookExFunc CallNextHookEx_;

void
LoadKeyboardHook() {
  HMODULE library;
  library = LoadLibraryA("User32.dll");
  if(!library) {
    WWDebug_Printf("Unable to find User32.dll");
    return;
  }

  SetWindowsHookEx_ = (SetWindowsHookExFunc) GetProcAddress(library, "SetWindowsHookExA");

  if(!SetWindowsHookEx_) {
    WWDebug_Printf("Unable to find SetWindowsHookEx\n");
    return;
  }
  CallNextHookEx_ = (CallNextHookExFunc) GetProcAddress(library, "CallNextHookEx");
  if(!CallNextHookEx_) {
    WWDebug_Printf("Unable to find CallNextHookEx\n");
    return;
  }
  hKeyboardHook = SetWindowsHookEx_( WH_KEYBOARD_LL,  LowLevelKeyboardProc, GetModuleHandle(NULL), 0 );
}

// keyboard hook proc
LRESULT CALLBACK
LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {

  if (nCode < 0 || nCode != HC_ACTION ) return CallNextHookEx_( hKeyboardHook, nCode, wParam, lParam);

  KBDLLHOOKSTRUCT* p = (KBDLLHOOKSTRUCT*)lParam;

  if(p->vkCode==VK_TAB && p->flags & LLKHF_ALTDOWN) return 1; //disable alt-tab
  if((p->vkCode == VK_LWIN) || (p->vkCode == VK_RWIN)) return 1;//disable windows keys
  if (p->vkCode == VK_ESCAPE && p->flags & LLKHF_ALTDOWN) return 1;//disable alt-escape
  BOOL bControlKeyDown = GetAsyncKeyState (VK_CONTROL) >> ((sizeof(SHORT) * 8) - 1);//checks ctrl key pressed
  if (p->vkCode == VK_ESCAPE && bControlKeyDown) return 1; //disable ctrl-escape

  return CallNextHookEx_( hKeyboardHook, nCode, wParam, lParam );
}
