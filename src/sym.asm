; legacy, porting
%macro setglob 2
    global %2
    %2 equ %1
%endmacro

; for C
%macro setcglob 2
    global _%2
    _%2 equ %1
%endmacro

; for c++
%macro setxglob 3
    setcglob {%2}, {%1}
    global %3
    %3 equ _%2
%endmacro

; winapi
setglob 0x006B4D6C, sendto
setglob 0x006B4D66, recvfrom
setglob 0x006B4D24, htonl
setglob 0x006CA24C, GetCommandLineA
setglob 0x006B6730, stristr_
setglob 0x006CA16C, LoadLibraryA
setglob 0x006CA174, GetProcAddress
setglob 0x006CA1D0, GetCurrentProcess
setglob 0x006B52EE, _sprintf
setglob 0x006CA4EC, timeGetTime ; idata pointer
setglob 0x006B73A0, __strcmpi
setglob 0x006B602A, _strtok

; Memory
setglob 0x006B51D7, new
setglob 0x006B63F0, memcpy
setglob 0x006C0080, memset

; House
setglob 0x007E155C, HouseClassArray
setglob 0x007E1568, HouseClassArray_Count
setglob 0x007E21D4, HouseTypesArray
setglob 0x004BB460, HouseClass__Assign_Handicap
setglob 0x004BDB30, HouseClass__Make_Ally
setglob 0x004BD9E0, HouseClass__Is_Ally
setglob 0x005DE210, Assign_Houses
setglob 0x005EEF70, Get_MP_Color
setglob 0x004CDEF0, HouseType_From_Name
setglob 0x004C2E40, Read_Scenario_Houses

; Arrays
setglob 0x007B3468, UnitClassArray_Count
setglob 0x007E4850, TeamTypesArray_Count
setglob 0x007E4844, TeamTypesArray     

; INI
setglob 0x004E8A30, INIClass__INIClass
setglob 0x00449F30, INIClass__Load
setglob 0x004DE140, INIClass__GetBool
setglob 0x004DD140, INIClass__GetInt
setglob 0x004DDF60, INIClass__GetString
setglob 0x004DD9F0, INIClass__GetFixed

setglob 0x0074C378, INIClass_SUN_INI 

; File
setglob 0x004497B0, FileClass__FileClass
setglob 0x004499C0, FileClass__Is_Available
setglob 0x00449A40, FileClass__Open
setglob 0x00449A10, FileClass__Close
setglob 0x00449850, FileClass__Write

; Session
setglob 0x007E2458, SessionClass_this
setglob 0x005ED510, SessionClass__Create_Connections
setglob 0x007E4580, GameActive
setglob 0x007E2458, SessionType
setglob 0x007E2480, UnitCount
setglob 0x006FB628, TechLevel
setglob 0x007E2484, AIPlayers
setglob 0x007E2488, AIDifficulty
setglob 0x007E248D, HarvesterTruce
setglob 0x007E2474, BridgeDestroy
setglob 0x007E248F, FogOfWar
setglob 0x007E2475, Crates
setglob 0x007E2476, ShortGame
setglob 0x007E246C, Bases
setglob 0x007E2490, MCVRedeploy
setglob 0x007E2470, Credits
setglob 0x007E4720, GameSpeed
setglob 0x007E247C, MultiEngineer
setglob 0x007E248C, AlliesAllowed
setglob 0x007E4924, Frame
setglob 0x00867014, GameIDNumber
setglob 0x007E24DC, PlayerColor
setglob 0x00867008, TournamentGame

; Random
setglob 0x007E4934, Seed
setglob 0x004E38A0, Init_Random

; Message
setglob 0x007E2C34, MessageListClass_this
setglob 0x007E2284, PlayerPtr
setglob 0x00572FE0, MessageListClass__Add_Message
setglob 0x006B2330, Get_Message_Delay_Or_Duration
setglob 0x007E24E4, Message_Input_Player_Dead

; Network
setglob 0x0070FCF0, ListenPort
setglob 0x006A1E70, UDPInterfaceClass__UDPInterfaceClass
setglob 0x0074C8D8, WinsockInterface_this
setglob 0x006A1180, WinsockInterfaceClass__Init
setglob 0x006A2130, UDPInterfaceClass__Open_Socket
setglob 0x006A1030, WinsockInterfaceClass__Start_Listening
setglob 0x006A10A0, WinsockInterfaceClass__Discard_In_Buffers
setglob 0x006A1110, WinsockInterfaceClass__Discard_Out_Buffers
setglob 0x007E45A0, IPXManagerClass_this
setglob 0x004F05B0, IPXManagerClass__Set_Timing
setglob 0x004EF040, IPXAddressClass__IPXAddressClass

setglob 0x007E250C, MaxAhead
setglob 0x007E2524, MaxMaxAhead
setglob 0x007E2510, FrameSendRate
setglob 0x007E3FA8, LatencyFudge
setglob 0x007E2514, RequestedFPS
setglob 0x007E2464, ProtocolVersion

setglob 0x00574F90, Init_Network
setglob 0x007E3EA0, NameNodes_CurrentSize
setglob 0x007E2508, HumanPlayers

; Scenario
setglob 0x007E28B8, ScenarioName
setglob 0x005DB170, Start_Scenario
setglob 0x007E3E90, NameNodeVector
setglob 0x0044D690, NameNodeVector_Add
setglob 0x005EE7D0, SessionClass__Read_Scenario_Descriptions
setglob 0x007E2438, ScenarioStuff
setglob 0x007E4724, SelectedDifficulty

; Save games
setglob 0x005D6910, Load_Game

; Mouse
setglob 0x0074C8F0, WWMouseClas_Mouse
setglob 0x00748348, MouseClass_Map

; Statistics
setglob 0x007E4FD0, StatisticsPacketSent
setglob 0x00867014, WOLGameID

; Sidebar
;setglob 0x00749874, LEFT_STRIP
;setglob 0x00749C48, RIGHT_STRIP
