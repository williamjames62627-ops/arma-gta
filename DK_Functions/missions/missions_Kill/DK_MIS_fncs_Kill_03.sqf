if !(isServer) exitWith {};


#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]
#define crtHeliPad createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 0, "CAN_COLLIDE"]

#define fridge selectRandom ["Fridge_01_open_F", "Fridge_01_closed_F"]
#define shelves selectRandom ["Land_ShelvesWooden_khaki_F", "Land_ShelvesWooden_F", "Land_ShelvesWooden_blue_F"]

#define posGrpBig01 [[1.5,-4.2, 0], [1.8,-2.8, 0], [0.7,-1, 0], [-1.2,5, 0], [2.2,5.15, 0], [1,5.2, 3.2], [-1,5.15, 3.2], [1,-0.6, 3.2], [-2,0.2, 3.2], [-2,-4.2, 3.2]]
#define posGrpBig02 [[1.7,3, 0], [-1.7,3.3, 0], [-1.7,1.4, 0], [-1.3, -2.4, 0], [-1.3, -2.4, 3.2], [-1.2, 1.8, 3.2], [0.5, 3.2, 3.2], [2.1, 2.6, 3.2]]
#define posGrpBarr [[11.8,2.8,0.3], [5.2,2.8,0.3], [-2.5,2.8,0.3], [-10.3,2.8,0.3], [11.8,2.8,3.7], [5.2,2.8,3.7], [-2.5,2.8,3.7], [-10.3,2.8,3.7], [-10.3,-2.8,3.7], [-4.3,-4,3.7], [11.8,-2.8,3.7], [5.2,-2.8,3.7], [11.8,-2.8,0.3], [5.2,-2.8,0.3], [-10.3,-2.8,0.3]]
#define posBarrDoor [ [[14,5.8,3.9], [10,5.8,3.9], [6,5.8,3.9], [2,5.8,3.9], [-2,5.8,3.9], [-6,5.8,3.9], [-10,5.8,3.9], [-12,5.8,3.9], [-2.5,5.6,0.4], [9.5,5.6,0.4], [-5.5,-7.6,0.4]], [[15.8,4.5,3.9], [15.8,2.25,3.9], [15.8,0,3.9], [15.7,0.2,0.4]] ]


DK_MIS_K03_create = {

	DK_MIS_loopsInProgress = 0;

	// Set Mission Type
	DK_MIS_missionType = "Kill";

	// Get Difficulty depending on number of missions completed (Ennemies Stuff, Weapons, Reward loot) (server)
	private _difficulties = call DK_MIS_fnc_slctDifficulty_K03;

	_difficulties params ["_nbUnits", "_className", "_uniform", "_weapons", "_vest", "_disSeen", "_behaviour", "_speed", "_rewardLvl", "_classGuy", "_canCallRfr", ["_canCallHeliRfr", [false]]];


	// Define ID mission (server)
	private _idMission = call DK_MIS_create_ID_mission;
	if (isNil "_idMission") then
	{
		_idMission = "error" + (str time);
	};
	DK_idMission = _idMission;
	publicVariable "DK_idMission";


	// Init mission (server)
	_result = _difficulties call DK_MIS_K03_init;

	_result params ["_allGrps", "_allUnits", "_lgcProps", "_startingPos", "_house"];


	// Create various Trigger AI (server)
	[_allUnits, _disSeen, DK_MIS_K01_triggerAI, 140, 45] spawn DK_MIS_Kill_addIsSeen;

	// Create Trigger reinforcement
	[_startingPos, _house, _className, _uniform, _weapons, _vest, _classGuy, _canCallRfr, _canCallHeliRfr, _idMission] spawn DK_MIS_K03_waitCallRfr;

	// Start cooldown mission
	_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission;


	// Start Mission for players ! (local)
	_insult = call DK_MIS_slctInsult;
	_victorySnd = call DK_MIS_slctVictorySnd;
	DK_MIS_IdJIP_initCL = [_idMission, _allUnits, _insult, _classGuy, _victorySnd] remoteExecCall ["DK_MIS_fnc_K01_initClient_cl", DK_isDedi, true];

	// Create markers targets
	[_allUnits, _idMission] spawn DK_MIS_Kill_mkrTargets;


/*	/// DEBUG
	_allUnits spawn
	{
		hideObject player;
		uiSleep 6;
		player setpos ((_this # 0) modelToWorldVisual [0,2,1]);

		uiSleep 5;
		_this apply
		{
			_x setDamage 1;
		};
	};
	/// DEBUG
*/

	// Handle & Waiting Ending (server)
	_result call DK_MIS_K03_finished;
};

DK_MIS_K03_init = {

	params ["_nbUnits", "_className", "_uniform", "_weapons", "_vest","", "_behaviour", "_speed", "_rewardLvl", "_ennemiesType", "_canCallRfr", ["_canCallHeliRfr", [false]]]; 


	private "_inSide";
	call
	{
		if (_className isEqualTo "O_G_Survivor_F") exitWith
		{
			_inSide = east;
		};

		_inSide = resistance;
	};

///	START // Create & manage entities to pre-initialize mission
	private ["_grp01", "_grp02", "_grp03", "_grp04", "_nil", "_resultAiCompo", "_pos", "_unitTmp", "_waitProps", "_nbCompo", "_posGrp", "_posGrpBody"];

	// Create units --
	private _logic = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
	_logic setPos [0,0,40];
	private _allGrps = [];


	switch ( selectRandom [1,2,3,4] ) do
	{
		case 1 :
		{
			_grp01 = createGroup _inSide;

			_allGrps pushBack _grp01;
		};

		case 2 :
		{
			_grp01 = createGroup _inSide;
			_grp02 = createGroup _inSide;

			_allGrps pushBack _grp01;
			_allGrps pushBack _grp02;
		};

		case 3 :
		{
			_grp01 = createGroup _inSide;
			_grp02 = createGroup _inSide;
			uiSleep 0.05;
			_grp03 = createGroup _inSide;

			_allGrps pushBack _grp01;
			_allGrps pushBack _grp02;
			_allGrps pushBack _grp03;
		};

		case 4 :
		{
			_grp01 = createGroup _inSide;
			_grp02 = createGroup _inSide;
			uiSleep 0.05;
			_grp03 = createGroup _inSide;
			_grp04 = createGroup _inSide;

			_allGrps pushBack _grp01;
			_allGrps pushBack _grp02;
			_allGrps pushBack _grp03;
			_allGrps pushBack _grp04;
		};
	};

	private _allUnits = [];
	call
	{
		if (_nbUnits isEqualTo 6) exitWith
		{
			for "_i" from 1 to 6 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 8) exitWith
		{
			for "_i" from 1 to 8 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 10) exitWith
		{
			for "_i" from 1 to 10 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 12) exitWith
		{
			for "_i" from 1 to 12 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 14) then
		{
			for "_i" from 1 to 14 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
		};
	};

	// Form group (move unit to grp1 at grpX)
	private _allGrpsTmps = +_allGrps - [_grp01];
	if !(count _allGrps isEqualTo 1) then
	{
		private ["_unit", "_laps"];
		{
			_laps = selectRandom [1,2,3];
			for "_i" from 1 to _laps step 1 do
			{
				if (count units _grp01 isEqualTo 1) exitWith {};

				_unit = selectRandom (units _grp01);

				if ( (!isNil "_unit") && { (!isNull _unit) } ) then
				{
					[_unit] join _x;
				};
			};

			if (count units _grp01 isEqualTo 1) exitWith {};

			uiSleep 0.05;

		} count _allGrpsTmps;
	};

	// Protect Units & set variable
	{
		_x allowDamage false;
		_x attachTo [_logic, [0,0,0]];
		_x disableAI "MOVE";
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
//		_x allowFleeing 0;
		_x setVariable ["allGroups", _allGrps];
		_nil = _x call DK_MIS_addEH_HandleDmg;
		_nil = DK_unitsStayUp pushBackUnique _x;
		_x hideObjectGlobal true;
		_x setCaptive true;

		uiSleep 0.03;

	} count _allUnits;

	// Setup Groups & added car
	_allGrps apply
	{
		_x deleteGroupWhenEmpty true;
		_x setFormation "DIAMOND";
	};

	// Placement
	call
	{
		if (_nbUnits isEqualTo 6) exitWith
		{
			_nbCompo = selectRandom [1,2,3,4,5,6];

			switch ( _nbCompo ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo6_1; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo6_2; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo6_3; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo6_4; 
				};

				case 5 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo6_5; 
				};

				case 6 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo6_6; 
				};
			};
		};

		if (_nbUnits isEqualTo 8) exitWith
		{
			_nbCompo = selectRandom [1,2,3,4,5,6,7,8,9];

			switch ( _nbCompo ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_1; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_2; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_3; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_4; 
				};

				case 5 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_5; 
				};

				case 6 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_6; 
				};
	
				case 7 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_7; 
				};

				case 8 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_8; 
				};

				case 9 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo8_9; 
				};
			};
		};

		if (_nbUnits isEqualTo 10) exitWith
		{
			_nbCompo = selectRandom [1,2,3,4,5,6,7,8,9,10,11];

			switch ( _nbCompo ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_1; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_2; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_3; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_4; 
				};

				case 5 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_5; 
				};

				case 6 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_6; 
				};
	
				case 7 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_7; 
				};

				case 8 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_8; 
				};

				case 9 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_9; 
				};

				case 10 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_10; 
				};

				case 11 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo10_11; 
				};
			};
		};

		if (_nbUnits isEqualTo 12) exitWith
		{
			_nbCompo = selectRandom [1,2,3,4,5,6,7,8,9,10,11,12,13,14];

			switch ( _nbCompo ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_1; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_2; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_3; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_4; 
				};

				case 5 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_5; 
				};

				case 6 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_6; 
				};
	
				case 7 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_7; 
				};

				case 8 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_8; 
				};

				case 9 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_9; 
				};

				case 10 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_10; 
				};

				case 11 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_11; 
				};

				case 12 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_12; 
				};

				case 13 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_13; 
				};

				case 14 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo12_14; 
				};
			};
		};

		if (_nbUnits isEqualTo 14) then
		{
			_nbCompo = selectRandom [1,2,3,4,5,6,7,8,9,10,11,12,13,14];

			switch ( _nbCompo ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_1; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_2; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_3; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_4; 
				};

				case 5 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_5; 
				};

				case 6 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_6; 
				};
	
				case 7 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_7; 
				};

				case 8 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_8; 
				};

				case 9 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_9; 
				};

				case 10 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_10; 
				};

				case 11 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_11; 
				};

				case 12 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_12; 
				};

				case 13 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_13; 
				};

				case 14 :
				{
					_resultAiCompo = _allUnits call DK_MIS_K03_compo14_14; 
				};
			};
		};

	};

	_unitsToMove = _resultAiCompo # 0;

	uiSleep 0.1;	// Sleep for performance

