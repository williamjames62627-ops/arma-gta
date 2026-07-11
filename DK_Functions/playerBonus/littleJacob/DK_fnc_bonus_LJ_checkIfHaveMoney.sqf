
params ["_player", "_choice", "_lvl", "_DLC", "_cost", "_realCost", "_negativCost"];

private _actuMoney = _player getVariable "DK_moneyWallet";

if (isNil "_actuMoney") then
{
	_actuMoney = 0;
	_player setVariable ["DK_moneyWallet",_actuMoney];	
};

call
{
	if (_choice isEqualTo 0) exitWith
	{
		_cost = DK_LJ_WP_costAmmo;
	};

	if (_lvl isEqualTo 0) exitWith
	{
		if (_choice isEqualTo 1) exitWith
		{
			_cost = DK_LJ_WP_cost_1_0;
		};
		if (_choice isEqualTo 2) then
		{
			_cost = DK_LJ_WP_cost_2_0;
		};
	};

	if (_lvl isEqualTo 1) exitWith
	{
		if (_choice isEqualTo 1) exitWith
		{
			_cost = DK_LJ_WP_cost_1_1;
		};
		if (_choice isEqualTo 2) then
		{
			_cost = DK_LJ_WP_cost_2_1;
		};
	};

	if (_lvl isEqualTo 2) exitWith
	{
		if (_choice isEqualTo 1) exitWith
		{
			_cost = DK_LJ_WP_cost_1_2;
		};
		if (_choice isEqualTo 2) exitWith
		{
			_cost = DK_LJ_WP_cost_2_2;
		};
		if (_choice isEqualTo 3) exitWith
		{
			_cost = DK_LJ_WP_cost_3_2;
		};
		if (_choice isEqualTo 4) then
		{
			_cost = DK_LJ_WP_cost_4_2;
		};
	};

	if (_lvl isEqualTo 3) exitWith
	{
		if (_choice isEqualTo 1) exitWith
		{
			_cost = DK_LJ_WP_cost_1_3;
		};
		if (_choice isEqualTo 2) exitWith
		{
			_cost = DK_LJ_WP_cost_2_3;
		};
		if (_choice isEqualTo 3) exitWith
		{
			_cost = DK_LJ_WP_cost_3_3;
		};
		if (_choice isEqualTo 4) exitWith
		{
			_cost = DK_LJ_WP_cost_4_3;
		};
		if (_choice isEqualTo 5) then
		{
			_cost = DK_LJ_WP_cost_5_3;
		};
	};

	if (_lvl isEqualTo 4) then
	{
		if (_choice isEqualTo 1) exitWith
		{
			_cost = DK_LJ_WP_cost_1_4;
		};
		if (_choice isEqualTo 2) exitWith
		{
			_cost = DK_LJ_WP_cost_2_4;
		};
		if (_choice isEqualTo 3) exitWith
		{
			_cost = DK_LJ_WP_cost_3_4;
		};
		if (_choice isEqualTo 4) exitWith
		{
			_cost = DK_LJ_WP_cost_4_4;
		};
		if (_choice isEqualTo 5) then
		{
			_cost = DK_LJ_WP_cost_5_4;
		};
	};
};

_realCost = call _cost;

if ( (_player getVariable "DK_moneyWallet") >= _realCost ) then
{
	_negativCost = _realCost - (_realCost * 2);

	[_player,_choice,_lvl,_DLC,_negativCost] call DK_fnc_bonus_LJ_createLJ;
}
else
{
	DK_weapon_LJ_InProgress = false;
	publicVariable "DK_weapon_LJ_InProgress";

	remoteExecCall ["DK_fnc_showNotifNoMoney_LJ", _player];

	if (alive _player) then
	{
		[_player,true] call DK_fnc_bonus_LJ_handleIfPlyrAlwd;
	};
};