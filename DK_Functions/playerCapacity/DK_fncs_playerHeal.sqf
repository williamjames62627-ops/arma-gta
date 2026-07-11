if !(hasInterface) exitWith {};

DK_addAction_playerHeal = {

	if ( (alive player) && { !((lifeState player) isEqualTo "INCAPACITATED") && { !(((getAllHitPointsDamage player) # 2) findIf {_x > 0.085} isEqualTo -1) && { (isNil "DK_idActionPlayerHeal_Local") } } } ) then
	{
		DK_idActionPlayerHeal_Local =
		[
			player,
			"Treat yourself",
			"a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",
			"a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",
			"
				!((getAllHitPointsDamage player) # 2 findIf {_x > 0.085} isEqualTo -1) && { !(stance player isEqualTo 'UNDEFINED') && { (isTouchingGround player) && { (alive player) && { !(player getVariable ['DK_healing', false]) && { !(animationState player in ['ainvppnemstpslaywnondnon_medic', 'ainvpknlmstpslaywnondnon_medic', 'ainvpknlmstpsnonwrfldr_medic0s', 'ainvpknlmstpsnonwrfldnon_medicend', 'ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic', '']) } } } } }
			",
			"true",
			{},
			{},
			{
				[player, (_this select 2)] call BIS_fnc_holdActionRemove;
				DK_idActionPlayerHeal_Local = nil;
				player setVariable ["DK_healing", true];

				[] spawn DK_addAction_playerHealCancel;

				private "_stance";
				call
				{
					if (stance player isEqualTo "PRONE") exitWith
					{
						player playMoveNow "ainvppnemstpslaywnondnon_medic";
						_stance = 1;
					};

					player playMoveNow "ainvpknlmstpslaywnondnon_medic";
					_stance = 2;
				};

				_stance spawn DK_fnc_playerHealStart;
			},
			{},
			[],
			0.3,
			20,
			false,
			false,
			false

		] call BIS_fnc_holdActionAdd;
	};
};

DK_fnc_playerHealStart = {

	private _time = time + 7;
	waitUntil { (time > _time) OR (!alive player) OR ((lifeState player) isEqualTo "INCAPACITATED") OR (damage player isEqualTo 0) OR !(player getVariable ["DK_healing", false]) OR !(isTouchingGround player) OR ((animationState player) in ["ainvppnemstpslaywnondnon_medic", "ainvpknlmstpslaywnondnon_medic"]) };

	if ( (!alive player) OR (lifeState player isEqualTo "INCAPACITATED") OR (damage player isEqualTo 0) OR !(player getVariable ["DK_healing", false]) ) exitWith
	{
		if (!isNil "DK_idActionPlayerHeal_Local") then
		{
			[player, DK_idActionPlayerHeal_Local] call BIS_fnc_holdActionRemove;
			DK_idActionPlayerHeal_Local = nil;
		};

		if (lifeState player isEqualTo "INCAPACITATED") then
		{
			player playMoveNow "UnconsciousReviveDefault";
		};

		player setVariable ["DK_healing", false];
	};

	if ( !(isTouchingGround player) OR !((animationState player) in ["ainvppnemstpslaywnondnon_medic", "ainvpknlmstpslaywnondnon_medic"]) ) exitWith
	{
		if (!isNil "DK_idActionPlayerHeal_Local") then
		{
			[player, DK_idActionPlayerHeal_Local] call BIS_fnc_holdActionRemove;
			DK_idActionPlayerHeal_Local = nil;
		};

		player setVariable ["DK_healing", false];

		call DK_fnc_playerHealStopAnim;

		call DK_addAction_playerHeal;
	};

	_this spawn DK_fnc_playerHealSpdAnim;
//	private _debugTime = time;


	private _timeBis = time + 5;
	_time = time + 20;
	waitUntil { (time > _time) OR (!alive player) OR ((lifeState player) isEqualTo "INCAPACITATED") OR (damage player isEqualTo 0) OR !(player getVariable ["DK_healing", false]) OR !(isTouchingGround player) OR !((animationState player) in ["ainvppnemstpslaywnondnon_medic", "ainvpknlmstpslaywnondnon_medic"]) };

	if !(player getVariable ["DK_healing", false]) exitWith {};

	player setVariable ["DK_healing", false];

	if ( (!alive player) OR (lifeState player isEqualTo "INCAPACITATED") ) exitWith {};

	if (!isNil "DK_idActionPlayerHeal_Local") then
	{
		[player, DK_idActionPlayerHeal_Local] call BIS_fnc_holdActionRemove;
		DK_idActionPlayerHeal_Local = nil;
	};

	if ( (damage player isEqualTo 0) OR !(isTouchingGround player) OR ( (time < _timeBis) && { !((animationState player) in ["ainvppnemstpslaywnondnon_medic", "ainvpknlmstpslaywnondnon_medic"]) } ) ) exitWith
	{
		call DK_fnc_playerHealStopAnim;

		call DK_addAction_playerHeal;
	};

//	systemChat ("Heal time on: " + (str (time - _debugTime)));

	player setDamage 0;
	for "_i" from 0 to 11 do
	{
		player setHitIndex [ _i, 0];
	};
};



DK_addAction_playerHealCancel = {

	private _time = time + 10;
	waitUntil { (time > _time) OR (!alive player) OR (lifeState player isEqualTo "INCAPACITATED") OR (damage player isEqualTo 0) OR !(player getVariable ["DK_healing", false]) OR !(isTouchingGround player) OR ((animationState player) in ["ainvppnemstpslaywnondnon_medic", "ainvpknlmstpslaywnondnon_medic"]) };

	if (  (time > _time) OR (!alive player) OR (lifeState player isEqualTo "INCAPACITATED") OR (damage player isEqualTo 0) OR !(player getVariable ["DK_healing", false]) OR !(isTouchingGround player) OR !((animationState player) in ["ainvppnemstpslaywnondnon_medic", "ainvpknlmstpslaywnondnon_medic"]) ) exitWith {};

	if (isNil "DK_idActionPlayerHeal_Local") then
	{
		DK_idActionPlayerHeal_Local =
		[
			player,
			"<t color='#F00000'>Cancel treat</t>",
			"a3\ui_f\data\IGUI\Cfg\Revive\overlayIcons\r100_ca.paa",
			"a3\ui_f\data\IGUI\Cfg\Revive\overlayIcons\r100_ca.paa",
			"
				(alive player) && { (player getVariable ['DK_healing', false]) }
			",
			"true",
			{},
			{},
			{
				call DK_fnc_playerHealStopAnim;

				[player, (_this select 2)] call BIS_fnc_holdActionRemove;
				DK_idActionPlayerHeal_Local = nil;
				player setVariable ["DK_healing", false];

				call DK_addAction_playerHeal;
			},
			{},
			[],
			0.3,
			20,
			false,
			false,
			false

		] call BIS_fnc_holdActionAdd;
	};
};

DK_fnc_playerHealStopAnim = {

	if (lifeState player isEqualTo "INCAPACITATED") exitWith
	{
		player playMoveNow "UnconsciousReviveDefault";
	};

	switch (animationState player) do
	{
		case "ainvppnemstpslaywnondnon_medic" :
		{
			player switchMove "AmovPpneMstpSnonWnonDnon";
		};

		case "ainvpknlmstpslaywnondnon_medic" :
		{
			player switchMove "AmovPknlMstpSnonWnonDnon";
		};
	};
};

DK_fnc_playerHealSpdAnim = {

	
	private _hitPart = selectMax ((getAllHitPointsDamage player) # 2);

//	systemChat ("hit part max: " +  (str _hitPart));

	private _time = time;


	switch _this do
	{
		case 1 :
		{
			player setAnimSpeedCoef (1 - (_hitPart / 2.1));
		};

		case 2 :
		{
			player setAnimSpeedCoef (1 - (_hitPart / 2.3));
		};
	};

	waitUntil { (!alive player) OR (lifeState player isEqualTo "INCAPACITATED") OR !(player getVariable ["DK_healing", false]) OR (damage player isEqualTo 0) OR (((getAllHitPointsDamage player) # 2) findIf {_x > 0} isEqualTo -1) };

	player setVariable ["DK_healing", false];
	player setAnimSpeedCoef (("Par_playerSpeed" call BIS_fnc_getParamValue) / 100);

//	player sideChat (str (damage player) + " : " + (str (time - _time)));
};
