%include "macros/setsym.inc"

; Memory
setcglob 0x006B51D7, new
setcglob 0x006B63F0, memcpy
setcglob 0x006C0080, memset

; House
setcglob 0x007E155C, HouseClassArray
setcglob 0x007E1568, HouseClassArray_Count
setcglob 0x007E21D4, HouseTypesArray
setcglob 0x004BB460, HouseClass__Assign_Handicap
setcglob 0x004BDB30, HouseClass__Make_Ally
setcglob 0x004BD9E0, HouseClass__Is_Ally
setcglob 0x005DE210, Assign_Houses
setcglob 0x005EEF70, Get_MP_Color
setcglob 0x004CDEF0, HouseType_From_Name
setcglob 0x004C2E40, Read_Scenario_Houses

; TechnoClass
setcglob 0x0040F2A0, TechnoClass_What_Weapon_Should_I_Use
setcglob 0x00632310, TechnoClass__Can_Player_Fire
setcglob 0x005872A0, ObjectClass__InAir

; AircraftClass
setcglob 0x0040BA40, AircraftClass__Mission_Attack

; Arrays
setcglob 0x007B3468, UnitClassArray_Count
setcglob 0x007E4850, TeamTypesArray_Count
setcglob 0x007E4844, TeamTypesArray     
setcglob 0x0070D850, PlayerColorMap
setcglob 0x007E4058, DynamicVectorClass_AircraftClass

; INI
setcglob 0x004E8A30, INIClass__INIClass
setcglob 0x00449F30, INIClass__Load
setcglob 0x004DE140, INIClass__GetBool
setcglob 0x004DD140, INIClass__GetInt
setcglob 0x004DDF60, INIClass__GetString
setcglob 0x004DD9F0, INIClass__GetFixed

setcglob 0x0074C378, INIClass_SUN_INI 

; File
setcglob 0x004497B0, FileClass__FileClass
setcglob 0x004499C0, FileClass__Is_Available
setcglob 0x00449A40, FileClass__Open
setcglob 0x00449A10, FileClass__Close
setcglob 0x00449850, FileClass__Write
setcglob 0x00561940, MonoClass__Printf

; Session
setcglob 0x007E2458, SessionClass_this
setcglob 0x005ED510, SessionClass__Create_Connections
setcglob 0x007E4580, GameActive
setcglob 0x007E2458, SessionType
setcglob 0x007E2480, UnitCount
setcglob 0x006FB628, TechLevel
setcglob 0x007E2484, AIPlayers
setcglob 0x007E2488, AIDifficulty
setcglob 0x007E248D, HarvesterTruce
setcglob 0x007E2474, BridgeDestroy
setcglob 0x007E248F, FogOfWar
setcglob 0x007E2475, Crates
setcglob 0x007E2476, ShortGame
setcglob 0x007E246C, Bases
setcglob 0x007E2490, MCVRedeploy
setcglob 0x007E2470, Credits
setcglob 0x007E4720, GameSpeed
setcglob 0x007E247C, MultiEngineer
setcglob 0x007E248C, AlliesAllowed
setcglob 0x007E4924, Frame
setcglob 0x00867014, GameIDNumber
setcglob 0x007E24DC, PlayerColor
setcglob 0x00867008, TournamentGame

; Random
setcglob 0x007E4934, Seed
setcglob 0x004E38A0, Init_Random

; Message
setcglob 0x007E2C34, MessageListClass_this
setcglob 0x007E2284, PlayerPtr
setcglob 0x00572FE0, MessageListClass__Add_Message
setcglob 0x006B2330, Get_Message_Delay_Or_Duration
setcglob 0x007E24E4, Message_Input_Player_Dead

; Network
setcglob 0x0070FCF0, ListenPort
setcglob 0x006A1E70, UDPInterfaceClass__UDPInterfaceClass
setcglob 0x0074C8D8, WinsockInterface_this
setcglob 0x006A1180, WinsockInterfaceClass__Init
setcglob 0x006A2130, UDPInterfaceClass__Open_Socket
setcglob 0x006A1030, WinsockInterfaceClass__Start_Listening
setcglob 0x006A10A0, WinsockInterfaceClass__Discard_In_Buffers
setcglob 0x006A1110, WinsockInterfaceClass__Discard_Out_Buffers
setcglob 0x007E45A0, IPXManagerClass_this
setcglob 0x004F05B0, IPXManagerClass__Set_Timing
setcglob 0x004EF040, IPXAddressClass__IPXAddressClass