///	END // Create & manage entities to pre-initialize mission


	// Added Stuff
	private _waitLO = [_allUnits, _uniform, _weapons, _vest] spawn DK_MIS_fnc_slctUnitsLO;

	// Find place
	private _startingArray = call DK_MIS_fnc_slctSafePlace_04;
	private _startingPos = _startingArray # 1;
	private _house = _startingArray # (count _startingArray - 1);
	private _houseType = _startingArray # 0;

	// Create Props decors and Move Vehicles & Props
	private _dirH = _startingArray # 2;
	private	_lgcProps = createVehicle ["Land_VR_Shape_01_cube_1m_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_lgcProps hideObjectGlobal true;
	_lgcProps enableSimulation false;

	// Move units
	call
	{
		if (_houseType isEqualTo "big01") exitWith
		{
			_posGrp = +posGrpBig01;
			_posGrpBody = +posGrpBig01;
			_lgcProps setPosATL _startingPos;
			_waitProps = [_lgcProps, _dirH] spawn DK_MIS_K03_compoBig01;
		};

		if (_houseType isEqualTo "big02") exitWith
		{
			_posGrp = +posGrpBig02;
			_posGrpBody = +posGrpBig02;
			_lgcProps setPosATL _startingPos;
			_waitProps = [_lgcProps, _dirH] spawn DK_MIS_K03_compoBig02;
		};

		if (_houseType in ["Barr", "BarrO"]) then
		{
			_posGrp = +posGrpBarr;
			_posGrpBody = +posGrpBarr;
			_lgcProps setPosATL _startingPos;
			_waitProps = [_lgcProps, _dirH] spawn DK_MIS_K03_compoBarr;
		};
	};

	_lgcProps setDir _dirH;

	{
		_pos = selectRandom _posGrp;
		_nil = _posGrp deleteAt (_posGrp find _pos);
		_x attachTo [_lgcProps, _pos];
		uiSleep 0.08;
		detach _x;
		_x setDir (random 360);

	} count _unitsToMove;

	if ( ((_nbUnits isEqualTo 6) && { (_nbCompo > 3) }) OR ((_nbUnits isEqualTo 8) && { (_nbCompo > 4) }) OR ((_nbUnits isEqualTo 10) && { (_nbCompo > 5) }) OR ((_nbUnits isEqualTo 12) && { (_nbCompo > 7) }) OR ((_nbUnits isEqualTo 14) && { (_nbCompo > 7) }) ) then
	{
		private _unitsToDoor = _resultAiCompo # 1;

		call
		{
			if (_houseType in ["Barr", "BarrO"]) exitWith
			{
				private _posBarrDoor = +posBarrDoor;
				_posBarrDoor call KK_fnc_arrayShuffle;
				for "_i" from 0 to (count _unitsToDoor) - 1 do 
				{
					_unitTmp = _unitsToDoor # _i;
					_unitTmp attachTo [_lgcProps, selectRandom (_posBarrDoor # _i)];
					uiSleep 0.08;
					detach _unitTmp;
					_unitTmp setDir (_lgcProps getRelDir _unitTmp);
				};
			};

			private _posDoors = [_startingArray # 3, _startingArray # 4] call KK_fnc_arrayShuffle;

			for "_i" from 0 to (count _unitsToDoor) - 1 do 
			{
				_unitTmp = _unitsToDoor # _i;
				detach _unitTmp;
				uiSleep 0.08;
				_unitTmp setPosATL ((_posDoors # _i) # 0);
				_unitTmp setDir ((_posDoors # _i) # 1);
			};
		};
	};

	waitUntil { uiSleep 0.1; scriptDone _waitLO };

	deleteVehicle _logic;

	// Create & Move Reward stuff crate
	[_waitProps, _lgcProps, _rewardLvl, _startingPos, _className, _posGrpBody, _house] spawn
	{
		params ["_waitProps", "_lgcProps", "_rewardLvl", "_pos", "_className", "_posGrpBody", "_house"];


		waitUntil { uiSleep 1; scriptDone _waitProps };

		private _corps = [];
		private _props = _lgcProps getVariable "props";

		if (isNil "_props") exitWith {};

		_tableRwrds = _props # (selectRandom [0,1,2]);
		_rwdr = [_pos, _rewardLvl, _tableRwrds] call DK_MIS_fnc_crtRwrd;
		_lgcProps setVariable ["rwrd", _rwdr];

		if (_className isEqualTo "I_officer_F") then
		{
			private "_body";

			for "_i" from 1 to 4 do
			{
				_pos = selectRandom _posGrpBody;
				_body = createAgent ["O_G_Survivor_F", (_house modelToWorld _pos) vectorAdd [0,0,0.4], [], 0, "CAN_COLLIDE"];
				_body setDir (random 360);
				_body setVelocity [selectRandom [6,-6], selectRandom [6,-6], 2.5];
				uiSleep 0.5;
				_body setDamage 1;
				_nil = _corps pushBackUnique _body;
			};

			_uniVest = selectRandom [["uniform_thug_N1", "vest_empty"], ["uniform_looter", "vest_empty"], ["uniform_thug_N2", "vest_bandoBelt"], ["uniform_Ballas", "vest_bando"], ["uniform_Triads", "vest_belt"], ["uniform_Dominicans", "vest_mediumDomi"], ["uniform_Albanians", "vest_mediumAlban"]];
			private _uniform = _uniVest # 0;
			private _vest = _uniVest # 1;
			[_corps, _uniform, "", _vest] spawn DK_MIS_fnc_slctUnitsLO;
			_props append _corps;
			_lgcProps setVariable ["props", _props];
		};
	};


	// Added varied Trigger for start AI units
	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["MIS_center", _startingPos];
		_x call DK_MIS_K01_unitsAddEH_trgAI;
		_x call DK_MIS_EH_handleAmmoNweapons;

		uiSleep 0.02;

		// DEBUG
		if (((getPosATL _x) # 0) < 1) then
		{
			_x setPosATL _startingPos;
		};
	};


	// Define variables related to the mission (Only Server)
	DK_MIS_var_AiIsBlocked = true;
	DK_MIS_var_PlayersAreNotSeen = true;
	DK_MIS_var_behaviour = _behaviour;
	DK_MIS_var_speedUnits = _speed;
	DK_MIS_var_missInProg = true;
	DK_MIS_playerRewardsMarkersList = [];
	DK_MIS_allTargets = _allUnits;

	// Define variables related to the mission (Clients & Server)
	DK_nbTargets_Goal = _nbUnits;
	publicVariable "DK_nbTargets_Goal";

	DK_nbTargets_Cnt = 0;
	publicVariable "DK_nbTargets_Cnt";

	uiSleep 0.5;

///	// Tweaking before starting mission for mafioso & Add EH to units for Hud player & Ending mission
	_allUnits spawn
	{
		{
			detach _x;
			_x hideObjectGlobal false;

		} count _this;

		uiSleep 10;

		{
			_x disableAI "ANIM";

			call
			{
				if (selectRandom [true,false]) exitWith
				{
					_x action ["WeaponOnBack", _x];
				};

				_x playMoveNow "AmovPercMstpSnonWnonDnon";
			};

			uiSleep 0.02;

		} count _this;

		uiSleep 1;

		{
			_x allowDamage true;
			_x call DK_MIS_Kill_addEH_targetsDead;

		} count _this;
	};


//// /// MISSION IS FULL INIT /////

/*
		// DEBUG
		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, _startingPos];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [30, 30];
		// DEBUG
*/


	[_allGrps, _allUnits, _lgcProps, _startingPos, _house]
};

DK_MIS_K03_finished = {

	params ["_allGrps", "_allUnits", "_lgcProps"];


	private _allUnits = +_allUnits;
	private _allGrps = +_allGrps;
	private _time = time + DK_MIS_maxTimeMission;

	waitUntil { uiSleep 0.3; !(DK_MIS_var_missInProg) OR (time > _time) OR (_allUnits findIf { uiSleep 0.02; !isNil "_x" } isEqualTo -1) OR (_allUnits findIf { uiSleep 0.02; alive _x } isEqualTo -1) };

	// Ending the game if counter is down
	if ((call BIS_fnc_missionTimeLeft) isEqualTo 0) exitWith
	{
		call DK_fnc_endSelectWinner;
	};

	// Delete info for local player from JIP
	remoteExecCall ["", DK_MIS_IdJIP_initCL];

	// Variable to be sure that Ending mission
	DK_MIS_var_missInProg = false;

	// Add Rewards to Clean Up & manage Clean Props
	_lgcProps spawn
	{
		private _time = time + 60;

		waitUntil { uiSleep 0.3; (time > _time) OR (!isNil {_this getVariable "rwrd"}) };

		// Give HUD score for winners players
		private _rwdr = _this getVariable "rwrd";

		if (!isNil "_rwdr") then
		{
			call
			{
				if (DK_MIS_playerRewardsMarkersList isEqualTo []) exitWith
				{
					_rwdr + [nil, 0, 30] spawn DK_MIS_fnc_deleteReward;
				};

				(_rwdr # 0) remoteExecCall ["DK_MIS_fnc_rewards3dIcone_cl", DK_MIS_playerRewardsMarkersList];
				_rwdr spawn DK_MIS_fnc_deleteReward;
			};
		};

		private _props = _this getVariable "props";
		deleteVehicle _this;

		// Delete all props
		if (!isNil "_props") then
		{
			uiSleep DK_MIS_timeDelRewards;

			private _mod = _props # 0;
			_time = time + 300;

			waitUntil { uiSleep 5; (time > _time) OR (playableUnits findIf { (_x distance2D _mod) < 100 } isEqualTo -1) };

			if (time > _time) then
			{
				waitUntil { uiSleep 3; (playableUnits findIf { (_x distance2D _mod) < 30 } isEqualTo -1) };
			};

			{
				if (!isNil "_x") then
				{
					deleteVehicle _x;
				};

			} count _props;
		};
	};

	// Add UNITS to Clean Up
	{
		if !(isNull _x) then
		{
			if (alive _x) then
			{
				call
				{
					if (isNull (objectParent _x)) exitWith
					{
						deleteVehicle _x;
					};

					(objectParent _x) deleteVehicleCrew _x;
				};
			}
			else
			{
				[_x, DK_MIS_timeDelCorps, DK_MIS_disDelCorps, true] spawn DK_fnc_addAllTo_CUM;
			};
		};

	} forEach _allUnits;


	// Delete group of units
	{
		if !(isNull _x) then
		{
			deleteGroup _x;
			_x = grpNull;
			_x = nil;
		};

	} forEach _allGrps;

	uiSleep 2;

	// Start ending for players !
	DK_idMission = "0";
	publicVariable "DK_idMission";

	// Waiting all loop are finished & Delete variable
	uiSleep 3;
	waitUntil { uiSleep 0.5; DK_MIS_loopsInProgress isEqualTo 0; };

	DK_MIS_var_AiIsBlocked = nil;
	DK_MIS_var_PlayersAreNotSeen = nil;
	DK_MIS_var_behaviour = nil;
	DK_MIS_var_speedUnits = nil;
	DK_nbTargets_Goal = nil;
	DK_nbTargets_Cnt = nil;
	DK_cntdwnTime = 0;
	DK_MIS_playerRewardsMarkersList = nil;
	DK_MIS_allTargets = [];
//	DK_MIS_IdJIP_initCL = nil;
	DK_MIS_missionType = "";


	uiSleep 1;

	// Start next mission
	call DK_MIS_fnc_slctDifficultyLevel;

};


/// Reinforcement
DK_MIS_K03_waitCallRfr = {

	params ["_startingPos", "_house", "_className", "_uniform", "_weapons", "_vest", "_classGuy", "_canCallRfr", "_canCallHeliRfr", "_idMission"];


	if ( !(selectRandom _canCallRfr) OR !(DK_mkrs_centerCity findIf {_startingPos inArea _x} isEqualTo -1 ) ) exitWith {};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	waitUntil { uiSleep 1; !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg }; 

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;


	if !(DK_MIS_var_missInProg) exitWith {};

	call
	{
		_classGuy remoteExecCall ["DK_fnc_hudKillRfr", DK_isDedi];

		private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

		if (_nbMaxFam < 3) exitWith
		{
			if (selectRandom _canCallHeliRfr) exitWith
			{
				[_startingPos, _house, _className, _uniform, _weapons, _vest, _classGuy, _idMission] spawn DK_MIS_K03_callHeliRfr;
			};

			[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
		};

		if ( (_nbMaxFam > 2) && { (_nbMaxFam < 7) } ) exitWith
		{
			if (selectRandom _canCallHeliRfr) exitWith
			{
				[_startingPos, _house, _className, _uniform, _weapons, _vest, _classGuy, _idMission] spawn DK_MIS_K03_callHeliRfr;
				[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
			};

			[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
			[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
		};

		if (_nbMaxFam > 6) then
		{
			if (selectRandom _canCallHeliRfr) exitWith
			{
				[_startingPos, _house, _className, _uniform, _weapons, _vest, _classGuy, _idMission] spawn DK_MIS_K03_callHeliRfr;
				[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
				[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
			};

			[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
			[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
			[_startingPos, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K03_callRfr;
		};
	};
};

DK_MIS_K03_callRfr = {

	params ["_startingPos", "_className", "_uniform", "_weapons", "_vest", "_classGuy"];


	uiSleep (10 + (random 20));

	// Search position safe for spawn Reinforcement
	private _resultPos = [_startingPos, 200, 500, 12, 4, true] call DK_fnc_MTW_searchSpawnVeh_OnRoad;

	_resultPos params ["_spawnPos", "_dir"];

	if !(_spawnPos isEqualTo 0) then
	{
		// Create Reinforcement Vehicle & Crew 
		private _resultCrewVeh = [_className, _classGuy, _uniform, _weapons, _vest, _spawnPos, _dir, false, true] call DK_fnc_crtCrewVeh_rfr;
		_resultCrewVeh params ["_unitsCrew", "_grp", "_vehicle"];

		DK_nbSearchSpawnRoad_inProg = false;

		waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _vehicle) };

		if (_unitsCrew findIf { (alive _x) } isEqualTo -1) exitWith {}; 

		private _road = [_startingPos, 150] call BIS_fnc_nearestRoad;
		call
		{
			if (_road isEqualTo objNull) exitWith
			{
				_road = _startingPos;
			};

			_road = getPosATL _road;
		};

		// Move Rfr to nearest road to building mission
		_unitsCrew doMove _road;

		private _time = time + (_vehicle distance _road) / 2;
		waitUntil { uiSleep 1; (_unitsCrew findIf {alive _x} isEqualTo -1) OR (leader _grp distance2D _road < 15) OR (time > _time) };

		if ( (!isNull _vehicle) && { (alive _vehicle) } ) then
		{
			_vehicle call DK_MIS_fnc_vehicle_removeAllEH;
			_vehicle call DK_MIS_reInitVehNormal;
			_vehicle call DK_MIS_fnc_initVehWhenEnd;
			_vehicle setUnloadInCombat [true,true]; 
		};

		if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

		_unitsCrew doMove _startingPos;

		_time = time + (_vehicle distance _startingPos) / 2;
		waitUntil { uiSleep 1; (_unitsCrew findIf {alive _x} isEqualTo -1) OR (leader _grp distance2D _startingPos < 25) OR (time > _time) };

		if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

		_waypoint = [_grp, _startingPos, "if (!isServer) exitWith {}; (group this) spawn DK_fnc_selectLoopVoice", "true", "UNLOAD", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypointState;
		_waypoint = [_grp, _startingPos, "SAD", nil,  "FULL", "COMBAT", 5] call DK_fnc_AddWaypoint;
		_unitsCrew orderGetIn false;
		_unitsCrew allowGetIn false;
		_grp leaveVehicle _vehicle;

		(units _grp) apply
		{
			unassignVehicle _x;
			[_x, 200, 180, true] spawn DK_fnc_addAllTo_CUM;
		};
	}
	else
	{
		DK_nbSearchSpawnRoad_inProg = false;
	};
};

DK_MIS_K03_callHeliRfr = {

	params ["_startingPos", "_house", "_className", "_uniform", "_weapons", "_vest", "_classGuy", "_idMission"];


	uiSleep (10 + (random 20));

	// Search position safe for spawn Reinforcement
	private _resultPos = [_house, 1000, 2500, [], 3] call DK_fnc_searchSpawn_rfr_heli; 
	_resultPos params ["_spawnPos", "_dir"];

	if (_spawnPos isEqualTo 0) exitWith
	{
		DK_nb_searchSpawn_rfr_heli_inProg = false;
	};

	// Create Reinforcement Vehicle & Crew 
	private _resultCrewVeh = [_className, _classGuy, _uniform, _weapons, _vest, _spawnPos, _dir, "0", false] call DK_fnc_crtCrewVeh_rfr_heli;
	_resultCrewVeh params ["_unitsCrew", "_grp", "_helico"];

	DK_nb_searchSpawn_rfr_heli_inProg = false;

	private ["_unitsCrewFoot", "_grp", "_grpFoot", "_result"];

	uiSleep 0.5;
	_unitsCrew apply
	{
		_x call DK_addEH_getOut_heliCrew_rfr;
	};


	waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _helico) };


	private _fnc_condSSVOR = {

		( !(playableUnits findIf { _x distance2D _house < 300 } isEqualTo -1) && { (_idMission isEqualTo DK_idMission) } )
	};


	// Create Helipads around target
	_angle = random 360;
	_heliPad01 = crtHeliPad;
	_heliPad01 setPosATL (_house getPos [22, _angle]);
	_heliPad02 = crtHeliPad;
	_heliPad02 setPosATL (_house getPos [22, _angle + 90]);
	_heliPad03 = crtHeliPad;
	_heliPad03 setPosATL (_house getPos [22, _angle + 180]);
	_heliPad04 = crtHeliPad;
	_heliPad04 setPosATL (_house getPos [22, _angle + 270]);

	_heliPads = [_heliPad01, _heliPad02, _heliPad03, _heliPad04];

///	// AI Loop Pursuit Start
	private _posHouse = getPosATL _house;
	private _pilotHeli = driver _helico;
	private _haveDisembark = false;
	private _ending = "";

	[_pilotHeli, _house] spawn DK_fnc_selectLoopVoiceHeli;

	while { call _fnc_condSSVOR } do
	{
		_grp = group _pilotHeli;
		_grp call DK_fnc_delAllWp;
		_unitsCrew = units _grp;

	///	// Move Helicopter at Target objectif
		call
		{
			if (_house distance2D _helico < 350) exitWith
			{
				_unitsCrew doMove (_house getPos [70 + random 70, random 360]);
				_grp setSpeedMode "LIMITED";
				_helico limitSpeed 50;
				_helico flyInHeight 20;
			};

			_unitsCrew doMove _posHouse;
			_grp setSpeedMode "FULL";
			_helico limitSpeed 1000;
			_helico flyInHeight 80;
		};

		uiSleep 1;

	///	// Check for Disembark crew
		if !(_haveDisembark) then
		{
			_result = [_helico, _house, _grp] call DK_MIS_K03_fnc_chckIfDismbrkHeliRfr;

			_haveDisembark = _result # 0;
			_grpFoot = _result # 1;
		};

		uiSleep 3;

	///	// Check for Exit loop
		if !(call _fnc_condSSVOR) exitWith {};

		if ( ({alive _x} count crew _helico isEqualTo 1) && { (alive _pilotHeli) } ) exitWith
		{
			_ending = "A";
		};

		uiSleep 1;

		if (!alive _pilotHeli) exitWith
		{
			if !(units _grp findIf {alive _x} isEqualTo -1) exitWith
			{
				_ending = "B";
			};

			_ending = "C";
		};

		uiSleep 1;

		if ( !(canMove _helico) OR {(!alive _helico)} ) exitWith
		{
			if (crew _helico findIf {alive _x} isEqualTo -1) exitWith
			{
				_ending = "C";
			};

			_ending = "B";
		};
	};
///	// AI Loop Pursuit END

	_helico setVehicleLock "UNLOCKED";
	_unitsCrew = units _grp;
	_grp call DK_fnc_delAllWp;
	_helico limitSpeed 1000;
	_grp setSpeedMode "FULL";

	// Start Ending for heli
	call DK_MIS_K03_endHeliRfr;

};

DK_MIS_K03_endHeliRfr = {

	switch (_ending) do
	{
		case "A" :	// Pilot alone in heli
		{
			_helico flyInHeight 100;
			uiSleep 10;

			if ( (!isNil "_grpFoot") && { !(units _grpFoot findIf {alive _x} isEqualTo -1) } ) then
			{
				_unitsCrew doMove (_house getPos [70 + random 70, random 360]);
				uiSleep 20;
			};

			(crew _helico) doMove (_helico getPos [30000, random 360]);

			if (alive (driver _helico)) then
			{
				[(driver _helico), 19, 545, true] spawn DK_fnc_addAllTo_CUM;
			};
			if (alive _helico) then
			{
				[_helico, 21, 600, true] spawn DK_fnc_addVehTo_CUM;
			};
		};

		case "B" :	// Pilot heli dead, crew in heli alive // Heli HS with crew
		{
			{
				if (alive _x) then
				{
					unassignVehicle _x;
					moveOut _x;
					uiSleep (random 0.4);
				};
				
			} count (crew _helico);	

			[_house, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
		};

		case "C" :	// Pilot heli dead, not crew in heli
		{
			
		};

		case "" :	// Mission terminée / il n'y a plus d'objectif
		{
			private _crew = crew _helico;
	
			if !(_crew findIf {alive _x} isEqualTo -1) then
			{
				if ( (_helico distance2D _house < 700) && { (!isNil "_house") } ) then
				{
					// Land at objectif/rescue place
					_helico flyInHeight 30;
					_waypoint = [_grp, _house, "UNLOAD", nil,  "FULL", "CARELESS"] call DK_fnc_AddWaypoint;
					_waypoint = [_grp, _house, "SAD", nil,  "FULL", "COMBAT", 13] call DK_fnc_AddWaypoint;
					_crew orderGetIn false;
					_crew allowGetIn false;
					_grp leaveVehicle _helico;

					(units _grp) apply
					{
						unassignVehicle _x;
					};

					[_helico, 80, 500, true] spawn DK_fnc_addVehTo_CUM;

					[_helico, _unitsCrew, _house, _grp] spawn
					{
						params ["_helico", "_unitsCrew", "_house", "_grp"];


						private _time = time + 180;

						waitUntil { uiSleep 0.5; (time > _time) OR (!canMove _helico) OR ((getPosATL _helico) # 2 < 1) OR (crew _helico findIf {alive _x} isEqualTo -1) OR !(crew _helico findIf { (isPlayer _x) OR (side (group _x) isEqualTo west) } isEqualTo -1) };

						if !(_unitsCrew findIf {alive _x} isEqualTo -1) then
						{
					//		_unitsCrew doMove _house;
							[_house, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
						};
					};
				}
				else
				{
					// Move far away
					private _heliCrew = crew _helico;

					if !(_heliCrew findIf {alive _x} isEqualTo -1) then
					{
						_grp setBehaviour "CARELESS";
						_heliCrew doMove (_helico getPos [30000, random 360]);

						private "_nil";
						{
							if (alive _x) then
							{
								_nil = [_x, 19, 545, true] spawn DK_fnc_addAllTo_CUM;							
							};

						} count _heliCrew;
					};

					if (alive _helico) then
					{
						[_helico, 21, 600, true] spawn DK_fnc_addVehTo_CUM;
					};
				};
			};
		};
	};

	waitUntil { uiSleep 5; (isNil "_helico") OR (isNull _helico) OR !(alive _helico) OR (crew _helico findIf {alive _x} isEqualTo -1) OR (_unitsCrew findIf {alive _x} isEqualTo -1) };

	_heliPads apply
	{
		deleteVehicle _x;
	};
};

DK_MIS_K03_fnc_chckIfDismbrkHeliRfr = {

	params ["_helico", "_objTarget", "_grp"];


	private ["_waypointGrp", "_waypointGrpFoot", "_grpBis", "_grpFoot", "_unitsCrew"];
	private _driver = driver _helico;
	private _haveDisembark = false;
	private _result = [_haveDisembark, nil];


	if ( (_objTarget distance2D _helico < 400) && { ({alive _x} count (crew _helico) > 1) && { !(playableUnits findIf {_x distance2D _objTarget < 120} isEqualTo -1) && { ((_objTarget nearEntities [["landVehicle","Man"], 140]) findIf {side (driver _x) isEqualTo (side _driver)} isEqualTo -1) } } } ) then
	{
		_grp call DK_fnc_delAllWp;
		_helico limitSpeed 1000;
		_waypointGrp = [_grp, _objTarget, "UNLOAD", nil,  "FULL", "CARELESS"] call DK_fnc_AddWaypoint;

	///	// LOOP for UNLOAD
		private _time = time + 100;
		private _exitLand = false;
		while { (time < _time) } do
		{
			_unitsCrew = units _grp;

			if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (!alive _driver) OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) ) exitWith {};

			// Landing ok, Allow Disembark
			if ( ((getPosATL _helico) # 2 < 2.5) OR (_helico getVariable ["haveDisembark", false]) ) exitwith
			{
				_unitsCrew apply
				{
					_x enableAI "MOVE";
					_x enableAI "PATH";
				};

				_helico setVariable ["haveDisembark", true];
				_grpFoot = createGroup _inSide;

				_driver disableAI "MOVE";

				_unitsCrew doFollow (leader _grp);
				(_unitsCrew - [_driver]) join _grpFoot;
				_unitsCrewFoot = units _grpFoot;

				_unitsCrewFoot orderGetIn false;
				_unitsCrewFoot allowGetIn false;
				_grpFoot leaveVehicle _helico;
				_grpFoot setCombatMode "GREEN";

				{
					if (alive _x) then
					{
						unassignVehicle _x;
						moveOut _x;

						uiSleep (0.3 + (random 0.3));
					};

				} forEach _unitsCrewFoot;

				_grp call DK_fnc_delAllWp;
				_grpFoot call DK_fnc_delAllWp;

				// Force Driver helico to cancel Landing
				private _sideGrp = side _driver;
				_grpBis = createGroup _sideGrp;
				[_driver] join _grpBis;
				_driver enableAI "MOVE";
				_grpBis deleteGroupWhenEmpty true;
				doStop _driver;
				_driver doFollow (leader _grpBis);
				_helico flyInHeight 80;
				_helico land "NONE";
				_waypointGrp = [_grpBis, (_objTarget getPos [150, random 360]), "MOVE", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypoint;

				_waypointGrpFoot = [_grpFoot, _objTarget, "SAD", nil,  if (!isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}, if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"}] call DK_fnc_AddWaypoint;

				uiSleep 1;
				_grpFoot setCombatMode "YELLOW";
				_grpFoot setBehaviour "COMBAT";
				[_objTarget, _grpFoot] spawn DK_loop_crewOnFoot_heli_rfr;

				_haveDisembark = true;
			};

			uiSleep 0.5;

			if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (!alive _driver) OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) ) exitWith {};

			if ( ( ({alive _x} count (units _grp) < 2) && { (alive (driver _helico)) && { !(_helico getVariable ["haveDisembark", false]) } } ) OR (_objTarget distance2D _helico > 700) OR (((playableUnits findIf {_x distance2D _objTarget < 120} isEqualTo -1) OR !((_objTarget nearEntities [["landVehicle","Man"], 80]) findIf {side (driver _x) isEqualTo (side _driver)} isEqualTo -1)) && {((getPosATL _helico) # 2 > 50)}) ) exitWith
			{
				_grp call DK_fnc_delAllWp;
				_grp setBehaviour "CARELESS";

				if ( (alive _helico) && { (canMove _helico) && { (alive (driver _helico)) } } ) then
				{
					// Force Driver helico to cancel Landing
					private _sideGrp = side _driver;
					_grpBis = createGroup _sideGrp;
					_unitsCrew join _grpBis;
					_grpBis deleteGroupWhenEmpty true;
					_unitsCrew apply
					{
						doStop _x;
						_x doFollow (leader _grpBis);
					};
					_helico flyInHeight 80;
					_helico land "NONE";
					_grpBis setBehaviour "CARELESS";
					_waypointGrp = [_grpBis, (_objTarget getPos [150, random 360]), "MOVE", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypoint;
				};
			};

			uiSleep 0.5;

			if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (!alive _driver) OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) ) exitWith {};

			if ( ((_unitsCrew - [_driver]) findIf {alive _x} isEqualTo -1) && { (alive driver _helico) } ) exitWith
			{
				_grp call DK_fnc_delAllWp;

				if ((alive _helico) && {(canMove _helico)}) then
				{
					_helico flyInHeight 140;
					_helico land "NONE";
					_helico forceSpeed 500;
				};
			};
		};
	};


	if _haveDisembark then
	{
		_result = [_haveDisembark, _grpFoot];
	};


	_result
};

/// Props compo
DK_MIS_K03_compoBig01 = {

	params ["_logic", "_dirH"];


	private _dirRev = _dirH - 180;
	private _dir9 = _dirH + 90;

	// Create all props
	private	_light = createVehicle ["Land_Camping_Light_F", [0,1,20], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;

	private	_garb01 = createVehicle ["Land_Garbage_square5_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;
	private	_garb02 = createVehicle ["Land_Garbage_square3_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_garbMed01 = createVehicle ["MedicalGarbage_01_3x3_v1_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_garbMed02 = createVehicle ["MedicalGarbage_01_5x5_v1_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_garbMed03 = createVehicle ["MedicalGarbage_01_3x3_v2_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 

	private	_sac01 = createVehicle ["Land_Sacks_heap_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_sac02 = createVehicle ["Land_Sacks_heap_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;

	private _tableSml = createSimpleObject ["Land_WoodenTable_small_F", [0,0,0]];
	uiSleep 0.3;
	private _tableLrg = createSimpleObject ["Land_WoodenTable_large_F", [0,0,0]];
	uiSleep 0.3;

//	private _sofaBig = createSimpleObject ["Land_Sofa_01_F", [0,0,0]];
	private	_sofaBig = createVehicle ["Land_Sofa_01_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
//	private _sofaSml = createSimpleObject ["Land_ArmChair_01_F", [0,0,0]];
	private	_sofaSml = createVehicle ["Land_ArmChair_01_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;

	private _chair01 = createSimpleObject ["Land_ChairWood_F", [0,0,0]];
	uiSleep 0.3;
	private _chair02 = createSimpleObject ["Land_ChairWood_F", [0,0,0]];
	uiSleep 0.3;

	private _cab = createSimpleObject ["Land_OfficeCabinet_02_F", [0,0,0]];
	uiSleep 0.3;
	private _rackM = createSimpleObject ["Land_Metal_rack_F", [0,0,0]];
	uiSleep 0.3;
	private _rackW = createSimpleObject ["Land_Metal_wooden_rack_F", [0,0,0]];
	uiSleep 0.3;
	private _schelv01 = createSimpleObject [shelves, [0,0,0]];
	uiSleep 0.3;
	private _schelv02 = createSimpleObject [shelves, [0,0,0]];
	uiSleep 0.3;

	private	_desk = createVehicle ["OfficeTable_01_old_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;

	private	_bed = createVehicle ["Land_WoodenBed_01_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;

	private _fridge = createSimpleObject [fridge, [0,0,0]];
	uiSleep 0.3;

	// Attach props to Logic
	_garb01 attachTo [_logic, [1.5, -3.1, 0]];
	uiSleep 0.05;
	_garb02 attachTo [_logic, [1, 5.3, 0]];
	uiSleep 0.05;
	_garbMed01 attachTo [_logic, [-2.5, -4.5, 3.4]];
	uiSleep 0.05;
	_garbMed02 attachTo [_logic, [-2, 0, 3.4]];
	uiSleep 0.05;
	_garbMed03 attachTo [_logic, [0.5, 5.5, 3.4]];
	uiSleep 0.05;

	_rackM attachTo [_logic, [-2.5, -6.99, 4.275]];
	uiSleep 0.05;
	_rackW attachTo [_logic, [-3.2, 2.45, 4.38]];
	uiSleep 0.05;

	private _shelvsPos = [[0.2, -2.66, 3.87],[1.35, -2.66, 3.87],[2.5, -2.66, 3.87]] call KK_fnc_arrayShuffle;
	_schelv01 attachTo [_logic, _shelvsPos # 0];
	uiSleep 0.05;
	_schelv02 attachTo [_logic, _shelvsPos # 1];
	uiSleep 0.05;

	_fridge attachTo [_logic, [-3.5, -6.79, 3.872]];
	uiSleep 0.05;

	_cab attachTo [_logic, [-1, 7.05, 0.72]];
	uiSleep 0.05;

	private _posSacs = [[3.6, -6.1, 3.77], [1.4, -6.1, 3.77]] call KK_fnc_arrayShuffle;
	_sac01 attachTo [_logic, _posSacs # 0];
	uiSleep 0.05;
	_sac02 attachTo [_logic, _posSacs # 1];
	uiSleep 0.05;

	_bed attachTo [_logic, [3.7, 6.15, 3.82]];
	uiSleep 0.05;

	_desk attachTo [_logic, [-3.65, 6.92, 3.77]];
	uiSleep 0.05;

	_sofaBig attachTo [_logic, [0.9, -6.5, 0.45]];
	uiSleep 0.05;
	_sofaSml attachTo [_logic, [4.05, -4, 0.45]];
	uiSleep 0.05;

	_tableLrg attachTo [_logic, [-3.75, 5.2, 0.37]];
	uiSleep 0.05;
	_tableSml attachTo [_logic, [4.05, -6.35, 0.39]];
	uiSleep 0.05;

	_chair01 attachTo [_logic, [-3.75, 6.0, 3.36]];
	uiSleep 0.05;
	_chair02 attachTo [_logic, [-3.6, 6.7, -0.07]];
	uiSleep 0.05;

	_light attachTo [_logic, selectRandom [[4.1, -6, 0.93], [-3.95, 4.6, 0.845], [-0.1, -2.7, 4.452], [-3.2, 7, 4.29]]];
	uiSleep 0.05;

	// Turn props
	{
		detach _x;
		uiSleep 0.02;

	} count [_rackW, _bed, _desk, _sofaBig, _tableSml, _tableLrg, _chair01, _chair02, _cab, _sofaSml];

	{
		detach _x;
		_x setDir _dir9;
		uiSleep 0.05;

	} count [_schelv01, _schelv02];

	{
		detach _x;
		_x setDir _dirRev;
		uiSleep 0.05;

	} count [_rackM, _fridge];

	{
		detach _x;
		_x setDir (random 360);
		uiSleep 0.05;

	} count [_light, _garb01, _garb02, _garbMed01, _garbMed02, _garbMed03, _sac01, _sac02];

	_chair01 setDir (_dirH + (190 + (random 70)));
	_chair02 setDir (random 360);

	_sofaSml setDir (_dirH - 90);

	private _money = [[_chair01, _sofaBig, _sofaSml, _schelv01, _schelv02, _rackM, _fridge], 100 + (round (random 50))] call DK_fnc_createMoneyObj;


	_logic setVariable ["props", [_tableSml, _tableLrg, _bed, _light, _garb01, _garb02, _garbMed01, _garbMed02, _garbMed03, _sac01, _sac02, _sofaBig, _sofaSml, _chair01, _chair02, _cab, _rackM, _rackW, _schelv01, _schelv02, _desk, _fridge, _money]];
};

DK_MIS_K03_compoBig02 = {

	params ["_logic", "_dirH"];


	private _dir7 = _dirH + 270;

	// Create all props
	private	_light = createVehicle ["Land_Camping_Light_F", [0,1,20], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;

	private	_garb01 = createVehicle ["Land_Garbage_square5_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;
	private	_garb02 = createVehicle ["Land_Garbage_square3_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_garbMed01 = createVehicle ["MedicalGarbage_01_3x3_v1_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_garbMed02 = createVehicle ["MedicalGarbage_01_5x5_v1_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_garbMed03 = createVehicle ["MedicalGarbage_01_3x3_v2_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 

	private	_sac01 = createVehicle ["Land_Sacks_heap_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;
	private	_sac02 = createVehicle ["Land_Sacks_heap_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;

	private _tableSml = createSimpleObject ["Land_WoodenTable_small_F", [0,0,0]];
	uiSleep 0.3;
	private _tableLrg = createSimpleObject ["Land_WoodenTable_large_F", [0,0,0]];
	uiSleep 0.3;

	private _sofaBig = createSimpleObject ["Land_Sofa_01_F", [0,0,0]];
	uiSleep 0.3;
	private _sofaSml = createSimpleObject ["Land_ArmChair_01_F", [0,0,0]];
	uiSleep 0.3;

	private _chair01 = createSimpleObject ["Land_ChairWood_F", [0,0,0]];
	uiSleep 0.3;
	private _chair02 = createSimpleObject ["Land_ChairWood_F", [0,0,0]];
	uiSleep 0.3;

	private _cab = createSimpleObject ["Land_OfficeCabinet_02_F", [0,0,0]];
	uiSleep 0.3;
	private _rackM = createSimpleObject ["Land_Metal_rack_F", [0,0,0]];
	uiSleep 0.3;
	private _schelv01 = createSimpleObject [shelves, [0,0,0]];
	uiSleep 0.3;
	private _schelv02 = createSimpleObject [shelves, [0,0,0]];
	uiSleep 0.3;

	private	_desk = createVehicle ["OfficeTable_01_old_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	uiSleep 0.3;

	private _bed = createSimpleObject ["Land_WoodenBed_01_F", [0,0,0]];
	uiSleep 0.3;

	private _fridge = createSimpleObject [fridge, [0,0,0]];
	uiSleep 0.3;

	// Attach props to Logic
	_garb01 attachTo [_logic, [0.2,2,-0.22]];
	uiSleep 0.05;
	_garb02 attachTo [_logic, [-1.5, -2.5, -0.22]];
	uiSleep 0.05;
	_garbMed01 attachTo [_logic, [-2.4, 3.3, 3.14]];
	uiSleep 0.05;
	_garbMed02 attachTo [_logic, [0.6, 2.9, 3.13]];
	uiSleep 0.05;
	_garbMed03 attachTo [_logic, [-1, -2.5, 3.16]];
	uiSleep 0.05;

	_rackM attachTo [_logic, [-1.3, 5.05, 4.005]];
	uiSleep 0.05;

	_schelv01 attachTo [_logic, [-4.15, 3.7, 3.6]];
	uiSleep 0.05;
	_schelv02 attachTo [_logic, [-4.15, 4.7, 3.6]];
	uiSleep 0.05;

	_fridge attachTo [_logic, [1.4, 4.83, 3.61]];
	uiSleep 0.05;

	_cab attachTo [_logic, [-4.225, 1, 0.51]];
	uiSleep 0.05;

	private _posSacs = [[3.4, 4.0, 3.5], [3.4, 1.2, 3.5]] call KK_fnc_arrayShuffle;
	_sac01 attachTo [_logic, _posSacs # 0];
	uiSleep 0.05;
	_sac02 attachTo [_logic, _posSacs # 1];
	uiSleep 0.05;

	_bed attachTo [_logic, [-3.46, 0.81, 3.57]];
	uiSleep 0.05;

	_desk attachTo [_logic, [-4.05, -1.4, 3.29]];
	uiSleep 0.05;

	_sofaBig attachTo [_logic, [1.2, 0.2, 0.23]];
	uiSleep 0.05;
	_sofaSml attachTo [_logic, [4.2, 4.2, 0.22]];
	uiSleep 0.05;

	_tableLrg attachTo [_logic, [4.2, 0.8, 0.17]];
	uiSleep 0.05;
	_tableSml attachTo [_logic, [2.1, -1.55, 0.17]];
	uiSleep 0.05;

	_chair01 attachTo [_logic, [1, -1.5, -0.26]];
	uiSleep 0.05;
	_chair02 attachTo [_logic, [-3.2, -1.9, 3.12]];
	uiSleep 0.05;

	_light attachTo [_logic, selectRandom [[4.0, 1.6, 0.73], [1.75, -2.09, 0.745], [-3.85, -1.88, 4.07], [-0.9, 5.05, 4.69]]];
	uiSleep 0.05;

	// Turn props
	{
		detach _x;
		uiSleep 0.02;

	} count [_sofaBig, _tableSml, _tableLrg, _schelv01, _schelv02, _rackM, _fridge, _bed];

	{
		detach _x;
		_x setDir (random 360);
		uiSleep 0.05;

	} count [_light, _garb01, _garb02, _garbMed01, _garbMed02, _garbMed03, _sac01, _sac02, _chair01, _chair02];

	{
		detach _x;
		_x setDir _dir7;
		uiSleep 0.05;

	} count [_sofaSml, _desk, _cab];

	_bed setDir (_dirH + 180);

	private _money = [[_chair01, _chair02, _sofaBig, _sofaSml, _schelv01, _schelv02, _rackM, _fridge], 100 + (round (random 50))] call DK_fnc_createMoneyObj;


	_logic setVariable ["props", [_tableSml, _tableLrg, _bed, _light, _garb01, _garb02, _garbMed01, _garbMed02, _garbMed03, _sac01, _sac02, _sofaBig, _sofaSml, _chair01, _chair02, _cab, _rackM, _schelv01, _schelv02, _desk, _fridge, _money]];
};

DK_MIS_K03_compoBarr = {

	params ["_logic", "_dirH"];


	private _dir9 = _dirH + 90;
	private _dir18 = _dirH + 180;


	// Create all props
	private _desk1 = createVehicle ["Land_TableDesk_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;
	private _desk2 = createVehicle ["Land_TableDesk_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;
	private _desk3 = createVehicle ["Land_TableDesk_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;
	private _desk4 = createVehicle ["Land_TableDesk_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;
	private _desk5 = createVehicle ["Land_TableDesk_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	uiSleep 0.3;

	private _water = createSimpleObject ["Land_WaterCooler_01_old_F", [0,0,0]];
	uiSleep 0.3;

	private _plant1 = createSimpleObject ["Land_FlowerPot_01_Flower_F", [0,0,0]];
	uiSleep 0.3;
	private _plant2 = createSimpleObject ["Land_FlowerPot_01_Flower_F", [0,0,0]];
	uiSleep 0.3;
	private _plant3 = createSimpleObject ["Land_FlowerPot_01_Flower_F", [0,0,0]];
	uiSleep 0.3;

	private _chair1 = createSimpleObject ["Land_OfficeChair_01_F", [0,0,0]];
	uiSleep 0.3;
	private _chair2 = createSimpleObject ["Land_OfficeChair_01_F", [0,0,0]];
	uiSleep 0.3;
	private _chair3 = createSimpleObject ["Land_OfficeChair_01_F", [0,0,0]];
	uiSleep 0.3;
	private _chair4 = createSimpleObject ["Land_OfficeChair_01_F", [0,0,0]];
	uiSleep 0.3;
	private _chair5 = createSimpleObject ["Land_OfficeChair_01_F", [0,0,0]];
	uiSleep 0.3;


	_desk1 attachTo [_logic, [-13.2, -2.80, 0.41]];
	uiSleep 0.05;
	_desk2 attachTo [_logic, [2.33, 2.80, 0.41]];
	uiSleep 0.05;
	_desk3 attachTo [_logic, [10, -1.53, 0.41]];
	uiSleep 0.05;
	_desk4 attachTo [_logic, [13.71, 4.21, 3.77]];
	uiSleep 0.05;
	_desk5 attachTo [_logic, [-13.2, 3.7, 3.77]];
	uiSleep 0.05;

	_water attachTo [_logic, [-3.5,-3.22,0.745]];
	uiSleep 0.05;

	_plant1 attachTo [_logic, [1.1, 1.80, 0.818]];
	uiSleep 0.05;
	_plant2 attachTo [_logic, [14, 1.80, 0.818]];
	uiSleep 0.05;
	_plant3 attachTo [_logic, [-1.55, -5.80, 4.150]];
	uiSleep 0.05;


	// Turn props
	detach _water;
	uiSleep 0.02;

	{
		detach _x;
		_x setDir _dir9;
		uiSleep 0.05;

	} count [_desk1, _desk2, _desk5];

	{
		detach _x;
		_x setDir _dir18;
		uiSleep 0.05;

	} count [_desk3, _desk4];


	_chair1 attachTo [_desk1, [0, 1.0, 0.19]];
	uiSleep 0.05;
	_chair2 attachTo [_desk2, [0, 1.0, 0.19]];
	uiSleep 0.05;
	_chair3 attachTo [_desk3, [0, 1.0, 0.19]];
	uiSleep 0.05;
	_chair4 attachTo [_desk4, [0, 1.0, 0.19]];
	uiSleep 0.05;
	_chair5 attachTo [_desk5, [0, 1.0, 0.19]];
	uiSleep 0.05;


	{
		detach _x;
		_x setDir (random 360);
		uiSleep 0.05;

	} count [_plant1, _plant2, _plant3, _chair1, _chair2, _chair3, _chair4, _chair5];



	private _desks = [_desk1, _desk4, _desk5, _desk2, _desk3] call KK_fnc_arrayShuffle;

	private _money = [[_desks # 3, _desks # 4], 100 + (round (random 50))] call DK_fnc_createMoneyObj;


	_logic setVariable ["props", (_desks + [_water, _plant1, _plant2, _plant3, _chair1, _chair2, _chair3, _chair4, _chair5, _money])];
};


/// Units compo
DK_MIS_K03_compo6_1 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;


	[[_tg_kill01,_tg_kill04]]
};

DK_MIS_K03_compo6_2 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;


	[[_tg_kill01,_tg_kill03,_tg_kill05]]
};

DK_MIS_K03_compo6_3 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;


	[[_tg_kill01,_tg_kill05]]
};

DK_MIS_K03_compo6_4 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;



	[[_tg_kill01,_tg_kill03], [_tg_kill05,_tg_kill06]]
};

DK_MIS_K03_compo6_5 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;


	[[_tg_kill01], [_tg_kill05,_tg_kill06]]
};

DK_MIS_K03_compo6_6 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05] call DK_fnc_3_chatting;


	[[_tg_kill01,_tg_kill03], [_tg_kill06]]
};


DK_MIS_K03_compo8_1 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07]]
};

DK_MIS_K03_compo8_2 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07]]
};

DK_MIS_K03_compo8_3 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill05]]
};

DK_MIS_K03_compo8_4 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05]]
};

DK_MIS_K03_compo8_5 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05], [_tg_kill08]]
};

DK_MIS_K03_compo8_6 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05], [_tg_kill07, _tg_kill08]]
};

DK_MIS_K03_compo8_7 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03], [_tg_kill07, _tg_kill08]]
};

DK_MIS_K03_compo8_8 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill04], [_tg_kill07, _tg_kill08]]
};

DK_MIS_K03_compo8_9 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill05], [_tg_kill08]]
};


DK_MIS_K03_compo10_1 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07]]
};

DK_MIS_K03_compo10_2 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09]]
};

DK_MIS_K03_compo10_3 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill09]]
};

DK_MIS_K03_compo10_4 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07]]
};

DK_MIS_K03_compo10_5 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_4_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill07]]
};

DK_MIS_K03_compo10_6 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07], [_tg_kill10]]
};

