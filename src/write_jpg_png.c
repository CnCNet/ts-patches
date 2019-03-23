#include "macros/patch.h"
#include "TiberianSun.h"
#include "patch.h"
#include "lodepng.h"

#define TJE_IMPLEMENTATION
#include "tiny_jpeg.h"

CALL(0x004EACC6, _Write_PCX_File_hack_png);

int ScreenshotWidth = 0;
int ScreenshotHeight = 0;
uint16_t *ScreenshotBuffer = NULL;
HANDLE ScreenshotMutex = NULL;
HANDLE ScreenshotSignal = NULL;
HANDLE ScreenshotThread;
bool UseJPG = false;
char FileName[1000];

DWORD WINAPI ScreenshotWriter();
typedef HANDLE (WINAPI *CREATETHREADPROC)(LPSECURITY_ATTRIBUTES, SIZE_T, LPTHREAD_START_ROUTINE, LPVOID, DWORD, LPDWORD);

void __fastcall
Write_PCX_File_hack_png(CCFileClass *ccFile, DSurface *surface, void *palette)
{
    static bool initialized = false;

    if (!UsePNG && !DoingAutoSS)
    {
        return Write_PCX_File(ccFile, surface, palette);
    }

    if (!initialized)
    {
        ScreenshotMutex = CreateMutex(NULL, FALSE, NULL);
        ScreenshotSignal = CreateEvent(NULL, TRUE, FALSE, NULL);

        HANDLE lib = LoadLibraryA("kernel32.dll");
        CREATETHREADPROC CreateThread_ = (CREATETHREADPROC)GetProcAddress(lib, "CreateThread");

        if (CreateThread_)
            CreateThread_(NULL, 0, (LPTHREAD_START_ROUTINE)ScreenshotWriter, NULL, 0, NULL);
        else
            return;
        initialized = true;
    }

    if (WaitForSingleObject(ScreenshotMutex, 0) == WAIT_TIMEOUT)
    {
        // Only 1 screenshot at a time is allowed
        WWDebug_Printf("Skipping screenshot because ScreenshotMutex isn't free\n");
        return;
    }

    ScreenshotWidth = surface->vtable->Get_Width(surface);
    ScreenshotHeight = surface->vtable->Get_Height(surface);

    int16_t *buf = (int16_t *)surface->vtable->Lock(surface, 0, 0);

    ScreenshotBuffer = malloc(ScreenshotHeight * (ScreenshotWidth * 2));

    surface->vtable->Unlock(surface);

    memcpy(ScreenshotBuffer, buf, ScreenshotHeight * (ScreenshotWidth * 2));

    strcpy(FileName, ccFile->cd.b.r.Filename);

    // JPEGs are ugly so we only use it for Auto SS
    if (DoingAutoSS)
        UseJPG = true;
    else
        UseJPG = false;

    ReleaseMutex(ScreenshotMutex);
    SetEvent(ScreenshotSignal);
}

DWORD WINAPI
ScreenshotWriter()
{
    CCFileClass ccfile;
    unsigned char * png;
    size_t pngsize;
    LodePNGState state;
    while (WaitForSingleObject(ScreenshotSignal, INFINITE) == WAIT_OBJECT_0)
    {
        if (WaitForSingleObject(ScreenshotMutex, INFINITE) != WAIT_OBJECT_0)
        {
            ResetEvent(ScreenshotSignal);
            continue;
        }

        char *rgb24buf = (char*)malloc(ScreenshotHeight * (ScreenshotWidth * 3));
        char *outPixel = rgb24buf;

        int count = ScreenshotHeight * ScreenshotWidth;
        while (count-- > 0)
        {
            int16_t value = *(ScreenshotBuffer++);
            int r = value >> 11;
            int g = (0x07e0 & value) >> 5;
            int b = (0x001f & value);

            *(outPixel++) = (char)(r * 255 / 31);
            *(outPixel++) = (char)(g * 255 / 63);
            *(outPixel++) = (char)(b * 255 / 31);
        }

        uint32_t error;

        if (UseJPG)
        {
            // https://github.com/serge-rgb/TinyJPEG/blob/master/tiny_jpeg.h
            // Arg 2 (quality) = 1 (lowest quality)
            error = tje_encode_to_file_at_quality(FileName, 1, ScreenshotWidth, ScreenshotHeight, 3, rgb24buf);
        }
        else
        {
            memset(&state, 0, sizeof(state));
            lodepng_state_init(&state);

            state.info_png.color.colortype = LCT_RGB;
            state.info_png.color.bitdepth = 8;
            state.info_raw.colortype = LCT_RGB;
            state.info_raw.bitdepth = 8;
            state.encoder.zlibsettings.windowsize = 32768;
            state.encoder.auto_convert = 0;

            error = lodepng_encode(&png, &pngsize, (char *)rgb24buf,
                                   ScreenshotWidth, ScreenshotHeight, &state);

            CCFileClass__CCFileClass(&ccfile, FileName);
            CCFileClass__Is_Available(&ccfile, TRUE);
            CCFileClass__Open(&ccfile, 2);
            CCFileClass__Write(&ccfile, png, pngsize);
            CCFileClass__Destroy(&ccfile);

            free(png);
        }

        WWDebug_Printf("Writing: %s %dx%d to %p error=%d pngsize=%d\n", FileName,
                       ScreenshotWidth, ScreenshotHeight, ScreenshotBuffer, error, pngsize);

        free(ScreenshotBuffer);
        ScreenshotBuffer = NULL;
        ReleaseMutex(ScreenshotMutex);
        ResetEvent(ScreenshotSignal);
    }
    return 1;
}
