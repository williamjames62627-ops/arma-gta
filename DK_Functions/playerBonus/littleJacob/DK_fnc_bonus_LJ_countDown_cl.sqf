
[] spawn
{
	uiSleep (call DK_LJ_WP_CNTDWN);

	private _player = player;
	[_player,true,true] remoteExecCall ["DK_fnc_bonus_LJ_handleIfPlyrAlwd", 2];
};