DK_MIS_K03_compo10_7 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07], [_tg_kill09, _tg_kill10]]
};

DK_MIS_K03_compo10_8 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05], [_tg_kill09, _tg_kill10]]
};

DK_MIS_K03_compo10_9 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05] call DK_fnc_3_chatting;
	[_tg_kill06,_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill06], [_tg_kill10]]
};

DK_MIS_K03_compo10_10 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05] call DK_fnc_3_chatting;
	[_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill06], [_tg_kill09,_tg_kill10]]
};

DK_MIS_K03_compo10_11 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill05], [_tg_kill09,_tg_kill10]]
};


DK_MIS_K03_compo12_1 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
	[_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill10]]
};

DK_MIS_K03_compo12_2 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09, _tg_kill11]]
};

DK_MIS_K03_compo12_3 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill09, _tg_kill11]]
};

DK_MIS_K03_compo12_4 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill09]]
};

DK_MIS_K03_compo12_5 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill09]]
};

DK_MIS_K03_compo12_6 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill05, _tg_kill09]]
};

DK_MIS_K03_compo12_7 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09]]
};

DK_MIS_K03_compo12_8 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
	[_tg_kill10,_tg_kill11] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill10], [_tg_kill12]]
};

DK_MIS_K03_compo12_9 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09], [_tg_kill11,_tg_kill12]]
};

