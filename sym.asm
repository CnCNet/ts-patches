%include "macros/setsym.inc"

; Memory
setcglob 0x006B51D7, new
setcglob 0x006B63F0, memcpy
setcglob 0x006C0080, memset
setcglob 0x006B766C, _controlfp

; House
setcglob 0x007E1558, HouseClassArray
setcglob 0x007E155C, HouseClassArray_Vector
setcglob 0x007E1568, HouseClassArray_Count
setcglob 0x007E21D4, HouseTypesArray
setcglob 0x004BB460, HouseClass__Assign_Handicap
setcglob 0x004BDB30, HouseClass__Make_Ally
setcglob 0x004BDB50, HouseClass__Make_Ally_House
setcglob 0x004BD9E0, HouseClass__Is_Ally
setcglob 0x004BD9E0, HouseClass__Is_Ally_HI
setcglob 0x004BDA20, HouseClass__Is_Ally_HH
setcglob 0x004BDA60, HouseClass__Is_Ally_Techno
setcglob 0x004CB950, HouseClass__Is_Player
setcglob 0x004BEEA0, HouseClass__Manual_Place
setcglob 0x004BE200, HouseClass__Begin_Production
setcglob 0x004BF4C0, HouseClass__MPlayer_Defeated
setcglob 0x004BF910, HouseClass__Blowup_All
setcglob 0x004C4730, HouseClass__House_From_HouseType
setcglob 0x004CDEF0, HouseTypeClass__From_Name
setcglob 0x004974A0, FactoryClass__Get_Product
setcglob 0x00497470, FactoryClass__Has_Completed
setcglob 0x005DE210, Assign_Houses
setcglob 0x005EEF70, Get_MP_Color
setcglob 0x004CDEF0, HouseType_From_Name
setcglob 0x004C2E40, Read_Scenario_Houses
setcglob 0x006FB630, Player_Active
setcglob 0x00674600, WaypointPathClass_GetWaypoint

; TechnoClass
setcglob 0x0040F2A0, TechnoClass_What_Weapon_Should_I_Use
setcglob 0x00632310, TechnoClass__Can_Player_Fire
setcglob 0x005872A0, ObjectClass__InAir
setcglob 0x00403570, Is_Techno
setcglob 0x00586640, ObjectClass__Who_Can_Build_Me

; FootClass
setcglob 0x00584BF0, Is_Foot

; AircraftClass
setcglob 0x0040BA40, AircraftClass__Mission_Attack

; BuildingClass
setcglob 0x00436200, BuildingClass__Do_Animation

; Arrays
setcglob 0x007B3468, UnitClassArray_Count
setcglob 0x007E4850, TeamTypesArray_Count
setcglob 0x007E4844, TeamTypesArray
setcglob 0x0070D850, PlayerColorMap
setcglob 0x007E4058, DynamicVectorClass_AircraftClass
setcglob 0x007E4858, CurrentObjectsArray
setcglob 0x007E485C, CurrentObjectsArray_Vector
setcglob 0x007E4868, CurrentObjectsArray_Count
setcglob 0x00806DD0, DynamicVectorClass_Movies
setcglob 0x00806DD4, DynamicVectorClass_Movies_Vector
setcglob 0x00806DE0, DynamicVectorClass_Movies_ActiveCount

setcglob 0x007B345C, DynamicVectorClass_UnitClass_Array
setcglob 0x007E2304, DynamicVectorClass_InfantryClass_Array
setcglob 0x007E2310, DynamicVectorClass_InfantryClass_ActiveCount
setcglob 0x007E470C, DynamicVectorClass_BuildingClass_Array
setcglob 0x007E4718, DynamicVectorClass_BuildingClass_ActiveCount

setcglob 0x0076092C, SearchDirs
setcglob 0x006CD148, ArmorNames


