
///	// Show NFO for activate ambulance
	[DK_vTxt_nfoActAmb,-1,0.725,45,0,0,DK_lyDyn_amb] spawn BIS_fnc_dynamicText; 

	player setVariable ["DK_nbMedicsAllow", _this];
//	player setVariable ["DK_nbMedicsAllow", 4];

///	// Added Action Menu to player for call an ambulance
	DK_idActionBonusAmb =
	[
		player,
		"<t color='#D8D819'>Call emergency</t>   <t shadow='2'>$ " + (str (call DK_AMB_COSTP)),
		"a3\ui_f\data\IGUI\Cfg\Revive\overlayIcons\r100_ca.paa",
		"a3\ui_f\data\IGUI\Cfg\Revive\overlayIcons\r100_ca.paa",
		"true",
		"true",
		{},
		{},
		{
			[player, (_this # 2)] call BIS_fnc_holdActionRemove;
			DK_idActionBonusAmb = nil;

			if (DK_nbAmb < 2) then
			{
				DK_lyDyn_amb cutText ["","PLAIN",0];
				["ntf_bonus_amb_called",[]] call bis_fnc_showNotification;
				private _player = player;
				private _nbMedicAllowed = player getVariable ["DK_nbMedicsAllow",2];

				[_player,_nbMedicAllowed] remoteExecCall ["DK_fnc_bonus_amb_create", 2];
			}
			else
			{
				[] spawn
				{
					uiSleep 1;

					["ntf_bonus_amb_isBusy",[]] call bis_fnc_showNotification;
					uiSleep 2;

					if (lifeState player isEqualTo "INCAPACITATED") then
					{
						if ((getPlayerScores player # 5) > call DK_AMB_SCORE_MINI) then
						{
							(player getVariable ["DK_nbMedicsAllow",2]) call DK_fnc_addActAmbulance;
						};
					};
				};
			};
		},
		{},
		[],
		1,
		10,
		false,
		true 

	] call BIS_fnc_holdActionAdd;