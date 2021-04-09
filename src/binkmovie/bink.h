//
// Header containing bare basic structures and types required for interacting
// with the BinkW32 library.
//
// Author: CCHyper
//
 
#ifndef _BINK_HEADER_H_
#define _BINK_HEADER_H_


typedef struct BINK * HBINK;

struct BINKSND;

typedef int (__stdcall *BINKSNDOPEN) (struct BINKSND *BnkSnd, unsigned int freq, int bits, int chans, int flags, HBINK bink);
typedef BINKSNDOPEN (__stdcall *BINKSNDSYSOPEN)(unsigned int param);
typedef void (__stdcall * BINKSNDRESET) (struct BINKSND *BnkSnd);
typedef int (__stdcall * BINKSNDREADY) (struct BINKSND *BnkSnd);
typedef int (__stdcall * BINKSNDLOCK) (struct BINKSND *BnkSnd, unsigned char **addr, unsigned int *len);
typedef int (__stdcall * BINKSNDUNLOCK) (struct BINKSND *BnkSnd, unsigned int filled);
typedef void (__stdcall * BINKSNDVOLUME) (struct BINKSND *BnkSnd, int volume);
typedef void (__stdcall * BINKSNDPAN) (struct BINKSND *BnkSnd, int pan);
typedef int (__stdcall * BINKSNDOFF) (struct BINKSND *BnkSnd, int status);
typedef int (__stdcall * BINKSNDPAUSE) (struct BINKSND *BnkSnd, int status);
typedef void (__stdcall * BINKSNDCLOSE) (struct BINKSND *BnkSnd);


#define BINKFRAMERATE         0x00001000L
#define BINKPRELOADALL        0x00002000L
#define BINKSNDTRACK          0x00004000L
#define BINKOLDFRAMEFORMAT    0x00008000L
#define BINKRBINVERT          0x00010000L
#define BINKGRAYSCALE         0x00020000L
#define BINKNOMMX             0x00040000L
#define BINKNOSKIP            0x00080000L
#define BINKALPHA             0x00100000L
#define BINKNOFILLIOBUF       0x00200000L
#define BINKSIMULATE          0x00400000L
#define BINKFILEHANDLE        0x00800000L
#define BINKIOSIZE            0x01000000L
#define BINKIOPROCESSOR       0x02000000L
#define BINKFROMMEMORY        0x04000000L
#define BINKNOTHREADEDIO      0x08000000L

#define BINKSURFACEFAST       0x00000000L
#define BINKSURFACESLOW       0x08000000L
#define BINKSURFACEDIRECT     0x04000000L

#define BINKCOPYALL           0x80000000L
#define BINKCOPY2XH           0x10000000L
#define BINKCOPY2XHI          0x20000000L
#define BINKCOPY2XW           0x30000000L
#define BINKCOPY2XWH          0x40000000L
#define BINKCOPY2XWHI         0x50000000L
#define BINKCOPY1XI           0x60000000L
#define BINKCOPYNOSCALING     0x70000000L

#define BINKSURFACE8P          0
#define BINKSURFACE24          1
#define BINKSURFACE24R         2
#define BINKSURFACE32          3
#define BINKSURFACE32R         4
#define BINKSURFACE32A         5
#define BINKSURFACE32RA        6
#define BINKSURFACE4444        7
#define BINKSURFACE5551        8
#define BINKSURFACE555         9
#define BINKSURFACE565        10
#define BINKSURFACE655        11
#define BINKSURFACE664        12
#define BINKSURFACEYUY2       13
#define BINKSURFACEUYVY       14
#define BINKSURFACEYV12       15
#define BINKSURFACEMASK       15

#define BINKGOTOQUICK          1

#define BINKGETKEYPREVIOUS     0
#define BINKGETKEYNEXT         1
#define BINKGETKEYCLOSEST      2
#define BINKGETKEYNOTEQUAL   128


//
// The following will have been larger structs in the real Bink SDK headers, but are
// only accessed through pointers so we don't care unless access to the internals
// is required.
//

typedef struct BINKRECT
{
    int Left;
    int Top;
    int Width;
    int Height;
} BINKRECT;