setcglob 0x007E250C, MaxAhead
setcglob 0x007E2524, MaxMaxAhead
setcglob 0x007E2510, FrameSendRate
setcglob 0x007E3FA8, LatencyFudge
setcglob 0x007E2514, RequestedFPS
setcglob 0x007E2464, ProtocolVersion

setcglob 0x00574F90, Init_Network
setcglob 0x007E3EA0, NameNodes_CurrentSize
setcglob 0x007E2508, HumanPlayers

; Scenario
setcglob 0x007E28B8, ScenarioName
setcglob 0x005DB170, Start_Scenario
setcglob 0x007E3E90, NameNodeVector
setcglob 0x0044D690, NameNodeVector_Add
setcglob 0x005EE7D0, SessionClass__Read_Scenario_Descriptions
setcglob 0x007E2438, ScenarioStuff
setcglob 0x007E4724, SelectedDifficulty

; Save games
setcglob 0x005D6910, Load_Game

; Mouse
setcglob 0x0074C8F0, WWMouseClas_Mouse
setcglob 0x00748348, MouseClass_Map

; MapClass
setcglob 0x0051E130, MapClass__GetCellFloorHeight
setcglob 0x0050F210, MapClass__Get_Target_Coord
setcglob 0x0052B870, MapClass__Cell_Is_Shrouded
setcglob 0x0050F280, MapClass__Coord_Cell
setcglob 0x007B3304, dword_7B3304

; Statistics
setcglob 0x007E4FD0, StatisticsPacketSent
setcglob 0x00867014, WOLGameID

; Others
setcglob 0x007A1790, VideoWindowed
setcglob 0x0070EC84, VideoBackBuffer

; Sidebar
;setcglob 0x00749874, LEFT_STRIP
;setcglob 0x00749C48, RIGHT_STRIP

; clib
setcglob 0x006B73A0, __strcmpi
setcglob 0x006B8E20, strcmp
setcglob 0x006B602A, _strtok
setcglob 0x006B52EE, _sprintf
setcglob 0x006B6A41, vsprintf
setcglob 0x006B6730, stristr_
setcglob 0x006BA490, strlen

; winapi
setcglob 0x006B4D6C, sendto
setcglob 0x006B4D66, recvfrom
setcglob 0x006B4D24, htonl
setcglob 0x006B4D2A, htons


;WSOCK32
setcglob 0x006CA504, _imp__sendto
setcglob 0x006CA4FC, _imp__recvfrom

setcglob 0x006CA24C, _imp__GetCommandLineA
setcglob 0x006CA16C, _imp__LoadLibraryA
setcglob 0x006CA174, _imp__GetProcAddress
setcglob 0x006CA1D0, _imp__GetCurrentProcess
setcglob 0x006CA4EC, _imp__timeGetTime
setcglob 0x006CA28C, _imp__GetStdHandle
setcglob 0x006CA2B4, _imp__WriteConsoleA

