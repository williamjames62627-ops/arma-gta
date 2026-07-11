
_this addAction ["<t color='#fcfff7'>Take MONEY</t>  (E)",
{
	if ((_this # 0) getVariable ["moneyOff", false]) exitWith {};

	(_this # 0) setVariable ["moneyOff", true, true];

	removeAllActions (_this # 0);
	player playActionNow "TakeFlag";

	(_this # 0) spawn
	{
		uiSleep 0.5;

		_this remoteExecCall ["DK_fnc_deleteVehicle", 2];
		private _player = player;
		[_player, _this getVariable ["gain", (50 + (round (random 20)))]] remoteExecCall ["DK_fnc_handlePlayerMoney",2];
	};

} ,nil,6,true,true,"LeanRight","((player distance _target) < 2.3) && (isNull (objectParent player))" ];  