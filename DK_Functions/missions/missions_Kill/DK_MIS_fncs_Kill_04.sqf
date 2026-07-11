if !(isServer) exitWith {};


#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]
#define classBoat selectRandom ["C_Boat_Civil_01_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","I_Boat_Transport_01_F"]


DK_MIS_K04_create = {

	DK_MIS_loopsInProgress = 0;

	// Set Mission Type
	DK_MIS_missionType = "Kill";

	// Get Difficulty depending on number of missions completed (Ennemies Stuff, Weapons, Reward loot) (server)
	private _difficulties = call DK_MIS_fnc_slctDifficulty_K04;

	_difficulties params ["_nbUnits", "_nfoGangs", "_disSeen", "_behaviour", "_speed", "_rewardLvl", "_canFollow", "_canCallRfr", ["_canCallHeliRfr", [false]]];

	_nfoGangs params ["_nfoGang1", "_nfoGang2"];
	_nfoGang1 params ["_vehClass1", "_className1", "_uniform1", "_weapons1", "_vest1", "_classGuy1"];
	_nfoGang2 params ["_vehClass2", "_className2", "_uniform2", "_weapons2", "_vest2", "_classGuy2"];


	// Define ID mission (server)
	private _idMission = call DK_MIS_create_ID_mission;
	if (isNil "_idMission") then
	{
		_idMission = "error" + (str time);
	};
	DK_idMission = _idMission;
	publicVariable "DK_idMission";


	// Init mission (server)
	_result = _difficulties call DK_MIS_K04_init;

	_result params ["_allGrps", "_allUnits", "_allTargets", "_startingPos", "_vehicles", "_rwdrs"];


	// Create various Trigger AI (server)
	[_allUnits, _disSeen, DK_MIS_K04_triggerAI, 400, 60] spawn DK_MIS_Kill_addIsSeen;

	// Create Trigger reinforcement
	call
	{
		private _allUnitsScdr = (+_allUnits) - _allTargets;
		if (selectRandom [true,false]) exitWith
		{
			[_startingPos, _allUnitsScdr, _className1, _uniform1, _weapons1, _vest1, _classGuy1, _canCallRfr, _canCallHeliRfr, _idMission] spawn DK_MIS_K04_waitCallRfr;
		};

		[_startingPos, _allUnitsScdr, _className2, _uniform2, _weapons2, _vest2, _classGuy2, _canCallRfr, _canCallHeliRfr, _idMission] spawn DK_MIS_K04_waitCallRfr;
	};

	// Start cooldown mission
	_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission;


	// Start Mission for players ! (local)
	_victorySnd = call DK_MIS_slctVictorySnd;
	DK_MIS_IdJIP_initCL = [_idMission, _allTargets, [_classGuy1, _classGuy2], _victorySnd] remoteExecCall ["DK_MIS_fnc_K04_initClient_cl", DK_isDedi, true];

	// Create markers targets
	[_allTargets, _idMission] spawn DK_MIS_Kill_mkrTargets;


	// Added protect what to recognize chefs
	_allTargets spawn DK_fnc_LO_leaders;

/*	_startingPos spawn
	{
		player hideObjectGlobal true;
		uiSleep 6;
		player setPosATL _this;
		uiSleep 5;
		DK_MIS_allTargets apply
		{
			_x setDamage 1;
		};
	};
*/

	// Handle & Waiting Ending (server)
	_result call DK_MIS_K04_finished;
};

