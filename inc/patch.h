#include <windows.h>
#include <stdbool.h>
#include <stdint.h>

// This header is used for patches
// This header will be split up as it becomes larger

// ### Functions ###

void SetSingleProcAffinity();
void DisableHighDpiScaling();
void DisableMaxWindowedMode();

// ### Variables ###

extern bool NoWindowFrame;
extern bool UseGraphicsPatch;
extern bool IsNoCD;
