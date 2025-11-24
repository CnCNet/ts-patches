#include <stdint.h>
#include <stdbool.h>

/* Add mod specific defaults here and reference them as extern or cextern in headers/includes
   Each mod should have it's own config.c file
 */
#if defined(MOD_DTA)
int32_t MultiFactoryCost = 0;
bool RefundFreeUnit = false;

#elif defined(MOD_TI)
int32_t MultiFactoryCost = 1000;
bool RefundFreeUnit = false;

#elif defined(MOD_TO)
int32_t MultiFactoryCost = 0;
bool RefundFreeUnit = false;

#elif defined(MOD_RUBICON)
int32_t MultiFactoryCost = 0;
bool RefundFreeUnit = false;

#elif defined(MOD_FD)
int32_t MultiFactoryCost = 2000;
bool RefundFreeUnit = false;

#elif defined(MOD_SD)
int32_t MultiFactoryCost = 2000;
bool RefundFreeUnit = false;

#elif defined(TSCLIENT)
int32_t MultiFactoryCost = 2000;
bool RefundFreeUnit = false;

#else
int32_t MultiFactoryCost = 2000;
bool RefundFreeUnit = true;

#endif
