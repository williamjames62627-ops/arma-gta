
params ["_unit", ["_scrToAdd", 0]];


if ((isNil "_unit") OR (isNull _unit)) exitWith {};


private _actuScr = (_unit getVariable ["DK_moneyWallet",0]) + _scrToAdd;

_unit setVariable ["DK_moneyWallet",_actuScr];

[_actuScr,_scrToAdd] remoteExecCall ["DK_fnc_UI_moneyWallet", _unit];


// Store persistant money until mission
private _uid = getPlayerUID _unit;

if (_uid isEqualTo "") exitWith {};

missionNamespace setVariable [("DK_" + _uid), _actuScr];

