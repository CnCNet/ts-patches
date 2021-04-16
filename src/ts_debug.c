#include "macros/patch.h"
#include "TiberianSun.h"
#include <windows.h>
#include "patch.h"
#include <string.h>
#include <stdbool.h>

#ifdef WWDEBUG
LJMP(0x004082D0, _hook_wwdebug_printf);
LJMP(0x004735C0, _hook_wwdebug_printf);
#endif

int __cdecl vsprintf(char * restrict str, const char * restrict format, va_list ap);
size_t strnlen(const char *s, size_t maxlen);
char wwdebug_buf[100];

void __cdecl
hook_wwdebug_printf(char const *fmt, ...)
{
  va_list ap;
  va_start(ap,fmt);
  static bool already_consoled = false;

  if (!already_consoled) {
    AllocConsole();
    already_consoled = true;
    WWDebug_Printf("Allocated the console\n");
  }

  HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);

  size_t fmt_len = strnlen(fmt,99);

  if (fmt_len >= 99)
    return;
  vsprintf(wwdebug_buf, fmt, ap);
  va_end(ap);

  size_t len = strnlen(wwdebug_buf,99);
  if (len >= 99)
    return;
  LPDWORD ret;

  WriteConsole(h,wwdebug_buf,len, 0, 0);
  return;
}

size_t
strnlen(const char *s, size_t maxlen)
{
        size_t len;

        for (len = 0; len < maxlen; len++, s++) {
                if (!*s)
                        break;
        }
        return (len);
}