; INI
setcglob 0x004E8A30, INIClass__INIClass
setcglob 0x00449F30, INIClass__Load
setcglob 0x004DE140, INIClass__GetBool
setcglob 0x004DD140, INIClass__GetInt
setcglob 0x004DDF60, INIClass__GetString
setcglob 0x004DD9F0, INIClass__GetFixed
setcglob 0x004DC8D0, INIClass__GetEntry
setcglob 0X004DC6A0, INIClass__EntryCount
setcglob 0x0074C378, INIClass_SUN_INI
setcglob 0x004DDBE0, INIClass__PutString
setcglob 0x004DC180, INIClass__Save
setcglob 0x004DB470, INIClass__Destroy
setcglob 0x004DC550, INIClass__Find_Section
setcglob 0x004DC770, INIClass__Find_Entry
setcglob 0x005C6710, RulesClass__Process
setcglob 0x005D1800, RulesClass__Objects
setcglob 0x005C6CF0, RulesClass__AudioVisual
setcglob 0x0074C488, Rules

; File
setcglob 0x004497B0, FileClass__FileClass
setcglob 0x004499C0, FileClass__Is_Available
setcglob 0x00449A40, FileClass__Open
setcglob 0x00449A10, FileClass__Close
setcglob 0x00449A10, CCFileClass__Close
setcglob 0x00449850, FileClass__Write
setcglob 0x004E8970, FileClass__dtor
setcglob 0x00449970, FileClass__Size
setcglob 0x00449880, FileClass__Read
setcglob 0x00561940, MonoClass__Printf
setcglob 0x004497B0, CCFileClass__CCFileClass
setcglob 0x004E8970, CCFileClass__Destroy
setcglob 0x00449880, CCFileClass__Read
setcglob 0x00449850, CCFileClass__Write
setcglob 0x00449A40, CCFileClass__Open
setcglob 0x004499C0, CCFileClass__Is_Available
setcglob 0x00449970, CCFileClass__Size
setcglob 0x005BE310, RawFileClass__RawFileClass
setcglob 0x005BE470, RawFileClass__Is_Available
setcglob 0x005BE9C0, RawFileClass__Create
setcglob 0x005BE290, RawFileClass__Destroy

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
setcglob 0x008670BC, WOL_SERVER_PORT ; Hijacking this for Mumble

; EventClass
setcglob 0x00493E40, EventClass__EventClass_PlayerID
setcglob 0x00493DE0, EventClass__EventClass_noarg
setcglob 0x004940A0, EventClass__EventClass_produce
setcglob 0x00494280, EventClass__EventClass_Execute
setcglob 0x005B1210, Queue_Exit
setcglob 0x007B3530, DoList
setcglob 0x007E15F8, OutList
setcglob 0x006CB1B8, FramesPerMinute
setcglob 0x007B353C, EventType_Offset
setcglob 0x005B58F0, Print_CRCs

; Random
setcglob 0x007E4934, Seed
setcglob 0x004E38A0, Init_Random
setcglob 0x005BE080, Random2Class__operator

; Message
setcglob 0x007E2C34, MessageListClass_this
setcglob 0x007E2284, PlayerPtr
setcglob 0x00572FE0, MessageListClass__Add_Message
setcglob 0x005734B0, MessageListClass__Concat_Message
setcglob 0x006B2330, Get_Message_Delay_Or_Duration
setcglob 0x007E24E4, Message_Input_Player_Dead
setcglob 0x005098D0, Message_Input
setcglob 0x005739E0, MessageListClass__Manage
setcglob 0x00573DC0, MessageListClass__Draw
setcglob 0x007E36A4, MessageToIPaddr
setcglob 0x007E36A8, MessageToPort
setcglob 0x007E36AC, MessageToAFI


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
setcglob 0x004F0F00, IPXManagerClass__Response_Time
setcglob 0x004EF040, IPXAddressClass__IPXAddressClass
setcglob 0x004F07E0, IPXManagerClass__Connection_Name

