if (!hasInterface) exitWith {};


DK_fnc_bonus_LJ_Esc_01 = {

	closeDialog 0;
	DK_weapon_LJ_InProgress = false;
	publicVariable "DK_weapon_LJ_InProgress";
	publicVariableServer "DK_weapon_LJ_InProgress";

	private _player = player;
	[_player,true] remoteExecCall ["DK_fnc_bonus_LJ_handleIfPlyrAlwd", 2];
};

DK_fnc_bonus_LJ_Esc_02 = {

	uiSleep 0.02;
	closeDialog 0;
};
