
private _score = (getPlayerScores player) # 5;

if (_score > call DK_AMB_SCORE_MINI) then
{
	_score spawn
	{
		uiSleep 1;

		if (!isNil "DK_idActionBonusAmb") exitWith {};

		call
		{
			if (_this < call DK_AMB_SCORE_MAX_PAL1) exitWith
			{
				2 call DK_fnc_addActAmbulance;
			};
			if ( (_this >= call DK_AMB_SCORE_MAX_PAL1) && { (_this < call DK_AMB_SCORE_MAX_PAL2) } ) exitWith
			{
				3 call DK_fnc_addActAmbulance;
			};

			4 call DK_fnc_addActAmbulance;
		};

		uiSleep 1;

		waitUntil { !(lifeState player isEqualTo "INCAPACITATED") };

		if (!isNil "DK_idActionBonusAmb") then
		{
			[player, DK_idActionBonusAmb] call BIS_fnc_holdActionRemove;
			DK_idActionBonusAmb = nil;
			DK_lyDyn_amb cutText ["","PLAIN",0];
		};
	};
};

