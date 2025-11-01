%include "macros/datatypes.inc"

; src\auto_ss.asm
gbool RunAutoSS, 0
gint DoingAutoSS, 0

; src\attack_neutral_units.asm
gbool AttackNeutralUnits, 0

; src\auto_deploy_mcv.asm
gbool AutoDeployMCV, false

; src\briefing_screen_mission_start.asm
gint PlayerSide, 0
gbool SkipBriefingOnMissionStart, 0

; src\buildconst_harvesterunit_baseunit.asm
gint AlexB_HarvesterUnit, 0
gint AlexB_BuildRefinery, 0

; src\center_team.asm
gint DoubleTapFrame, 0x7fffffff
gint LastTeamNumber, 0
gint DoubleTapInterval, 30

; src\chatallies.asm
gstring str_ToAllies, "(Allies): "
gstring str_ToAll, "(All): "
gstring str_ToOne, "(one): "
gstring str_ToSpectators, "(Specs): "

gbool ChatToAlliesFlag, 0
gbool ChatToAllFlag, 0
gbool ChatToOneFlag, 0
gbool ChatToSpectatorsFlag, 0

; src\disable_edge_scrolling.asm
gbool DisableEdgeScrolling, false

; src\high_res_crash.asm
gint BottomInfoPanel, 0

; src\manual_aim_sams.asm
gbool AimableSams, 0

; src\mouse_always_in_focus.asm
gbool MouseAlwaysInFocus, 0
gbool MouseInFocusOnce, 0

; src\mouse_behavior.asm
gint DragDistance, 4
gbool OnlyRightClickDeselect, false

; src\mpdebug.asm
gbool already_filled_rect, false

; src\multiplayer_movies.asm
gbool NetworkRefreshStarted, false

; src\multiplayer_units_placing.asm
gbool IsSpawnXAircraft, false
cglobal UsedSpawnsArray
section .bss
    UsedSpawnsArray:           RESD 8

; src\no_window_frame.asm
gbool NoWindowFrame, 1

; src\oil_derricks.asm
gint ProduceCashFrameDelay, 180

; src\online_optimizations.asm
gint LastRenderTime, 0
gint WFPRenderInterval, 16

; src\record_rng_func.asm
gbool NoRNG, 0

; src\scrap_metal_explosion.asm
gbool ScrapMetal, false

; src\scrollrate_fix.asm
gint ScrollDelay, 0

; src\smarter_firesale.asm
gbool LeaveABuilding, false
gint ObjectCount, 0

; src\smarter_harvesters.asm
gint ClosestFreeRefinery, 0
gint ClosestFreeRefineryDistance, 0
gint ClosestPossiblyOccupiedRefinery, 0
gint ClosestPossiblyOccupiedRefineryDistance, 0
gint OldHarvDistance, 0

; src\unit_self_heal_repair_step.asm
gint UnitSelfHealRepairStep, 1

; src\spawner\auto-surrender.asm
gbool AutoSurrender, 0

; src\spawner\build_off_ally.asm
gbool BuildOffAlly, 0

; src\spawner\protocol_zero.asm
gbyte NewFrameSendRate, 2

; src\spawner\random_map.asm
gbool RandomMap, 0

; src\spawner\spawner.asm
gint SpawnerActive, 0
cglobal INIClass_SPAWN
cglobal SpawnLocationsArray
cglobal SpawnLocationsHouses
cglobal DifficultyName

gbool SavesDisabled, true
gbool QuickMatch, false
gbool IsHost, true
gbool UseMPAIBaseNodes, false
gbool PlayMoviesInMultiplayer, false
gbool DifficultyBasedAINames, false
gint CampaignID, 0

gstring MapHash, "", 256

section .bss
    INIClass_SPAWN             RESB 256 ; FIXME: make this a local variable
    SpawnLocationsArray        RESD 8
    SpawnLocationsHouses       RESD 8
    DifficultyName             RESB 30

; src\spawner\spectators.asm
gbool SpectatorStuffInit, 0
cglobal IsSpectatorArray
section .bss
    IsSpectatorArray           RESD 8
