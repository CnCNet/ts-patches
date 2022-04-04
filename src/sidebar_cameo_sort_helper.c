#include "macros/patch.h"
#include "TiberianSun.h"
#include <windows.h>
#include <assert.h>

// Comparison function for sorting sidebar icons (BuildTypes)
// Author: Rampastring
int __cdecl BuildType_Comparison(const void *p1, const void *p2)
{
    BuildType *bt1 = (BuildType*)p1;
    BuildType *bt2 = (BuildType*)p2;
    
    if (bt1->BuildableType == bt2->BuildableType)
        return bt1->BuildableID - bt2->BuildableID;
    
    if (bt1->BuildableType == ABSTRACT_INFTYPE)
        return -1;
    
    if (bt2->BuildableType == ABSTRACT_INFTYPE)
        return 1;
    
    if (bt1->BuildableType == ABSTRACT_UNITTYPE)
        return -1;
    
    if (bt2->BuildableType == ABSTRACT_UNITTYPE)
        return 1;
    
    if (bt1->BuildableType == ABSTRACT_AIRCRAFTTYPE)
        return -1;
    
    if (bt2->BuildableType == ABSTRACT_AIRCRAFTTYPE)
        return 1;
    
    return 0;
}

