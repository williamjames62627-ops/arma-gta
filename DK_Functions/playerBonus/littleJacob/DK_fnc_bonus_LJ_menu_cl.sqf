
	private "_handle";
	private _score = (getPlayerScores player) # 5;

	call
	{
		if (_score < call DK_LJ_WP_SCORE_MAX_PAL0) exitWith
		{
			_handle = createdialog (call DK_LJ_WP_ChsPAL0);
		};

		if ( (_score >= call DK_LJ_WP_SCORE_MAX_PAL0) && { (_score < call DK_LJ_WP_SCORE_MAX_PAL1) } ) exitWith
		{
			_handle = createdialog (call DK_LJ_WP_ChsPAL01);
		};

		if ( (_score >= call DK_LJ_WP_SCORE_MAX_PAL1) && { (_score < call DK_LJ_WP_SCORE_MAX_PAL2) } ) exitWith
		{
			_handle = createdialog (call DK_LJ_WP_ChsPAL012);
		};
		if ( (_score >= call DK_LJ_WP_SCORE_MAX_PAL2) && { (_score < call DK_LJ_WP_SCORE_MAX_PAL3) } ) exitWith
		{
			_handle = createdialog (call DK_LJ_WP_ChsPAL0123);
		};

		_handle = createdialog (call DK_LJ_WP_ChsPAL01234);
	};

	DK_noEscKey_2702 = (findDisplay 2702) displayAddEventHandler ["KeyDown", { if ((_this select 1) == 1) then { call DK_fnc_bonus_LJ_Esc_01; false } }];

	[] spawn
	{
		for "_i" from 1 To 20 do
		{
			if ( (!alive player) OR ( (isNull (findDisplay 2702)) && { (isNull (findDisplay 2701)) } ) ) exitWith {};

			uiSleep 1;
		};

		if ( (!isNull (findDisplay 2702)) OR (!isNull (findDisplay 2701)) ) then
		{
			call DK_fnc_bonus_LJ_Esc_01;
			[] spawn DK_fnc_bonus_LJ_Esc_02;
		};

		if (!isNil "DK_noEscKey_2701") then
		{
			(findDisplay 2701) displayRemoveEventHandler ["KeyDown", DK_noEscKey_2701];
			DK_noEscKey_2701 = nil;
		};
		if (!isNil "DK_noEscKey_2702") then
		{
			(findDisplay 2702) displayRemoveEventHandler ["KeyDown", DK_noEscKey_2702];
			DK_noEscKey_2702 = nil;
		};
	};