;Address  Ordinal Name                          Library 
;-------  ------- ----                          ------- 
;006CA000         RegCloseKey                   ADVAPI32
;006CA004         RegQueryValueExA              ADVAPI32
;006CA008         RegEnumKeyExA                 ADVAPI32
;006CA00C         RegOpenKeyExA                 ADVAPI32
;006CA010         RegSetValueExA                ADVAPI32
;006CA014         RegCreateKeyExA               ADVAPI32
;006CA018         RegDeleteKeyA                 ADVAPI32
;006CA01C         RegQueryInfoKeyA              ADVAPI32
;006CA024         ImageList_DragShowNolock      COMCTL32
;006CA028 17      InitCommonControls            COMCTL32
;006CA02C         ImageList_DragMove            COMCTL32
;006CA030         ImageList_DragEnter           COMCTL32
;006CA034         ImageList_BeginDrag           COMCTL32
;006CA038         ImageList_Destroy             COMCTL32
;006CA03C         ImageList_EndDrag             COMCTL32
;006CA044         DirectDrawCreate              DDRAW   
;006CA04C 1       DirectSoundCreate             DSOUND  
;006CA054         DeleteObject                  GDI32   
;006CA058         CreateSolidBrush              GDI32   
;006CA05C         SetTextColor                  GDI32   
;006CA060         SetBkColor                    GDI32   
;006CA064         SetBkMode                     GDI32   
;006CA068         GetTextColor                  GDI32   
;006CA06C         GetBkColor                    GDI32   
;006CA070         GetBkMode                     GDI32   
;006CA074         SelectObject                  GDI32   
;006CA078         GetStockObject                GDI32   
;006CA07C         GetTextMetricsA               GDI32   
;006CA080         TextOutA                      GDI32   
;006CA084         SetTextAlign                  GDI32   
;006CA088         CreateFontA                   GDI32   
;006CA08C         RestoreDC                     GDI32   
;006CA090         CreateFontIndirectA           GDI32   
;006CA094         DPtoLP                        GDI32   
;006CA098         SetWindowOrgEx                GDI32   
;006CA09C         SetViewportOrgEx              GDI32   
;006CA0A0         ModifyWorldTransform          GDI32   
;006CA0A4         SetGraphicsMode               GDI32   
;006CA0A8         SaveDC                        GDI32   
;006CA0AC         GetTextExtentPoint32A         GDI32   
;006CA0B0         CreateDIBSection              GDI32   
;006CA0B8         FileTimeToSystemTime          KERNEL32
;006CA0BC         FileTimeToLocalFileTime       KERNEL32
;006CA0C0         GetDateFormatA                KERNEL32
;006CA0C4         GetTimeFormatA                KERNEL32
;006CA0C8         SystemTimeToFileTime          KERNEL32
;006CA0CC         CopyFileA                     KERNEL32
;006CA0D0         CreateDirectoryA              KERNEL32
;006CA0D4         QueryPerformanceFrequency     KERNEL32
;006CA0D8         QueryPerformanceCounter       KERNEL32
;006CA0DC         CompareFileTime               KERNEL32
;006CA0E0         EscapeCommFunction            KERNEL32
;006CA0E4         SetCommBreak                  KERNEL32
;006CA0E8         ReadFile                      KERNEL32
;006CA0EC         SetFilePointer                KERNEL32
;006CA0F0         GetFileSize                   KERNEL32
;006CA0F4         FileTimeToDosDateTime         KERNEL32
;006CA0F8         GetFileInformationByHandle    KERNEL32
;006CA0FC         SetFileTime                   KERNEL32
;006CA100         DosDateTimeToFileTime         KERNEL32
;006CA104         lstrlenA                      KERNEL32
;006CA108         lstrcatA                      KERNEL32
;006CA10C         ClearCommBreak                KERNEL32
;006CA110         DeleteFileA                   KERNEL32
;006CA114         SetCurrentDirectoryA          KERNEL32
;006CA118         OpenMutexA                    KERNEL32
;006CA11C         GetFileTime                   KERNEL32
;006CA120         GlobalMemoryStatus            KERNEL32
;006CA124         ClearCommError                KERNEL32
;006CA128         SetCommTimeouts               KERNEL32
;006CA12C         SetCommState                  KERNEL32
;006CA130         GetCommState                  KERNEL32
;006CA134         GetTickCount                  KERNEL32
;006CA138         GetSystemTime                 KERNEL32
;006CA13C         SetupComm                     KERNEL32
;006CA140         GetCommMask                   KERNEL32
;006CA144         ResetEvent                    KERNEL32
;006CA148         GetCommModemStatus            KERNEL32
;006CA14C         GetOverlappedResult           KERNEL32
;006CA150         GetVersionExA                 KERNEL32
;006CA154         GetExitCodeProcess            KERNEL32
;006CA158         CreateProcessA                KERNEL32
;006CA15C         SetEvent                      KERNEL32
;006CA160         GetCurrentDirectoryA          KERNEL32
;006CA164         HeapDestroy                   KERNEL32
;006CA168         LockResource                  KERNEL32
;006CA170         GetModuleHandleA              KERNEL32
;006CA178         GetDiskFreeSpaceA             KERNEL32
;006CA17C         FindNextFileA                 KERNEL32
;006CA180         FindFirstFileA                KERNEL32
;006CA184         FindClose                     KERNEL32
;006CA188         GetDriveTypeA                 KERNEL32
;006CA18C         CreateFileA                   KERNEL32
;006CA190         DeviceIoControl               KERNEL32
;006CA194         GetLastError                  KERNEL32
;006CA198         Sleep                         KERNEL32
;006CA19C         CloseHandle                   KERNEL32
;006CA1A0         MultiByteToWideChar           KERNEL32
;006CA1A4         InterlockedIncrement          KERNEL32
;006CA1A8         InterlockedDecrement          KERNEL32
;006CA1AC         DeleteCriticalSection         KERNEL32
;006CA1B0         GetCurrentThreadId            KERNEL32
;006CA1B4         InitializeCriticalSection     KERNEL32
;006CA1B8         EnterCriticalSection          KERNEL32
;006CA1BC         WideCharToMultiByte           KERNEL32
;006CA1C0         VirtualQuery                  KERNEL32
;006CA1C4         VirtualProtect                KERNEL32
;006CA1C8         FlushInstructionCache         KERNEL32
;006CA1CC         WriteFile                     KERNEL32
;006CA1D4         IsBadCodePtr                  KERNEL32
;006CA1D8         IsBadReadPtr                  KERNEL32
;006CA1DC         ExitProcess                   KERNEL32
;006CA1E0         AllocConsole                  KERNEL32
;006CA1E4         FreeConsole                   KERNEL32
;006CA1E8         WaitForSingleObject           KERNEL32
;006CA1EC         WaitForMultipleObjects        KERNEL32
;006CA1F0         ReleaseMutex                  KERNEL32
;006CA1F4         CreateMutexA                  KERNEL32
;006CA1F8         FreeLibrary                   KERNEL32
;006CA1FC         GetVolumeInformationA         KERNEL32
;006CA200         GetModuleFileNameA            KERNEL32
;006CA204         FindResourceA                 KERNEL32
;006CA208         LoadResource                  KERNEL32
;006CA20C         CreateEventA                  KERNEL32
;006CA210         PurgeComm                     KERNEL32
;006CA214         lstrcpyA                      KERNEL32
;006CA218         SetUnhandledExceptionFilter   KERNEL32
;006CA21C         TlsGetValue                   KERNEL32
;006CA220         FreeEnvironmentStringsW       KERNEL32
;006CA224         TlsFree                       KERNEL32
;006CA228         TlsAlloc                      KERNEL32
;006CA22C         TlsSetValue                   KERNEL32
;006CA230         RaiseException                KERNEL32
;006CA234         LCMapStringW                  KERNEL32
;006CA238         LCMapStringA                  KERNEL32
;006CA23C         FatalAppExitA                 KERNEL32
;006CA240         HeapSize                      KERNEL32
;006CA244         HeapReAlloc                   KERNEL32
;006CA248         GetVersion                    KERNEL32
;006CA250         GetStartupInfoA               KERNEL32
;006CA254         RtlUnwind                     KERNEL32
;006CA258         GetSystemTimeAsFileTime       KERNEL32
;006CA25C         HeapAlloc                     KERNEL32
;006CA260         SetLastError                  KERNEL32
;006CA264         TerminateProcess              KERNEL32
;006CA268         GetLocalTime                  KERNEL32
;006CA26C         GetTimeZoneInformation        KERNEL32
;006CA270         HeapFree                      KERNEL32
;006CA274         GetCurrentThread              KERNEL32
;006CA278         HeapCreate                    KERNEL32
;006CA27C         VirtualFree                   KERNEL32
;006CA280         VirtualAlloc                  KERNEL32
;006CA284         IsBadWritePtr                 KERNEL32
;006CA288         SetHandleCount                KERNEL32
;006CA28C         GetStdHandle                  KERNEL32
;006CA290         GetFileType                   KERNEL32
;006CA294         GetCPInfo                     KERNEL32
;006CA298         GetACP                        KERNEL32
;006CA29C         GetOEMCP                      KERNEL32
;006CA2A0         SetConsoleCtrlHandler         KERNEL32
;006CA2A4         GetFileAttributesA            KERNEL32
;006CA2A8         GetCurrentProcessId           KERNEL32
;006CA2AC         UnhandledExceptionFilter      KERNEL32
;006CA2B0         FreeEnvironmentStringsA       KERNEL32
;006CA2B4         WriteConsoleA                 KERNEL32
;006CA2B8         GetEnvironmentStrings         KERNEL32
;006CA2BC         GetEnvironmentStringsW        KERNEL32
;006CA2C0         LeaveCriticalSection          KERNEL32
;006CA2C4         IsValidLocale                 KERNEL32
;006CA2C8         IsValidCodePage               KERNEL32
;006CA2CC         GetLocaleInfoA                KERNEL32
;006CA2D0         EnumSystemLocalesA            KERNEL32
;006CA2D4         GetUserDefaultLCID            KERNEL32
;006CA2D8         GetStringTypeA                KERNEL32
;006CA2DC         GetStringTypeW                KERNEL32
;006CA2E0         SetStdHandle                  KERNEL32
;006CA2E4         FlushFileBuffers              KERNEL32
;006CA2E8         CompareStringA                KERNEL32
;006CA2EC         CompareStringW                KERNEL32
;006CA2F0         SetEnvironmentVariableA       KERNEL32
;006CA2F4         LocalFree                     KERNEL32
;006CA2F8         GetNumberOfConsoleInputEvents KERNEL32
;006CA2FC         PeekConsoleInputA             KERNEL32
;006CA300         GetConsoleMode                KERNEL32
;006CA304         SetConsoleMode                KERNEL32
;006CA308         SetEndOfFile                  KERNEL32
;006CA30C         GetLocaleInfoW                KERNEL32
;006CA310         lstrlenW                      KERNEL32
;006CA314         ReadConsoleInputA             KERNEL32
;006CA31C 2       SysAllocString                OLEAUT32
;006CA320 6       SysFreeString                 OLEAUT32
;006CA324 201     SetErrorInfo                  OLEAUT32
;006CA328 12      VariantChangeType             OLEAUT32
;006CA32C 202     CreateErrorInfo               OLEAUT32
;006CA330 9       VariantClear                  OLEAUT32
;006CA334 8       VariantInit                   OLEAUT32
;006CA338 161     LoadTypeLib                   OLEAUT32
;006CA33C 34      RevokeActiveObject            OLEAUT32
;006CA340 33      RegisterActiveObject          OLEAUT32
;006CA344 200     GetErrorInfo                  OLEAUT32
;006CA34C         FindExecutableA               SHELL32 
;006CA354         DialogBoxIndirectParamA       USER32  
;006CA358         DialogBoxParamA               USER32  
;006CA35C         SetDlgItemTextA               USER32  
;006CA360         SetFocus                      USER32  
;006CA364         EndDialog                     USER32  
;006CA368         GetActiveWindow               USER32  
;006CA36C         ShowCursor                    USER32  
;006CA370         ChildWindowFromPoint          USER32  
;006CA374         TranslateMessage              USER32  
;006CA378         GetDlgItem                    USER32  
;006CA37C         EnableWindow                  USER32  
;006CA380         SetWindowTextA                USER32  
;006CA384         ClientToScreen                USER32  
;006CA388         GetClientRect                 USER32  
;006CA38C         DestroyWindow                 USER32  
;006CA390         GetKeyState                   USER32  
;006CA394         ToAscii                       USER32  
;006CA398         MapVirtualKeyA                USER32  
;006CA39C         GetAsyncKeyState              USER32  
;006CA3A0         GetSystemMetrics              USER32  
;006CA3A4         SendDlgItemMessageA           USER32  
;006CA3A8         GetWindowTextA                USER32  
;006CA3AC         MoveWindow                    USER32  
;006CA3B0         AdjustWindowRectEx            USER32  
;006CA3B4         GetMenu                       USER32  
;006CA3B8         SetRect                       USER32  
;006CA3BC         SetWindowPos                  USER32  
;006CA3C0         PostMessageA                  USER32  
;006CA3C4         ValidateRect                  USER32  
;006CA3C8         InvalidateRect                USER32  
;006CA3CC         CheckDlgButton                USER32  
;006CA3D0         CharToOemBuffA                USER32  
;006CA3D4         ScreenToClient                USER32  
;006CA3D8         GetWindowRect                 USER32  
;006CA3DC         DispatchMessageA              USER32  
;006CA3E0         IsDlgButtonChecked            USER32  
;006CA3E4         GetDlgItemTextA               USER32  
;006CA3E8         WaitForInputIdle              USER32  
;006CA3EC         GetTopWindow                  USER32  
;006CA3F0         GetForegroundWindow           USER32  
;006CA3F4         LoadIconA                     USER32  
;006CA3F8         RegisterHotKey                USER32  
;006CA3FC         RedrawWindow                  USER32  
;006CA400         GetWindowContextHelpId        USER32  
;006CA404         WinHelpA                      USER32  
;006CA408         SendMessageA                  USER32  
;006CA40C         LoadCursorA                   USER32  
;006CA410         SetCursor                     USER32  
;006CA414         CreateDialogParamA            USER32  
;006CA418         PostQuitMessage               USER32  
;006CA41C         FindWindowA                   USER32  
;006CA420         GetDlgCtrlID                  USER32  
;006CA424         GetCapture                    USER32  
;006CA428         SetCursorPos                  USER32  
;006CA42C         SetForegroundWindow           USER32  
;006CA430         CreateDialogIndirectParamA    USER32  
;006CA434         DrawTextA                     USER32  
;006CA438         DefWindowProcA                USER32  
;006CA43C         CloseWindow                   USER32  
;006CA440         GetDC                         USER32  
;006CA444         ReleaseDC                     USER32  
;006CA448         GetKeyNameTextA               USER32  
;006CA44C         GetFocus                      USER32  
;006CA450         GetNextDlgTabItem             USER32  
;006CA454         GetUpdateRect                 USER32  
;006CA458         MessageBoxA                   USER32  
;006CA45C         LoadStringA                   USER32  
;006CA460         MessageBoxIndirectA           USER32  
;006CA464         wsprintfA                     USER32  
;006CA468         GetWindowLongA                USER32  
;006CA46C         SetWindowLongA                USER32  
;006CA470         ShowWindow                    USER32  
;006CA474         UpdateWindow                  USER32  
;006CA478         CallWindowProcA               USER32  
;006CA47C         WindowFromPoint               USER32  
;006CA480         KillTimer                     USER32  
;006CA484         SetTimer                      USER32  
;006CA488         IntersectRect                 USER32  
;006CA48C         GetWindow                     USER32  
;006CA490         GetClassNameA                 USER32  
;006CA494         EnumChildWindows              USER32  
;006CA498         GetParent                     USER32  
;006CA49C         BringWindowToTop              USER32  
;006CA4A0         SetCapture                    USER32  
;006CA4A4         ReleaseCapture                USER32  
;006CA4A8         CreateWindowExA               USER32  
;006CA4AC         RegisterClassA                USER32  
;006CA4B0         IsWindowEnabled               USER32  
;006CA4B4         PeekMessageA                  USER32  
;006CA4B8         GetMessageA                   USER32  
;006CA4BC         IsDialogMessageA              USER32  
;006CA4C0         TranslateAcceleratorA         USER32  
;006CA4C4         GetCursorPos                  USER32  
;006CA4C8         SetActiveWindow               USER32  
;006CA4D0         GetFileVersionInfoSizeA       VERSION 
;006CA4D4         GetFileVersionInfoA           VERSION 
;006CA4D8         VerQueryValueA                VERSION 
;006CA4E0         timeBeginPeriod               WINMM   
;006CA4E4         timeSetEvent                  WINMM   
;006CA4E8         timeKillEvent                 WINMM    
;006CA4F0         timeGetDevCaps                WINMM   
;006CA4F4         timeEndPeriod                 WINMM   
;006CA4FC 17      recvfrom                      WSOCK32 
;006CA500 21      setsockopt                    WSOCK32 
;006CA504 20      sendto                        WSOCK32 
;006CA508 116     WSACleanup                    WSOCK32 
;006CA50C 101     WSAAsyncSelect                WSOCK32 
;006CA510 108     WSACancelAsyncRequest         WSOCK32 
;006CA514 7       getsockopt                    WSOCK32 
;006CA518 111     WSAGetLastError               WSOCK32 
;006CA51C 11      inet_ntoa                     WSOCK32 
;006CA520 15      ntohs                         WSOCK32 
;006CA524 14      ntohl                         WSOCK32 
;006CA528 9       htons                         WSOCK32 
;006CA52C 115     WSAStartup                    WSOCK32 
;006CA530 57      gethostname                   WSOCK32 
;006CA534 52      gethostbyname                 WSOCK32 
;006CA538 3       closesocket                   WSOCK32 
;006CA53C 23      socket                        WSOCK32 
;006CA540 2       bind                          WSOCK32 
;006CA544 8       htonl                         WSOCK32 
;006CA54C         StgCreateDocfile              ole32   
;006CA550         CoRevokeClassObject           ole32   
;006CA554         OleInitialize                 ole32   
;006CA558         CoRegisterClassObject         ole32   
;006CA55C         OleUninitialize               ole32   
;006CA560         CoDisconnectObject            ole32   
;006CA564         StringFromGUID2               ole32   
;006CA568         StgOpenStorage                ole32   
;006CA56C         CoFileTimeNow                 ole32   
;006CA570         StringFromCLSID               ole32   
;006CA574         CLSIDFromString               ole32   
;006CA578         OleSaveToStream               ole32   
;006CA57C         OleLoadFromStream             ole32   
;006CA580         CoCreateInstance              ole32   
;006CA584         OleRun                        ole32   
