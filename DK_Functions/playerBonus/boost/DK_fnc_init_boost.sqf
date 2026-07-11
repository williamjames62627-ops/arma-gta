params ["_veh", "_player"];


if (score _player < 0) exitWith {};


if (isServer) exitWith
{
//	private _idJIP = [_veh, "DK_Functions\playerBonus\boost\DK_fnc_addAct_boost_cl.sqf"] remoteExecCall ["BIS_fnc_execVM", 0, true];
	private _idJIP = _veh remoteExecCall ["DK_fnc_addAction_boost_cl", 0, true];
	[_veh, _idJIP] call DK_fnc_addEhServ_boost;
};

//private _idJIP = [_veh, "DK_Functions\playerBonus\boost\DK_fnc_addAct_boost_cl.sqf"] remoteExecCall ["BIS_fnc_execVM", -2, true];
private _idJIP = _veh remoteExecCall ["DK_fnc_addAction_boost_cl", 0, true];
[_veh, _idJIP] remoteExecCall ["DK_fnc_addEhServ_boost", 2];