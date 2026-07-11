if (!hasInterface) exitWith {};

params ["_littleJ"];


DK_LJ_Guy = _littleJ;

// ICON 3D
if (!isNil "DK_LJ_EF") then
{
	removeMissionEventHandler ["EachFrame", DK_LJ_EF];
	DK_LJ_EF = nil;
};

DK_LJ_EF = addMissionEventHandler ["EachFrame",
{
	call DK_fnc_bonus_LJ_hud_fam;
}];


// Check when it's finish
[_littleJ] spawn
{
	params ["_littleJ"];


	waitUntil { uiSleep 0.5; (isNil "DK_LJ_Guy") OR (!alive _littleJ) OR (!alive player) };

	if (!isNil "DK_LJ_EF") then
	{
		removeMissionEventHandler ["EachFrame", DK_LJ_EF];
		DK_LJ_EF = nil;
	};

	/// DELETE / RE-INIT all variables
	DK_LJ_Guy = nil;
};

