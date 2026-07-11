
#define slp_LS 0.33


/// Added Event Handler for PLAYER

_this addMPEventHandler ["MPKilled",
{
	params ["_killed", "_killer"];


	if (hasInterface) then
	{
		[_killed, _killer] call DK_fnc_MPkilled_cl;
	};
}];


_this addEventhandler ["Killed",
{
	_this call DK_fnc_killed_cl;
}];



/// Handle clean up weapon at land
_this addEventHandler ["Put",
{
    params[ "_unit", "_wpHold"];


	if (DK_thisIsFirstStarting) exitWith
	{
		deleteVehicle _wpHold;
	};

	[typeOf _wpHold, _wpHold] remoteExecCall ["DK_fnc_checkWpHold_CUM", 2];
}];


/// Handle damage player
_this addEventHandler ["HandleDamage",
{
	private _dmgInit = _this call DK_fnc_handleDmg_cl;

	_dmgInit

//	0
}];

/// Check if player is in incapacitated state
_this addEventHandler ["Dammaged",
{
	_this call DK_fnc_damaged_cl;
}];