typedef struct BINKSND
{
    BINKSNDRESET SetParam;
    BINKSNDRESET Reset;
    BINKSNDREADY Ready;
    BINKSNDLOCK Lock;
    BINKSNDUNLOCK Unlock;
    BINKSNDVOLUME Volume;
    BINKSNDPAN Pan;
    BINKSNDPAUSE Pause;
    BINKSNDOFF Off;
    BINKSNDCLOSE Close;
    unsigned int BestSizeIn16;
    unsigned int SoundDroppedOut;
    unsigned int freq;
    int bits;
    int chans;
    unsigned char snddata[128];
} BINKSND;


typedef struct BINKPLANE
{
    int Allocate;
    void * Buffer;
    unsigned int BufferPitch;
} BINKPLANE;


typedef struct BINKFRAMEPLANESET
{
  BINKPLANE YPlane;
  BINKPLANE cRPlane;
  BINKPLANE cBPlane;
  BINKPLANE APlane;
} BINKFRAMEPLANESET;


typedef struct BINKFRAMEBUFFERS
{
    int TotalFrames;
    unsigned int YABufferWidth;
    unsigned int YABufferHeight;
    unsigned int cRcBBufferWidth;
    unsigned int cRcBBufferHeight;
    unsigned int FrameNum;
    BINKFRAMEPLANESET Frames[2];
} BINKFRAMEBUFFERS;


typedef struct BINK
{
    unsigned int Width;
    unsigned int Height;
    unsigned int Frames;
    unsigned int FrameNum;
    unsigned int LastFrameNum;
    unsigned int FrameRate;
    unsigned int FrameRateDiv;
    unsigned int ReadError;
    unsigned int OpenFlags;
    unsigned int BinkType;
    unsigned int Size;
    unsigned int FrameSize;
    unsigned int SndSize;
    unsigned int FrameChangePercent;
    BINKRECT FrameRects[8];
    int NumRects;
    BINKFRAMEBUFFERS *FrameBuffers;
    void * MaskPlane;
    unsigned int MaskPitch;
    unsigned int MaskLength;
    void * AsyncMaskPlane;
    void * InUseMaskPlane;
    void * LastMaskPlane;
    unsigned int LargestFrameSize;
    unsigned int InternalFrames;
    int NumTracks;
    unsigned int Highest1SecRate;
    unsigned int Highest1SecFrame;
    int Paused;
} BINK;


//
// Use this define and don't call BinkOpenDirectSound directly!
//
#define BinkSoundUseDirectSound(lpDS) BinkSetSoundSystem(BinkOpenDirectSound, (unsigned int)lpDS)

//
// Function typedefs.
//
typedef int (__stdcall * BINKSETSOUNDSYSTEM)(BINKSNDSYSOPEN *open, unsigned int param);
typedef void * (__stdcall * BINKOPENDIRECTSOUND)(unsigned int param);
typedef char * (__stdcall * BINKGETERROR)(void);
typedef HBINK (__stdcall * BINKOPEN)(const char *name, unsigned int flags);
typedef void (__stdcall * BINKCLOSE)(HBINK bnk);
typedef int (__stdcall * BINKDDSURFACETYPE)(void *lpDDS);
typedef void (__stdcall * BINKGOTO)(HBINK bnk, unsigned int frame, unsigned int flags);  // use 1 for the first frame
typedef int (__stdcall * BINKPAUSE)(HBINK bnk, int pause);
typedef void (__stdcall *BINKNEXTFRAME)(HBINK bnk);
typedef int (__stdcall * BINKCOPYTOBUFFER)(HBINK bnk, void *dest, int destpitch, unsigned int destheight, unsigned int destx, unsigned int desty, unsigned int flags);
typedef int (__stdcall * BINKDOFRAME)(HBINK bnk);
typedef int (__stdcall * BINKWAIT)(HBINK bnk);
typedef int (__stdcall * BINKSETVOLUME)(HBINK bnk, int volume);
typedef void (__stdcall BINKSETPAN)(HBINK bnk, int volume);


#endif // _BINK_HEADER_H_