DK_MIS_K04_init = {

	params ["_nbUnits", "_nfoGangs", "", "_behaviour", "_speed", "_rewardLvl", "_canFollow"];

	_nfoGangs params ["_nfoGang1", "_nfoGang2"];
	_nfoGang1 params ["_vehClass1", "_className1", "_uniform1", "_weapons1", "_vest1"];
	_nfoGang2 params ["_vehClass2", "_className2", "_uniform2", "_weapons2", "_vest2"];

///	START // Create & manage entities to pre-initialize mission
	private ["_grp01A", "_grp02A", "_grp01B", "_grp02B", "_grp01C", "_grp02C", "_unit", "_laps", "_nil", "_resultAiCompo", "_pos", "_veh", "_posVehAct", "_heli", "_dir"];

	// Set side, Gangs = _side ; Cops = Resistance
	private "_side";
	call
	{
		if (_className1 isEqualTo "O_G_Survivor_F") exitWith
		{
			_side = east;
		};

		_side = resistance;
	};

	private _nbVeh1 = selectRandom [1,2];
	private _nbVeh2 = 3 - _nbVeh1;
	private _vehicles = [];
	
	switch ( _vehClass1 ) do
	{
		case "veh_cls" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_cls;
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Heli
			_heli = createVehicle ["O_Heli_Light_02_unarmed_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_heli spawn DK_fnc_initOrca;
		};

		case "veh_looter" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				_veh = [] call DK_MIS_fnc_crtVan_looters;
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Heli
			_heli = createVehicle ["O_Heli_Light_02_unarmed_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_heli spawn DK_fnc_initOrca;
		};

		case "veh_sportOffroad" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Heli
			_heli = createVehicle ["O_Heli_Light_02_unarmed_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_heli spawn DK_fnc_initOrca;
		};

		case "veh_Ballas" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_Ballas;
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Added MP3 Players
			[(selectRandom _vehicles), true, [["MP3music02", 18.125], ["MP3music03", 14.793], ["MP3music04", 24], ["MP3music07", 40.435], ["MP3music05", 8]]] spawn DK_fnc_MP3car_init;

			// Heli
			_heli = createVehicle ["O_Heli_Light_02_unarmed_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_heli spawn DK_fnc_initOrca;
		};

		case "veh_Triads" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_Triads;
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Added MP3 Players
			[(selectRandom _vehicles), true, [["MP3music01", 32], ["MP3music06", 35.559], ["MP3music08", 23.001]]] spawn DK_fnc_MP3car_init;

			// Heli
			_heli = createVehicle ["O_Heli_Light_02_unarmed_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_heli spawn DK_fnc_initOrca;
		};

		case "veh_Dominicans" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				switch (selectRandom [1,2,3]) do
				{
					case 1 :
					{
						_veh = [] call DK_MIS_fnc_crtVeh_Domi;
					};

					case 2 :
					{
						_veh = [true, "LMG"] call DK_MIS_fnc_crtVeh_DomiGun;
					};

					case 3 :
					{
						_veh = [true, "AT"] call DK_MIS_fnc_crtVeh_DomiGun;
					};
				};
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Heli
			_heli = call DK_MIS_fnc_crtHeliLand_DomiGun;
		};

		case "veh_Albanians" :
		{
			for "_i" from 1 to _nbVeh1 do
			{
				switch (selectRandom [1,2,3]) do
				{
					case 1 :
					{
						_veh = [] call DK_MIS_fnc_crtVeh_Alban;
					};

					case 2 :
					{
						_veh = [true, "LMG"] call DK_MIS_fnc_crtVeh_AlbanGun;
					};

					case 3 :
					{
						_veh = [true, "AT"] call DK_MIS_fnc_crtVeh_AlbanGun;
					};
				};
				_veh setVariable ["DK_grp", "A"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};

			// Heli
			_heli = call DK_MIS_fnc_crtHeliLand_AlbanGun;
		};
	};

	switch ( _vehClass2 ) do
	{
		case "veh_cls" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_cls;
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};

		case "veh_looter" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				_veh = [] call DK_MIS_fnc_crtVan_looters;
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};

		case "veh_sportOffroad" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};

		case "veh_Ballas" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_Ballas;
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};

		case "veh_Triads" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				_veh = [] call DK_MIS_fnc_crtVeh_Triads;
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};

		case "veh_Dominicans" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				switch (selectRandom [1,2,3]) do
				{
					case 1 :
					{
						_veh = [] call DK_MIS_fnc_crtVeh_Domi;
					};

					case 2 :
					{
						_veh = [true, "LMG"] call DK_MIS_fnc_crtVeh_DomiGun;
					};

					case 3 :
					{
						_veh = [true, "AT"] call DK_MIS_fnc_crtVeh_DomiGun;
					};
				};
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};

		case "veh_Albanians" :
		{
			for "_i" from 1 to _nbVeh2 do
			{
				switch (selectRandom [1,2,3]) do
				{
					case 1 :
					{
						_veh = [] call DK_MIS_fnc_crtVeh_Alban;
					};

					case 2 :
					{
						_veh = [true, "LMG"] call DK_MIS_fnc_crtVeh_AlbanGun;
					};

					case 3 :
					{
						_veh = [true, "AT"] call DK_MIS_fnc_crtVeh_AlbanGun;
					};
				};
				_veh setVariable ["DK_grp", "B"];
				_vehicles pushBack _veh;
				uiSleep 0.1;
			};
		};
	};

	_vehicles pushBack _heli;

	_vehicles params ["_veh01", "_veh02", "_veh03", "_heli"];

	private _vehWheel = [_veh01, _veh02, _veh03];

	// Protect Vehicles
	{
		_x allowDamage false;
		_x enableSimulationGlobal false;

		uiSleep 0.02;

	} count _vehicles;

	uiSleep 0.15;

	// Create units --
	private _logic = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
	_logic setPos [0,0,40];

	private _grpA = createGroup _side;
	private _grpB = createGroup _side;
	private _allGrps = [_grpA, _grpB];
	{
		_x setVariable ["grpCheif", true];

	} count _allGrps;

	private _cheifA = crtU(_grpA,_className1);
	private _cheifB = crtU(_grpB,_className2);

	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_grp01A = createGroup _side;

			_allGrps pushBack _grp01A;
		};

		case 2 :
		{
			_grp01A = createGroup _side;
			_grp02A = createGroup _side;

			_allGrps pushBack _grp01A;
			_allGrps pushBack _grp02A;
		};
	};

	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_grp01B = createGroup _side;

			_allGrps pushBack _grp01B;
		};

		case 2 :
		{
			_grp01B = createGroup _side;
			_grp02B = createGroup _side;

			_allGrps pushBack _grp01B;
			_allGrps pushBack _grp02B;
		};
	};

	private _allUnits = [_cheifA, _cheifB];
	call
	{
		if (_nbUnits isEqualTo 8) exitWith
		{
			for "_i" from 1 to 4 do
			{
				_allUnits pushBackUnique (crtU(_grp01A,_className1));
				uiSleep 0.02;
			};

			for "_i" from 1 to 4 do
			{
				_allUnits pushBackUnique (crtU(_grp01B,_className2));
				uiSleep 0.02;
			};
		};

		if (_nbUnits > 8) exitWith
		{
			_laps = _nbUnits / 2;

			for "_i" from 1 to _laps do
			{
				_allUnits pushBackUnique (crtU(_grp01A,_className1));
				uiSleep 0.02;
			};

			for "_i" from 1 to _laps do
			{
				_allUnits pushBackUnique (crtU(_grp01B,_className2));
				uiSleep 0.02;
			};

			_grp01C = createGroup _side;
			_grp02C = createGroup _side;
			_allGrps pushBack _grp01C;
			_allGrps pushBack _grp02C;
		};
	};

	// Added Stuff
	private _unitsGrpsA = units _grp01A;
	private _unitsGrpsB = units _grp01B;

	private _unitsGrpsATmp = +_unitsGrpsA + [_cheifA];
	private _waitLoA = [_unitsGrpsATmp, _uniform1, _weapons1, _vest1] spawn DK_MIS_fnc_slctUnitsLO;
	private _unitsGrpsBTmp = +_unitsGrpsB + [_cheifB];
	private _waitLoB = [_unitsGrpsBTmp, _uniform2, _weapons2, _vest2] spawn DK_MIS_fnc_slctUnitsLO;


	// Form group (move unit to grp1 at grpX) & add veh
	private _vehScndForCheif = +_vehWheel;

	if !(isNil "_grp02A") then
	{
		_laps = selectRandom [1,2,3];
		for "_i" from 1 to _laps step 1 do
		{
			if (count units _grp01A isEqualTo 1) exitWith {};

			_unit = selectRandom _unitsGrpsA;

			if ( (!isNil "_unit") && { (!isNull _unit) } ) then
			{
				[_unit] join _grp02A;
			};
		};

		uiSleep 0.05;

		if (selectRandom _canFollow) then
		{
			for "_i" from 0 to (selectRandom [0,1]) do
			{
				_veh = _vehWheel # _i;

				if (_veh getVariable ["DK_grp", ""] isEqualTo "A") then
				{
					_grp02A setVariable ["useVehicle", true];
					_grp02A setVariable ["assignedVeh", _veh];
					_nil = _vehScndForCheif deleteAt (_vehScndForCheif find _veh);
					_grp02A addVehicle _veh;
				};
			};
		};
	};

	if !(isNil "_grp02B") then
	{
		_laps = selectRandom [1,2,3];
		for "_i" from 1 to _laps step 1 do
		{
			if (count units _grp01B isEqualTo 1) exitWith {};

			_unit = selectRandom _unitsGrpsB;

			if ( (!isNil "_unit") && { (!isNull _unit) } ) then
			{
				[_unit] join _grp02B;
			};
		};

		uiSleep 0.05;

		if (selectRandom _canFollow) then
		{
			for "_i" from 1 to (selectRandom [1,2]) do
			{
				_veh = _vehWheel # _i;

				if (_veh getVariable ["DK_grp", ""] isEqualTo "B") then
				{
					_grp02B setVariable ["useVehicle", true];
					_grp02B setVariable ["assignedVeh", _veh];
					_nil = _vehScndForCheif deleteAt (_vehScndForCheif find _veh);
					_grp02B addVehicle _veh;
				};
			};
		};
	};

	// Protect Units & set variable
	{
		_x allowDamage false;
		_x attachTo [_logic, [0,0,0]];
		_x disableAI "MOVE";
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x setVariable ["allGroups", _allGrps];
		_nil = _x call DK_MIS_addEH_HandleDmg;
		_nil = DK_unitsStayUp pushBackUnique _x;
		_x hideObjectGlobal true;
		_x setCaptive true;

		uiSleep 0.03;

	} count _allUnits;

	// Setup Groups
	_allGrps apply
	{
		_x deleteGroupWhenEmpty true;
		_x setFormation "DIAMOND";
		_x setCombatMode "RED";
	};

	// Placement
	[_cheifA, _cheifB] call DK_fnc_2_chatting;

	uiSleep 0.1;	// Sleep for performance

