
DK_fnc_initPlayerServer = compileFinal preprocessFileLineNumbers "initPlayerServer.sqf";


/// VARIABLE'S For Setup
DK_delVeh_time = 180;
DK_delVeh_dis = 200;

DK_wheels = ["wheel_1_1_steering","wheel_2_1_steering","wheel_1_2_steering","wheel_2_2_steering"];
DK_centerPostionMap = getMarkerPos "DK_mkr_middleMapSearch";

/// Bonus Player
call compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\DK_params_bonus.sqf";

"DK_mkrMapNFOicon_2" setMarkerColorLocal "Color5_FD_F";

DK_isDedi = if (isDedicated) then { -2 } else { 0 };


if (isServer) then
{
///	 --=== COMPILE SERVER FUNCTION'S ===-- 
	DK_cntdwnTime = 0;

	// Target mission in array for On Off loop manager
	DK_MIS_allTargets = [];

	// Get Params
	DK_weaponStart_init = "Par_weaponStart" call BIS_fnc_getParamValue;
	DK_weaponStart = compileFinal "DK_weaponStart_init";

	// Core spawn
	DK_fnc_SP_setVarT = compileFinal preprocessFileLineNumbers "DK_Functions\spawn\DK_fnc_spawnProtect_setVarTrue.sqf";
	DK_fnc_SP_setVarF = compileFinal preprocessFileLineNumbers "DK_Functions\spawn\DK_fnc_spawnProtect_setVarFalse.sqf";

	// Clean Up object/car/body on MAP
	call compileFinal preprocessFileLineNumbers "DK_Functions\cleanUpMap\DK_fncs_cleanUpMap.sqf";
	DK_fnc_addAllTo_CUM = compileFinal preprocessFileLineNumbers "DK_Functions\cleanUpMap\DK_fnc_addAllTo_CUM.sqf";
	DK_fnc_addVehTo_CUM = compileFinal preprocessFileLineNumbers "DK_Functions\cleanUpMap\DK_fnc_addVehTo_CUM.sqf";
	[] execVM "DK_Functions\cleanUpMap\DK_loop_cleanUpMap.sqf";
	[] execVM "DK_Functions\cleanUpMap\DK_loop_handleEmptyVehForAddTo_CUM.sqf";

	// Clean Up object/car/body on SPAWN Area
	DK_fnc_spawnCleanUp = compileFinal preprocessFileLineNumbers "DK_Functions\spawn\DK_fnc_spawnCleanUp.sqf";
	[] execVM "DK_Functions\spawn\DK_loop_spawnCleanUp.sqf";

	// Clean Up almost all Weapon Holder Simulated on MAP
	DK_fnc_checkWpHold_CUM = compileFinal preprocessFileLineNumbers "DK_Functions\cleanUpMap\DK_fnc_checkWeaponHolder_CUM.sqf";
	[] execVM "DK_Functions\cleanUpMap\DK_loop_cleanUpAllWpHolderSim.sqf";

	// Init Vehicle's
	DK_fnc_init_veh = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fnc_init_vehicle.sqf";
	DK_fnc_init_vehAir = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fnc_init_vehicle_air.sqf";
	DK_fnc_init_vehFlyAir = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fnc_init_vehicle_flyingAir.sqf";
	DK_fnc_init_boat = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fnc_init_boat.sqf";
	call compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fncs_exploseEngine.sqf";
	call compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fncs_exploseFuelTank.sqf";

	// Boost Vehicle Player at SPAWN
	DK_fnc_addEhServ_boost = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_addEhKilledAndVarServ_boost.sqf";

	// Handle Score
	DK_fnc_AddHdlPlyScrKF =  compileFinal preprocessFileLineNumbers "DK_Functions\scores\DK_fnc_AddHandlePlayerScoreAndKF.sqf";
	DK_fnc_hdlPlyScr =  compileFinal preprocessFileLineNumbers "DK_Functions\scores\DK_fnc_handlePlayerScore.sqf";
	DK_fnc_addScr =  compileFinal preprocessFileLineNumbers "DK_Functions\scores\DK_fnc_addPlayerScore.sqf";

	// Killfeed
	DK_fnc_hdlPlyKF =  compileFinal preprocessFileLineNumbers "DK_Functions\scores\DK_fnc_handlePlayerKillFeed.sqf";

	// Loadout's ambient life & bonus
	call compileFinal preprocessFileLineNumbers "DK_Functions\loadouts\DK_fnc_loadouts_AI.sqf";

	// Variable's Texts UI
	call compileFinal preprocessFileLineNumbers "DK_Texts\DK_var_texts.sqf";

	// Set Info Score to PLayer first respawn
	DK_fnc_setInfoScorePLayerCo = compileFinal preprocessFileLineNumbers "DK_Functions\spawn\DK_fnc_setInfoScorePlayerCo.sqf";

	// Bonus
//	DK_fnc_bonus_LJ_cntDwn =  compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_countDown_cl.sqf";

};