setcglob 0x007093C0, Radar_Movie_Playing
setcglob 0x007E250C, MaxAhead
setcglob 0x007E2524, MaxMaxAhead
setcglob 0x007E2510, FrameSendRate
setcglob 0x007E3FA8, LatencyFudge
setcglob 0x007E2514, RequestedFPS
setcglob 0x007E252C, PreCalcFrameRate
setcglob 0x007E2528, PreCalcMaxAhead
setcglob 0x00804D2C, FramesPerSecond
setcglob 0x00804D34, AverageFPS
setcglob 0x00804D30, AverageFPS2
setcglob 0x0080CA80, GameStartTime
setcglob 0x007E2464, ProtocolVersion
setcglob 0x007E289A, OutOfSync
setcglob 0x00574F90, Init_Network
setcglob 0x007E3EA0, NameNodes_CurrentSize
setcglob 0x007E2508, HumanPlayers
setcglob 0x007E3EA0, HumanNode_ActiveCount
setcglob 0x007E4720, GameOptionsClass_GameSpeed
setcglob 0x007E474C, GameOptionsClass_VoiceVolume
setcglob 0x007E473C, GameOptionsClass_ScreenWidth
setcglob 0x007E4740, GameOptionsClass_ScreenHeight
setcglob 0x007E4744, GameOptionsClass_StretchMovies

; Scenario
setcglob 0x007E28B8, ScenarioName
setcglob 0x005DB170, Start_Scenario
setcglob 0x007E3E90, NameNodeVector
setcglob 0x0044D690, NameNodeVector_Add
setcglob 0x005EE7D0, SessionClass__Read_Scenario_Descriptions
setcglob 0x007E2438, ScenarioStuff
setcglob 0x007E4724, SelectedDifficulty
setcglob 0x007E4548, SpecialClass__Special
setcglob 0x005DE580, Create_Units
setcglob 0x007E2650, CriticalRandomNumber
setcglob 0x00805E10, MapSeed
setcglob 0x007E4394, ScenarioInit

; Save games
setcglob 0x005D6910, Load_Game
setcglob 0x005D4FE0, Save_Game

; Mouse
setcglob 0x0074C8F0, WWMouseClas_Mouse
setcglob 0x00748348, MouseClass_Map
setcglob 0x007482C0, WWKeyboard
setcglob 0x0074C8F0, WWMouse
setcglob 0x007E47B0, Left_Shift_Key
setcglob 0x007E47B4, Right_Shift_Key
setcglob 0x004FB390, WWKeyboardClass__Down
setcglob 0x004FB4F0, WWKeyboardClass__Clear
setcglob 0x004FAF30, WWKeyboardClass__Check
setcglob 0x004FAF80, WWKeyboardClass__Get
setcglob 0x006A5FE0, WWMouseClass__Show_Mouse
setcglob 0x006A6140, WWMouseClass__Hide_Mouse
setcglob 0x0059C9D0, PrettyPrintKey
setcglob 0x007E47A8, ForceFire1
setcglob 0x007E47AC, ForceFire2
setcglob 0x007E47A0, Left_Alt_Key
setcglob 0x007E47A4, Right_Alt_Key
setcglob 0x007E47B8, QMove_Key1
setcglob 0x007E47BC, QMove_Key2

; MapClass
setcglob 0x0051E130, MapClass__GetCellFloorHeight
setcglob 0x0050F210, MapClass__Get_Target_Coord
setcglob 0x0052B870, MapClass__Cell_Is_Shrouded
setcglob 0x0050F280, MapClass__Coord_Cell
setcglob 0x0051E0A0, MapClass__Reveal_The_Map
setcglob 0x0052BBE0, MapClass__Fill_Map_With_Fog
setcglob 0x007B3304, dword_7B3304
setcglob 0x004B9470, GScreenClass__Input
setcglob 0x004B95A0, GScreenClass__Render
setcglob 0x004B96C0, GScreenClass__Do_Blit
setcglob 0x0061CBA0, TActionClass__Zoom_Out
setcglob 0x0061CB30, TActionClass__Zoom_In
setcglob 0x004B9440, GScreenClass__Flag_To_Redraw
setcglob 0x00475D90, DisplayClass__Init_IO
setcglob 0x004797D0, DisplayClass__Closest_Free_Spot

