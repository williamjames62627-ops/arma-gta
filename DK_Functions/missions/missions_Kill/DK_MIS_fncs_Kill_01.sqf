if !(isServer) exitWith {};


#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]

#define wreckList_1 ["Land_Wreck_Ural_F","Land_Wreck_UAZ_F","Land_Wreck_Offroad_F","Land_Wreck_Car3_F","Land_Wreck_Car2_F","Land_Wreck_CarDismantled_F","Land_Wreck_Truck_F","Land_Wreck_Skodovka_F","Land_Wreck_Van_F","Land_Wreck_Truck_dropside_F"]
#define wreckList_2 ["Land_Wreck_Slammer_F","Land_Wreck_MBT_04_F","Land_Wreck_Slammer_hull_F","Land_Wreck_T72_hull_F","Land_Wreck_Hunter_F","Land_Wreck_AFV_Wheeled_01_F","Land_Wreck_BRDM2_F","Land_Wreck_BMP2_F"]

#define farmMaldList ["Land_Shed_08_brown_F", "Land_Shed_08_grey_F"]
#define farmList ["Land_i_Stone_HouseSmall_V1_F", "Land_i_Stone_HouseSmall_V2_F", "Land_i_Stone_HouseSmall_V3_F"]
#define farmDestroy "Land_d_Stone_HouseSmall_V1_F"

#define towerFarm ["Land_WaterTank_02_F", "Land_WaterTower_01_F", "Land_WindmillPump_01_F"]

#define construcSite ["Land_Unfinished_Building_01_F", "Land_Unfinished_Building_02_F"]
#define construcProps ["Land_WorkStand_F", "Land_CinderBlocks_F", "Land_Coil_F", "Land_ConcretePipe_F", "Land_Pallets_stack_F", "Land_Pipes_large_F", "Land_WoodenPlanks_01_messy_pine_F", "Land_WoodenPlanks_01_pine_F", "Land_IronPipes_F", "Land_MobileScafolding_01_F", "Land_ToiletBox_F", "Land_Bricks_V4_F", "Land_Bricks_V1_F", "Land_Bricks_V3_F"]

#define bulldozer ["Land_Bulldozer_01_wreck_F", "Land_Excavator_01_wreck_F"]
#define dirtHump ["Dirthump_1_F", "Dirthump_2_F", "Dirthump_3_F"]

#define slumList_1 ["Land_cargo_house_slum_F","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_Shed_03_F","Land_Shed_02_F","Land_Shed_05_F"]

#define barrelList_D ["Land_MetalBarrel_empty_F","Land_BarrelTrash_F","Land_GarbageBarrel_01_F"]


DK_MIS_Kill_01_create = {

	DK_MIS_loopsInProgress = 0;

	// Set Mission Type
	DK_MIS_missionType = "Kill";

	// Get Difficulty depending on number of missions completed (Ennemies Stuff, Weapons, Reward loot) (server)
	private _difficulties = call DK_MIS_fnc_slctDifficulty_K01;

	_difficulties params ["_vehClass","_nbUnits","_className","_uniform","_weapons","_vest","_disSeen","_behaviour","_speed","_nbGrpinVeh","_rewardLvl", "_classGuy", "_canSitting"];


	// Define ID mission (server)
	private _idMission = call DK_MIS_create_ID_mission;
	if (isNil "_idMission") then
	{
		_idMission = "error" + (str time);
	};
	DK_idMission = _idMission;
	publicVariable "DK_idMission";


	// Init mission (server)
	_result = _difficulties call DK_MIS_Kill_01_init;

	_result params ["_allGrps", "_allUnits","_vehicles","_props","_propsLinkToAI","_rwdrs_tableBox"];


	// Create various Trigger AI (server)
	[_allUnits, _disSeen, DK_MIS_K01_triggerAI] spawn DK_MIS_Kill_addIsSeen;


	// Start cooldown mission
	_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission;


	// Start Mission for players ! (local)
	_insult = call DK_MIS_slctInsult;
	_victorySnd = call DK_MIS_slctVictorySnd;
	DK_MIS_IdJIP_initCL = [_idMission, _allUnits, _insult, _classGuy, _victorySnd] remoteExecCall ["DK_MIS_fnc_K01_initClient_cl", DK_isDedi, true];

	// Create markers targets
	[_allUnits, _idMission] spawn DK_MIS_Kill_mkrTargets;


/*	_allUnits spawn
	{
//		if true exitWith {};

		hideObject player;
		uiSleep 6;
		player setpos ((_this # 0) modelToWorldVisual [0,2,1]);

		uiSleep 5;
		DK_MIS_allUnits apply { _x setdamage 1 };
	};
*/

	// Handle & Waiting Ending (server)
	_result call DK_MIS_Kill_01_finished;
};

DK_MIS_Kill_01_init = {

	params ["_vehClass","_nbUnits","_className","_uniform","_weapons","_vest","","_behaviour","_speed","_nbGrpinVeh","_rewardLvl","_ennemiesType", "_canSitting"];


	// Set side, Gangs = _side ; Cops = Resistance
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
	private ["_veh01", "_veh02", "_veh03", "_veh04", "_grp01","_grp02","_grp03","_grp04", "_nil", "_vehTemp", "_resultAiCompo", "_props", "_waitMoving", "_orderProps", "_pos"];

	// Create Vehicles --
	switch ( _vehClass ) do
	{
		case "veh_cls" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_cls;
			_veh02 = [] call DK_MIS_fnc_crtVeh_cls;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtVeh_cls;
			_veh04 = [] call DK_MIS_fnc_crtVeh_cls;
		};

		case "veh_looter" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVan_looters;
			_veh02 = [] call DK_MIS_fnc_crtVan_looters;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtQuad_looters;
			_veh04 = [] call DK_MIS_fnc_crtQuad_looters;
		};

		case "veh_sportOffroad" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
			_veh02 = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
			_veh04 = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
		};

		case "veh_Ballas" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_Ballas;
			_veh02 = [] call DK_MIS_fnc_crtVeh_Ballas;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtVeh_Ballas;
			_veh04 = [] call DK_MIS_fnc_crtVeh_Ballas;

			// Added MP3 Players
			[(selectRandom [_veh01, _veh02, _veh03, _veh04]), true, [["MP3music02", 18.125], ["MP3music03", 14.793], ["MP3music04", 24], ["MP3music07", 40.435], ["MP3music05", 8]]] spawn DK_fnc_MP3car_init;

		};

		case "veh_Triads" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_Triads;
			_veh02 = [] call DK_MIS_fnc_crtVeh_Triads;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtVeh_Triads;
			_veh04 = [] call DK_MIS_fnc_crtVeh_Triads;

			// Added MP3 Players
			[(selectRandom [_veh01, _veh02, _veh03, _veh04]), true, [["MP3music01", 32], ["MP3music06", 35.559], ["MP3music08", 23.001]]] spawn DK_fnc_MP3car_init;
		};

		case "veh_Dominicans" :
		{
			_veh01 = [true, "LMG"] call DK_MIS_fnc_crtVeh_DomiGun;
			_veh02 = [true, "AT"] call DK_MIS_fnc_crtVeh_DomiGun;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtVeh_Domi;
			_veh04 = [] call DK_MIS_fnc_crtVeh_Domi;
		};

		case "veh_Albanians" :
		{
			_veh01 = [true, "HMG"] call DK_MIS_fnc_crtVeh_AlbanGun;
			_veh02 = [true, "AT"] call DK_MIS_fnc_crtVeh_AlbanGun;
			uiSleep 0.1;
			_veh03 = [] call DK_MIS_fnc_crtVeh_Alban;
			_veh04 = [] call DK_MIS_fnc_crtVeh_Alban;
		};
	};

	// Protect Vehicles
	_vehicles = [_veh01,_veh02,_veh03,_veh04];
	{
		_x allowDamage false;
//		_x setUnloadInCombat [FALSE,FALSE]; 
		_x setDir (random 360);
		_x enableSimulationGlobal false;

	} count _vehicles;

	uiSleep 0.15;

	// Create units --
	private _logic = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
	_logic setPos [0,0,40];
	private _allGrps = [];

	private "_nbGrps";
	call
	{
		if (_ennemiesType isEqualTo "Ballas") exitWith
		{
			_nbGrps = selectRandom [2,3,4];
		};

		if (_ennemiesType isEqualTo "Triads") exitWith
		{
			_nbGrps = 4;
		};

		_nbGrps = selectRandom [1,2,3,4];
	};


	switch ( _nbGrps ) do
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
		if (_nbUnits isEqualTo 8) exitWith
		{
			for "_i" from 1 to 8 do
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

		if (_nbUnits isEqualTo 14) exitWith
		{
			for "_i" from 1 to 14 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 16) then
		{
			for "_i" from 1 to 16 do
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
		_x setVariable ["allGroups", _allGrps];
//		_nil = _x call DK_MIS_Kill_01_addEH_getInOut;
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
		_x setVariable ["allVehicles", _vehicles];
	};

	private _vehiclesTemp = +_vehicles;
	if !(_ennemiesType isEqualTo "Looters") then
	{
		if (count (units _grp01) < 4) then
		{
			{
				if (selectRandom _nbGrpinVeh) then
				{
					_x setVariable ["useVehicle", true];

					_vehTemp = selectRandom _vehiclesTemp;
					_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _vehTemp);

					_x addVehicle _vehTemp;
					_x setVariable ["assignedVeh", _vehTemp];
				};

			} count _allGrps;
		}
		else
		{
			{
				if (selectRandom _nbGrpinVeh) then
				{
					_x setVariable ["useVehicle", true];

					_vehTemp = selectRandom _vehiclesTemp;
					_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _vehTemp);

					_x addVehicle _vehTemp;
					_x setVariable ["assignedVeh", _vehTemp];
				};

			} count _allGrpsTmps;
		};
	}
	else
	{
		{
			call
			{
				if ( (selectRandom _nbGrpinVeh) && { (_forEachIndex in [0,1]) && { (count (units _x) < 12) } } ) exitWith
				{
					_x setVariable ["useVehicle", true];

					_vehTemp = _vehicles # _forEachIndex;

					_x addVehicle _vehTemp;
					_x setVariable ["assignedVeh", _vehTemp];
				};

				if ( (selectRandom _nbGrpinVeh) && { (_forEachIndex in [2,3]) && { (count (units _x) < 3) } } ) then
				{
					_x setVariable ["useVehicle", true];

					_vehTemp = _vehicles # _forEachIndex;

					_x addVehicle _vehTemp;
					_x setVariable ["assignedVeh", _vehTemp];
				};
			};

		} forEach _allGrps;
	};

	// Placement
	call
	{
		if ((_canSitting) OR (_nbUnits < 12)) exitWith
		{
			if (_nbUnits isEqualTo 8) exitWith
			{
				private _nbCompo = selectRandom [1,2,3,4,5,6,7];
				switch ( _nbCompo ) do
				{
					case 1 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_1; 
					};

					case 2 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_2; 
					};

					case 3 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_3; 
					};

					case 4 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_4; 
					};

					case 5 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_5; 
					};

					case 6 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_6; 
					};

					case 7 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo8_7; 
					};
				};

			};

			if (_nbUnits isEqualTo 12) exitWith
			{
				switch ( selectRandom [1,2,3,4] ) do
				{
					case 1 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_1; 
					};

					case 2 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_2; 
					};

					case 3 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_3; 
					};

					case 4 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_4; 
					};
				};
			};

			if (_nbUnits isEqualTo 14) exitWith
			{
				switch ( selectRandom [1,2,3,4] ) do
				{
					case 1 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_1; 
					};

					case 2 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_2; 
					};

					case 3 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_3; 
					};

					case 4 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_4; 
					};
				};
			};

			if (_nbUnits isEqualTo 16) then
			{
				switch ( selectRandom [1,2,3,4] ) do
				{
					case 1 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_1; 
					};

					case 2 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_2; 
					};

					case 3 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_3; 
					};

					case 4 :
					{
						_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_4; 
					};
				};
			};
		};

		if (_nbUnits isEqualTo 12) exitWith
		{
			switch ( selectRandom [1,2,3,4] ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_5; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_6; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_7; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo12_8; 
				};
			};
		};

		if (_nbUnits isEqualTo 14) exitWith
		{
			switch ( selectRandom [1,2,3,4] ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_5; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_6; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_7; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo14_8; 
				};
			};
		};

		if (_nbUnits isEqualTo 16) then
		{
			switch ( selectRandom [1,2,3,4] ) do
			{
				case 1 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_5; 
				};

				case 2 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_6; 
				};

				case 3 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_7; 
				};

				case 4 :
				{
					_resultAiCompo = _allUnits call DK_MIS_Kill_01_compo16_8; 
				};
			};
		};
	};

	// Get AI to move
	_unitsToMove = _resultAiCompo # 0;

	uiSleep 0.1;	// Sleep for performance