if (hasInterface) then
{
	0 fadeSound 0;

/// // Init first spawn
	DK_thisIsFirstStarting = true;

///	 --=== COMPILE LOCAL PLAYER FUNCTION'S ===-- 

	// Game time HUD
	DK_fnc_gameTime_cl = compileFinal preprocessFileLineNumbers "DK_Functions\gameTime\DK_fnc_gameTime_cl.sqf";

	// VARIABLE'S Texts UI
	call compileFinal preprocessFileLineNumbers "DK_Texts\DK_var_texts_cl.sqf";

	// SPAWN
	DK_fnc_init_playerAtSpawn_cl = compileFinal preprocessFileLineNumbers "DK_Functions\spawn\DK_fnc_init_playerAtSpawn_cl.sqf";
	DK_fnc_handle_playerRespawn = compileFinal preprocessFileLineNumbers "DK_Functions\spawn\DK_fnc_handle_playerRespawn_cl.sqf";

	// LIMIT MAP
	[] execVM "DK_Functions\mapLimit\DK_trg_mapLimitProtect_cl.sqf";
	DK_fnc_trg_mapLimitProtect_cl = compileFinal preprocessFileLineNumbers "DK_Functions\mapLimit\DK_fnc_trg_mapLimitProtect_cl.sqf";

	// CAPACITY Player
	DK_fnc_getOutAPB = compileFinal preprocessFileLineNumbers "DK_Functions\playerCapacity\DK_fnc_getOutAPB_cl.sqf";
	call compileFinal preprocessFileLineNumbers "Community_Scripts\JumpMF\MF_Compile_Local.sqf";
	[] execVM "Community_Scripts\JumpMF\init.sqf";

	// SOUND 3D a
	DK_fnc_say3Db = compileFinal preprocessFileLineNumbers "DK_Functions\sounds\DK_fnc_say3DGlobal_cl.sqf";

	// Handle Team Killer
	DK_fnc_handleTK =  compileFinal preprocessFileLineNumbers "DK_Functions\teamKiller\DK_fnc_handleTK_cl.sqf";

	/// // BONUS Player
	// Boost
	DK_fnc_init_boost = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_init_boost.sqf";
	DK_fnc_smoke_boost_cl = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_smoke_boost_cl.sqf";
	DK_fnc_boost = compile preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_boostAction_cl.sqf";
	DK_fnc_slcNosSnd = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_selectNosSound_cl.sqf";
	DK_fnc_setParticle_cl = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_setParamsSmoke_boost_cl.sqf";
	DK_fnc_addAction_boost_cl = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\boost\DK_fnc_addAct_boost_cl.sqf";

	// Ambulance
	DK_fnc_revivePlayer = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_revivePlayer_cl.sqf";
	DK_fnc_addActAmbulance = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_bonus_amb_addAction_cl.sqf";
	DK_fnc_chckAllowedAmb = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_bonus_amb_checkIfAllowed_cl.sqf";
	DK_add_hudAmbulance = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_bonus_amb_HUD_cl.sqf";
	DK_fnc_hudAmbulance = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_bonus_amb_iconMarker_cl.sqf";
	DK_loop_amb_beacon = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_bonus_amb_loop_beacon_cl.sqf";

	// Little Jacob
	DK_bonus_LJ_addAction = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_addAction_cl.sqf";
	DK_fnc_bonus_LJ_menu = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_menu_cl.sqf";
	DK_fnc_bonus_LJ_cntDwn =  compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_countDown_cl.sqf";
	DK_bonus_LJ_addHud_caller = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_bonus_LJ_addHUD_caller_cl.sqf";
	DK_fnc_bonus_LJ_hud_caller = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_iconMarker_caller_cl.sqf";
	DK_bonus_LJ_addHud_fam = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_bonus_LJ_addHUD_fam_cl.sqf";
	DK_fnc_bonus_LJ_hud_fam = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_iconMarker_fam_cl.sqf";
	call compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fncs_bonus_LJ_esc_cl.sqf";

	call compileFinal preprocessFileLineNumbers "DK_Functions\DK_fncs_divers_cl.sqf";	// Compil final

	// Repair capacity; THX Zealot111
	DK_addActRepair = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fnc_addActionRepair_cl.sqf";
	zltDK_fnc_repairCond = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\zltDK_fnc_repairCond_cl.sqf";
	zltDK_fnc_doRepair = compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\zltDK_fnc_doRepair_cl.sqf";

	///	// MISSIONS
	[] execVM "DK_Functions\missions\DK_MIS_init_cl.sqf";

	///	// ORDER FORCES
	DK_loop_policeOffroad_beacon_cl = compileFinal preprocessFileLineNumbers "DK_Functions\reinforcementAndOrderForces\DK_loop_policeOffroad_beacon_cl.sqf";
	call compileFinal preprocessFileLineNumbers "DK_Functions\reinforcementAndOrderForces\siren\DK_fncs_sirens_cl.sqf"; // compile final
};