; Tactical
setcglob 0x0074C5F4, TacticalClassMap
setcglob 0x0080CE30, CellHeight
setcglob 0x0080CE34, CellWidth
setcglob 0x0080CED8, ViewPort_Dimensions
setcglob 0x0080CED8, ViewPort_Dimensions_Left
setcglob 0x0080CEDC, ViewPort_Dimensions_Top
setcglob 0x0080CEE0, ViewPort_Dimensions_Right
setcglob 0x0080CEE4, ViewPort_Dimensions_Bottom
setcglob 0x00618050, Tactical_618050
setcglob 0x0060F3C0, Tactical_AdjustForZ
setcglob 0x0060F0F0, Tactical_60F0F0

setcglob 0x005BCC40, RadarClass__Play_Movie
setcglob 0x005BBEE0, RadarClass__Radar_Activate
setcglob 0x00838038, IngameVQ_Count
setcglob 0x007497FC, RadarClass_14B4;
setcglob 0x00749804 ,RadarClass_14BC;


; Statistics
setcglob 0x007E4FD0, StatisticsPacketSent
setcglob 0x00867014, WOLGameID
setcglob 0x00568060, MultiScore__Present

; Others
setcglob 0x007A1790, VideoWindowed
setcglob 0x0070EC84, VideoBackBuffer
setcglob 0x007E4740, ScreenHeight
setcglob 0x007E473C, ScreenWidth
setcglob 0x007E288C, MultiplayerDebug
setcglob 0x007A2274, ViewPortRect
setcglob 0x0074C260, VisibleRect
setcglob 0x0074C260, VisibleRect__FromLeft
setcglob 0x0074C264, VisibleRect__FromTop
setcglob 0x0074C268, VisibleRect__Width
setcglob 0x0074C26C, VisibleRect__Height
setcglob 0x00509D50, Multiplayer_Debug_Print
setcglob 0x004082D0, WWDebug_Printf
setcglob 0x00865040, hWndParent
setcglob 0x00474E70, Fancy_Text_Print
setcglob 0x00474A50, Simple_Text_Print
setcglob 0x00685BC0, WndProc
setcglob 0x00865040, MainWindow
setcglob 0x007E4920, GameInFocus
setcglob 0x007E48FC, InScenario

; Sidebar
setcglob 0x0080C3BC, SidebarClass_Redraw_Buttons
setcglob 0x0074C240, SidebarLoc
setcglob 0x00749874, LEFT_STRIP
setcglob 0x00749C48, RIGHT_STRIP
setcglob 0x005F48F0, SidebarClass__StripClass__Flag_To_Redraw
setcglob 0x005F38C0, SidebarClass__Blit
setcglob 0x005F3560, SidebarClass__Draw_It
setcglob 0x005F2720, SidebarClass__Init_IO
setcglob 0x005F2900, SidebarClass__Init_For_House


; Audio
setcglob 0x00489E30, DSAudio_Set_Volume_All
setcglob 0x00489F20, DSAudio_Set_Volume_Percent
setcglob 0x007A27CC, DSAudio_SoundObject
setcglob 0x007A27DC, DSAudio_AudioDone
setcglob 0x007A2448, DSAudio
setcglob 0x00665B20, Is_Speaking

setcglob 0x00806E1C, Current_Movie_Ptr
setcglob 0x005646E0, MovieClass_Update
setcglob 0x00563CC0, Movie_Handle_Focus


; Debug
setcglob 0x007E4903, Debug_Quiet

; clib
setcglob 0x006B73A0, __strcmpi
setcglob 0x006B8E20, strcmp
setcglob 0x006B602A, _strtok
setcglob 0x006B602A, strtok
setcglob 0x006B52EE, _sprintf
setcglob 0x006B52EE, sprintf
setcglob 0x006B6A41, vsprintf
setcglob 0x006B69C1, fprintf
setcglob 0x006BC70C, fwrite

