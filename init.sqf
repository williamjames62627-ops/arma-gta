
enableSaving [false, false];

enableSentences false;



/// COMMUNITY SCRIPTS
// Repack Mag ; THX to Outlawed
[] execVM "outlw_magRepack\MagRepack_init_sv.sqf";


DK_MIS_fnc_flipVeh = compileFinal preprocessFileLineNumbers "DK_Functions\missions\DK_MIS_fnc_flipVehicle.sqf";
DK_MIS_fnc_liftFlipVeh = compileFinal preprocessFileLineNumbers "DK_Functions\missions\DK_MIS_fnc_liftFlipVehicle.sqf";

// For BattleEye
if !(hasInterface) exitWith {};

0 spawn
{
	waitUntil {!isNull player};

	[player, didJIP] remoteExecCall ["DK_fnc_initPlayerServer", 2];
};
