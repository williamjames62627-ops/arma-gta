
if (player getVariable ["isInit", false]) exitWith {};


player setVariable ["isInit", true];

_this spawn
{
	params ["_playerCo"];


	private _id = owner _playerCo;

	if !(isNil "DK_cntdwnTime") then
	{
		_id publicVariableClient "DK_cntdwnTime";
	};

	waitUntil { getClientStateNumber > 9 };

	waitUntil { (call BIS_fnc_missionTimeLeft) > 0 };


	/// Give Remaining Time to player
	remoteExecCall ["DK_fnc_gameTime_cl", _id];


	/// Give info for Bonus
	if !(isNil "DK_nbAmb") then
	{
		_id publicVariableClient "DK_nbAmb";
	};

	if !(isNil "DK_weapon_LJ_InProgress") then
	{
		_id publicVariableClient "DK_weapon_LJ_InProgress";
	};


	/// Give info for current Mission
	if ( (!isNil "DK_MIS_var_missInProg") && {(DK_MIS_var_missInProg)} )  then
	{
		if !(isNil "DK_nbTargets_Goal") then
		{
			_id publicVariableClient "DK_nbTargets_Goal";
		};

		if !(isNil "DK_nbTargets_Cnt") then
		{
			_id publicVariableClient "DK_nbTargets_Cnt";
		};
	};

	if !(isNil "DK_idMission") then
	{
		_id publicVariableClient "DK_idMission";
	};



	// Give info music ambients
	if !(isNil "DK_start_music_house") then
	{
		_id publicVariableClient "DK_start_music_house";
	};


	// Disablevoice chat
	[_playerCo, "NoVoice"] remoteExecCall ["NoVoice", 0, _playerCo];

	uiSleep 1;

	private _uid = getPlayerUID _playerCo;
	if !(_uid isEqualTo "") then
	{
		private _money = missionNamespace getVariable [("DK_" + _uid), ""];
		if !(_money isEqualTo "") then
		{
			[_playerCo, _money] call DK_fnc_handlePlayerMoney;
		};
	};

	uiSleep 19;

	waitUntil { (!isNull _playerCo) && { (alive _playerCo) } };

	uiSleep 1;

	_playerCo call DK_addMpEH_respawn;

};

