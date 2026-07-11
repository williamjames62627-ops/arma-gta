
params ["_killer", ["_delHaveAction",false], ["_delInCntDownAction",false]];

if (_delHaveAction) then
{
	_killer setVariable ["haveAction_LJ", false];
};

if (_delInCntDownAction) then
{
	_killer setVariable ["inCntDownAction_LJ", false];
};

if ( !(_killer getVariable ["haveAction_LJ", false]) && { !(_killer getVariable ["inCntDownAction_LJ", false]) && { (score _killer > call DK_LJ_SCORE_MINI) } } ) then
{
	_killer setVariable ["haveAction_LJ", true];
	remoteExecCall ["DK_bonus_LJ_addAction", _killer];

	if (_killer getVariable ["LJfirstTime", true]) then
	{
		_killer setVariable ["LJfirstTime", false];

		_killer spawn
		{
			uiSleep 5;
			if (isNull _this) exitWith {};

			["Little Jacob", "LJ Welcome", _this] call DK_fnc_customChat;
		};
	};
};