setcglob 0x006B6AB0, strchr
setcglob 0x006C6A96, strupr
setcglob 0x006B6730, stristr_
setcglob 0x006BA490, strlen
setcglob 0x006BE630, strcpy
setcglob 0x006B51F0, strncpy
setcglob 0x006B6BA0, strncat
setcglob 0x006BE766, strdup
setcglob 0x006B6730, strstr
setcglob 0x006B51D7, operator_new
setcglob 0x006B51CC, operator_delete
setcglob 0x006B67B0, sscanf
setcglob 0x006B5F65, atoi
setcglob 0x006BCA26, calloc
setcglob 0x006B67E4, free
setcglob 0x006B6CCB, tolower
setcglob 0x006B72CC, malloc
setcglob 0x006B7F72, realloc
setcglob 0x006B6A2E, fopen
setcglob 0x006B6944, fclose
setcglob 0x006BC288, fflush 

; winapi
setcglob 0x006B4D6C, sendto
setcglob 0x006B4D66, recvfrom
setcglob 0x006B4D24, htonl
setcglob 0x006B4D2A, htons

;;;
setcglob 0x007481A8, DynamicVectorClass__CommandClass
setcglob 0x004EB940, DynamicVectorClass__CommandClass__Add
setcglob 0x005DDFE0, MapSnapshot
setcglob 0x004E7050, Load_Keyboard_Hotkeys
setcglob 0x007481C0, Hotkeys
setcglob 0x007481C0, Hotkeys_Vector
setcglob 0x007481C4, Hotkeys_ActiveCount
setcglob 0x007481C8, Hotkeys_VectorMax
setcglob 0x004EBCD0, CCINIClass_Vector_Resize
setcglob 0x006D273C, AllianceCommandClass
setcglob 0x006D27E4, CenterREventCommandClass
setcglob 0x006d27AC, TogglePowerCommandClass
setcglob 0x006D26CC, GuardCommandClass
setcglob 0x006D2790, ToggleSellCommandClass
setcglob 0x006D2694, DeployCommandClass
setcglob 0x006D26B0, StopCommandClass
setcglob 0x006D26E8, ScatterCommandClass
setcglob 0x006D2720, CenterBaseCommandClass
setcglob 0x006D2758, SelectViewCommandClass
setcglob 0x006D2774, ToggleRepairCommandClass
setcglob 0x006D29C0, OptionsCommandClass
setcglob 0x006D2A30, SetView1CommandClass
setcglob 0x006D2AA0, View1CommandClass
setcglob 0x006D2ABC, FollowCommandClass
setcglob 0x006D2B80, WaypointCommandClass
setcglob 0x006D2BF0, DeleteWayPointCommandClass
setcglob 0x006D2BD4, SelectSameTypeCommandClass
setcglob 0x006D2B0C, SelectTeamCommandClass
setcglob 0x004E8C40, CreateTeamCommandClass_Execute
setcglob 0x004E90D0, CenterTeamCommandClass_Execute
setcglob 0x004EAB00, ScreenCaptureCommandClass_Execute
setcglob 0x005B10F0, Queue_Options

setcglob 0x00413760, Rect_Intersect

setcglob 0x00602480, Emergency_Exit
setcglob 0x006B6EAA, exit

;WSOCK32
setcglob 0x006CA504, _imp__sendto
setcglob 0x006CA4FC, _imp__recvfrom

