
//	hint str (random 50000);

	if !(isNil "DK_idActionJacobWeapon_Local") then
	{
		player removeAction DK_idActionJacobWeapon_Local;
	};

		DK_idActionJacobWeapon_Local =
		[
			player,
			"<t color='#92E800'>Call Little Jacob</t>",
			"DK_Textures\UI\iconActionLJ.paa",
			"DK_Textures\UI\iconActionLJ.paa",
			"
			!(player getVariable ['DK_healing', false])
			",
			"true",
			{},
			{},
			{
				[player, (_this select 2)] call BIS_fnc_holdActionRemove;

				DK_idActionJacobWeapon_Local = nil;

				call
				{
					if !(DK_weapon_LJ_InProgress) exitWith
					{
						DK_weapon_LJ_InProgress = true;
						publicVariable "DK_weapon_LJ_InProgress";
						publicVariableServer "DK_weapon_LJ_InProgress";

						(vehicle player) say2D "TelCompTrue";

						[] spawn
						{
							uiSleep 8;

							if ( (alive player) && { !(lifeState player isEqualTo "INCAPACITATED") } ) then
							{
								[] call DK_fnc_bonus_LJ_menu;
							}
							else
							{
								DK_weapon_LJ_InProgress = false;
								publicVariable "DK_weapon_LJ_InProgress";
								publicVariableServer "DK_weapon_LJ_InProgress";

								private _player = player;
								[_player,true] remoteExecCall ["DK_fnc_bonus_LJ_handleIfPlyrAlwd", 2];
							};
						};
					};

					(vehicle player) say2D "TelCompFalse";

					[] spawn
					{
						uiSleep 9.5;
						["ntf_bonus_LJ_alreadyInProgress",[]] call bis_fnc_showNotification;

						uiSleep 2;
						private _player = player;
						[_player,true] remoteExecCall ["DK_fnc_bonus_LJ_handleIfPlyrAlwd", 2];

					};
				};
			},
			{},
			[],
			1.3,
			-2,
			false,
			false,
			false

		] call BIS_fnc_holdActionAdd;

