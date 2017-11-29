#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include "windows.h"

LJMP(0x006019D0, _Top_Level_Exception_Filter_hack2);

/*
SETDWORD(0x006019E3, _Top_Level_Exception_Filter_hack);
LONG WINAPI Top_Level_Exception_Filter_hack(struct _EXCEPTION_POINTERS *ExceptionInfo)
{
    DWORD *eip = &(ExceptionInfo->ContextRecord->Eip);
    return Top_Level_Exception_Filter(ExceptionInfo);
}
*/

/* Intercept the the top level exception filter call and if we have a known restartable exception
 * set eip to the restart location and return EXCEPTION_CONTINUE_EXECUTION;
 */

LONG __fastcall Top_Level_Exception_Filter_hack2(int exception_id, struct _EXCEPTION_POINTERS *ExceptionInfo)
{
    DWORD *eip = &(ExceptionInfo->ContextRecord->Eip);
    switch (*eip)
    {
    /* Fog of war crashes */
    case 0x0046C7E2:
        *eip = 0x0046C837;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x0046BA24:
        *eip = 0x0046BA55;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x0046AF75:
        *eip = 0x0046AFB5;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x00469129:
        *eip = 0x00469163;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x00469AD6:
        *eip = 0x00469B1A;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x0046C7A7:
        *eip = 0x0046C837;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x0046AF6E:
        *eip = 0x0046AFB5;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x00469AA0:
        *eip = 0x00469B1A;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x0046B9E9:
        *eip = 0x0046BA55;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x004681B4:
        *eip = 0x004681E6;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x004690EF:
        *eip = 0x00469163;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x0046AF8A:
        *eip = 0x0046AFB5;
        return EXCEPTION_CONTINUE_EXECUTION;

    /* non-fog of war crashes*/
    case 0x006A8D16:
        *eip = 0x006A8D1F;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x006703d4:
        *eip = 0x00670499;
        return EXCEPTION_CONTINUE_EXECUTION;
    case 0x004668a8:
        *eip = 0x004668AD;
        return EXCEPTION_CONTINUE_EXECUTION;


    default:
        return PrintException(exception_id, ExceptionInfo);
    }
    return 0;
}


/*
;    typedef struct _CONTEXT {
;      DWORD ContextFlags;
;      DWORD Dr0;
;      DWORD Dr1;
;      DWORD Dr2;
;      DWORD Dr3;
;      DWORD Dr6;
;      DWORD Dr7;
;      FLOATING_SAVE_AREA FloatSave; size=40
;      DWORD SegGs;
;      DWORD SegFs;
;      DWORD SegEs;
;      DWORD SegDs;;
;
;      DWORD Edi; =84
;      DWORD Esi; =88
;      DWORD Ebx; =92
;      DWORD Edx; =96
;      DWORD Ecx; =100
;      DWORD Eax; =104
;      DWORD Ebp; =108
;      DWORD Eip; =112
;      DWORD SegCs; =116
;      DWORD EFlags; =120
;      DWORD Esp; =124
;      DWORD SegSs; =128
;      BYTE ExtendedRegisters[MAXIMUM_SUPPORTED_EXTENSION];
;    } CONTEXT;

;    typedef struct _FLOATING_SAVE_AREA {
;      DWORD ControlWord;
;      DWORD StatusWord;
;      DWORD TagWord;
;      DWORD ErrorOffset;
;      DWORD ErrorSelector;
;      DWORD DataOffset;
;      DWORD DataSelector;
;      BYTE RegisterArea[SIZE_OF_80387_REGISTERS];
;      DWORD Cr0NpxState;
;    } FLOATING_SAVE_AREA;
*/