// -== SERVER & CLIENT'S ==-

call compileFinal preprocessFileLineNumbers "DK_Functions\DK_fncs_divers_common.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fncs_vehicle_handleDamage.sqf";

// Repair capacity; THX Zealot111
call compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\zltDK_fncs_repair.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\zltDK_fncs_repair_clSrv.sqf";

// SOUND 3D b
DK_fnc_say3D = compileFinal preprocessFileLineNumbers "DK_Functions\sounds\DK_fnc_say3DGlobalCheck_cl.sqf";

// ADD LOADOUT on Respawn Screen
[west, "normal_SUVblack"] call BIS_fnc_addRespawnInventory;
[west, "normal_SUVgrey"] call BIS_fnc_addRespawnInventory;
[west, "normal_SUVorange"] call BIS_fnc_addRespawnInventory;
[west, "normal_SUVred"] call BIS_fnc_addRespawnInventory;

[west, "normal_OffroadBeige"] call BIS_fnc_addRespawnInventory;
[west, "normal_OffroadBlue"] call BIS_fnc_addRespawnInventory;
[west, "normal_OffroadDarkred"] call BIS_fnc_addRespawnInventory;
[west, "normal_OffroadRed"] call BIS_fnc_addRespawnInventory;
[west, "normal_OffroadWhite"] call BIS_fnc_addRespawnInventory;

[west, "normal_TruckBlack"] call BIS_fnc_addRespawnInventory;
[west, "normal_TruckRed"] call BIS_fnc_addRespawnInventory;
[west, "normal_TruckWhite"] call BIS_fnc_addRespawnInventory;


// Radio Station Car
call compileFinal preprocessFileLineNumbers "DK_Functions\MP3car\DK_MP3car_Init.sqf";
//execVM "DK_Functions\MP3car\DK_MP3car_Init.sqf";


