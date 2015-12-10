%include "macros/setsym.inc"

; winapi
setcglob 0x006B4D6C, sendto
setcglob 0x006B4D66, recvfrom
setcglob 0x006B4D24, htonl
setcglob 0x006CA24C, GetCommandLineA
setcglob 0x006B6730, stristr_
setcglob 0x006CA16C, LoadLibraryA
setcglob 0x006CA174, GetProcAddress
setcglob 0x006CA1D0, GetCurrentProcess
setcglob 0x006B52EE, _sprintf
setcglob 0x006CA4EC, timeGetTime ; idata pointer
setcglob 0x006B73A0, __strcmpi
setcglob 0x006B602A, _strtok

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

; Arrays
setcglob 0x007B3468, UnitClassArray_Count
setcglob 0x007E4850, TeamTypesArray_Count
setcglob 0x007E4844, TeamTypesArray     

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

; Statistics
setcglob 0x007E4FD0, StatisticsPacketSent
setcglob 0x00867014, WOLGameID

; Sidebar
;setcglob 0x00749874, LEFT_STRIP
;setcglob 0x00749C48, RIGHT_STRIP