///	END // Create & manage entities to pre-initialize mission


	// Find place
	private _startingArray = call DK_MIS_fnc_slctSafePlace_05;
	_startingArray params ["_placeType", "_startingPos", "_posVeh", "_posHeli", "_posBoats", "_unitsPosVehTmp", "_nfoRoundGuard"];
	_placeType params ["_typeVehFlee1", "_typeVehFlee2"];

	private _unitsPosVeh = +_unitsPosVehTmp;
	_unitsPosVeh params ["_unitsPosVeh01", "_unitsPosVeh02", "_unitsPosVeh03"];

	// Place Chiefs
	detach _cheifA;
	uiSleep 0.08;
	_cheifA setDir (random 360);
	_cheifA setPosATL _startingPos;

	// Place Units cheif A
	private _dirBase = (getDir _cheifA) + 180;
	private _posGrpA = [_cheifA getPos [3 + (random 1.2), _dirBase], _cheifA getPos [3 + (random 1.2), _dirBase + 30], _cheifA getPos [3 + (random 1.2), _dirBase + 60], _cheifA getPos [3 + (random 1.2), _dirBase - 30], _cheifA getPos [3 + (random 1.2), _dirBase - 60], _unitsPosVeh01, _unitsPosVeh02, _unitsPosVeh03] call KK_fnc_arrayShuffle;
	private _unitsPosVehToDel = [];

	for "_i" from 0 to 3 do
	{
		_unit = _unitsGrpsA # _i;
		detach _unit;
		_pos = (_posGrpA # _i);
		uiSleep 0.08;

		call
		{
			if (count _pos isEqualTo 2) exitWith
			{
				_unit setPosATL (_pos # 0);
				_unit setDir (_pos # 1);
				_unitsPosVehToDel pushBack _pos;
			};

			_unit setPosATL _pos;
			_unit setDir (_unit getRelDir _cheifB);
		};
	};

	// Place Units cheif B
	detach _cheifB;
	{
		_nil = _unitsPosVeh deleteAt (_unitsPosVeh find _x);

	} count _unitsPosVehToDel;
	uiSleep 0.08;

	_dirBase = (getDir _cheifB) + 180;
	private _posGrpB = ([_cheifB getPos [3 + (random 1.2), _dirBase], _cheifB getPos [3 + (random 1.2), _dirBase + 30], _cheifB getPos [3 + (random 1.2), _dirBase + 60], _cheifB getPos [3 + (random 1.2), _dirBase - 30], _cheifB getPos [3 + (random 1.2), _dirBase - 60]] + _unitsPosVeh) call KK_fnc_arrayShuffle;

	for "_i" from 0 to 3 do
	{
		_unit = _unitsGrpsB # _i;
		detach _unit;
		_pos = (_posGrpB # _i);
		uiSleep 0.08;

		call
		{
			if (count _pos isEqualTo 2) exitWith
			{
				_unit setPosATL (_pos # 0);
				_unit setDir (_pos # 1);
				_unitsPosVehToDel pushBack _pos;
			};

			_unit setPosATL _pos;
			_unit setDir (_unit getRelDir _cheifB);
		};
	};

	{
		_nil = _unitsPosVeh deleteAt (_unitsPosVeh find _x);

	} count _unitsPosVehToDel;


	if (_nbUnits > 8) then
	{
		private _helfNbU = (_nbUnits / 2) - 1;
		_unitsPosVeh pushBack ((_nfoRoundGuard # 8) # 0);

		for "_i" from 4 to _helfNbU do
		{
			_unit = _unitsGrpsA # _i;
			detach _unit;
			_pos = selectRandom _unitsPosVeh;
			uiSleep 0.08;

			call
			{
				if (count _pos isEqualTo 2) exitWith
				{
					_unit setPosATL (_pos # 0);
					_unit setDir (_pos # 1);
					_nil = _unitsPosVeh deleteAt (_unitsPosVeh find _pos);
				};

				[_unit] join _grp01C;
				_unit setPosATL _pos;
				[_unit, _nfoRoundGuard] call DK_MIS_K04_roundGuard;
			};
		};

		for "_i" from 4 to _helfNbU do
		{
			_unit = _unitsGrpsB # _i;
			detach _unit;
			_pos = selectRandom _unitsPosVeh;
			uiSleep 0.08;

			call
			{
				if (count _pos isEqualTo 2) exitWith
				{
					_unit setPosATL (_pos # 0);
					_unit setDir (_pos # 1);
					_nil = _unitsPosVeh deleteAt (_unitsPosVeh find _pos);
				};

				[_unit] join _grp02C;
				_unit setPosATL _pos;
				[_unit, _nfoRoundGuard] call DK_MIS_K04_roundGuard;
			};
		};
	};


	// Place Vehicles
	_vehWheel call KK_fnc_arrayShuffle;
	for "_i" from 0 to 2 do
	{
		_veh = _vehWheel # _i;
		_posVehAct = _posVeh # _i;
		_dir = _posVehAct # 1;

		_veh setDir (_dir + (selectRandom [0,180]));
		_veh setPosATL (_posVehAct # 0);
		_veh setPosATL (_veh getPos [selectRandom [0, 0.5,1,1.3, -0.5,-1,-1.3], _dir + (selectRandom [0,180])]);
		_veh setVectorUp surfaceNormal (getPosATLVisual _veh);
		uiSleep 0.1;
	};	

	// Place Helico
	_heli setDir ((_posHeli # 1) + (selectRandom [0,180]));
	_heli setPosATL (_posHeli # 0);
	_heli setFuel 0.2;
	if (_posHeli # 2 < 1) then
	{
		_heli setVectorUp surfaceNormal (_posHeli # 0);
	};

	uiSleep 0.05;

	// Create & Place Boat (or Heli or Plane)
	private _vehFrstForCheif = [_heli];
	call
	{
		if (_typeVehFlee2 isEqualTo "Boat") exitWith
		{
			_boat = createVehicle [classBoat, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_vehicles pushBack _boat;
			_boat allowDamage false;
			_boat enableSimulationGlobal false;
			private _posBoat = selectRandom _posBoats;
			_boat setDir (_posBoat # 1);
			_boat setPosATL (_posBoat # 0);
			clearItemCargoGlobal _boat;
			_boat setUnloadInCombat [FALSE,FALSE]; 

			_vehFrstForCheif pushBack _boat;
			_vehFrstForCheif call KK_fnc_arrayShuffle;
		};

		if (_typeVehFlee2 isEqualTo "Plane") then
		{
			_plane = createVehicle ["C_Plane_Civil_01_racing_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
			_vehicles pushBack _plane;
			_plane allowDamage false;
			_plane enableSimulationGlobal false;
			_plane setDir (_posBoats # 1);
			_plane setPosATL (_posBoats # 0);
			_plane setVectorUp surfaceNormal (_posBoats # 0);
			_plane call DK_fnc_initCesar;
			_plane setUnloadInCombat [FALSE,FALSE]; 

			_vehFrstForCheif pushBack _plane;
			_vehFrstForCheif call KK_fnc_arrayShuffle;
		};
	};

	missionNamespace setVariable ["vehForCheif", [_vehFrstForCheif, _vehScndForCheif]];


	waitUntil { uiSleep 0.1; (scriptDone _waitLoA) && { (scriptDone _waitLoB) } };

	deleteVehicle _logic;

	// Create & Move Reward stuff crate
	private _rwdrs = [_cheifA modelToWorldVisual [2, 0.6, 0.5], _rewardLvl] call DK_MIS_fnc_crtRwrd;


	// Added varied Trigger for start AI units
	_cheifA call DK_MIS_Kill_addEH_targetsDead;
	_cheifB call DK_MIS_Kill_addEH_targetsDead;

	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["MIS_center", _startingPos];
		_x call DK_MIS_Kill_04_unitsAddEH_trgAI;
		_x call DK_MIS_EH_handleAmmoNweapons;

		uiSleep 0.02;

		// DEBUG
		if (((getPosATL _x) # 0) < 1) then
		{
			_x setVehiclePosition [_startingPos, [], 8, "NONE"];
		};
	};


	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["allVehicles", _vehicles];
		_nil = _x call DK_MIS_Kill_04_vehAddEH_trgAI;
		_x enableSimulationGlobal true;
		_x allowDamage true;

		uiSleep 0.02;

	} count _vehicles;

	_nil = _vehicles spawn
	{
		uiSleep 3;

		{
//			_nil = _x call DK_fnc_EH_dynSim;
			_x enableDynamicSimulation true;
			uiSleep 0.02;

		} count _this;
	};


	// Define variables related to the mission (Only Server)
	DK_MIS_var_AiIsBlocked = true;
	DK_MIS_var_PlayersAreNotSeen = true;
	DK_MIS_var_behaviour = _behaviour;
	DK_MIS_var_speedUnits = _speed;
	DK_MIS_var_missInProg = true;
	DK_MIS_playerRewardsMarkersList = [];
	DK_MIS_allTargets = [_cheifA, _cheifB];

	// Define variables related to the mission (Clients & Server)
	DK_nbTargets_Goal = count DK_MIS_allTargets;
	publicVariable "DK_nbTargets_Goal";

	DK_nbTargets_Cnt = 0;
	publicVariable "DK_nbTargets_Cnt";

	uiSleep 0.5;

///	// Tweaking before starting mission for mafioso & Add EH to units for Hud player & Ending mission
	{
		detach _x;
		_x allowDamage true;
		_x hideObjectGlobal false;
		uiSleep 0.02;

	} count _allUnits;

	{
		_x setVariable ["DK_score", (_x getVariable ["DK_score", 20]) * 20];

	} count DK_MIS_allTargets;

	[_unitsGrpsA + _unitsGrpsB, _cheifA, _cheifB, _allUnits] spawn
	{
		params ["_unitsGrps", "_cheifA", "_cheifB", "_allUnits"];


		uiSleep 9;

		{
			if !(_x getVariable ["DK_behaviour", ""] isEqualTo "walk") then
			{
				_x disableAI "ANIM";
			};

		} count _allUnits;

		uiSleep 1;

		_cheifA playMoveNow "AmovPercMstpSnonWnonDnon";
		_cheifB playMoveNow "AmovPercMstpSnonWnonDnon";

		private "_nil";
		{
			_x action ["WeaponOnBack", _x];
			_x call DK_MIS_addEH_secondDead;
			_nil = _x call DK_MIS_addEH_selectSeat;

		} count _unitsGrps;

		uiSleep 1;

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

//	DKK_allUnits = +_allUnits;
//	DKK_veh = [_veh01, _veh02, _veh03];
//	DKK_veh apply { _x call DK_fnc_EH_dynSim;}


	[_allGrps, _allUnits, [_cheifA, _cheifB], _startingPos, _vehicles, _rwdrs]
};

DK_MIS_K04_finished = {

	params ["_allGrps", "_allUnits", "_allTargets", "", "_vehicles", "_rwdrs"];

/*	_allUnits spawn
	{
		uiSleep 10;
		player setPos (boat modelToWorldVisual [0,3,0]);
		uiSleep 10;
		_this apply
		{
			_x setDamage 1;
		};
	};
*/

	private "_nil";
	private _allUnits = +_allUnits;
	private _vehicles = +_vehicles;
	private _allGrps = +_allGrps;
	private _time = time + DK_MIS_maxTimeMission;

	waitUntil { uiSleep 0.3; !(DK_MIS_var_missInProg) OR (time > _time) OR (_allTargets findIf { uiSleep 0.02; !isNil "_x" } isEqualTo -1) OR (_allTargets findIf { uiSleep 0.02; alive _x } isEqualTo -1) };

	// Ending the game if counter is down
	if ((call BIS_fnc_missionTimeLeft) isEqualTo 0) exitWith
	{
		call DK_fnc_endSelectWinner;
	};

	// Delete info for local player from JIP
	remoteExecCall ["", DK_MIS_IdJIP_initCL];

	// Variable to be sure that Ending mission
	DK_MIS_var_missInProg = false;

	// Add Rewards to Clean Up
	call
	{
		if (DK_MIS_playerRewardsMarkersList isEqualTo []) exitWith
		{
			_rwdrs + [nil, 0, 30] spawn DK_MIS_fnc_deleteReward;
		};

		(_rwdrs # 0) remoteExecCall ["DK_MIS_fnc_rewards3dIcone_cl", DK_MIS_playerRewardsMarkersList];
		_rwdrs + [nil, nil, 300] spawn DK_MIS_fnc_deleteReward;
	};

	// Add UNITS to Clean Up
	{
		if !(isNull _x) then
		{
			call
			{
				if (DK_MIS_var_AiIsBlocked) exitWith
				{
					call
					{
						if (isNull (objectParent _x)) exitWith
						{
							deleteVehicle _x;
						};

						(objectParent _x) deleteVehicleCrew _x;
					};
				};

				if (alive _x) exitWith
				{
					[_x, DK_MIS_timeDelScdrU2, DK_MIS_disDelScdrU2, true] spawn DK_fnc_addAllTo_CUM;
				};

				[_x, DK_MIS_timeDelCorps, DK_MIS_disDelCorps, true] spawn DK_fnc_addAllTo_CUM;
			};
		};

	} forEach _allUnits;


	// Add VEHICLES to Clean Up
	{
		uiSleep 0.05;

		if ( (!isNil "_x") && { (alive _x) } ) then
		{
			if (_x isKindOf "LandVehicle") exitWith
			{
				_x call DK_MIS_fnc_vehicle_removeAllEH;
				_x call DK_MIS_reInitVehNormal;
				_x call DK_MIS_fnc_initVehWhenEnd;
				_nil = [_x, DK_MIS_timeDelVeh, DK_MIS_disDelVeh, true] spawn DK_fnc_addVehTo_CUM;
			};

			if (_x isKindOf "Air") exitWith
			{
				_x call DK_fnc_initHeliBoatEnd;
				_nil = [_x, DK_MIS_timeDelVeh, DK_MIS_disDelVeh, true] spawn DK_fnc_addVehTo_CUM;
			};

			_x call DK_fnc_initHeliBoatEnd;
			_nil = [_x, DK_MIS_timeDelVeh, DK_MIS_disDelVeh, true] spawn DK_fnc_addVehTo_CUM;
		};

	} count	_vehicles;



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
	missionNamespace setVariable ["vehForCheif", nil];


	uiSleep 1;

	// Start next mission
	call DK_MIS_fnc_slctDifficultyLevel;
};


// Varied Trigger for start AI
DK_MIS_Kill_04_unitsAddEH_trgAI = {

	_this addEventHandler ["FiredNear",
	{
		_this append [DK_MIS_K04_triggerAI, 400, 60];
		_this call DK_MIS_fnc_EhFiredNear_trgAI;
	}];

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K04_triggerAI, 400, 60, _thisEventHandler];
		_this call DK_MIS_fnc_EhHit_trgAI;
	}];

	private _idEhKilled = _this addEventHandler ["Killed",
	{
		_this append [DK_MIS_K04_triggerAI, 400, 60];
		_this call DK_MIS_fnc_EhKilled_trgAI;
	}];

	_this setVariable ["idEhHitTrgAI", _idEhHit];
	_this setVariable ["idEhKilledTrgAI", _idEhKilled];
};

DK_MIS_Kill_04_vehAddEH_trgAI = {

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K04_triggerAI, 400, 60];
		_this call DK_MIS_fnc_EhHitNear_trgAI_Veh;
	}];

	private _idEhGetIn = _this addEventHandler ["GetIn",
	{
		params ["_veh"];


		_veh removeEventHandler ["GetIn", _thisEventHandler];
		_veh setVariable ["free", false];
	}];

	_this setVariable ["idEhHitTrgAI", _idEhHit];
};


// Trigger Script for start AI
DK_MIS_K04_triggerAI = {

	params ["_allUnits", ["_disMax", 250], ["_disMin", 40], "_shooter"];


	DK_MIS_var_PlayersAreNotSeen = false;

	if (_allUnits findIf {alive _x} isEqualTo -1) exitWith {};

	private _allGrps = (_allUnits # 0) getVariable "allGroups";

	if (isNil "_allGrps") then
	{
		private _idGrp = _allUnits findIf { (!isNil {_x getVariable "allGroups"}) };
		if !(_idGrp isEqualTo -1) then
		{
			_allGrps = (_allUnits # _idGrp) getVariable ["allGroups", []];
		};

		if (_allGrps isEqualTo []) then
		{
			_allGrps pushBack (group (_allUnits # 0));
		};
	};

	private _vehicles = (_allGrps # 0) getVariable ["allVehicles", []];


	[_allUnits, (group (_allUnits # 0))] call DK_MIS_fnc_removeEhTrgAi;

	// Activate AI target
	_allUnits apply
	{
		if (alive _x) then
		{
			_x enableAI "ANIM";
			_x enableAI "MOVE";
			_x enableAI "TARGET";
			_x enableAI "AUTOTARGET";
			_x setCaptive false;

			uiSleep (random 0.3);
		};
	};

	if (isNil "_shooter") then
	{
		_shooter = leader (_allGrps # 0);
	};


	// Move units if they have a linked Vehicle
	private _unitsMis = _allUnits select [2, 20];
	private ["_vehTemp", "_nil", "_waypoint", "_grp", "_grpShooter"];
	{
		call
		{
			_grp = _x;

			if (units _grp findIf { alive _x } isEqualTo -1) exitWith {};

			if (_grp getVariable ["grpCheif", false]) exitWith
			{
				[_grp, leader _grp] spawn DK_MIS_fnc_K04_cheifFlee;
			};

			_nil = _grp spawn DK_fnc_selectLoopVoice;
			_grp setSpeedMode DK_MIS_var_speedUnits;

			if ( (_grp getVariable ["useVehicle", false]) && { !(isNil {_grp getVariable "assignedVeh"}) && { (_shooter distance leader _grp > 50) } } ) exitWith
			{
				(units _grp) orderGetIn true;
				(units _grp) allowGetIn true;

				_vehTemp = _grp getVariable "assignedVeh";
				_grp setVariable ["chaseNFO", [units _grp, _grp, _vehTemp, _unitsMis, (leader _grp) getVariable ["MIS_center", [0,0,0]], false, _shooter]];
				_waypoint = [_grp, _vehTemp, "if (!isServer) exitWith {}; (group this getVariable 'chaseNFO') spawn DK_MIS_fnc_K04_vehGoToHelp", "!((units this) findIf {alive _x} isEqualTo -1)", "GETIN", nil, "FULL", "CARELESS", 10] call DK_fnc_AddWaypointState;
			};

			_grp setBehaviour DK_MIS_var_behaviour;
			_nil = [_grp, _disMax, _disMin] spawn DK_MIS_fnc_stayCloseArea;

			if ( (!isNil "_shooter") && { (selectRandom [true,false]) } ) then
			{
	//			systemChat "fnc trigAI 2b";

				_grpShooter = units (group _shooter);
				_mateId = _grpShooter findIf {_x distance2D (leader _grp) < 70};

				if ( !(_mateId isEqualTo -1) && { (selectRandom [true,false]) } ) exitWith
				{
					_waypoint = [_grp, getPosATL (_grpShooter # _mateId), "SAD", nil,  DK_MIS_var_speedUnits, DK_MIS_var_behaviour, 50] call DK_fnc_AddWaypoint;
				};

				if (_shooter distance leader _grp < 100) then
				{
					_waypoint = [_grp, getPosATL _shooter, "SAD", nil,  DK_MIS_var_speedUnits, DK_MIS_var_behaviour, 50] call DK_fnc_AddWaypoint;
				};
			};
		};

		uiSleep 0.3;

	} count _allGrps;

};


// Cheif fleeing
DK_MIS_fnc_K04_cheifFlee = {

	params ["_grp", "_cheif"];


	if (!alive _cheif) exitWith {};

	_vehicles = missionNamespace getVariable ["vehForCheif", []];

	if (_vehicles isEqualTo []) exitWith {};

	private ["_nil", "_veh"];
	_vehicles params ["_vehBoathelis", "_vehWheel"];

	private _vehId = _vehBoathelis findIf { (canMove _x) && { (_x getVariable ["free", true]) } };

	call
	{
		if (_vehId isEqualTo -1) exitWith
		{
			_vehId = _vehWheel findIf { (canMove _x) && { (_x getVariable ["free", true]) } };
			if !(_vehId isEqualTo -1) then
			{
				_veh = _vehWheel # _vehId;
				_nil = _vehWheel deleteAt _vehId;
			};
		};

		_veh = _vehBoathelis # _vehId;
		_nil = _vehBoathelis deleteAt _vehId;
	};

	if (_vehId isEqualTo -1) exitWith {};


	_grp setBehaviour "CARELESS";
	_grp setCombatMode "YELLOW";
	_grp setSpeedMode "FULL";
	_grp addVehicle _veh;
	[_cheif] orderGetIn true;
	[_cheif] allowGetIn true;
	_cheif forceSpeed 200;

	missionNamespace setVariable ["vehForCheif", [_vehBoathelis, _vehWheel]];

	_grp call DK_fnc_delAllWp;
	[_grp, _veh, "GETIN", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypoint;

	private _time = time + 180;
	waitUntil { uiSleep 0.5; (isNil "_cheif") OR (isNull _cheif) OR (!alive _cheif) OR (!alive _veh) OR !(_veh getVariable ["free", true]) OR (time > _time) };

	if ( (isNil "_cheif") OR (isNull _cheif) OR (!alive _cheif) ) exitWith {};

	call
	{
		if (objectParent _cheif isEqualTo _veh) exitWith
		{
			_veh forceSpeed 150;
			_grp call DK_fnc_delAllWp;


			if (_veh isKindOf "LandVehicle") exitWith
			{
				[_cheif, 120, 500, true] spawn DK_fnc_addAllTo_CUM;
				[_grp, _veh, false] call DK_MIS_Kill_01_AiInVeh_move_2;
			};

			_cheif setVariable ["DK_spawnProtectOn", false];

			if (_veh isKindOf "Air") exitWith
			{
				[_cheif, 90, 1300, false] spawn DK_fnc_addAllTo_CUM;
				_veh flyInHeight 120;
				[_grp, [getPosATL _veh, 3000, 8000, 0, 2, 0, 0, [], [_veh getPos [4000, getDir _veh], _veh getPos [4000, getDir _veh]]] call BIS_fnc_findSafePos, "if (!isServer) exitWith {}; [group this, (vehicle this) getPos [6000, (getDir (vehicle this) - 45 + (random 90))], 'MOVE', nil, 'FULL', 'CARELESS'] call DK_fnc_AddWaypoint", "alive this", "MOVE", nil, "FULL", "CARELESS", 50] call DK_fnc_AddWaypointState;
				[_veh, _cheif] call DK_MIS_addEH_airScrTarget;
			};

			[_cheif, 90, 300, true] spawn DK_fnc_addAllTo_CUM;
			[_grp, [getPosATL _veh, 1700, 5000, 0, 2, 0, 0, [[_veh getPos [4000, (getDir _veh) + 180], 5000]], [_veh getPos [500, getDir _veh], _veh getPos [500, getDir _veh]]] call BIS_fnc_findSafePos, "if (!isServer) exitWith {}; this spawn DK_fnc_CLAG_doMoveBoatNext;", "alive this", "MOVE", nil, "FULL", "CARELESS", 50] call DK_fnc_AddWaypointState;
		};

		[_grp, _cheif] call DK_MIS_fnc_K04_cheifFlee;
	};
};


/// Reinforcement
DK_MIS_K04_waitCallRfr = {

	params ["_startingPos", "_allUnits", "_className", "_uniform", "_weapons", "_vest", "_classGuy", "_canCallRfr", "_canCallHeliRfr", "_idMission"];


	if !(selectRandom _canCallRfr) exitWith {};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	waitUntil { uiSleep 1; !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg }; 

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;

	uiSleep 1;

	if !(DK_MIS_var_missInProg) exitWith {};

	call
	{
		_classGuy remoteExecCall ["DK_fnc_hudKillRfr", DK_isDedi];

		private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

		if (_nbMaxFam < 3) exitWith
		{
			if ((selectRandom _canCallHeliRfr) && { (_classGuy in ["Albanians", "Dominicans"]) } ) exitWith
			{
				[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy, _idMission] spawn DK_MIS_K04_callHeliRfr;
			};

			[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
		};

		if ( (_nbMaxFam > 2) && { (_nbMaxFam < 7) } ) exitWith
		{
			if ((selectRandom _canCallHeliRfr) && { (_classGuy in ["Albanians", "Dominicans"]) } ) exitWith
			{
				[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy, _idMission] spawn DK_MIS_K04_callHeliRfr;
				[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
			};

			[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
			[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
		};

		if (_nbMaxFam > 6) then
		{
			if ((selectRandom _canCallHeliRfr) && { (_classGuy in ["Albanians", "Dominicans"]) } ) exitWith
			{
				[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy, _idMission] spawn DK_MIS_K04_callHeliRfr;
				[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
				[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
			};

			[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
			[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
			[_startingPos, _allUnits, _className, _uniform, _weapons, _vest, _classGuy] spawn DK_MIS_K04_callRfr;
		};
	};
};

DK_MIS_K04_callRfr = {

	params ["_startingPos", "_unitsMis", "_className", "_uniform", "_weapons", "_vest", "_classGuy"];


	uiSleep (5 + (random 10));

	// Search position safe for spawn Reinforcement
	private _resultPos = [_startingPos, 200, 800, 12, 4, true, 700] call DK_fnc_MTW_searchSpawnVeh_OnRoad;

	_resultPos params ["_spawnPos", "_dir"];

	if !(_spawnPos isEqualTo 0) then
	{
	// Create Reinforcement Vehicle & Crew 
		private _resultCrewVeh = [_className, _classGuy, _uniform, _weapons, _vest, _spawnPos, _dir, false, true] call DK_fnc_crtCrewVeh_rfr;
		_resultCrewVeh params ["_unitsCrew", "_grp", "_vehicle"];

		DK_nbSearchSpawnRoad_inProg = false;

		waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _vehicle) };

		[_unitsCrew, _grp, _vehicle, _unitsMis, _startingPos, true] call DK_MIS_fnc_K04_vehGoToHelp;
	}
	else
	{
		DK_nbSearchSpawnRoad_inProg = false;
	};
};

DK_MIS_fnc_K04_vehGoToHelp = {

	params ["_unitsCrew", "_grp", "_vehicle", "_unitsMis", "_finalPos", "_reInitEnd", "_shooter"];


	if (_unitsCrew findIf { (alive _x) } isEqualTo -1) exitWith {}; 

	// Chase a nearest player targeting by a gang member
	call
	{
		if (!isNil "_shooter") exitWith
		{
			_finalPos = getPosATL _shooter;
		};

		private _idSHooter = _unitsCrew findIf { !(assignedTarget _x isEqualTo objNull) };

		if !(_idSHooter isEqualTo -1) exitWith
		{
			_shooter = assignedTarget (_unitsCrew # _idSHooter);
			_unitsCrew doTarget _shooter;
			_finalPos = getPosATL _shooter;
		};

		_unitsMis call KK_fnc_arrayShuffle;
		_idSHooter = _unitsMis findIf { !(assignedTarget _x isEqualTo objNull) };

		if !(_idSHooter isEqualTo -1) then
		{
			_shooter = assignedTarget (_unitsMis # _idSHooter);
			_unitsCrew doTarget _shooter;
			_finalPos = getPosATL _shooter;
		};
	};

	private _road = [_finalPos, 150] call BIS_fnc_nearestRoad;

	call
	{
		if (_road isEqualTo objNull) exitWith
		{
			_road = _finalPos;
		};

		_road = getPosATL _road;
	};

	// Go to road nearest target
	_grp call DK_fnc_delAllWp;
	_unitsCrew doMove _road;


/*		// DEBUG
		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, _road];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [15, 15];
		// DEBUG
*/
	// Go and disembark to starting place
	private _time = time + (_vehicle distance _road) / 3;
	waitUntil { uiSleep 1; (_unitsCrew findIf {alive _x} isEqualTo -1) OR (leader _grp distance2D _road < 15) OR (time > _time) };

	if ( (_reInitEnd) && { (!isNull _vehicle) && { (alive _vehicle) } } ) then
	{
		_vehicle call DK_MIS_fnc_vehicle_removeAllEH;
		_vehicle call DK_MIS_reInitVehNormal;
		_vehicle call DK_MIS_fnc_initVehWhenEnd;
		_vehicle setUnloadInCombat [true,true]; 
	};

	if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

	if !(_road isEqualTo _finalPos) then
	{
		_unitsCrew doMove _finalPos;

		_time = time + (_vehicle distance _finalPos) / 3;
		waitUntil { uiSleep 1; (_unitsCrew findIf {alive _x} isEqualTo -1) OR (leader _grp distance2D _finalPos < 30) OR (time > _time) };
	};

	if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

	_grp call DK_fnc_delAllWp;
	private _waypoint = [_grp, _finalPos, "if (!isServer) exitWith {}; (group this) spawn DK_fnc_selectLoopVoice", "true", "UNLOAD", nil, "FULL", "COMBAT", 30] call DK_fnc_AddWaypointState;
	_waypoint = [_grp, _finalPos, "SAD", nil,  "FULL", "COMBAT", 10] call DK_fnc_AddWaypoint;
	_unitsCrew orderGetIn false;
	_unitsCrew allowGetIn false;
	_grp leaveVehicle _vehicle;

	(units _grp) apply
	{
		unassignVehicle _x;
		[_x, 200, 180, true] spawn DK_fnc_addAllTo_CUM;
	};
};

DK_MIS_K04_callHeliRfr = {

	params ["_startingPos", "_allUnits", "_className", "_uniform", "_weapons", "_vest", "_classGuy", "_idMission"];


	uiSleep (5 + (random 10));

	// Search position safe for spawn Reinforcement
	private _resultPos = [_startingPos, 800, 2300, [], 3, "", 1500] call DK_fnc_searchSpawn_rfr_heli; 
	_resultPos params ["_spawnPos", "_dir"];

	if ( (isNil "_resultPos") OR (_spawnPos isEqualTo 0) ) exitWith
	{
		DK_nb_searchSpawn_rfr_heli_inProg = false;
	};

	// Create Reinforcement Vehicle & Crew 
	private _resultCrewVeh = [_className, _classGuy, _uniform, _weapons, _vest, _spawnPos, _dir, "0", false] call DK_fnc_crtCrewVeh_rfr_heli;
	_resultCrewVeh params ["_unitsCrew", "_grp", "_helico"];

	DK_nb_searchSpawn_rfr_heli_inProg = false;


	private ["_grpFoot", "_result", "_idSHooter"];

	uiSleep 0.5;
	_unitsCrew apply
	{
		_x call DK_addEH_getOut_heliCrew_rfr;
	};


	waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _helico) };

	private _time = time + 600;
	private _fnc_condSSVOR = {

		!(playableUnits findIf { _x distance2D _startingPos < 800 } isEqualTo -1) && { (time < _time) }
	};

	// Create Helipads around target
	_heliPad = createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
	_heliPad setPos ([_startingPos, 0, 100, 10, 0, 0.1, 0, [], [_startingPos,_startingPos]] call BIS_fnc_findSafePos);


///	// AI Loop Pursuit Start
	private _pilotHeli = driver _helico;
	private _haveDisembark = false;
	private _ending = "";
	call
	{
		if (count _unitsCrew isEqualTo 1 ) exitWith
		{
			_grp setBehaviour "COMBAT";
		};

		_grp setBehaviour "CARELESS";
	};

	[_pilotHeli] spawn DK_fnc_selectLoopVoiceHeli;

	while { call _fnc_condSSVOR } do
	{
		_grp = group _pilotHeli;
		_grp call DK_fnc_delAllWp;
		_unitsCrew = units _grp;

	///	// Move Helicopter at Target objectif
		call
		{
			_idSHooter = _unitsCrew findIf { !(assignedTarget _x isEqualTo objNull) };

			if !(_idSHooter isEqualTo -1) exitWith
			{
				_shooter = assignedTarget (_unitsCrew # _idSHooter);
				_unitsCrew doMove (_shooter getPos [70 + random 50, random 360]);
				_unitsCrew doTarget _shooter;

				if (_pilotHeli distance2D _shooter < 500) exitWith
				{
					_grp setSpeedMode "LIMITED";
					_helico limitSpeed 50;
					_helico flyInHeight 20;
				};

				_grp setSpeedMode "NORMAL";
				_helico limitSpeed 120;
				_helico flyInHeight 80;
			};

			_allUnits call KK_fnc_arrayShuffle;
			_idSHooter = _allUnits findIf { !(assignedTarget _x isEqualTo objNull) };

			if !(_idSHooter isEqualTo -1) exitWith
			{
				_shooter = assignedTarget (_allUnits # _idSHooter);
				_unitsCrew doMove (_shooter getPos [70 + random 50, random 360]);
				_unitsCrew doTarget _shooter;

				if (_pilotHeli distance2D _shooter < 500) exitWith
				{
					_grp setSpeedMode "LIMITED";
					_helico limitSpeed 50;
					_helico flyInHeight 20;
				};

				_grp setSpeedMode "NORMAL";
				_helico limitSpeed 120;
				_helico flyInHeight 80;
			};


			_unitsCrew doMove (_startingPos getPos [120, random 360]);
			_grp setSpeedMode "NORMAL";
			_helico limitSpeed 150;
			_helico flyInHeight 80;
		};

		uiSleep 2;

	///	// Check for Exit loop
		if !(call _fnc_condSSVOR) exitWith {};

		if ( ({alive _x} count crew _helico isEqualTo 1) && { (alive _pilotHeli) && { !(typeOf _helico isEqualTo "O_Heli_Light_02_dynamicLoadout_F") } } ) exitWith
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

		uiSleep 1;
	};
///	// AI Loop Pursuit END

	_helico setVehicleLock "UNLOCKED";
	_unitsCrew = units _grp;
	_grp call DK_fnc_delAllWp;
	_helico limitSpeed 1000;
	_grp setSpeedMode "FULL";

	// Start Ending for heli
	call DK_MIS_K04_endHeliRfr;


	waitUntil { uiSleep 5; (isNil "_helico") OR (isNull _helico) OR !(alive _helico) OR (crew _helico findIf {alive _x} isEqualTo -1) OR (_unitsCrew findIf {alive _x} isEqualTo -1) };

	deleteVehicle _heliPad;
};

DK_MIS_K04_endHeliRfr = {

	switch (_ending) do
	{
		case "A" :	// Pilot alone in heli
		{
			_helico flyInHeight 100;
			uiSleep 10;

			if ( (!isNil "_grpFoot") && { !(units _grpFoot findIf {alive _x} isEqualTo -1) } ) then
			{
				_unitsCrew doMove (_startingPos getPos [70 + random 70, random 360]);
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

			[_startingPos, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
		};

		case "C" :	// Pilot heli dead, not crew in heli
		{
			
		};

		case "" :	// Mission terminée / il n'y a plus d'objectif
		{
			private _crew = crew _helico;
	
			if !(_crew findIf {alive _x} isEqualTo -1) then
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


/// Action for units
DK_MIS_K04_roundGuard = {

	params ["_unit"];

	_unit setVariable ["DK_behaviour", "walk"];

	_this spawn
	{
		params ["_unit", "_nfoRoundGuard"];


		waitUntil { uiSleep 0.5; !(isNil "DK_MIS_var_AiIsBlocked")  OR !(alive _unit) };

		uiSleep 4;

		if (alive _unit) then
		{
			private ["_weapon", "_posBlack", "_nil", "_pos", "_time", "_ElTmp"];

			private _haveHandgun = false;

			if !(handgunWeapon _unit isEqualTo "") then
			{
				_haveHandgun = true;

				_weapon = currentWeapon _unit;
				_unit removeWeapon _weapon;
			};

			_unit setBehaviour "SAFE";
			_unit enableAI "MOVE";
			_unit enableAI "ANIM";
			_unit forceWalk true;

			while { DK_MIS_var_AiIsBlocked && { (alive _unit) && { (_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") } } } do
			{
				_ElTmp = _nfoRoundGuard # 7;
				_posBlack = [getPosATL _unit, 35];
				_ElTmp set [count _ElTmp, _posBlack];
				_pos = _nfoRoundGuard call BIS_fnc_findSafePos;
				_nil = _ElTmp deleteAt (_ElTmp find _posBlack);
				if (count _pos isEqualTo 3) then
				{
					_pos = _nfoRoundGuard # 0 getPos [20, random 360];
				};

//				private _arrow = createVehicle ["Sign_Arrow_Large_Yellow_F", _pos, [], 0, "CAN_COLLIDE"];
				_unit doMove _pos;

				_time = time + (_unit distance2D _pos);
				waitUntil { uiSleep 1; (_unit distance2D _pos < 1) OR (time > _time) OR (!alive _unit) OR !(DK_MIS_var_AiIsBlocked) OR !(_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") };

				if ( !(DK_MIS_var_AiIsBlocked) OR (!alive _unit) OR !(_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") ) exitWith {};

				_unit doFollow _unit;
				doStop _unit;
				_unit setFormDir (random 360);

//				deleteVehicle _arrow;

				_time = time + (3 + (random 20));
				waitUntil { uiSleep 1; (time > _time) OR (!alive _unit) OR !(DK_MIS_var_AiIsBlocked) OR !(_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") };
			};

			if (!alive _unit) exitWith {};

			_unit doFollow leader (group _unit);
			if _haveHandgun then
			{
				_unit addWeapon _weapon;
			};

			_unit forceWalk false;
		};
	};
};