///	END // Create & manage entities to pre-initialize mission


	// Added Stuff
	private _waitLO = [_allUnits, _uniform, _weapons, _vest] spawn DK_MIS_fnc_slctUnitsLO;

	// Find place
	private _startingPos = call DK_MIS_fnc_slctSafePlace_01;

	// Move units
	{
		detach _x;
		uiSleep 0.08;
		_x setVehiclePosition [_startingPos, [], 20, "NONE"];

	} count _unitsToMove;

	waitUntil { uiSleep 0.1; scriptDone _waitLO };

	deleteVehicle _logic;

	// Create Props decors and Move Vehicles & Props
	if !(_startingPos in DK_MIS_posStart_K01_custom) then
	{
		_orderProps = selectRandom DK_MIS_Kill_01_props_select;
	}
	else
	{
		_orderProps = 0;
	};

	switch (_orderProps) do
	{
		case 0 :
		{
			_props = [];
			_waitMoving = [_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_0;
		};

		case 1 :
		{
			_props = call DK_MIS_Kill_01_props_1;
			_waitMoving = [_props,_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_1;
		};

		case 2 :
		{
			_props = call DK_MIS_Kill_01_props_2;
			_waitMoving = [_props,_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_2;
		};

		case 3 :
		{
			_props = call DK_MIS_Kill_01_props_3;
			_waitMoving = [_props,_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_3;
		};

		case 4 :
		{
			_props = call DK_MIS_Kill_01_props_4;
			_waitMoving = [_props,_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_4;
		};

		case 5 :
		{
			_props = call DK_MIS_Kill_01_props_5;
			_waitMoving = [_props,_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_5;
		};

		case 6 :
		{
			_props = call DK_MIS_Kill_01_props_6;
			_waitMoving = [_props,_vehicles,_startingPos,_allUnits] spawn DK_MIS_Kill_01_moveVehProps_6;
		};

	};

	_nil = DK_MIS_Kill_01_props_select deleteAt (DK_MIS_Kill_01_props_select find _orderProps);

	if (DK_MIS_Kill_01_props_select isEqualTo []) then
	{
		DK_MIS_Kill_01_props_select = +DK_MIS_Kill_01_props_select_Init;
		_nil = DK_MIS_Kill_01_props_select deleteAt (DK_MIS_Kill_01_props_select find _orderProps);
	};


	// Create & Move Reward stuff crate
	_obstacles = [];
	_obstacles append _props;
	_obstacles append _allUnits;
	_obstacles append _vehicles;
	private _rwdrs = [_waitMoving, _startingPos, _rewardLvl, _obstacles] call DK_MIS_fnc_crtRwrdWthTabl;


	// Added varied Trigger for start AI units
	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["MIS_center", _startingPos];
		_x call DK_MIS_K01_unitsAddEH_trgAI;
		_x call DK_MIS_EH_handleAmmoNweapons;

		uiSleep 0.05;

		// DEBUG
		if (((getPosATL _x) # 0) < 1) then
		{
			_x setVehiclePosition [_startingPos, [], 20, "NONE"];
		};
	};

	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["allVehicles", _vehicles];
		_nil = _x call DK_MIS_K01_vehAddEH_trgAI;
		_x enableSimulationGlobal true;

		uiSleep 0.05;

	} count _vehicles;

	_nil = _vehicles spawn
	{
		uiSleep 3;

		{
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
	DK_MIS_allTargets = _allUnits;

	// Define variables related to the mission (Clients & Server)
	DK_nbTargets_Goal = _nbUnits;
	publicVariable "DK_nbTargets_Goal";

	DK_nbTargets_Cnt = 0;
	publicVariable "DK_nbTargets_Cnt";


	waitUntil { scriptDone _waitMoving };

///	// Tweaking before starting mission for mafioso
	_allUnits spawn
	{
		{
			detach _x;

		} count _this;

		uiSleep 10;

		private "_DKbehaviour";
		{
			_DKbehaviour = _x getVariable ["DK_behaviour", ""];

			if !(_DKbehaviour isEqualTo "walk") then
			{
				_x disableAI "ANIM";
			};

			call
			{
				if (_DKbehaviour isEqualTo "sit") exitWith
				{
					_x playMoveNow "AmovPsitMstpSnonWnonDnon_ground";
				};

				if (selectRandom [true,false]) exitWith
				{
					_x action ["WeaponOnBack", _x];
				};

				if !(_DKbehaviour isEqualTo "walk") then
				{
					_x playMoveNow "AmovPercMstpSnonWnonDnon";
				};
			};

			uiSleep 0.02;

		} count _this;

		uiSleep 1;

		{
			_x allowDamage true;

		} count _this;
	};

	// Detach props link to compo AI if exist
	private _propsLinkToAI = [];
	if (count _resultAiCompo > 1) then
	{
		_propsLinkToAI = _resultAiCompo # 1;

//		private "_pos";
		_propsLinkToAI apply
		{
			detach _x;
			uiSleep 0.08;
			_pos = getPosATL _x;
			_pos set [2,0];
			_x setPosATL _pos;
			_x setVectorUp surfaceNormal _pos;
		};
	};

	// Add EH to units for Hud player & Ending mission
	_allUnits apply
	{
		_x call DK_MIS_Kill_addEH_targetsDead;
		_x hideObjectGlobal false;
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


	[_allGrps, _allUnits, _vehicles, _props, _propsLinkToAI, _rwdrs]
};

DK_MIS_Kill_01_finished = {

	params ["_allGrps", "_allUnits", "_vehicles", "_props", "_propsLinkToAI", "_rwdrs"];

	private _allUnits = +_allUnits;
	private _vehicles = +_vehicles;
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

	// Add Rewards to Clean Up
	call
	{
		if (DK_MIS_playerRewardsMarkersList isEqualTo []) exitWith
		{
			_rwdrs + [nil, 0, 30] spawn DK_MIS_fnc_deleteReward;
		};

		(_rwdrs # 0) remoteExecCall ["DK_MIS_fnc_rewards3dIcone_cl", DK_MIS_playerRewardsMarkersList];
		_rwdrs spawn DK_MIS_fnc_deleteReward;
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


	// Add VEHICLES to Clean Up
	private "_nil";
	{
		if ( (!isNil "_x") && { (alive _x) } ) then
		{
			_x call DK_MIS_fnc_vehicle_removeAllEH;
			_x call DK_MIS_reInitVehNormal;
			_x call DK_MIS_fnc_initVehWhenEnd;
			_nil = [_x, DK_MIS_timeDelVeh, DK_MIS_disDelVeh, true] spawn DK_fnc_addVehTo_CUM;
			uiSleep 0.1;
		};

	} count _vehicles;

	// Add PROPS to Clean Up
	_props apply
	{
		if (!isNil "_x") then
		{
			[_x, DK_MIS_timeDelProps, DK_MIS_disDelProps, true] spawn DK_fnc_addAllTo_CUM;
		};
	};

	if !(_propsLinkToAI isEqualTo []) then
	{
		_propsLinkToAI apply
		{
			if (!isNil "_x") then
			{
				[_x, DK_MIS_timeDelProps, DK_MIS_disDelProps, true] spawn DK_fnc_addAllTo_CUM;
			};
		};
	};

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


// Varied Trigger for start AI
DK_MIS_K01_unitsAddEH_trgAI = {

	_this addEventHandler ["FiredNear",
	{
		_this append [DK_MIS_K01_triggerAI];
		_this call DK_MIS_fnc_EhFiredNear_trgAI;
	}];

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K01_triggerAI, nil, nil, _thisEventHandler];
		_this call DK_MIS_fnc_EhHit_trgAI;
	}];

	private _idEhKilled = _this addEventHandler ["Killed",
	{
		_this append [DK_MIS_K01_triggerAI];
		_this call DK_MIS_fnc_EhKilled_trgAI;
	}];

	_this setVariable ["idEhHitTrgAI", _idEhHit];
	_this setVariable ["idEhKilledTrgAI", _idEhKilled];
};

DK_MIS_K01_vehAddEH_trgAI = {

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K01_triggerAI];
		_this call DK_MIS_fnc_EhHitNear_trgAI_Veh;
	}];


	_this setVariable ["idEhHitTrgAI", _idEhHit];
};


// Trigger Script for start AI
DK_MIS_K01_triggerAI = {

	params ["_allUnits", ["_disMax", 250], ["_disMin", 40]];

	DK_MIS_var_PlayersAreNotSeen = false;

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


	// Move units if they have a linked Vehicle
	private ["_grp", "_nil"];
	{
		call
		{
			_grp = _x;

			if (units _grp findIf { alive _x } isEqualTo -1) exitWith {};

			_nil = _grp spawn DK_fnc_selectLoopVoice;

			if (_grp getVariable ["useVehicle", false]) exitWith
			{
				_nil = [_grp] call DK_MIS_Kill_01_AiInVeh_move_1;
				_grp setCombatMode "GREEN";
			};

			_grp setBehaviour DK_MIS_var_behaviour;
			_grp setCombatMode "RED";
			_nil = [_grp, _disMax, _disMin] spawn DK_MIS_fnc_stayCloseArea;
			_grp setSpeedMode DK_MIS_var_speedUnits;
		};

		uiSleep 0.3;

	} count _allGrps;

};


//// // Custome AI : Vehicles
DK_MIS_Kill_01_addEH_getInOut = {	// Handle Driver & Cargo vehicles

	_this call DK_MIS_addEH_selectSeat;

	_this addEventHandler ["GetInMan",
	{
		_this call DK_MIS_K01_EHGetIn;
	}];


	_this addEventHandler ["GetOutMan",
	{
		_this call DK_MIS_K01_EHGetOut;
	}];

};

DK_MIS_K01_EHGetIn = {

	params ["_unit", "", "_vehicle"];


	private _exit = false;

	if (typeName _vehicle isEqualTo "SCALAR") then
	{
		if (!isNull (objectParent _unit)) then
		{
			_vehicle = objectParent _unit;
		}
		else
		{
			_exit = true;
		};
	};

	if _exit exitWith {};

	private _grp = group _unit;
	private _unitsGrp = units _grp;
	if (_unitsGrp findIf { !(objectParent _x isEqualTo _vehicle) } isEqualTo -1) then
	{
		_grp setBehaviour "CARELESS";
		_grp setVariable ["AiInVeh_attackOnFoot", false];

		private _nil = _vehicle spawn DK_MIS_Kill_01_crtTrg_AiInVeh_react;
	};

	_grp addVehicle _vehicle;
	_unitsGrp orderGetIn true;
	_unitsGrp allowGetIn true;
	_grp setVariable ["assignedVeh", _vehicle];
};

DK_MIS_K01_EHGetOut = {

	params ["_unit", "", "_vehicle"];


	if (alive _unit) then
	{
		private _exit = false;

		if (typeName _vehicle isEqualTo "SCALAR") exitWith
		{
			if (!isNull (objectParent _unit)) then
			{
				_vehicle = objectParent _unit;
			}
			else
			{
				_exit = true;
			};
		};

		if _exit exitWith {};

		private _nil = _vehicle call DK_MIS_Kill_01_delTrg_AiInVeh_react;

		if ((!canMove _vehicle) OR !(DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1)) then
		{
			private _grp = group _unit;

			_grp call DK_fnc_delAllWp;

			_grp call DK_fnc_delAllWp;
			_grp setVariable ["AiInVeh_WpIsDeleted", true];
			_grp setVariable ["AiInVeh_attackOnFoot", true];
		};
	};
};

DK_MIS_Kill_01_AiInVeh_move_1 = {

	params ["_grp"];


	private _unitsGrp = units _grp;
	_unitsGrp orderGetIn true;
	_unitsGrp allowGetIn true;
	
	_grp setBehaviour "CARELESS";
	_grp setSpeedMode "FULL";

	[_grp, assignedVehicle (leader _grp), "	if (!isServer) exitWith {}; [(group this), (assignedVehicle this)] spawn DK_MIS_Kill_01_AiInVeh_move_2; ", "true", "GETIN", nil, "FULL","CARELESS"] call DK_fnc_AddWaypointState;
};

DK_MIS_Kill_01_AiInVeh_move_2 = {

	params ["_grp", "_vehicle", ["_limitSpd", true]];


	_grp setCombatMode "RED";
	_grp setSpeedMode (if !(isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"});
	_grp setVariable ["assignedVeh", _vehicle];

	if ( !(canMove _vehicle) OR !(DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1) ) exitWith
	{
		_grp setBehaviour (if !(isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"});
		_waypoint = [_grp, ((leader _grp) getVariable ["MIS_center", getPosATL (leader _grp)]), "SAD", "DIAMOND"] call DK_fnc_AddWaypoint;
	};

	private _unitsGrp = units _grp;

	// Limite speed vehicle if player has so far
	if _limitSpd then
	{
		[_grp, _unitsGrp] spawn DK_MIS_fnc_limitSpeedIfAlone;
	};

	// EH related to this loop
	_unitsGrp apply
	{
		_x call DK_MIS_Kill_01_addEH_AiInVEH_react;
		_x call DK_MIS_Kill_01_addEH_getInOut;
	};

	private ["_waypoint", "_time", "_posWp"];
	private _timeDEBUG = time;

	while { !(_unitsGrp findIf { alive _x } isEqualTo -1) } do
	{
		_unitsGrp = units _grp;
		_vehicle = _grp getVariable "assignedVeh";


	///	// Force new waypoint Move
		_grp call DK_fnc_delAllWp;

		_grp setVariable ["AiInVeh_WpIsDeleted", false];

		_posWp = [_unitsGrp, 1400] call DK_MIS_fnc_searchWpPos_veh;

		if (_unitsGrp findIf { alive _x } isEqualTo -1) exitWith {};

		_waypoint = [_grp, _posWp, "MOVE", "DIAMOND", if !(isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}] call DK_fnc_AddWaypoint;

		// Force to Move
		_unitsGrp doMove _posWp;

		waitUntil { uiSleep 1.5; (_grp isEqualTo grpNull) OR (_grp getVariable ["AiInVeh_WpIsDeleted", true]) OR (_unitsGrp isEqualTo []) OR (_unitsGrp findIf { alive _x } isEqualTo -1) OR (_posWp distance (leader _grp) < 120) };

		if ((_grp isEqualTo grpNull) OR (_unitsGrp isEqualTo [])) exitWith {};

///	AI LOOP	// Getout & Manage AI if units are attacked
		_unitsGrp = units _grp;
		if ( (_grp getVariable ["AiInVeh_attackOnFoot", false]) && { !(_unitsGrp findIf { alive _x } isEqualTo -1) } ) then
		{
			_vehicle call DK_MIS_Kill_01_delTrg_AiInVeh_react;

			_grp call DK_fnc_delAllWp;

			_driver = driver _vehicle;
			doStop _driver;
			_driver disableAI "MOVE";

			waitUntil { uiSleep 0.3; speed _vehicle < 5 };

			_driver enableAI "MOVE";

			if !(_unitsGrp findIf { alive _x } isEqualTo -1) then
			{
				_unitsGrp orderGetIn false;
				_unitsGrp allowGetIn false;
				_grp leaveVehicle _vehicle;
				_grp setBehaviour (if !(isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"});
				_unitsGrp apply
				{
					if (alive _x) then
					{
						unassignVehicle _x;
						moveOut _x;
					};

					uiSleep (random 0.3);
				};

				_waypoint = [_grp, leader _grp, "SAD", nil, if !(isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}, if !(isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"}] call DK_fnc_AddWaypoint;

				uiSleep (20 + (random 50));

				_grp call DK_fnc_delAllWp;

				_unitsGrp = units _grp;
				if !(_unitsGrp findIf { alive _x } isEqualTo -1) then
				{
					_vehicle = _grp getVariable "assignedVeh";
					_grp setVariable ["AiInVeh_WpIsDeleted", false];
//					_grp setBehaviour "CARELESS";
					_grp setBehaviour "AWARE";

					if ( (canMove _vehicle) && { (DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1) } ) then
					{
						_grp addVehicle _vehicle;
						_unitsGrp orderGetIn true;
						_unitsGrp allowGetIn true;

						_waypoint = [_grp, _vehicle, " if (!isServer) exitWith {}; (group this) setVariable ['AiInVeh_WpIsDeleted', true]; (group this) setVariable ['AiInVeh_attackOnFoot', false]; ", "true", "GETIN", nil, "FULL", "AWARE"] call DK_fnc_AddWaypointState;
					}
					else
					{ 
						_waypoint = [_grp, leader _grp, " if (!isServer) exitWith {}; (group this) setVariable ['AiInVeh_WpIsDeleted', true]; (group this) setVariable ['AiInVeh_attackOnFoot', false]; ", "true", "GETIN NEAREST", nil, "FULL", "AWARE"] call DK_fnc_AddWaypointState;
					};
	
					_time = time + 180;

					waitUntil { uiSleep 0.3; (_grp getVariable "AiInVeh_WpIsDeleted") OR (time > _time) OR (_unitsGrp findIf { alive _x } isEqualTo -1) };

					_unitsGrp = units _grp;
					if !(_unitsGrp findIf { alive _x } isEqualTo -1) then
					{
						_vehicle = _grp getVariable "assignedVeh";
						call
						{
							if ( !(canMove _vehicle) OR !(DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1) ) exitWith
							{
								_unitsGrp orderGetIn false;
								_unitsGrp allowGetIn false;
								_grp leaveVehicle _vehicle;
								{
									if (alive _x) then
									{
										unassignVehicle _x;
										moveOut _x;
									};

								} count _unitsGrp;
						
								_grp setBehaviour (if !(isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"});
							};

							if !(_unitsGrp findIf { !(_x in _vehicle) } isEqualTo -1) then
							{
								_grp setBehaviour DK_MIS_var_behaviour;
							};
						};
					};
				};
			};
		};
	};

	_vehicle = _grp getVariable "assignedVeh";
	if ( (!isNil "_vehicle") && { (alive _vehicle) } ) then
	{
		_vehicle call DK_MIS_fnc_initVehWhenEnd;
	};

};

DK_MIS_Kill_01_addEH_AiInVEH_react = {

	_this addEventHandler ["Hit",
	{
		params ["_unit", "_killer", "", "_instigator"];


		if ((isNull _instigator) OR (_instigator isEqualType "STRING")) then
		{
			_instigator = _killer;
		};

		if ( !(_instigator isEqualType "STRING") && { !(group _unit getVariable ["AiInVeh_attackOnFoot", false]) && { (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) } } ) then
		{
			private _vehicle = objectParent _unit;

			if !(isNull _vehicle) then
			{
				_unit removeEventHandler ["Hit", _thisEventHandler];
				[_unit,_instigator,_vehicle] spawn DK_MIS_Kill_01_AiInVeh_react;
			};
		};
	}];
};

DK_MIS_Kill_01_AiInVeh_react = {

	params ["_unit", "_shooter", "_vehicle"];


	private _time = time + 5;
	private _grp = group _unit;

	waitUntil
	{
		uiSleep 0.5;

		!(alive _unit) OR (time > _time) OR (_grp getVariable ["AiInVeh_attackOnFoot", false]) OR ( (speed _vehicle < 15) && {(speed _vehicle > -15)} ) OR (_shooter distance2D _unit > 80);   // 15 = 5 ; 600 = 60
	};


	if (alive _unit) then
	{
		_unit call DK_MIS_Kill_01_addEH_AiInVEH_react;

		if ( !(_grp getVariable ["AiInVeh_attackOnFoot", false]) && { (time <= _time) && { (speed _vehicle < 15) && { (speed _vehicle > -15) && { (_shooter distance2D _unit <= 80) } } } } ) then
		{
			_grp call DK_fnc_delAllWp;
			_grp setVariable ["AiInVeh_WpIsDeleted", true];
			_grp setVariable ["AiInVeh_attackOnFoot", true];
		};
	};

};

DK_MIS_Kill_01_crtTrg_AiInVeh_react = {

	if !(isNil {_this getVariable "trgAiInVehReact"} ) exitWith {};

	uiSleep (15 + (random 20));

	private _trg = createTrigger ["EmptyDetector", [0,0,0], false];
	_trg setTriggerArea [26, 26, 0, false, 10];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [" this ",
	"
		thisTrigger call DK_MIS_fnc_actTrg_AiInVeh_react;
	",
	"
	"];
	_trg setTriggerTimeout [2, 4, 5, true];
	_trg attachTo [_this, [0,0,0]];

	private _EhId = _this addEventHandler ["Deleted",
	{
		params ["_veh"];

		_trg = _veh getVariable "trgAiInVehReact";

		if (!isNil "_trg") then
		{
			deleteVehicle _trg;
		};
	}];

	_this setVariable ["trgAiInVehReact", _trg];
	_this setVariable ["EhDelAiInVehReact", _EhId];
};

DK_MIS_fnc_actTrg_AiInVeh_react = {

	private _vehicle = attachedTo _this;
	private _vehCrew = crew _vehicle;
	_vehicle call DK_MIS_Kill_01_delTrg_AiInVeh_react;

	if !(_vehCrew findIf {alive _x} isEqualTo -1) then
	{
		private _grp = group (_vehCrew select (_vehCrew findIf {alive _x}));

		_grp call DK_fnc_delAllWp;
		_grp setVariable ["AiInVeh_WpIsDeleted", true];
		_grp setVariable ["AiInVeh_attackOnFoot", true];
	};
};

DK_MIS_Kill_01_delTrg_AiInVeh_react = {

	private _trg = _this getVariable "trgAiInVehReact";
	if !(isNil "_trg") then
	{
		deleteVehicle _trg;
		_this setVariable ["trgAiInVehReact", nil];
	};

	private _EhId = _this getVariable "EhDelAiInVehReact";
	if !(isNil "_EhId") then
	{
		_this removeEventHandler ["Deleted", _EhId];
	};
};

/// // Units compositon : 8 units
DK_MIS_Kill_01_compo8_1 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
	[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;


	[[_tg_kill01,_tg_kill04,_tg_kill07]]
};

DK_MIS_Kill_01_compo8_2 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
	[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;


	[[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07]]
};

DK_MIS_Kill_01_compo8_3 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
	[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;


	[[_tg_kill01,_tg_kill03,_tg_kill05]]
};

DK_MIS_Kill_01_compo8_4 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;


	[[_tg_kill01,_tg_kill05]]
};

// Sitting & with Object linked to AI 
DK_MIS_Kill_01_compo8_5 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	private ["_objectMiddleAI","_classObjectMiddleAI"];

	_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;

			_objectMiddleAI = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI attachTo [_tg_kill07, [0,1.3,1]];

			[_tg_kill07,_tg_kill08] call DK_fnc_2_sitting;

			_tg_kill07 setVariable ["DK_behaviour", "sit"];
			_tg_kill08 setVariable ["DK_behaviour", "sit"];
		};

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill04,_tg_kill03] call DK_fnc_2_chatting;

		_objectMiddleAI = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
		_objectMiddleAI attachTo [_tg_kill07, [0,1.3,1]];

		[_tg_kill07,_tg_kill05,_tg_kill06,_tg_kill08,_objectMiddleAI] call DK_fnc_4_sitting;


		_tg_kill05 setVariable ["DK_behaviour", "sit"];
		_tg_kill06 setVariable ["DK_behaviour", "sit"];
		_tg_kill07 setVariable ["DK_behaviour", "sit"];
		_tg_kill08 setVariable ["DK_behaviour", "sit"];
	};


	[[_tg_kill01,_tg_kill04,_tg_kill07],[_objectMiddleAI]]
};

DK_MIS_Kill_01_compo8_6 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill03, [0,1.2,1]];

			[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08,_objectMiddleAI_a] call DK_fnc_6_sitting;

			_tg_kill03 setVariable ["DK_behaviour", "sit"];
			_tg_kill04 setVariable ["DK_behaviour", "sit"];
			_tg_kill05 setVariable ["DK_behaviour", "sit"];
			_tg_kill06 setVariable ["DK_behaviour", "sit"];
			_tg_kill07 setVariable ["DK_behaviour", "sit"];
			_tg_kill08 setVariable ["DK_behaviour", "sit"];

			_return = [[_tg_kill01,_tg_kill03],[_objectMiddleAI_a]];
		};

		_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
		_objectMiddleAI_a attachTo [_tg_kill01, [0,1.2,1]];

		[_tg_kill01,_tg_kill02,_tg_kill04,_tg_kill05,_objectMiddleAI_a] call DK_fnc_4_sitting;

		_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
		_objectMiddleAI_b attachTo [_tg_kill03, [0,1.2,1]];

		[_tg_kill03,_tg_kill06,_tg_kill07,_tg_kill08,_objectMiddleAI_b] call DK_fnc_4_sitting;

		_tg_kill01 setVariable ["DK_behaviour", "sit"];
		_tg_kill02 setVariable ["DK_behaviour", "sit"];
		_tg_kill03 setVariable ["DK_behaviour", "sit"];
		_tg_kill04 setVariable ["DK_behaviour", "sit"];
		_tg_kill05 setVariable ["DK_behaviour", "sit"];
		_tg_kill06 setVariable ["DK_behaviour", "sit"];
		_tg_kill07 setVariable ["DK_behaviour", "sit"];
		_tg_kill08 setVariable ["DK_behaviour", "sit"];

		_return = [[_tg_kill01,_tg_kill03],[_objectMiddleAI_a,_objectMiddleAI_b]];
	};


	_return
};

DK_MIS_Kill_01_compo8_7 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill01, [0,1.2,1]];

			[_tg_kill01,_tg_kill02] call DK_fnc_2_sitting;

			_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_b attachTo [_tg_kill03, [0,1.2,1]];

			[_tg_kill03,_tg_kill04,_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08,_objectMiddleAI_b] call DK_fnc_6_sitting;

			_tg_kill01 setVariable ["DK_behaviour", "sit"];
			_tg_kill02 setVariable ["DK_behaviour", "sit"];
			_tg_kill03 setVariable ["DK_behaviour", "sit"];
			_tg_kill04 setVariable ["DK_behaviour", "sit"];
			_tg_kill05 setVariable ["DK_behaviour", "sit"];
			_tg_kill06 setVariable ["DK_behaviour", "sit"];
			_tg_kill07 setVariable ["DK_behaviour", "sit"];
			_tg_kill08 setVariable ["DK_behaviour", "sit"];

			_return = [[_tg_kill01,_tg_kill03],[_objectMiddleAI_a,_objectMiddleAI_b]];
		};

		_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
		_objectMiddleAI_a attachTo [_tg_kill01, [0,1.2,1]];

		[_tg_kill01,_tg_kill02] call DK_fnc_2_sitting;

		_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
		_objectMiddleAI_b attachTo [_tg_kill03, [0,1.2,1]];

		[_tg_kill03,_tg_kill04] call DK_fnc_2_sitting;

		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

		_tg_kill01 setVariable ["DK_behaviour", "sit"];
		_tg_kill02 setVariable ["DK_behaviour", "sit"];
		_tg_kill03 setVariable ["DK_behaviour", "sit"];
		_tg_kill04 setVariable ["DK_behaviour", "sit"];
	
		_return = [[_tg_kill01,_tg_kill03,_tg_kill05],[_objectMiddleAI_a,_objectMiddleAI_b]];
	};
	
	_return
};


/// // Units compositon : 12 units
DK_MIS_Kill_01_compo12_1 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill12]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;

		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

				[_tg_kill09,_tg_kill10,_objectMiddleAI_a] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

				[_tg_kill11,_tg_kill12,_objectMiddleAI_b] call DK_fnc_2_sitting;

				_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill11],[_objectMiddleAI_a,_objectMiddleAI_b]];
			};

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

			[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12,_objectMiddleAI_a] call DK_fnc_4_sitting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09],[_objectMiddleAI_a]];
		};

		_tg_kill09 setVariable ["DK_behaviour", "sit"];
		_tg_kill10 setVariable ["DK_behaviour", "sit"];
		_tg_kill11 setVariable ["DK_behaviour", "sit"];
		_tg_kill12 setVariable ["DK_behaviour", "sit"];		
	};


	_return
};

