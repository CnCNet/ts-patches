#include <windows.h>
#include <windowsx.h>
#include "TiberianSun.h"
#include "macros/patch.h"

SETDWORD(0x006861B2, _fake_WndProc);

LRESULT CALLBACK fake_WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    return WndProc(hwnd, uMsg, wParam, lParam);
}