setcglob 0x006CA24C, _imp__GetCommandLineA
setcglob 0x006CA16C, _imp__LoadLibraryA
setcglob 0x006CA1F8, _imp__FreeLibrary
setcglob 0x006CA2A4, _imp__GetFileAttributesA
setcglob 0x006CA174, _imp__GetProcAddress
setcglob 0x006CA1D0, _imp__GetCurrentProcess
setcglob 0x006CA4EC, _imp__timeGetTime
setcglob 0x006CA28C, _imp__GetStdHandle
setcglob 0x006CA2B4, _imp__WriteConsoleA
setcglob 0x006CA1E0, _imp__AllocConsole
setcglob 0x006CA19C, _imp__CloseHandle
setcglob 0x006CA1A0, _imp__MultiByteToWideChar
setcglob 0x006CA170, _imp__GetModuleHandleA
setcglob 0x006CA200, _imp__GetModuleFileNameA
setcglob 0x006CA39C, _imp__GetAsyncKeyState
setcglob 0x006CA3BC, _imp__SetWindowPos
setcglob 0x006CA448, _imp__GetKeyNameTextA
setcglob 0x006CA398, _imp__MapVirtualKeyA
setcglob 0x006CA394, _imp__ToAscii
setcglob 0x006CA3BC, SetWindowPos
setcglob 0x006CA388, _imp__GetClientRect
setcglob 0x006CA384, _imp__ClientToScreen
setcglob 0x006CA360, _imp__SetFocus
setcglob 0x006CA360, SetFocus
setcglob 0x006CA3C8, InvalidateRect
setcglob 0x006CA470, _imp__ShowWindow
setcglob 0x006CA46C, _imp__SetWindowLongA
setcglob 0x006CA468, _imp__GetWindowLongA
setcglob 0x005FF7D0, Top_Level_Exception_Filter
setcglob 0x00496350, PrintException
setcglob 0x006CA198, _imp__Sleep
setcglob 0x006CA3A0, _imp__GetSystemMetrics
setcglob 0x006CA4E4, _imp__timeSetEvent
setcglob 0x006CA1F4, _imp__CreateMutexA
setcglob 0x006CA20C, _imp__CreateEventA
;setcglob 0x00 _imp__CreateThread
setcglob 0x006CA1E8, _imp__WaitForSingleObject
setcglob 0x006CA1F0, _imp__ReleaseMutex
setcglob 0x006CA144, _imp__ResetEvent
setcglob 0x006Ca15C, _imp__SetEvent
setcglob 0x006CA194, _imp__GetLastError
setcglob 0x006CA458, _imp__MessageBoxA
setcglob 0x006CA36C, ShowCursor
setcglob 0x006CA36C, _imp__ShowCursor

; Theme
setcglob 0x00644190, Theme__Stop

; Tutorial
setcglob 0x006FE49C, TUTORIAL_INI_Name
setcglob 0x007E2440, Tutorials
setcglob 0x007E2444, TutorialActiveCount
setcglob 0x007E2448, TutorialMax
setcglob 0x007E244C, TutorialSorted

; Strings
setcglob 0x00472350, Fetch_String

;KERNEL32
setcglob 0x006CA0E8, _imp__ReadFile
setcglob 0x006CA0EC, _imp__SetFilePointer
setcglob 0x006CA18C, _imp__CreateFileA  


setcglob 0x0074950C, Current_Waypoint
setcglob 0x004EAF20, Delete_Waypoint

setcglob 0x0047C780, CC_Draw_Shape
setcglob 0x00559DE0, MixFileClass__CCFileClass__Retrieve
setcglob 0x0055A1C0, MixFileClass__Offset
setcglob 0x0074C5D8, PrimarySurface
setcglob 0x0074C5D0, SidebarSurface
setcglob 0x0074C5E4, TempSurface
setcglob 0x0074C5EC, CompositeSurface
setcglob 0x0074C5E0, AlternateSurface
setcglob 0x0074C5DC, HiddenSurface
setcglob 0x0048BB00, DSurface_FillRect
setcglob 0x0048C140, DSurface_Conversion_Type
setcglob 0x0069FAE0, Write_PCX_File

setcglob 0x00563670, Play_Movie
setcglob 0x00563B00, Play_Ingame_Movie
setcglob 0x0066B230, VQA_Windows_Message_Loop

setcglob 0x006CAB74, vtBSurface


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