DK_MIS_Kill_01_compo12_2 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;

		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

				[_tg_kill09,_tg_kill10,_objectMiddleAI_a] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

				[_tg_kill11,_tg_kill12,_objectMiddleAI_b] call DK_fnc_2_sitting;

				_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11],[_objectMiddleAI_a,_objectMiddleAI_b]];
			};

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

			[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12,_objectMiddleAI_a] call DK_fnc_4_sitting;


			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09],[_objectMiddleAI_a]];
		};

		_tg_kill09 setVariable ["DK_behaviour", "sit"];
		_tg_kill10 setVariable ["DK_behaviour", "sit"];
		_tg_kill11 setVariable ["DK_behaviour", "sit"];
		_tg_kill12 setVariable ["DK_behaviour", "sit"];		
	};


	_return
};

DK_MIS_Kill_01_compo12_3 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11]];
		};


		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

		[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;


		call
		{
			if (selectRandom [true,false]) exitWith
			{
				[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

				_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11]];
			};

			_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill11, [0,1.2,1]];

			[_tg_kill11,_tg_kill12,_objectMiddleAI_a] call DK_fnc_2_sitting;
			_tg_kill11 setVariable ["DK_behaviour", "sit"];
			_tg_kill12 setVariable ["DK_behaviour", "sit"];

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11],[_objectMiddleAI_a]];
		};

	};


	_return
};