DK_MIS_K03_compo12_10 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07], [_tg_kill11,_tg_kill12]]
};

DK_MIS_K03_compo12_11 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07], [_tg_kill11,_tg_kill12]]
};

DK_MIS_K03_compo12_12 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_4_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill07], [_tg_kill11,_tg_kill12]]
};

DK_MIS_K03_compo12_13 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06,_tg_kill07] call DK_fnc_4_chatting;
	[_tg_kill08,_tg_kill09,_tg_kill10,_tg_kill11] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill08], [_tg_kill12]]
};

DK_MIS_K03_compo12_14 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill09], [_tg_kill11,_tg_kill12]]
};


DK_MIS_K03_compo14_1 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
	[_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_3_chatting;
	[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill10, _tg_kill13]]
};

DK_MIS_K03_compo14_2 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;
	[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09, _tg_kill11, _tg_kill13]]
};

DK_MIS_K03_compo14_3 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09, _tg_kill11]]
};

DK_MIS_K03_compo14_4 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill11]]
};

DK_MIS_K03_compo14_5 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_4_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill07, _tg_kill11]]
};

DK_MIS_K03_compo14_6 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill11]]
};

DK_MIS_K03_compo14_7 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill11]]
};

DK_MIS_K03_compo14_8 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill11], [_tg_kill13,_tg_kill14]]
};

DK_MIS_K03_compo14_9 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09, _tg_kill11], [_tg_kill13,_tg_kill14]]
};

DK_MIS_K03_compo14_10 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill04, _tg_kill07, _tg_kill09, _tg_kill11], [_tg_kill13,_tg_kill14]]
};

DK_MIS_K03_compo14_11 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill09, _tg_kill11], [_tg_kill13,_tg_kill14]]
};

DK_MIS_K03_compo14_12 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
	[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill09, _tg_kill11], [_tg_kill14]]
};

DK_MIS_K03_compo14_13 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill05, _tg_kill07, _tg_kill11], [_tg_kill14]]
};

DK_MIS_K03_compo14_14 = {

	params ["_tg_kill01", "_tg_kill02", "_tg_kill03", "_tg_kill04", "_tg_kill05", "_tg_kill06", "_tg_kill07", "_tg_kill08", "_tg_kill09", "_tg_kill10", "_tg_kill11", "_tg_kill12", "_tg_kill13", "_tg_kill14"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_4_chatting;
	[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
	[_tg_kill11,_tg_kill12,_tg_kill13] call DK_fnc_3_chatting;


	[[_tg_kill01, _tg_kill03, _tg_kill07, _tg_kill11], [_tg_kill14]]
};
















