%include "macros/extern.inc"

; This header works with sym.asm which defines the Vanilla symbols
; This header will be split up as it becomes larger

; ### Constants ###

%define AddressList_length 8
%define StripClass_Size 980

; ### Variables ###
cextern hook_wwdebug_printf
; Session
cextern SessionClass_this
cextern SessionClass__Create_Connections
cextern GameActive
cextern SessionType
cextern UnitCount
cextern TechLevel
cextern AIPlayers
cextern AIDifficulty
cextern HarvesterTruce
cextern BridgeDestroy
cextern FogOfWar
cextern Crates
cextern ShortGame
cextern Bases
cextern MCVRedeploy
cextern Credits
cextern GameSpeed
cextern MultiEngineer
cextern AlliesAllowed
cextern Frame
cextern GameIDNumber
cextern PlayerColor
cextern TournamentGame

;ini
cextern INIClass_SUN_INI 

;need to fix those two, should set them in sym.asm
%define LEFT_STRIP 0x00749874
%define RIGHT_STRIP 0x00749C48

; ### Functions ###

; INI
cextern INIClass__INIClass
cextern INIClass__Load
cextern INIClass__GetBool
cextern INIClass__GetInt
cextern INIClass__GetString
cextern INIClass__GetFixed

; File
cextern FileClass__FileClass
cextern FileClass__Is_Available
cextern FileClass__Open
cextern FileClass__Close
cextern FileClass__Write

; ### imports ###
cextern sendto
cextern recvfrom
cextern htonl
cextern htons

cextern _imp__GetCommandLineA
cextern _imp__timeGetTime
cextern _imp__LoadLibraryA
cextern _imp__GetProcAddress
cextern _imp__GetCurrentProcess
cextern SetFocus
cextern SetWindowPos
cextern InvalidateRect

cextern WWDebug_Printf
cextern hWndParent
; ### definitions of common structures ###

struc sockaddr_in
    .sin_family     RESW 1
    .sin_port       RESW 1
    .sin_addr       RESD 1
    .sin_zero       RESB 8
endstruc

struc ListAddress
    .port:      RESD 1
    .ip:        RESD 1
endstruc

struc NetAddress
    .port:      RESD 1
    .ip:        RESD 1
    .zero:      RESW 1
endstruc

struc SpawnAddress
    .pad1:      RESD 1
    .id:        RESD 1
    .pad2:      RESW 1
endstruc

; ### sym.asm (should maybe sort this) ###

; Memory
cextern new
cextern memcpy
cextern memset

; House
cextern HouseClassArray
cextern HouseClassArray_Count
cextern HouseTypesArray
cextern HouseClass__Assign_Handicap
cextern HouseClass__Make_Ally
cextern HouseClass__Is_Ally
cextern Assign_Houses
cextern Get_MP_Color
cextern HouseType_From_Name
cextern Read_Scenario_Houses
cextern GetHouseByUserName     ; Defined in ts_util.c
cextern store_house_spawn_location
cextern CurrentObjectsArray
cextern CurrentObjectsArray_Count

; Arrays
cextern UnitClassArray_Count
cextern TeamTypesArray_Count
cextern TeamTypesArray     

; Random
cextern Seed
cextern Init_Random

; Message
cextern MessageListClass_this
cextern PlayerPtr
cextern MessageListClass__Add_Message
cextern Get_Message_Delay_Or_Duration
cextern Message_Input_Player_Dead
cextern MessageToIPaddr
cextern MessageToPort
cextern MessageToAFI

; Network
cextern ListenPort
cextern UDPInterfaceClass__UDPInterfaceClass
cextern WinsockInterface_this
cextern WinsockInterfaceClass__Init
cextern UDPInterfaceClass__Open_Socket
cextern WinsockInterfaceClass__Start_Listening
cextern WinsockInterfaceClass__Discard_In_Buffers
cextern WinsockInterfaceClass__Discard_Out_Buffers
cextern IPXManagerClass_this
cextern IPXManagerClass__Set_Timing
cextern IPXAddressClass__IPXAddressClass
cextern IPXManagerClass__Connection_Name

cextern MaxAhead
cextern MaxMaxAhead
cextern FrameSendRate
cextern LatencyFudge
cextern RequestedFPS
cextern ProtocolVersion
cextern ally_by_spawn_location

cextern Init_Network
cextern NameNodes_CurrentSize
cextern HumanPlayers

; Scenario
cextern ScenarioName
cextern Start_Scenario
cextern NameNodeVector
cextern NameNodeVector_Add
cextern SessionClass__Read_Scenario_Descriptions
cextern ScenarioStuff
cextern SelectedDifficulty
cextern SpecialClass__Special

; Save games
cextern Load_Game

; Mouse
cextern WWMouseClas_Mouse
cextern MouseClass_Map
cextern is_coord_shrouded
cextern ScreenHeight
cextern ScreenWidth
cextern VisibleRect__FromLeft
cextern VisibleRect__FromTop
cextern VisibleRect__Width
cextern VisibleRect__Height
cextern WWKeyboard
cextern WWKeyboardClass__Down
cextern Left_Shift_Key
cextern Right_Shift_Key

; Aircraft
cextern Loop_Test_Aircraft

; Statistics
cextern StatisticsPacketSent
cextern WOLGameID

; Sidebar
;cextern LEFT_STRIP
;cextern RIGHT_STRIP
cextern MultiplayerDebug

; clib
cextern __strcmpi
cextern _strtok
cextern _sprintf
cextern stristr_

; Mumble
cextern initMumble
cextern updateMumble
cextern set_team_name
cextern set_tean_name_spec