DK_MIS_Kill_01_compo12_4 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;


	[[_tg_kill01,_tg_kill05,_tg_kill09]]

};

// Walking round (possible round guard, nobody sitting)
DK_MIS_Kill_01_compo12_5 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
			[_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_3_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill10]];
		};


		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
		[_tg_kill10,_tg_kill11] call DK_fnc_2_chatting;

		[_tg_kill12]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill10,_tg_kill12]];
	};


	_return
};

DK_MIS_Kill_01_compo12_6 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill11]];
		};


		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;

		[_tg_kill11]  call DK_MIS_K01_roundGuard;
		[_tg_kill12]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill11,_tg_kill12]];
	};


	_return
};

DK_MIS_Kill_01_compo12_7 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
			[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;

			_return = [[_tg_kill01,_tg_kill05,_tg_kill09]];
		};

		[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
		[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;

		[_tg_kill11]  call DK_MIS_K01_roundGuard;
		[_tg_kill12]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill12]];
	};


	_return
};

DK_MIS_Kill_01_compo12_8 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11]];
		};

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;

		[_tg_kill10]  call DK_MIS_K01_roundGuard;
		[_tg_kill11]  call DK_MIS_K01_roundGuard;
		[_tg_kill12]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill10,_tg_kill11,_tg_kill12]];
	};


	_return
};


/// // Units compositon : 14 units
DK_MIS_Kill_01_compo14_1 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11] call DK_fnc_3_chatting;
			[_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_3_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill12]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;

		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

				[_tg_kill09,_tg_kill10] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

				[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14,_objectMiddleAI_b] call DK_fnc_4_sitting;
			};

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

			[_tg_kill09,_tg_kill10,_tg_kill13,_tg_kill12,_objectMiddleAI_a] call DK_fnc_4_sitting;

			_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

			[_tg_kill11,_tg_kill14,_objectMiddleAI_b] call DK_fnc_2_sitting;
		};

		_tg_kill09 setVariable ["DK_behaviour", "sit"];
		_tg_kill10 setVariable ["DK_behaviour", "sit"];
		_tg_kill11 setVariable ["DK_behaviour", "sit"];
		_tg_kill12 setVariable ["DK_behaviour", "sit"];		
		_tg_kill13 setVariable ["DK_behaviour", "sit"];
		_tg_kill14 setVariable ["DK_behaviour", "sit"];

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill11],[_objectMiddleAI_a,_objectMiddleAI_b]];
	};


	_return
};

DK_MIS_Kill_01_compo14_2 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;
			[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11,_tg_kill13]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;

		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

				[_tg_kill09,_tg_kill10] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

				[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14,_objectMiddleAI_b] call DK_fnc_4_sitting;
			};

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

			[_tg_kill09,_tg_kill10,_tg_kill13,_tg_kill12,_objectMiddleAI_a] call DK_fnc_4_sitting;

			_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

			[_tg_kill11,_tg_kill14,_objectMiddleAI_b] call DK_fnc_2_sitting;
		};

		_tg_kill09 setVariable ["DK_behaviour", "sit"];
		_tg_kill10 setVariable ["DK_behaviour", "sit"];
		_tg_kill11 setVariable ["DK_behaviour", "sit"];
		_tg_kill12 setVariable ["DK_behaviour", "sit"];		
		_tg_kill13 setVariable ["DK_behaviour", "sit"];
		_tg_kill14 setVariable ["DK_behaviour", "sit"];

		_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11],[_objectMiddleAI_a,_objectMiddleAI_b]];
	};




	_return
};

DK_MIS_Kill_01_compo14_3 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

			[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill13]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

		[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
		[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill13, [0,1.2,1]];

				[_tg_kill13,_tg_kill14] call DK_fnc_2_sitting;


				_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill13],[_objectMiddleAI_a]];
			};


			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill13, [0,1.2,1]];

			[_tg_kill13,_tg_kill14,_objectMiddleAI_a] call DK_fnc_2_sitting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill13],[_objectMiddleAI_a]];
		};


		_tg_kill13 setVariable ["DK_behaviour", "sit"];
		_tg_kill14 setVariable ["DK_behaviour", "sit"];
	};




	_return
};

DK_MIS_Kill_01_compo14_4 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;
	[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;


	[[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill13]]

};

// Walking round (possible round guard, nobody sitting)
DK_MIS_Kill_01_compo14_5 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11] call DK_fnc_3_chatting;
			[_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_3_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill12]];
		};


		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
		[_tg_kill10,_tg_kill11] call DK_fnc_2_chatting;
		[_tg_kill12,_tg_kill13] call DK_fnc_2_chatting;

		[_tg_kill14]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill10,_tg_kill12,_tg_kill14]];
	};


	_return
};

DK_MIS_Kill_01_compo14_6 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
			[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill11]];
		};


		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
		[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

		[_tg_kill13]  call DK_MIS_K01_roundGuard;
		[_tg_kill14]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill11,_tg_kill13,_tg_kill14]];
	};


	_return
};

DK_MIS_Kill_01_compo14_7 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
			[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;
			[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill13]];
		};

		[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
		[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;

		[_tg_kill13]  call DK_MIS_K01_roundGuard;
		[_tg_kill14]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill13,_tg_kill14]];
	};


	_return
};

DK_MIS_Kill_01_compo14_8 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;
			[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11,_tg_kill13]];
		};

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
		[_tg_kill09,_tg_kill10,_tg_kill11] call DK_fnc_3_chatting;

		[_tg_kill12]  call DK_MIS_K01_roundGuard;
		[_tg_kill13]  call DK_MIS_K01_roundGuard;
		[_tg_kill14]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill12,_tg_kill13,_tg_kill14]];
	};


	_return
};

/// // Units compositon : 16 units
DK_MIS_Kill_01_compo16_1 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11] call DK_fnc_3_chatting;
			[_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_3_chatting;
			[_tg_kill15,_tg_kill16] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill12,_tg_kill15]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;

		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

				[_tg_kill09,_tg_kill10] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

				[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16,_objectMiddleAI_b] call DK_fnc_6_sitting;
			};

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

			[_tg_kill09,_tg_kill10,_tg_kill13,_tg_kill12,_objectMiddleAI_a] call DK_fnc_4_sitting;

			_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

			[_tg_kill11,_tg_kill14,_tg_kill15,_tg_kill16,_objectMiddleAI_b] call DK_fnc_4_sitting;
		};

		_tg_kill09 setVariable ["DK_behaviour", "sit"];
		_tg_kill10 setVariable ["DK_behaviour", "sit"];
		_tg_kill11 setVariable ["DK_behaviour", "sit"];
		_tg_kill12 setVariable ["DK_behaviour", "sit"];		
		_tg_kill13 setVariable ["DK_behaviour", "sit"];
		_tg_kill14 setVariable ["DK_behaviour", "sit"];
		_tg_kill15 setVariable ["DK_behaviour", "sit"];
		_tg_kill16 setVariable ["DK_behaviour", "sit"];	

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill11],[_objectMiddleAI_a,_objectMiddleAI_b]];
	};


	_return
};

