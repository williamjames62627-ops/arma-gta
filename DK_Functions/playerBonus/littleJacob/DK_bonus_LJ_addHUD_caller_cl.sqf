if (!hasInterface) exitWith {};

params ["_littleJ","_jacobCar","_posPlayer"];


DK_LJ_Guy = _littleJ;
DK_LJ_Car = _jacobCar;

/*
// ENABLE ESC
(findDisplay 2701) displayRemoveEventHandler ["KeyDown", DK_noEscKey_2701];
(findDisplay 2702) displayRemoveEventHandler ["KeyDown", DK_noEscKey_2702];
DK_noEscKey_2701 = nil;
DK_noEscKey_2702 = nil;
*/

DK_LJ_mkr = createMarkerLocal ["mkrLJ", getPosWorld DK_LJ_Car];
DK_LJ_mkr setMarkerTypeLocal "mil_box";
DK_LJ_mkr setMarkerColorLocal "ColorGreen";	
DK_LJ_mkr setMarkerSizeLocal [0.85,0.85];

["ntf_bonus_LJ_spawned",[]] call bis_fnc_showNotification;


// ICON 3D & MARKER
if (!isNil "DK_LJ_EF") then
{
	removeMissionEventHandler ["EachFrame", DK_LJ_EF];
	DK_LJ_EF = nil;
};

DK_LJ_EF = addMissionEventHandler ["EachFrame",
{
	call DK_fnc_bonus_LJ_hud_caller;
}];

// ARLERT JACOB ARRIVED
[_posPlayer,_littleJ,_jacobCar] spawn
{
	params ["_posPlayer","_littleJ","_jacobCar"];

	waitUntil { uiSleep 0.4; ( (isNil "DK_LJ_Guy") OR (!alive _littleJ) OR (_posPlayer distance _littleJ) < 65) OR ((player distance _littleJ) < 50) OR !(canMove _jacobCar) OR (!alive _jacobCar) };

	if (isNil "DK_LJ_Guy") exitWith {};

	uiSleep 1;

	if ( !(_jacobCar getVariable ["isDestroy", false]) && { (alive _jacobCar) } ) then
	{
		["ntf_bonus_LJ_isArrived",[]] call bis_fnc_showNotification;
	}
	else
	{
		["ntf_bonus_LJ_vehDestroyed",[]] call bis_fnc_showNotification;
	};
};

// Check when it's finish

[_jacobCar] spawn
{
	params ["_jacobCar"];


	private _time = time + 300;

	waitUntil { uiSleep 0.5; (isNil "DK_LJ_Car") OR (!alive _jacobCar) OR (time > _time) };

	if !(isNil "DK_LJ_mkr") then
	{
		deleteMarkerLocal DK_LJ_mkr;
		DK_LJ_mkr = nil;
	};


	if (!isNil "DK_LJ_EF") then
	{
		removeMissionEventHandler ["EachFrame", DK_LJ_EF];
		DK_LJ_EF = nil;
	};

	/// DELETE / RE-INIT all variables
	DK_LJ_Car = nil;
};

[_littleJ] spawn
{
	params ["_littleJ"];


	waitUntil { uiSleep 0.5; (isNil "DK_LJ_Guy") OR (!alive _littleJ) };

	/// DELETE / RE-INIT all variables
	DK_LJ_Guy = nil;
};

