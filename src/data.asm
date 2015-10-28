[org 0xA69000]

str_MyIdField db "MYID",0
str_AccountNameField db "ACCN",0
str_NoWindowFrame db "NoWindowFrame",0
str_kernel32dll db "Kernel32.dll",0
str_SetProcessAffinityMask db "SetProcessAffinityMask",0
str_SingleProcAffinity db "SingleProcAffinity",0
str_GameID          db "GameID", 0
str_gcanyonmap      db "blitz_test.map", 0 
str_debugplayer     db "debugplayer",0
str_debugplayer2    db "debugplayer2",0
str_wsock32_dll     db "wsock32.dll",0
str_inet_addr       db "inet_addr",0
str_localhost       db "127.0.0.1",0
str_spawn_ini       db "SPAWN.INI",0
str_Settings        db "Settings",0
str_UnitCount       db "UnitCount",0
str_Scenario        db "Scenario",0
str_Empty           db "",0
str_GameSpeed       db "GameSpeed",0
str_Seed            db "Seed",0
str_TechLevel       db "TechLevel",0
str_AIPlayers       db "AIPlayers",0
str_AIDifficulty    db "AIDifficulty",0
str_HarvesterTruce  db "HarvesterTruce",0
str_BridgeDestroy   db "BridgeDestroy",0
str_FogOfWar        db "FogOfWar",0
str_Crates          db "Crates",0
str_ShortGame       db "ShortGame",0
str_Bases           db "Bases",0
str_MCVRedeploy     db "MCVRedeploy",0
str_Credits         db "Credits",0
str_Name            db "Name",0
str_Side            db "Side",0
str_Color           db "Color",0
str_OtherSectionFmt db "Other%d",0
str_Port            db "Port",0
str_Ip              db "Ip",0
str_SpawnArg        db "-SPAWN",0
str_MultiEngineer   db "MultiEngineer",0
str_Firestorm       db "Firestorm",0
str_HouseColors     db "HouseColors",0
str_HouseCountries  db "HouseCountries",0
str_HouseHandicaps  db "HouseHandicaps",0
str_Tunnel          db "Tunnel",0
str_SpawnLocations  db "SpawnLocations",0
str_IsSinglePlayer  db "IsSinglePlayer",0
str_LoadSaveGame    db "LoadSaveGame",0
str_SaveGameName    db "SaveGameName",0
str_MultipleFactory db "MultipleFactory",0
str_AlliesAllowed   db "AlliesAllowed",0
str_SidebarHack     db "SidebarHack",0
str_BuildOffAlly    db "BuildOffAlly",0
str_CustomLoadScreen db "CustomLoadScreen",0
str_Host             db "Host",0

str_DifficultyModeComputer db "DifficultyModeComputer",0
str_DifficultyModeHuman db "DifficultyModeHuman",0

str_Multi1          db "Multi1",0
str_Multi2          db "Multi2",0
str_Multi3          db "Multi3",0
str_Multi4          db "Multi4",0
str_Multi5          db "Multi5",0
str_Multi6          db "Multi6",0
str_Multi7          db "Multi7",0
str_Multi8          db "Multi8",0

str_HouseAllyOne 		db "HouseAllyOne",0
str_HouseAllyTwo 		db "HouseAllyTwo",0
str_HouseAllyThree 		db "HouseAllyThree",0
str_HouseAllyFour 		db "HouseAllyFour",0
str_HouseAllyFive 		db "HouseAllyFive",0
str_HouseAllySix 		db "HouseAllySix",0
str_HouseAllySeven	 	db "HouseAllySeven",0

str_Multi1_Alliances db "Multi1_Alliances",0
str_Multi2_Alliances db "Multi2_Alliances",0
str_Multi3_Alliances db "Multi3_Alliances",0
str_Multi4_Alliances db "Multi4_Alliances",0
str_Multi5_Alliances db "Multi5_Alliances",0
str_Multi6_Alliances db "Multi6_Alliances",0
str_Multi7_Alliances db "Multi7_Alliances",0
str_Multi8_Alliances db "Multi8_Alliances",0

str_Spawn1              db "Spawn1",0
str_Spawn2              db "Spawn2",0
str_Spawn3              db "Spawn3",0
str_Spawn4              db "Spawn4",0
str_Spawn5              db "Spawn5",0
str_Spawn6              db "Spawn6",0
str_Spawn7              db "Spawn7",0
str_Spawn8              db "Spawn8",0

str_IsSpectator     db "IsSpectator",0

str_message_fmt db "%s: %s",0

str_AutoSSFileNameFormat db"AUTOSS\\AutoSS-%d-%d_%d.PCX",0
str_AutoSSDir db"./AutoSS",0

str_stats_dmp: db "stats.dmp",0

str_UseGraphicsPatch: db "UseGraphicsPatch",0

str_ForceLowestDetailLevel db"ForceLowestDetailLevel",0
str_InvisibleSouthDisruptorWave db"InvisibleSouthDisruptorWave",0

str_Video_Windowed: db"Video.Windowed",0
str_Video_WindowedScreenHeight db"Video.WindowedScreenHeight",0
str_Video_WindowedScreenWidth db"Video.WindowedScreenWidth",0

str_InternetDisabled db"This version of Tiberian Sun only supports online play on CnCNet 5  (www.cncnet.org)",0

str_NoCD db"NoCD",0

str_SaveGameLoadFolder      db"Saved Games\%s",0,0,0,0,0,0,0,0
str_SaveGameFolderFormat    db"Saved Games\*.%3s",0
str_SaveGameFolderFormat2   db"Saved Games\SAVE%04lX.%3s",0 
str_SaveGamesFolder        db"Saved Games",0

str_bue_li24_pcx      db"bue_li24.pcx",0
str_bue_mi24_pcx      db"bue_mi24.pcx",0
str_bue_ri24_pcx      db"bue_ri24.pcx",0

_2Bin:               INCBIN "res/2.bin"
_1Bin:               INCBIN "res/1.bin"