DK_MIS_Kill_01_compo16_2 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;
			[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;
			[_tg_kill15,_tg_kill16] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11,_tg_kill13,_tg_kill15]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;

		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

				[_tg_kill09,_tg_kill10] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

				[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16,_objectMiddleAI_b] call DK_fnc_6_sitting;
			};

			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill09, [0,1.2,1]];

			[_tg_kill09,_tg_kill10,_tg_kill13,_tg_kill12,_objectMiddleAI_a] call DK_fnc_4_sitting;

			_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_b attachTo [_tg_kill11, [0,1.2,1]];

			[_tg_kill11,_tg_kill14,_tg_kill15,_tg_kill16,_objectMiddleAI_b] call DK_fnc_4_sitting;
		};

		_tg_kill09 setVariable ["DK_behaviour", "sit"];
		_tg_kill10 setVariable ["DK_behaviour", "sit"];
		_tg_kill11 setVariable ["DK_behaviour", "sit"];
		_tg_kill12 setVariable ["DK_behaviour", "sit"];		
		_tg_kill13 setVariable ["DK_behaviour", "sit"];
		_tg_kill14 setVariable ["DK_behaviour", "sit"];
		_tg_kill15 setVariable ["DK_behaviour", "sit"];
		_tg_kill16 setVariable ["DK_behaviour", "sit"];	

		_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11],[_objectMiddleAI_a,_objectMiddleAI_b]];
	};




	_return
};

DK_MIS_Kill_01_compo16_3 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private ["_objectMiddleAI_a","_objectMiddleAI_b","_classObjectMiddleAI","_return"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;

			[_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16] call DK_fnc_4_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill13]];
		};

		_classObjectMiddleAI = call DK_MIS_slctObjLinkToAI;

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;

		[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
		[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;


		call
		{
			if (selectRandom [true,false]) exitWith
			{
				_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_a attachTo [_tg_kill13, [0,1.2,1]];

				[_tg_kill13,_tg_kill14] call DK_fnc_2_sitting;

				_objectMiddleAI_b = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
				_objectMiddleAI_b attachTo [_tg_kill15, [0,1.2,1]];

				[_tg_kill15,_tg_kill16] call DK_fnc_2_sitting;

				_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill13,_tg_kill15],[_objectMiddleAI_a,_objectMiddleAI_b]];
			};


			_objectMiddleAI_a = createVehicle [_classObjectMiddleAI, [0,0,10], [], 0, "CAN_COLLIDE"];
			_objectMiddleAI_a attachTo [_tg_kill13, [0,1.2,1]];

			[_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16,_objectMiddleAI_a] call DK_fnc_4_sitting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill09,_tg_kill11,_tg_kill13],[_objectMiddleAI_a]];
		};


		_tg_kill13 setVariable ["DK_behaviour", "sit"];
		_tg_kill14 setVariable ["DK_behaviour", "sit"];
		_tg_kill15 setVariable ["DK_behaviour", "sit"];
		_tg_kill16 setVariable ["DK_behaviour", "sit"];	
	};




	_return
};

DK_MIS_Kill_01_compo16_4 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
	[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
	[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;
	[_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16] call DK_fnc_4_chatting;


	[[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill13]]

};

// Walking round (possible round guard, nobody sitting)
DK_MIS_Kill_01_compo16_5 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11] call DK_fnc_3_chatting;
			[_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_3_chatting;
			[_tg_kill15,_tg_kill16] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill09,_tg_kill12,_tg_kill15]];
		};


		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
		[_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_3_chatting;
		[_tg_kill13,_tg_kill14,_tg_kill15] call DK_fnc_3_chatting;

		[_tg_kill16]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill10,_tg_kill13,_tg_kill16]];
	};


	_return
};

DK_MIS_Kill_01_compo16_6 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
			[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
			[_tg_kill07,_tg_kill08,_tg_kill09] call DK_fnc_3_chatting;
			[_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_3_chatting;
			[_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16] call DK_fnc_4_chatting;

			_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill10,_tg_kill13]];
		};


		[_tg_kill01,_tg_kill02,_tg_kill03] call DK_fnc_3_chatting;
		[_tg_kill04,_tg_kill05,_tg_kill06] call DK_fnc_3_chatting;
		[_tg_kill07,_tg_kill08,_tg_kill09,_tg_kill10] call DK_fnc_4_chatting;
		[_tg_kill11,_tg_kill12,_tg_kill13,_tg_kill14] call DK_fnc_4_chatting;

		[_tg_kill15]  call DK_MIS_K01_roundGuard;
		[_tg_kill16]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill04,_tg_kill07,_tg_kill11,_tg_kill15,_tg_kill16]];
	};


	_return
};

DK_MIS_Kill_01_compo16_7 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
			[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
			[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;
			[_tg_kill13,_tg_kill14,_tg_kill15,_tg_kill16] call DK_fnc_4_chatting;

			_return = [[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill13]];
		};

		[_tg_kill01,_tg_kill02,_tg_kill03,_tg_kill04] call DK_fnc_4_chatting;
		[_tg_kill05,_tg_kill06,_tg_kill07,_tg_kill08] call DK_fnc_4_chatting;
		[_tg_kill09,_tg_kill10,_tg_kill11,_tg_kill12] call DK_fnc_4_chatting;
		[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;

		[_tg_kill15]  call DK_MIS_K01_roundGuard;
		[_tg_kill16]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill05,_tg_kill09,_tg_kill13,_tg_kill15,_tg_kill16]];
	};


	_return
};

