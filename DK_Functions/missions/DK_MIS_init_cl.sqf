if !(hasInterface) exitWith {};


// Time for debug / ending mission
DK_MIS_maxTimeMission = 900;	// 900 : 15 min


DK_MIS_tgMarkers = [];
DK_MIS_tgMarkersRescue = [];

call compileFinal preprocessFileLineNumbers "DK_Functions\missions\DK_MIS_fncs_missionsCore_cl.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_Kill\client\DK_MIS_fncs_Kill_cl.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_TakeCar\client\DK_MIS_fncs_TakeCar_cl.sqf";

