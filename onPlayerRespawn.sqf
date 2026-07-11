enableRadio false;

// Logo down-right screen
[DK_vImg_logo,  safeZoneX + safeZoneW - 0.79 * 3 / 4, safeZoneY + safeZoneH - 0.24, 99999, 0, 0, DK_lyDyn_logo] spawn bis_fnc_dynamicText;

// Black screen; Until player have good position and car for respawn
0 fadeSound 0;


DK_lyDyn_fadeBlack cutText ["", "BLACK FADED", 30, true, false];

///	// SHOW Tips
call DK_MTW_fnc_Tips_cl;


// Waiting before Respawn Script has terminate
if (!isNil "DK_handle_playerRespawn_terminate") then
{
	waitUntil { scriptDone DK_handle_playerRespawn_terminate };
};


private _player = player;
_player remoteExecCall ["DK_fnc_SP_setVarF", 2];


private _corps = _this # 1;

if (DK_thisIsFirstStarting) then
{
	DK_thisIsFirstStarting = false;

	if (isNull objectParent _corps) then
	{
		deleteVehicle _corps;
	}
	else
	{
		(objectParent _corps) deleteVehicleCrew _corps;
	};

	// Set Info Score to PLayer
	[_player] remoteExecCall ["DK_fnc_setInfoScorePLayerCo", 2];
};

/// Handle Spawn
waitUntil { (!isNull player) && { (alive player) } };

// Handle score (send to Server)
private _player = player;

_player remoteExecCall ["DK_fnc_AddHdlPlyScrKF", 2];

// Init basic capacity to player
[] spawn DK_fnc_init_playerAtSpawn_cl;

// Handle player respawn
DK_handle_playerRespawn_terminate = _corps spawn DK_fnc_handle_playerRespawn;

// Set limit view distance
[] execVM "setViewDistance.sqf";
[] execVM "setObjectViewDistance.sqf";

// Check & remove healing action
if (!isNil "DK_idActionPlayerHeal_Local") then
{
	[player, DK_idActionPlayerHeal_Local] call BIS_fnc_holdActionRemove;
	DK_idActionPlayerHeal_Local = nil;
};

// UI family numbers count
if (!isNil "DK_fnc_UI_familyMbsNb") then
{
	(count (units (group player))) call DK_fnc_UI_familyMbsNb;
};


// Variables secure
player setVariable ["DK_healing", false];
player setVariable ["DK_isICPCT", false];
player setVariable ["hitSlp", false];

player setVariable ["timeEhHD", nil];

player setVariable ["wantedLvl", [], true];