DK_MIS_Kill_01_compo16_8 = {

	params ["_tg_kill01","_tg_kill02","_tg_kill03","_tg_kill04","_tg_kill05","_tg_kill06","_tg_kill07","_tg_kill08","_tg_kill09","_tg_kill10","_tg_kill11","_tg_kill12","_tg_kill13","_tg_kill14","_tg_kill15","_tg_kill16"];


	private "_return";

	call
	{
		if (selectRandom [true,false,false]) exitWith
		{
			[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
			[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
			[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
			[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
			[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
			[_tg_kill11,_tg_kill12] call DK_fnc_2_chatting;
			[_tg_kill13,_tg_kill14] call DK_fnc_2_chatting;
			[_tg_kill15,_tg_kill16] call DK_fnc_2_chatting;

			_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11,_tg_kill13,_tg_kill15]];
		};

		[_tg_kill01,_tg_kill02] call DK_fnc_2_chatting;
		[_tg_kill03,_tg_kill04] call DK_fnc_2_chatting;
		[_tg_kill05,_tg_kill06] call DK_fnc_2_chatting;
		[_tg_kill07,_tg_kill08] call DK_fnc_2_chatting;
		[_tg_kill09,_tg_kill10] call DK_fnc_2_chatting;
		[_tg_kill11,_tg_kill12,_tg_kill13] call DK_fnc_3_chatting;

		[_tg_kill14]  call DK_MIS_K01_roundGuard;
		[_tg_kill15]  call DK_MIS_K01_roundGuard;
		[_tg_kill16]  call DK_MIS_K01_roundGuard;

		_return = [[_tg_kill01,_tg_kill03,_tg_kill05,_tg_kill07,_tg_kill09,_tg_kill11,_tg_kill14,_tg_kill15,_tg_kill16]];
	};


	_return
};


/// Props & Vehicle compositon
DK_MIS_Kill_01_props_1 = {		// Wreck car

	private ["_barrel01","_barrel02","_barrel03","_barrel04"];


	private _wreckList = wreckList_1 call KK_fnc_arrayShuffle;

	_wreck01 = createSimpleObject [_wreckList # 0, [0,0,0]];
	_wreck02 = createSimpleObject [_wreckList # 1, [0,0,0]];
	_wreck03 = createSimpleObject [_wreckList # 2, [0,0,0]];
	_wreck04 = createSimpleObject [_wreckList # 3, [0,0,0]];
	_wreck05 = createSimpleObject [_wreckList # 4, [0,0,0]];
	_wreck06 = createSimpleObject [_wreckList # 5, [0,0,0]];
	_wreck07 = createSimpleObject [_wreckList # 6, [0,0,0]];
	_wreck08 = createSimpleObject [_wreckList # 7, [0,0,0]];

	uiSleep 0.3;	// Sleep for performance

	_wreck09 = createSimpleObject [_wreckList # 8, [0,0,0]];
	_wreck10 = createSimpleObject [_wreckList # 9, [0,0,0]];
	_wreck11 = createSimpleObject [selectRandom _wreckList, [0,0,0]];
	_wreck12 = createSimpleObject [selectRandom _wreckList, [0,0,0]];

	if !(call DK_fnc_checkIfNight) then
	{
		_barrel01 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel02 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel03 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel04 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
	}
	else
	{
		_barrel01 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel02 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel03 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel04 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	};

	_junk01 = createVehicle ["Land_GarbageWashingMachine_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_junk02 = createVehicle ["Land_GarbagePallet_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_junk03 = createVehicle ["Land_GarbageBags_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_junk04 = createVehicle ["Land_JunkPile_F", [0,0,0], [], 0, "CAN_COLLIDE"];

	[_junk01,_junk02,_junk03,_junk04] apply
	{
		_x enableSimulationGlobal false;
	};

	[_wreck01,_wreck02,_wreck03,_wreck04,_wreck05,_wreck06,_wreck07,_wreck08,_wreck09,_wreck10,_wreck11,_wreck12,_barrel01,_barrel02,_barrel03,_barrel04,_junk01,_junk02,_junk03,_junk04] apply
	{
		_x setDir (random 360);
	};


	[_wreck01,_wreck02,_wreck03,_wreck04,_wreck05,_wreck06,_wreck07,_wreck08,_wreck09,_wreck10,_wreck11,_wreck12,_barrel01,_barrel02,_barrel03,_barrel04,_junk01,_junk02,_junk03,_junk04]
};

DK_MIS_Kill_01_props_2 = {		// Wreck military

	private ["_barrel01","_barrel02"];


	private _wreckList = wreckList_2 call KK_fnc_arrayShuffle;

	_wreck01 = createSimpleObject [_wreckList # 0, [0,0,0]];
	_wreck02 = createSimpleObject [_wreckList # 1, [0,0,0]];
	_wreck03 = createSimpleObject [_wreckList # 2, [0,0,0]];
	_wreck04 = createSimpleObject [_wreckList # 3, [0,0,0]];
	_wreck05 = createSimpleObject [_wreckList # 4, [0,0,0]];
	_wreck06 = createSimpleObject [_wreckList # 5, [0,0,0]];
	_wreck07 = createSimpleObject [_wreckList # 6, [0,0,0]];
	_wreck08 = createSimpleObject [_wreckList # 7, [0,0,0]];
	_wreck09 = createSimpleObject [selectRandom _wreckList, [0,0,0]];

	private _dirProps = 0;
	{
		_x setDir (_dirProps + (selectRandom [90,-90]));

		_dirProps = _dirProps + 45;

	} count [_wreck01,_wreck02,_wreck03,_wreck04,_wreck05,_wreck06,_wreck07,_wreck08,_wreck09];

	if !(call DK_fnc_checkIfNight) then
	{
		_barrel01 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel02 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
	}
	else
	{
		_barrel01 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel02 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	};


//	[_wreck01,_wreck02,_wreck03,_wreck04,_wreck05,_wreck06,_wreck07,_wreck08,_wreck09,_barrel01,_barrel02] apply
	[_barrel01,_barrel02] apply
	{
		_x setDir (random 360);
	};


	[_wreck01,_wreck02,_wreck03,_wreck04,_wreck05,_wreck06,_wreck07,_wreck08,_wreck09,_barrel01,_barrel02]
};

DK_MIS_Kill_01_props_3 = {		// Farms

	private _farmType = selectRandom farmList;

	_farm01 = createVehicle [_farmType, [0,0,0], [], 0, "CAN_COLLIDE"];
	_farm02 = createVehicle [selectRandom [_farmType, farmDestroy], [0,0,0], [], 0, "CAN_COLLIDE"];

	_tractor = createVehicle ["Land_CombineHarvester_01_wreck_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_tractor setDir (random 360);

	_waterBench = createSimpleObject ["Land_StallWater_F", [0,0,0]];
	_waterTank = createVehicle [selectRandom towerFarm, [0,0,0], [], 0, "CAN_COLLIDE"];

	[_tractor,_waterBench] apply
	{
		_x setDir (random 360);
	};


	[_farm01, _farm02, _tractor, _waterBench, _waterTank]

};

DK_MIS_Kill_01_props_4 = {		// Construction Site

	_construcProps = construcProps call KK_fnc_arrayShuffle;

	_construcSite01 = createVehicle [selectRandom construcSite, [0,0,0], [], 0, "CAN_COLLIDE"];

	_construcProps01 = createVehicle [_construcProps # 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_construcProps02 = createVehicle [_construcProps # 1, [0,0,0], [], 0, "CAN_COLLIDE"];
	_construcProps03 = createVehicle [_construcProps # 2, [0,0,0], [], 0, "CAN_COLLIDE"];
	_construcProps04 = createVehicle [_construcProps # 3, [0,0,0], [], 0, "CAN_COLLIDE"];
	_construcProps05 = createVehicle [_construcProps # 4, [0,0,0], [], 0, "CAN_COLLIDE"];
	_construcProps06 = createVehicle [_construcProps # 5, [0,0,0], [], 0, "CAN_COLLIDE"];
	_construcProps07 = createVehicle [_construcProps # 6, [0,0,0], [], 0, "CAN_COLLIDE"];

	_bulldozer = createVehicle [selectRandom bulldozer, [0,0,0], [], 0, "CAN_COLLIDE"];


	[_construcProps01,_construcProps02,_construcProps03,_construcProps04,_construcProps05,_construcProps06,_construcProps07,_bulldozer] apply
	{
		_x setDir (random 360);
		_x hideObject true;
	};


	[_construcSite01,_construcProps01,_construcProps02,_construcProps03,_construcProps04,_construcProps05,_construcProps06,_construcProps07,_bulldozer]
};

DK_MIS_Kill_01_props_5 = {		// Construction Dirt

//	_dirtsHump = dirtHump call KK_fnc_arrayShuffle;

	private ["_dirtHump01", "_dirtHump02", "_dirtHump03", "_dirtHump04", "_result"];


	_bulldozer01 = createVehicle [bulldozer # 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_bulldozer02 = createVehicle [bulldozer # 1, [0,0,0], [], 0, "CAN_COLLIDE"];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			_dirtHump01 = createVehicle [dirtHump # 0, [0,0,0], [], 0, "CAN_COLLIDE"];
			_dirtHump02 = createVehicle [dirtHump # 1, [0,0,0], [], 0, "CAN_COLLIDE"];
			_dirtHump03 = createVehicle [dirtHump # 2, [0,0,0], [], 0, "CAN_COLLIDE"];


			[_dirtHump01,_dirtHump02,_dirtHump03,_bulldozer01,_bulldozer02] apply
			{
				_x setDir (random 360);
			};

			_result = [_dirtHump01,_dirtHump02,_dirtHump03,_bulldozer01,_bulldozer02];
		};

		_dirtHump01 = createVehicle [dirtHump # 0, [0,0,0], [], 0, "CAN_COLLIDE"];
		_dirtHump02 = createVehicle [dirtHump # 1, [0,0,0], [], 0, "CAN_COLLIDE"];
		_dirtHump03 = createVehicle [dirtHump # 2, [0,0,0], [], 0, "CAN_COLLIDE"];
		_dirtHump04 = createVehicle [dirtHump # 0, [0,0,0], [], 0, "CAN_COLLIDE"];

		_bulldozer01 attachTo [ _dirtHump04, [0.5,-0.25,2.6] ];
		_bulldozer01 setDir 90;

		[_dirtHump01,_dirtHump02,_dirtHump03,_dirtHump04,_bulldozer02] apply
		{
			_x setDir (random 360);
		};

		_result = [_dirtHump01,_dirtHump02,_dirtHump03,_dirtHump04,_bulldozer02,_bulldozer01];
	};


	_result
};

DK_MIS_Kill_01_props_6 = {		// Slum houses

	private ["_barrel01","_barrel02","_barrel03","_barrel04"];


	_slum01 = createVehicle [slumList_1 # 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum02 = createVehicle [slumList_1 # 1, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum03 = createVehicle [slumList_1 # 2, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum04 = createVehicle [slumList_1 # 3, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum05 = createVehicle [slumList_1 # 4, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum06 = createVehicle [slumList_1 # 5, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum07 = createVehicle [slumList_1 # 6, [0,0,0], [], 0, "CAN_COLLIDE"];
	_slum08 = createVehicle [selectRandom slumList_1, [0,0,0], [], 0, "CAN_COLLIDE"];


	uiSleep 0.1;	// Sleep for performance

	if !(call DK_fnc_checkIfNight) then
	{
		_barrel01 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel02 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel03 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel04 = createVehicle [selectRandom barrelList_D, [0,0,0], [], 0, "CAN_COLLIDE"];
	}
	else
	{
		_barrel01 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel02 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel03 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_barrel04 = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	};

	_junk01 = createVehicle ["Land_GarbageWashingMachine_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_junk02 = createVehicle ["Land_GarbagePallet_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_junk03 = createVehicle ["Land_GarbageBags_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_junk04 = createVehicle ["Land_JunkPile_F", [0,0,0], [], 0, "CAN_COLLIDE"];

	[_junk01,_junk02,_junk03,_junk04] apply
	{
		_x setDir (random 360);
		_x enableSimulationGlobal false;
	};

	_slum01 setDir random 360;

	private _dirStart = random 360;
	[_slum02, _slum03, _slum04, _slum05, _slum06, _slum07, _slum08, _barrel01,_barrel02,_barrel03,_barrel04] apply
	{
		_x setDir (_dirStart + selectRandom [90,270,180,0] + (random 10));
	};


	[_slum01, _slum02, _slum03, _slum04, _slum05, _slum06, _slum07, _slum08, _junk01,_junk02,_junk03,_junk04,_barrel01,_barrel02,_barrel03,_barrel04]
};

DK_MIS_Kill_01_moveVehProps_0 = {

	uiSleep 0.2;

	// Move vehicles
	params ["_vehicles", "_startingPos", "_allUnits", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_vehiclesTemp", "_nil", "_allPropsVeh"];

	{
			_veh = _x;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
			_allPropsVeh = _vehiclesTemp + _allUnits;

			_veh setVehiclePosition [_startingPos, [], 25, "NONE"];

			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				{
					_bbr = boundingBox _x;
					_p1 = _bbr # 0;
					_p2 = _bbr # 1;

					_maxLength = ( abs ((_p2 # 1) - (_p1 # 1)) ) + 2.2;

					if (_veh distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _allPropsVeh;

				if _exit then
				{
					if !( (nearestTerrainObjects [ _veh, [], _maxLength + 3]) - (nearestTerrainObjects [ _veh, ["Bush"], _maxLength]) isEqualTo [] ) then
					{
						_exit = false;
					};
				};

				if _exit exitWith {};

//				uiSleep 0.02;
				uiSleep 0.04;

				_veh setVehiclePosition [_startingPos, [], 18, "NONE"];
			};

			_x setDamage 0;

			uiSleep 0.02;

	} count _vehicles;


	_vehicles spawn DK_fnc_activateVeh;
};

DK_MIS_Kill_01_moveVehProps_1 = {

	params ["_props","_vehicles","_startingPos","_allUnits"];


	uiSleep 0.5;

	// Move props (like wreck)
	private ["_object", "_exit", "_bbr", "_p1", "_p2", "_maxLength"];

	private _dirProps = random 360;
	for "_i" from 0 to 9 step 1 do
	{
		_dirProps = _dirProps + 36;
		_object = _props # _i;
		_object setVehiclePosition [_startingPos getPos [14 + (random 7), _dirProps], [], 5, "NONE"];

		for "_i" from 0 to 40 step 1 do
		{
			_exit = true;

			{
				_bbr = boundingBox _x;
				_p1 = _bbr # 0;
				_p2 = _bbr # 1;

				_maxLength = ( abs ((_p2 # 1) - (_p1 # 1)) ) + 1.5;

				if (_object distance2D _x < _maxLength) exitWith
				{
					_exit = false;
				};

			} count (_props + _allUnits - [_object]);

			if _exit exitWith {};

			uiSleep 0.04;
//			uiSleep 0.02;

			_object setVehiclePosition [_startingPos getPos [14 + (random 7), _dirProps], [], 5, "NONE"];
		};

		private _pos = getPosWorld _object;
		_pos set [2,0];
		_pos = AGLToASL _pos;
		_object setPosASL _pos;
		_object setVectorUp surfaceNormal _pos;

		uiSleep 0.02;
	};

	for "_i" from 10 to 11 step 1 do
	{
		_object = _props # _i;
		_object setDir (random 360);
		_object setVehiclePosition [_startingPos, [], 10, "NONE"];

		for "_i" from 0 to 40 step 1 do
		{
			_exit = true;

			{
				_bbr = boundingBox _x;
				_p1 = _bbr # 0;
				_p2 = _bbr # 1;

				_maxLength = ( abs ((_p2 # 1) - (_p1 # 1)) ) + 1.5;

				if (_object distance2D _x < _maxLength) exitWith
				{
					_exit = false;
				};

			} count (_props + _allUnits - [_object]);

			if _exit exitWith {};

			uiSleep 0.02;

			_object setVehiclePosition [_startingPos, [], 10, "NONE"];
		};

		private _pos = getPosWorld _object;
		_pos set [2,0];
		_pos = AGLToASL _pos;
		_object setPosASL _pos;
		_object setVectorUp surfaceNormal _pos;

		uiSleep 0.02;
	};

	// Move props (like garbage)
	private _rad = 5;
	for "_i" from 16 to 19 step 1 do
	{
		(_props # _i) setVehiclePosition [_startingPos, [], _rad, "NONE"];
		_rad = _rad + 5;

		uiSleep 0.03;
	};


	// Move vehicles
	uiSleep 0.3;

	[_vehicles,_props,_allUnits,_startingPos] spawn
	{
		params ["_vehicles", "_props", "_allUnits", "_startingPos", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_vehiclesTemp", "_nil", "_allPropsVeh"];

		{
			_veh = _x;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
			_allPropsVeh = _props + _vehiclesTemp + _allUnits;

			_veh setVehiclePosition [_startingPos, [], 25, "NONE"];

			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				{
					_bbr = boundingBox _x;
					_p1 = _bbr # 0;
					_p2 = _bbr # 1;

					_maxLength = ( abs ((_p2 # 1) - (_p1 # 1)) ) + 2.2;

					if (_veh distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _allPropsVeh;

				if _exit exitWith {};

				uiSleep 0.04;
//				uiSleep 0.02;

				_veh setVehiclePosition [_startingPos, [], 30, "NONE"];
			};

			_x setDamage 0;

			uiSleep 0.02;

		} count _vehicles;


		// Move props (like barrel)
		for "_i" from 12 to 15 step 1 do
		{
			(_props # _i) setVehiclePosition [_startingPos, [], 20, "NONE"];

			uiSleep 0.02;
		};

		_vehicles spawn DK_fnc_activateVeh;
	};

};

DK_MIS_Kill_01_moveVehProps_2 = {

	params ["_props","_vehicles","_startingPos","_allUnits"];


	uiSleep 0.5;

	// Move props (like wreck)
	private ["_object", "_pos", "_exit", "_bbr", "_p1", "_p2", "_maxLength"];

	private _dirProps = 0;

	for "_i" from 0 to 8 step 1 do
	{
		_object = _props # _i;

		private "_exit";
		for "_i" from 0 to 40 step 1 do
		{
			_exit = true;

			_object setVehiclePosition [_startingPos getPos [20 + (_i / 4), _dirProps], [], 10, "NONE"];

			{
				if (_object distance2D _x < 6.5) exitWith
				{
					_exit = false;
				};

			} count _allUnits;

			if _exit then
			{
				{
					if (_object distance2D _x < 12) exitWith
					{
						_exit = false;
					};

				} count (_props - [_object]);
			};

			if _exit exitWith {};

//			uiSleep 0.02;
			uiSleep 0.04;
		};


		_pos = getPosWorld _object;
		_pos set [2,0];
		_pos = AGLToASL _pos;
		_object setPosASL _pos;
		_object setVectorUp surfaceNormal _pos;

		_dirProps = _dirProps + 45;
	};


	// Move vehicles
	uiSleep 0.3;

	[_vehicles,_props,_allUnits,_startingPos] spawn
	{
		params ["_vehicles", "_props", "_allUnits", "_startingPos", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_vehiclesTemp", "_nil", "_allPropsVeh", "_vehBoxSize"];


		private _allProps = _props select [0,8];

		{
			_veh = _x;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
		
			_bbr = boundingBox _veh;
			_p1 = _bbr # 0;
			_p2 = _bbr # 1;

			_vehBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2;


			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				_veh setVehiclePosition [_startingPos, [], 29, "NONE"];


				{
					_bbr = boundingBox _x;
					_p1 = _bbr # 0;
					_p2 = _bbr # 1;

					_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.5);

					if (_veh distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _allProps;

				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + ( ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _vehiclesTemp;
				};

				if (_exit) then
				{
					{
						if (_veh distance2D _x < _vehBoxSize) exitWith
						{
							_exit = false;
						};

					} count _allUnits;
				};

				if _exit exitWith {};

//				uiSleep 0.02;
				uiSleep 0.04;
			};

			_veh setDamage 0;

			uiSleep 0.02;

		} count _vehicles;


		// Move props (like barrel)
		for "_i" from 9 to 10 step 1 do
		{
			(_props # _i) setVehiclePosition [_startingPos, [], 20, "NONE"];

			uiSleep 0.02;
		};

		_vehicles spawn DK_fnc_activateVeh;
	};

};

DK_MIS_Kill_01_moveVehProps_3 = {

	params ["_props","_vehicles","_startingPos","_allUnits"];


	private ["_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_leaderToFix", "_unitInside1", "_unitInside2"];
	private _farm01 = _props # 0;
	private _farm02 = _props # 1;


///	// Move farms 1
	private _startAngle = random 360;
	private _finishAngle = _startAngle + 360;

	for "_i" from _startAngle to _finishAngle step 22.5 do
	{
		_exit = true;

		_farm01 setDir _i;

		_farm01 setPos (_startingPos getPos [26, _i]);

		{
			if (_farm01 distance2D _x < 2) exitWith
			{
				_exit = false;
			};

		} count _allUnits;

		uiSleep 0.02;

		if _exit exitWith {};
	};

	if !(_exit) then
	{
		for "_i" from _startAngle to _finishAngle step 22.5 do
		{
			_exit = true;

			_farm01 setDir _i;

			_farm01 setPos (_startingPos getPos [14, _i]);

			{
				if (_farm01 distance2D _x < 2) exitWith
				{
					_exit = false;
				};

			} count _allUnits;

			uiSleep 0.02;

			if _exit exitWith {};
		};
	};

	if !(_exit) then
	{
		_farm01 setVehiclePosition [_startingPos, [], 27, "NONE"];
	};

	private _posFarm01 = getPosWorld _farm01;
	_posFarm01 set [2,0];
	_posFarm01 = AGLToASL _posFarm01;
	_farm01 setPosASL _posFarm01;
	_farm01 setVectorUp [0,0,1];

///	// Move farms 2
	private _rePlace = false;

	switch ( selectRandom ["side","front"] ) do
	{
		case "side" :
		{
			_farm02 setDir (getDir _farm01) - 90;
			_farm02 setPos (_farm01 modelToWorldVisual [-26,-16 - (random 7),0]);

			{
				if (_farm02 distance2D _x < 2) exitWith
				{
					_rePlace = true;
				};

			} count _allUnits;

			if _rePlace then
			{
				_rePlace = false;

				_farm02 setDir (getDir _farm01) + 90;
				_farm02 setPos (_farm01 modelToWorldVisual [26,-16 - (random 7),0]);

				{
					if (_farm02 distance2D _x < 2) exitWith
					{
						_rePlace = true;
					};

				} count _allUnits;
			};

			if _rePlace then
			{
				_rePlace = false;

				_farm02 setDir (getDir _farm01) + 180;
				_farm02 setPos (_farm01 modelToWorldVisual [0,-52,0]);

				{
					if (_farm02 distance2D _x < 2) exitWith
					{
						_rePlace = true;
					};

				} count _allUnits;
			};
		};

		case "front" :
		{
			_farm02 setDir (getDir _farm01) + 180;
			_farm02 setPos (_farm01 modelToWorldVisual [0,-52,0]);

			{
				if (_farm02 distance2D _x < 2) then
				{
					_rePlace = true;
				};

			} count _allUnits;

			if _rePlace then
			{
				_rePlace = false;

				_farm02 setDir (getDir _farm01) - 90;
				_farm02 setPos (_farm01 modelToWorldVisual [-26,-16 - (random 7),0]);

				{
					if (_farm02 distance2D _x < 2) exitWith
					{
						_rePlace = true;
					};

				} count _allUnits;
			};

			if _rePlace then
			{
				_rePlace = false;

				_farm02 setDir (getDir _farm01) + 90;
				_farm02 setPos (_farm01 modelToWorldVisual [26,-16 - (random 7),0]);

				{
					if (_farm02 distance2D _x < 2) exitWith
					{
						_rePlace = true;
					};

				} count _allUnits;
			};
		};
	};

	private _posFarm02 = getPosWorld _farm02;
	_posFarm02 set [2,0];
	_posFarm02 = AGLToASL _posFarm02;
	_farm02 setPosASL _posFarm02;
	_farm02 setVectorUp [0,0,1];


	// Move waterBench
	private _waterBench = _props # 3;

	private _placement = [10,9,8,7,6,5,4,3,2,1,0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10] call KK_fnc_arrayShuffle;
	for "_i" from 0 to 20 step 1 do
	{
		_exit = true;

		_waterBench setPos ( _farm01 modelToWorldVisual [_placement # _i, -6, -0.5] );

		{
			if (_waterBench distance2D _x < 1.7) exitWith
			{
				_exit = false;
			};

		} count _allUnits;

		uiSleep 0.02;

		if (_exit) exitWith {};
	};

	private _pos = getPosWorld _waterBench;
	_pos set [2,0];
	_pos = AGLToASL _pos;
	_waterBench setPosASL _pos;
	_waterBench setVectorUp surfaceNormal _pos;


	// Move water Tank
	private _waterTank = _props # 4;

	_waterTank setDir (getDir _farm02);

	_placement call KK_fnc_arrayShuffle;
	for "_i" from 0 to 20 step 1 do
	{
		_exit = true;

		_waterTank setPos ( _farm02 modelToWorldVisual [_placement # _i, -7.2, -0.5] );

		{
			if (_waterTank distance2D _x < 3.2) exitWith
			{
				_exit = false;
			};

		} count _allUnits;

		uiSleep 0.02;

		if (_exit) exitWith {};
	};

	private _pos = getPosWorld _waterTank;
	_pos set [2,0];
	_pos = AGLToASL _pos;
	_waterTank setPosASL _pos;
	_waterTank setVectorUp [0,0,1];
	_waterTank setDir (getDir _waterTank) + (selectRandom [90,270,0]);

	// Farm can be destroy
	if (selectRandom [true, false, false]) then
	{
		_farm01 setDamage [1, false];
	};

	// Move Tractor
	private _tractor = _props # 2;

	for "_i" from 0 to 100 step 1 do
	{
		_exit = true;

		_tractor setVehiclePosition [_farm01 modelToWorldVisual [0,-28,0], [], 12, "NONE"];

		{
			if (_tractor distance2D _x < 4) exitWith
			{
				_exit = false;
			};

		} count _allUnits;

		if _exit exitWith {};

		uiSleep 0.04;
	};


	// Move vehicles
	uiSleep 0.2;

	[[_posFarm01,_posFarm02], _vehicles, _props, _allUnits, _startingPos] spawn
	{
		params ["_posFarms", "_vehicles", "_props", "_allUnits", "_startingPos", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_vehiclesTemp", "_nil", "_allPropsVeh", "_vehBoxSize"];

		private _allTractor = [(_props # 2)];
		private _allProps = _props select [3,4];

		{
			_veh = _x;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
		
			_bbr = boundingBox _veh;
			_p1 = _bbr # 0;
			_p2 = _bbr # 1;

			_vehBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2;


			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				_veh setVehiclePosition [_startingPos, [], 27, "NONE"];

				{
					_maxLength = _vehBoxSize + 10;


					if (_veh distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _posFarms;

				if (_exit) then
				{
					{
						_maxLength = _vehBoxSize + 3.2;

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _allTractor;
				};

				if (_exit) then
				{
					{
						_maxLength = _vehBoxSize + 1.8;

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _allProps;
				};

				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + ( ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _vehiclesTemp;
				};

				if (_exit) then
				{
					{
						if (_veh distance2D _x < _vehBoxSize) exitWith
						{
							_exit = false;
						};

					} count _allUnits;
				};

				if _exit exitWith {};

				uiSleep 0.02;	// Sleep for performance
			};

			_veh setDamage 0;

//			uiSleep 0.02;
			uiSleep 0.04;

		} count _vehicles;

		_vehicles spawn DK_fnc_activateVeh;
	};

};

DK_MIS_Kill_01_moveVehProps_4 = {

	params ["_props","_vehicles","_startingPos","_allUnits", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_propBoxSize", "_object", "_slc1"];


	private _construcSite01 = _props # 0;

	// Maybe place AI in building
	if (selectRandom [false,true,true]) then
	{
		_slc1 = _allUnits findIf { (isNull attachedTo _x) && { !(_x getVariable ["DK_behaviour", ""] isEqualTo "sit") } };

		if !(_slc1 isEqualTo -1) then
		{
			_leaderToFix = _allUnits # _slc1;

			call
			{
				if (typeOf _construcSite01 isEqualTo "Land_Unfinished_Building_01_F") exitWith
				{
					_leaderToFix attachTo [_construcSite01, selectRandom [[-2,-0.7,2],[-2,0,-2]]];
				};

				_leaderToFix attachTo [_construcSite01, selectRandom [[4.2,3.2,1.5],[4.2,3.2,-2]]];
			};
		};
	};

	uiSleep 0.3;

///	// Move Construc site (buidling)

	// Site 1
	private _startAngle = random 360;
	private _finishAngle = _startAngle + 360;

	for "_i" from _startAngle to _finishAngle step 11.25 do
	{
		_exit = true;

		_construcSite01 setDir (_i + (selectRandom [0,180]));

		_construcSite01 setPos (_startingPos getPos [22, _i]);

		{
			if (_construcSite01 distance2D _x < 8) exitWith
			{
				_exit = false;
			};

		} count _allUnits;

		if _exit exitWith {};
	};


	if !(_exit) then
	{
		for "_i" from _startAngle to _finishAngle step 11.25 do
		{
			_exit = true;

			_construcSite01 setDir (_i + (selectRandom [0,180]));

			_construcSite01 setPos (_startingPos getPos [25, _i]);

			{
				if (_construcSite01 distance2D _x < 8) exitWith
				{
					_exit = false;
				};

			} count _allUnits;

			uiSleep 0.04;

			if _exit exitWith {};
		};

	};

	if !(_exit) then
	{
		_construcSite01 setVehiclePosition [_startingPos, [], 27, "NONE"];
	};


	private _posConstrucSite01 = getPosWorld _construcSite01;
	_posConstrucSite01 set [2,0.25];
	_posConstrucSite01 = AGLToASL _posConstrucSite01;
	_construcSite01 setPosASL _posConstrucSite01;
	_construcSite01 setVectorUp [0,0,1];


	// Move props
	private _justProps = _props select [1,8];
	private "_justPropsTmp";
	for "_i" from 1 to 8 step 1 do
	{
		_object = _props # _i;
		_justPropsTmp = (+_justProps) - [_object];

		_bbr = boundingBox _object;
		_p1 = _bbr # 0;
		_p2 = _bbr # 1;

		_propBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2;

		for "_i" from 0 to 100 step 1 do
		{
			_exit = true;

			_object setVehiclePosition [_startingPos, [], 18, "NONE"];

			{
				_maxLength = _propBoxSize + 1;

				if (_object distance2D _x < _maxLength) exitWith
				{
					_exit = false;
				};

			} count _allUnits;

			if _exit then
			{
				{
					_bbr = boundingBox _x;
					_p1 = _bbr # 0;
					_p2 = _bbr # 1;

					_maxLength = (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2) + _propBoxSize;

					if (_object distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

//				} count (_justProps - [_object]);
				} count _justPropsTmp;
			};

			if _exit then
			{
				_bbr = boundingBox _construcSite01;
				_p1 = _bbr # 0;
				_p2 = _bbr # 1;

				_maxLength = (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.4) + _propBoxSize;

				if (_object distance2D _construcSite01 < _maxLength) exitWith
				{
					_exit = false;
				};
			};

			if _exit exitWith
			{
				_object hideObject false;
			};

//			uiSleep 0.02;
			uiSleep 0.04;
		};

		uiSleep 0.02;
	};


	// Move vehicles
	uiSleep 0.2;

	[_vehicles,_props,_allUnits,_startingPos,_posConstrucSite01] spawn
	{
		params ["_vehicles", "_props", "_allUnits", "_startingPos", "_posConstrucSite01", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_vehiclesTemp", "_nil", "_vehBoxSize"];

		private _allProps = _props select [1,8];

		{
			_veh = _x;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
		
			_bbr = boundingBox _veh;
			_p1 = _bbr # 0;
			_p2 = _bbr # 1;

			_vehBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2;


			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				_veh setVehiclePosition [_startingPos, [], 27, "NONE"];

				_maxLength = _vehBoxSize + 8;

				if (_veh distance2D _posConstrucSite01 < _maxLength) then
				{
					_exit = false;
				};


				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _allProps;
				};

				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _vehiclesTemp;
				};

				if (_exit) then
				{
					{
						if (_veh distance2D _x < _vehBoxSize) exitWith
						{
							_exit = false;
						};

					} count _allUnits;
				};

				if _exit exitWith {};

//				uiSleep 0.02;
				uiSleep 0.02;
			};

			_veh setDamage 0;

			uiSleep 0.02;

		} count _vehicles;

		_vehicles spawn DK_fnc_activateVeh;
	};
};

DK_MIS_Kill_01_moveVehProps_5 = {

	params ["_props","_vehicles","_startingPos","_allUnits", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_propBoxSize", "_object", "_cntLp", "_slc1"];


	if (selectRandom [true,false,false]) then
	{
		_slc1 = _allUnits findIf { (isNull attachedTo _x) && { !(_x getVariable ["DK_behaviour", ""] isEqualTo "sit") } };

		if !(_slc1 isEqualTo -1) then
		{
			(_allUnits # _slc1) attachTo [_props # (selectRandom [0,1,2]), [-3 + (random 6),0,2.3]];
		};
	};

	uiSleep 0.3;

///	// Move dirt hump & bulldozer
	for "_i" from 0 to 4 step 1 do
	{
		_object = _props # _i;

		if (isNull attachedTo _object) then
		{
			_bbr = boundingBox _object;
			_p1 = _bbr # 0;
			_p2 = _bbr # 1;

			_propBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.6;

			for "_i" from 0 to 100 step 1 do
			{
				_exit = true;

				_object setVehiclePosition [_startingPos, [], 26, "NONE"];

				{
					_maxLength = _propBoxSize + 2;

					if (_object distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _allUnits;

				if _exit then
				{
					{
						if (isNull attachedTo _x) then
						{
							_bbr = boundingBox _x;
							_p1 = _bbr # 0;
							_p2 = _bbr # 1;

							_maxLength = (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.6) + _propBoxSize;

							if (_object distance2D _x < _maxLength) exitWith
							{
								_exit = false;
							};
						};

					} count (_props - [_object]);
				};


				if _exit exitWith {};
	
				uiSleep 0.02;
			};

			if !((typeOf _object) in bulldozer) then
			{
				_vectorUp = vectorUp _object;

				if ( (_vectorUp # 0 < 0.4) && { (_vectorUp # 1 < 0.4) } ) then
				{
					private _pos = getPosWorld _object;
					_pos set [2,-0.4];
					_pos = AGLToASL _pos;
					_object setPosASL _pos;
					_object setVectorUp surfaceNormal _pos;
				}
				else
				{
					{
						_x hideObjectGlobal true;

					} count (attachedObjects _object + [_object]);
				};
			};

//			uiSleep 0.02;
			uiSleep 0.04;
		};

	};


	// Move vehicles
	uiSleep 0.2;

	[_vehicles,_props,_allUnits,_startingPos] spawn
	{
		params ["_vehicles", "_props", "_allUnits", "_startingPos", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_vehiclesTemp", "_nil", "_vehBoxSize", "_rad"];

		{
			_veh = _x;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
		
			_bbr = boundingBox _veh;
			_p1 = _bbr # 0;
			_p2 = _bbr # 1;

			_vehBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2;


			_rad = random 360;
			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				_rad = _rad + 10;
				_veh setVehiclePosition [_startingPos getPos [5, _rad], [], 30, "NONE"];
	//			_veh setVehiclePosition [_startingPos, [], 35, "NONE"];

				{
					if (_veh distance2D _x < _vehBoxSize) exitWith
					{
						_exit = false;
					};

				} count _allUnits;

				if (_exit) then
				{
					{
						if (isNull attachedTo _x) then
						{
							_bbr = boundingBox _x;
							_p1 = _bbr # 0;
							_p2 = _bbr # 1;

							_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.3);

							if (_veh distance2D _x < _maxLength) exitWith
							{
								_exit = false;
							};
						};

					} count _props;
				};

				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _vehiclesTemp;
				};


				if _exit exitWith {};

//				uiSleep 0.02;
				uiSleep 0.04;
			};

			_veh setDamage 0;

			uiSleep 0.02;

		} count _vehicles;

		_vehicles spawn DK_fnc_activateVeh;
	};
};

DK_MIS_Kill_01_moveVehProps_6 = {

	params ["_props","_vehicles","_startingPos","_allUnits", "_exit", "_bbr", "_p1", "_p2", "_maxLength", "_veh", "_propBoxSize", "_slc1"];


	private _slums = _props select [0,8];

	// Maybe place AI in building
	if (selectRandom [true,true,false]) then
	{
		_slc1 = _allUnits findIf { (isNull attachedTo _x) && { !(_x getVariable ["DK_behaviour", ""] isEqualTo "sit") } };

		if !(_slc1 isEqualTo -1) then
		{
			(_allUnits # _slc1) attachTo [_slums # 3, [1,1,-0.5]];
		};


		_allUnits call KK_fnc_arrayShuffle;
		_slc1 = _allUnits findIf { (isNull attachedTo _x) && { !(_x getVariable ["DK_behaviour", ""] isEqualTo "sit") } };

		if !(_slc1 isEqualTo -1) then
		{
			(_allUnits # _slc1) attachTo [_slums # 5, [0,-0.7,-0.4]];
		};
	};

	uiSleep 0.3;

///	// Move slum house
	private ["_object", "_pos", "_slumsTmp"];
	{
		_object = _x;
		_slumsTmp = (+_slums) - [_object];

		_bbr = boundingBox _object;
		_p1 = _bbr # 0;
		_p2 = _bbr # 1;

		_propBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.4;

		for "_i" from 0 to 100 step 1 do
		{
			_exit = true;

			_object setVehiclePosition [_startingPos, [], 27, "NONE"];

			{
				_maxLength = _propBoxSize + 1;

				if (_object distance2D _x < _maxLength) exitWith
				{
					_exit = false;
				};

			} count _allUnits;

			if _exit then
			{
				{
					_bbr = boundingBox _x;
					_p1 = _bbr # 0;
					_p2 = _bbr # 1;

					_maxLength = (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.4) + _propBoxSize;

					if (_object distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _slumsTmp;
			};

			if _exit exitWith {};

//			uiSleep 0.02;
			uiSleep 0.04;
		};

		uiSleep 0.02;
		
		_pos = getPosWorld _object;
		_pos set [2,0];
		_pos = AGLToASL _pos;
		_object setPosASL _pos;
		_object setVectorUp [0,0,1];

	} count _slums;

	_slumCont = _props # 0;
	private _pos = getPosWorld _slumCont;
	_pos set [2,0];
	_pos = AGLToASL _pos;
	_slumCont setPosASL _pos;
	_slumCont setVectorUp surfaceNormal _pos;

	// Move garbage
	private _garbages = _props select [8,11];
	private _rad = 6;
	{
		_x setVehiclePosition [_startingPos, [], _rad, "NONE"];
		_rad = _rad + 6;

		uiSleep 0.02;

	} count _garbages;

	// Move vehicles
	uiSleep 0.2;

	[_garbages, _slums, _props, _vehicles, _allUnits, _startingPos] spawn
	{
		params ["_garbages", "_slums", "_props", "_vehicles", "_allUnits", "_startingPos", "_vehiclesTemp", "_nil", "_vehBoxSize", "_bbr", "_p1", "_p2", "_exit", "_maxLength", "_veh", "_object", "_rad"];

		{
			_veh = _x;

			_veh hideObjectGlobal true;
			_rad = random 360;

			_vehiclesTemp = +_vehicles;
			_nil = _vehiclesTemp deleteAt (_vehiclesTemp find _veh);
		
			_bbr = boundingBox _veh;
			_p1 = _bbr # 0;
			_p2 = _bbr # 1;

			_vehBoxSize = ( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.3;


			for "_i" from 0 to 500 step 1 do
			{
				_exit = true;

				_rad = _rad + 10;
				_veh setVehiclePosition [_startingPos getPos [5, _rad], [], 25, "NONE"];

				_maxLength = _vehBoxSize + 1;

				{
					if (_veh distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

				} count _allUnits;

				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.4);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _slums;
				};

				if (_exit) then
				{
					_maxLength = _vehBoxSize + 0.8;
					{
						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _garbages;
				};

				if (_exit) then
				{
					{
						_bbr = boundingBox _x;
						_p1 = _bbr # 0;
						_p2 = _bbr # 1;

						_maxLength = _vehBoxSize + (( abs ((_p2 # 1) - (_p1 # 1)) ) / 1.2);

						if (_veh distance2D _x < _maxLength) exitWith
						{
							_exit = false;
						};

					} count _vehiclesTemp;
				};

				if _exit exitWith {};

//				uiSleep 0.02;
				uiSleep 0.04;
			};

			_veh setDamage 0;
			_veh hideObjectGlobal false;

			uiSleep 0.02;

		} count _vehicles;


		// Move props (like barrel)
		for "_i" from 12 to 15 step 1 do
		{
			_object = _props # _i;


			for "_i" from 0 to 100 step 1 do
			{
				_object setVehiclePosition [_startingPos, [], 25, "NONE"];

				_exit = true;

				{
					if (_object distance2D _x < 1.2) exitWith
					{
						_exit = false;
					};

				} count _allUnits;

				if _exit exitWith {};

				uiSleep 0.02;
			};
		};

		_vehicles spawn DK_fnc_activateVeh;
	};

};



/// Action for units
DK_MIS_K01_roundGuard = {

	params ["_unit"];

	_unit setVariable ["DK_behaviour", "walk"];

	_this spawn
	{
		params ["_unit", ["_radMin", 15], ["_radMax", 35]];


		_radMax = _radMax - _radMin;

		waitUntil { uiSleep 0.5; ( !((_unit getVariable ["MIS_center", ""]) isEqualTo "") && { !(isNil "DK_MIS_var_AiIsBlocked") } ) OR !(alive _unit) };

		uiSleep 4;

		if (alive _unit) then
		{
			private "_weapon";
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

			private ["_pos", "_time", "_dir"];
			private _center = _unit getVariable ["MIS_center", getPosATL (leader _unit)];

			while { DK_MIS_var_AiIsBlocked && { (alive _unit) } } do
			{
				_dir = random 360;
				_pos = _center getPos [_radMin + (random _radMax), _dir];

				_unit doMove _pos;

				_time = time + (_unit distance2D _pos);
				waitUntil { uiSleep 1; (_unit distance2D _pos < 1) OR (time > _time) OR (!alive _unit) OR !(DK_MIS_var_AiIsBlocked) };

				if ( !(DK_MIS_var_AiIsBlocked) OR (!alive _unit) ) exitWith {};

				_unit doFollow _unit;
				doStop _unit;
				_unit setFormDir _dir;

				_time = time + (3 + (random 20));
				waitUntil { uiSleep 1; (time > _time) OR (!alive _unit) OR !(DK_MIS_var_AiIsBlocked) };
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



