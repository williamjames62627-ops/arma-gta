if !(isServer) exitWith {};


#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]

#define rescuePlace01 [[[21531.1,16007,0.5],[21524.7,16036.9,0.5],[21527.4,16021.8,0.156669],"shedIndus"],[[21256.2,16544.4,0.5],[21226.1,16538.6,0.5],[21241.4,16541.1,0.0871067],"shedIndus"],[[25813.4,20160.1,0.5],[25804.4,20189.4,0.5],[25808.4,20174.5,0.0203681],"shedIndus"],[[20593.3,16046.5,0.5],[20594.1,16015.9,0.5],[20594.2,16031.3,0.152855],"shedIndus"],[[20617,17016.1,0.5],[20647.6,17019,0.5],[20632.2,17018,0.0335045],"shedIndus"],[[19408.3,14297.3,0.5],[19397.6,14326,0.5],[19402.5,14311.4,0.204441],"shedIndus"],[[20298.5,17183.5,0.5],[20301.4,17153,0.5],[20300.4,17168.4,0.424702],"shedIndus"],[[24893.1,20843.7,0.5],[24896,20874.2,0.5],[24894,20858.9,0.235235],"shedIndus"],[[19038.7,14556.7,0.5],[19019.9,14580.9,0.5],[19028.9,14568.4,0.200417],"shedIndus"],[[18716.4,14542.7,0.5],[18722.7,14572.7,0.5],[18719,14557.7,0.204655],"shedIndus"],[[19330.8,17065.8,0.5],[19320.8,17094.7,0.5],[19325.4,17080,0.123152],"shedIndus"],[[19073.5,16624.7,0.5],[19098.6,16642.3,0.5],[19085.7,16633.8,0.154463],"shedIndus"],[[21004.5,19443.2,0.5],[20997.5,19473.1,0.5],[21000.6,19458,0.0174971],"shedIndus"],[[18253.7,13577.7,0.5],[18284.3,13576.4,0.5],[18268.9,13577.6,0.117802],"shedIndus"],[[20703.4,19452.5,0.5],[20675.5,19439.7,0.5],[20689.7,19445.7,0.383209],"shedIndus"],[[17319.5,13376.3,0.5],[17328.7,13347,0.5],[17324.6,13361.9,0.144904],"shedIndus"],[[17224.8,13181,0.5],[17235.1,13152.1,0.5],[17230.4,13166.8,0.0897417],"shedIndus"],[[26874.9,23795.2,0.5],[26862.6,23823.2,0.5],[26868.3,23808.9,0.122307],"shedIndus"],[[20734.1,15686.5,0.5],[20748.9,15680.6,0.5],[20741.1,15682.6,0.00245476],"shedSmall"],[[20605.7,15603.3,0.5],[20617.9,15613.6,0.5],[20612.4,15607.7,0.193327],"shedSmall"],[[20415.9,11473.2,0.5],[20410,11458.4,0.5],[20412,11466.2,0.21225],"shedSmall"],[[21123.9,16930.8,0.5],[21113.6,16943.1,0.5],[21119.5,16937.6,0.0771046],"shedSmall"],[[20570.9,16060.5,0.5],[20555.4,16056.3,0.5],[20562.9,16059.4,-0.00275612],"shedSmall"],[[21341.4,17640.4,0.5],[21352,17652.3,0.5],[21347.5,17645.7,-0.332157],"shedSmall"],[[25396.5,20391,0.5],[25385.1,20379.7,0.5],[25390.1,20386.1,0.208489],"shedSmall"],[[20966.9,17427.9,0.5],[20950.9,17428.4,0.5],[20958.9,17429.1,0.448032],"shedSmall"],[[21845,7924.54,0.5],[21838.3,7910,0.5],[21840.8,7917.69,0.128455],"shedSmall"],[[18780.5,16351.5,0.5],[18780.3,16335.5,0.5],[18779.4,16343.5,0.581083],"shedSmall"],[[17499.7,13110.6,0.5],[17511.6,13121.3,0.5],[17506.3,13115.2,-0.0657482],"shedSmall"],[[17325.3,13317.8,0.5],[17336.5,13306.4,0.5],[17330.2,13311.4,0.0142384],"shedSmall"],[[17257.1,13284.2,0.5],[17263.1,13299.1,0.5],[17261,13291.3,-0.0709457],"shedSmall"],[[17176.2,13263.3,0.5],[17191.8,13259.7,0.5],[17183.7,13260.5,0.0543709],"shedSmall"],[[26282.1,23359.6,0.5],[26297.7,23363,0.5],[26290.2,23360.3,-0.095829],"shedSmall"],[[28329.7,25766.9,0.5],[28345.7,25767.9,0.5],[28337.7,25766.4,-0.076416],"shedSmall"]]
DK_rescuePlace01 = +rescuePlace01;
DK_minimRescue01 = (count DK_rescuePlace01) - 6;


DK_MIS_TakeCar_01_create = {

	DK_MIS_loopsInProgress = 0;

	// Set Mission Type
	DK_MIS_missionType = "TakeCar";


	// Get Difficulty depending on number of missions completed (Ennemies Stuff, Weapons, Reward loot) (server)
	private _difficulties = call DK_MIS_fnc_slctDifficulty_TC01;

	_difficulties params ["_vehClass", "_className", "_uniform", "_weapons", "_vest", "_disSeen", "_behaviour", "_speed", "_rewardLvl", "_classGuy", "_canSitting"];


	// Limite Patrol cops on traffic
	private _ltdCops = _className call DK_MIS_fnc_setCntPatrolCops;


	// Define ID mission (server)
	private _idMission = call DK_MIS_create_ID_mission;
	if (isNil "_idMission") then
	{
		_idMission = "error" + (str time);
	};
	DK_idMission = _idMission;
	publicVariable "DK_idMission";
	_difficulties pushBack _idMission;


	// Init mission (server)
	_result = _difficulties call DK_MIS_TakeCar_01_init;

	_result params ["_allGrps", "_allUnits","_tg_TakeCar"];


	// Create various Trigger AI (server)
	[_allUnits, _disSeen, DK_MIS_TC01_triggerAI] spawn DK_MIS_Kill_addIsSeen;


	// Select & Create rescue place
	_rescuePlace = _tg_TakeCar call DK_MIS_TakeCar_01_getRescuePlace;


	// Set info mission
	_tg_TakeCar setVariable ["MIS_nfo", [_rescuePlace # 2, _className, _classGuy, _uniform, _weapons, _vest, _idMission]];

	// Assign objectif to misssion namespace
	missionNamespace setVariable [("DK_TC_veh_" + (str _idMission)), _tg_TakeCar];

	// Start loop for Checking if car is rescue
	[_rescuePlace, _tg_TakeCar, _idMission] spawn DK_MIS_TakeCar_01_loopRescue;


	// Start loop for Add score according to distance traveled with objectve
	[_rescuePlace # 2, _tg_TakeCar, _idMission] spawn DK_MIS_TakeCar_01_addScrAccordDisTraveled;


	// Start cooldown mission
	_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission;

	// Added MP3 Players
	[_tg_TakeCar, false] call DK_fnc_MP3car_init;


	// Start Mission for players ! (local)
	private _contain = call DK_MIS_slctContain;
	private _victorySnd = call DK_MIS_slctVictorySnd;
	private _configName = getText (configFile >> "CfgVehicles" >> typeOf (_tg_TakeCar) >> "displayName");
	DK_MIS_IdJIP_initCL = [_idMission, _tg_TakeCar, _rescuePlace, _contain, _configName, _classGuy, _victorySnd] remoteExecCall ["DK_MIS_fnc_TC01_initClient_cl", DK_isDedi, true];


	// Handle & Waiting Ending (server)
	_result call DK_MIS_TakeCar_01_finished;

	
	// Default Patrol cops on traffic
	DK_copsPatrolMax = _ltdCops;

};

DK_MIS_TakeCar_01_init = {

	params ["_vehClass", "_className", "_uniform", "_weapons", "_vest", "", "_behaviour", "_speed", "_rewardLvl", "_ennemiesType", "_canSitting", "_idMission"];


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

	// Create Vehicles --
	private "_tg_TakeCar";
	switch ( _vehClass ) do
	{
		case "veh_cls" :
		{
			_tg_TakeCar = [false, true] call DK_MIS_fnc_crtVeh_cls;
		};

		case "veh_Ballas" :
		{
			_tg_TakeCar = [false] call DK_MIS_fnc_crtVeh_Ballas;
		};

		case "veh_Dominicans" :
		{
			switch (call DK_MIS_fnc_ArmedVehicleChoiceDomi_TakeCar_01) do
			{
				case 1 :
				{
					_tg_TakeCar = [false, "LMG"] call DK_MIS_fnc_crtVeh_DomiGun;
				};
				case 2 :
				{
					_tg_TakeCar = [false, "AT"] call DK_MIS_fnc_crtVeh_DomiGun;
				};
				case 3 :
				{
					_tg_TakeCar = [false] call DK_MIS_fnc_crtVeh_Domi;
				};
			};
		};

		case "veh_Albanians" :
		{
			switch (call DK_MIS_fnc_ArmedVehicleChoiceAlban_TakeCar_01) do
			{
				case 1 :
				{
					_tg_TakeCar = [false, "HMG"] call DK_MIS_fnc_crtVeh_AlbanGun;
				};
				case 2 :
				{
					_tg_TakeCar = [false, "AT"] call DK_MIS_fnc_crtVeh_AlbanGun;
				};
				case 3 :
				{
					_tg_TakeCar = [false] call DK_MIS_fnc_crtVeh_Alban;
				};
			};
		};
	};

	// Protect Vehicles
	_tg_TakeCar allowDamage false;
	_tg_TakeCar enableSimulationGlobal false;

	uiSleep 0.15;

	// Create units --
	private _logic = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
	_logic setPos [0,0,40];

	private _grp01 = createGroup _inSide;
	private _grp02 = createGroup _inSide;

	private _allGrps = [_grp01, _grp02];

	private "_scd_unit04";
	_scd_unit01 = crtU(_grp01,_className);
	_scd_unit02 = crtU(_grp01,_className);
	uiSleep 0.1;
	_scd_unit03 = crtU(_grp01,_className);

	private _allUnits = [_scd_unit01, _scd_unit02, _scd_unit03];

	if (selectRandom [true,false]) then
	{
		_scd_unit04 = crtU(_grp01,_className);
		_allUnits pushBackUnique _scd_unit04;
	};


	// Form group (move one driver unit to grp1 at grp2)
	_unit = selectRandom (units _grp01);
	[_unit] join _grp02;

	// Protect Units & set variable
	private "_nil";
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
		_x call DK_MIS_addEH_secondDead;
		_nil = _x call DK_MIS_TakeCar_01_addEH_killed;
		_x setCaptive true;

		_x hideObjectGlobal true;

		uiSleep 0.05;

	} count _allUnits;

	uiSleep 0.15;	// Sleep for performance

	// Setup Groups & added car
	private _vehicles = [_tg_TakeCar];
	_allGrps apply
	{
		_x deleteGroupWhenEmpty true;
		_x setFormation "DIAMOND";
		_x setVariable ["allVehicles", _vehicles];
	};

	private ["_leader","_unitsGrp","_passager","_nil","_grpTemp"];


	// Added Stuff
	[_allUnits, _uniform, _weapons, _vest] call DK_MIS_fnc_slctUnitsLO;

///	END // Create & manage entities to pre-initialize mission


	// Find place
	private _startingPos = call DK_MIS_fnc_slctSafePlace_02;

	((nearestObjects [_startingPos # 1, ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"], 3,true]) # 0) setDamage 0;

	_dir = _startingPos # 2;

	// Move Target Car
	_tg_TakeCar setDir (_dir + selectRandom [-90,90]);
	_tg_TakeCar setPos (_startingPos # 1);

	// Move units
	_allUnits apply
	{
		detach _x;
	};

	uiSleep 0.08;
	_scd_unit01 setPos (_startingPos # 3);
	_scd_unit01 setDir (_dir - 180);
	uiSleep 0.08;
	_scd_unit02 setPos (_startingPos # 4);
	_scd_unit02 setDir _dir;
	uiSleep 0.08;
	_scd_unit03 setPos (_startingPos # 6);
	_scd_unit03 setDir (_dir + 90);
	if !(isNil "_scd_unit04") then
	{
		uiSleep 0.08;
		_scd_unit04 setPos (_startingPos # 5);
		_scd_unit04 setDir (_dir - 90);
	};

	deleteVehicle _logic;

	// Set reward level
	_tg_TakeCar setVariable ["rewardLvl", _rewardLvl];

	// Added varied Trigger for start AI units
	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["MIS_center", _tg_TakeCar];
		_x call DK_MIS_TakeCar_01_unitsAddEH_trgAI;
		_x call DK_MIS_EH_handleAmmoNweapons;
	
		if ( (_canSitting) && { (selectRandom [true,false]) } ) then
		{
			_x setVariable ["DK_behaviour", "sit"];
		};
	};

	_tg_TakeCar setVariable ["DK_isObjectif", true, true];
	_tg_TakeCar setVariable ["targetsMission", _allUnits];
	_tg_TakeCar call DK_MIS_TakeCar_01_vehAddEH_trgAI;
	_tg_TakeCar call DK_MIS_TakeCar_addEH_targetsDestroyed;
	[_tg_TakeCar, _idMission] spawn DK_MIS_fnc_breakEngine;

	// Define variables related to the mission (Only Server)
	DK_MIS_var_AiIsBlocked = true;
	DK_MIS_var_PlayersAreNotSeen = true;
	DK_MIS_var_behaviour = _behaviour;
	DK_MIS_var_speedUnits = _speed;
	DK_MIS_var_missInProg = true;
	DK_MIS_playerRewardsMarkersList = [];
	DK_MIS_allTargets = [_tg_TakeCar];

	// Define variables related to the mission (Clients & Server)
	DK_MIS_TakeCarIsSafe = false;
	publicVariable "DK_MIS_TakeCarIsSafe";

	uiSleep 2;

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

				_x playMoveNow "AmovPercMstpSnonWnonDnon";
			};

			uiSleep 0.02;

		} count _this;

		uiSleep 1;

		{
			_x allowDamage true;

		} count _this;
	};


	// Add EH to units for Hud player & Ending mission
	_allUnits apply
	{
		_x hideObjectGlobal false;
	};

	_tg_TakeCar enableSimulationGlobal true;
	_tg_TakeCar allowDamage true;

	_tg_TakeCar call DK_MIS_TakeCar_initVeh;

//// /// MISSION IS FULL INIT /////

		// DEBUG
/*		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, _startingPos # 1];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [50, 50];
*/		// DEBUG


	[_allGrps, _allUnits, _tg_TakeCar]
};


DK_MIS_TakeCar_01_finished = {

	params ["_allGrps", "_allUnits", "_tg_TakeCar"];


	private _allUnits = +_allUnits;
	private _allGrps = +_allGrps;
	private _time = time + DK_MIS_maxTimeMission;


/*	[_tg_TakeCar, _this # 3] spawn
	{
		params ["_tg_TakeCar", "_rescuePlace"];
		uiSleep 6;
//		player setpos (_tg_TakeCar modelToWorldVisual [0,10, 1]);
		uiSleep 1;
		player moveInDriver _tg_TakeCar;
		uiSleep 2;
		_tg_TakeCar setposatl _rescuePlace;
	};
*/

	waitUntil { uiSleep 0.3; !(DK_MIS_var_missInProg) OR (time > _time) OR (fuel _tg_TakeCar isEqualTo 0) };

	// Ending the game if counter is down
	if ((call BIS_fnc_missionTimeLeft) isEqualTo 0) exitWith
	{
		call DK_fnc_endSelectWinner;
	};

	// Delete info for local player from JIP
	remoteExecCall ["", DK_MIS_IdJIP_initCL];
	if (!isNil "DK_MIS_IdJIP_rfrNfoCL") then
	{
		remoteExecCall ["", DK_MIS_IdJIP_rfrNfoCL];
	};

	// Variable to be sure that Ending mission
	DK_MIS_var_missInProg = false;

	// Add Rewards to Clean Up or delete if mission fail
	if (!isNull _tg_TakeCar) then
	{
		if (alive _tg_TakeCar) then
		{
			_tg_TakeCar call DK_MIS_fnc_vehicle_removeAllEH;
		};

		_tg_TakeCar setVariable ["DK_isObjectif", nil, true];
		attachedObjects _tg_TakeCar apply
		{
			deleteVehicle _x;
		};
	};

	if ( (alive _tg_TakeCar) && { (!isNil "DK_MIS_TakeCarIsSafe") && { !(DK_MIS_TakeCarIsSafe) } } ) then
	{
		// Mission FAIL
		_tg_TakeCar call DK_MIS_reInitVehNormal;
		_tg_TakeCar call DK_MIS_fnc_initVehWhenEnd;
		[_tg_TakeCar, DK_MIS_timeDelVeh, DK_MIS_disDelVeh, true] spawn DK_fnc_addVehTo_CUM;
	};

	// Add UNITS to Clean Up
	{

		if !(isNull _x) then
		{
			call
			{
				if (DK_MIS_var_AiIsBlocked) exitWith
				{
					deleteVehicle _x;
				};

				if (alive _x) exitWith
				{
					[_x, DK_MIS_timeDelScdrU, DK_MIS_disDelScdrU, true] spawn DK_fnc_addAllTo_CUM;
				};

				[_x, 0, DK_MIS_disDelCorps, true] spawn DK_fnc_addAllTo_CUM;
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

	missionNamespace setVariable [("DK_TC_veh_" + (str DK_idMission)), nil];

	// Start ending for players !
	DK_idMission = "0";
	publicVariable "DK_idMission";

	// Waiting all loop are finished & Delete variable
	uiSleep 3;
	waitUntil { uiSleep 0.3; DK_MIS_loopsInProgress isEqualTo 0; };

	DK_MIS_var_AiIsBlocked = nil;
	DK_MIS_var_PlayersAreNotSeen = nil;
	DK_MIS_var_behaviour = nil;
	DK_MIS_var_speedUnits = nil;
	DK_cntdwnTime = 0;
	DK_MIS_playerRewardsMarkersList = nil;
	DK_MIS_allTargets = [];
	DK_MIS_IdJIP_rfrNfoCL = nil;
	DK_MIS_missionType = "";

	DK_MIS_TakeCarIsSafe = nil;
	publicVariable "DK_MIS_TakeCarIsSafe";

	private _nil = [] spawn DK_fnc_manageWantedLvlPlyEndMiss;

	uiSleep 1;

	// Start next mission
	call DK_MIS_fnc_slctDifficultyLevel;

};


// Varied Trigger for start AI
DK_MIS_TakeCar_01_unitsAddEH_trgAI = {


	_this addEventHandler ["FiredNear",
	{
		_this append [DK_MIS_TC01_triggerAI];
		_this call DK_MIS_fnc_EhFiredNear_trgAI;
	}];

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_TC01_triggerAI, nil, nil, _thisEventHandler];
		_this call DK_MIS_fnc_EhHit_trgAI;
	}];

	private _idEhKilled = _this addEventHandler ["Killed",
	{
		_this append [DK_MIS_TC01_triggerAI];
		_this call DK_MIS_fnc_EhKilled_trgAI;
	}];

	_this setVariable ["idEhHitTrgAI", _idEhHit];
	_this setVariable ["idEhKilledTrgAI", _idEhKilled];
};

DK_MIS_TakeCar_01_vehAddEH_trgAI = {

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_TC01_triggerAI];
		_this call DK_MIS_fnc_EhHitNear_trgAI_Veh;
	}];


	_this setVariable ["idEhHitTrgAI", _idEhHit];
};


// Trigger Script for start AI
DK_MIS_TC01_triggerAI = {

	params ["_allUnits"];


	DK_MIS_var_PlayersAreNotSeen = false;

	private ["_nil", "_nbRfr", "_grp"];

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
	{
		if (alive _x) then
		{
			_x enableAI "ANIM";
			_x enableAI "MOVE";
			_x enableAI "TARGET";
			_x enableAI "AUTOTARGET";
			_nil = [_x, 360, 500, true] spawn DK_fnc_addAllTo_CUM;
			_x setCaptive false;

			uiSleep (random 0.3);
		};

	} count _allUnits;

	// Activate vehicle simulation
	{
		_x enableDynamicSimulation false;

	} count _vehicles;

	// Move units if they have a linked Vehicle
	{
		_grp = _x;

		if (units _grp findIf { alive _x } isEqualTo -1) exitWith {};

		_grp setCombatMode "RED";
		_grp setBehaviour DK_MIS_var_behaviour;
		[_grp] spawn DK_MIS_fnc_stayCloseArea;
		_grp setSpeedMode DK_MIS_var_speedUnits;

		// Start Voice if order forces
		_nil = _grp spawn DK_fnc_selectLoopVoice;

		uiSleep 0.3;

	} count _allGrps;


	// Start wanted level
	call
	{
		private _side = (leader (_allGrps # 0)) getVariable ["DK_side", ""];
		if (_side isEqualTo "cops") exitWith
		{
			missionNamespace setVariable ["wantedMissionVal", 1];
			missionNamespace setVariable ["wantedMissionLvl_cl", 1, true];
		};

		if (_side isEqualTo "fbi") exitWith
		{
			missionNamespace setVariable ["wantedMissionVal", 8];
			missionNamespace setVariable ["wantedMissionLvl_cl", 2, true];
		};

		if (_side isEqualTo "army") then
		{
			missionNamespace setVariable ["wantedMissionVal", 19];
			missionNamespace setVariable ["wantedMissionLvl_cl", 3, true];
		};
	};


	private _tg_TakeCar = missionNamespace getVariable [("DK_TC_veh_" + (str DK_idMission)), ""];
	if ( (_tg_TakeCar isEqualTo "") && { !(_vehicles isEqualTo []) } ) then
	{
		_tg_TakeCar = _vehicles # 0;
	};

	if ((isNil "_tg_TakeCar") OR (_tg_TakeCar isEqualTo "")) exitWith
	{
		DK_MIS_var_missInProg = false;
	};

	uiSleep (1 + (random 4));


	// Start Reinforcement !
	private _nbPlayerMaxInTeam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;


	call
	{
		if ((_tg_TakeCar getVariable ["MIS_nfo", ["","",""]]) # 2 in ["Police forces", "FIB agents", "Military"]) exitWith
		{
			call
			{
				if (_nbPlayerMaxInTeam < 3) exitWith
				{
					_nbRfr = 1;
				};

				if (_nbPlayerMaxInTeam > 6) exitWith
				{
//					_nbRfr = 3;
					_nbRfr = 2;
				};

				_nbRfr = 2;
			};


			[_tg_TakeCar, 20, 60] spawn DK_fnc_init_rfr_heli;

			uiSleep 1;
			[_tg_TakeCar, (_tg_TakeCar getVariable "MIS_nfo") # 6] spawn DK_MIS_loop_checkForSubstractPointsToWantedLvl
		};

		if (_nbPlayerMaxInTeam isEqualTo 1) exitWith
		{
			_nbRfr = 1;
		};

		if (_nbPlayerMaxInTeam > 4) exitWith
		{
			_nbRfr = 3;
		};

		_nbRfr = 2;
	};

	_nbRfr = _nbRfr + ("Par_numbersRfr" call BIS_fnc_getParamValue);

	if (_nbRfr < 1) then
	{
		_nbRfr = 1;
	};

	for "_i" from 1 to _nbRfr step 1 do
	{
		[_tg_TakeCar, 15 + (random 45)] spawn DK_fnc_init_rfr;

		uiSleep 1;
	};


	uiSleep 0.5;

	// Start HUD reinforcement for Players
	DK_MIS_IdJIP_rfrNfoCL = [((_tg_TakeCar getVariable "MIS_nfo") # 2), _tg_TakeCar, ((_tg_TakeCar getVariable "MIS_nfo") # 6)] remoteExecCall ["DK_MIS_fnc_HUD_RfrCalled_rfr_cl", DK_isDedi, true];
};

//
DK_MIS_TakeCar_01_getRescuePlace = {

	private "_rescuePlace";

	private _rescuePlacesArray = +DK_rescuePlace01;
	_rescuePlacesArray call KK_fnc_arrayShuffle;

	private _idx = _rescuePlacesArray findIf { (_this distance (_x # 2) < 4000) && {(_this distance (_x # 2) > 2500)} };

	if (_idx isEqualTo -1) then
	{
		_idx = _rescuePlacesArray findIf { (_this distance (_x # 2) < 5500) && {(_this distance (_x # 2) > 2500)} };

		if (_idx isEqualTo -1) then
		{
			_idx = _rescuePlacesArray findIf { (_this distance (_x # 2) < 7000) && {(_this distance (_x # 2) > 2500)} };

			if (_idx isEqualTo -1) then
			{
				_idx = _rescuePlacesArray findIf { (_this distance (_x # 2) > 2500) };

				if (_idx isEqualTo -1) then
				{
					_rescuePlace = selectRandom _rescuePlacesArray;
				};
			};
		};
	};

	if (isNil "_rescuePlace") then
	{
		_rescuePlace = _rescuePlacesArray # _idx;
	};

	private _nul = DK_rescuePlace01 deleteAt (DK_rescuePlace01 find _rescuePlace);

	if (count DK_rescuePlace01 < DK_minimRescue01) then
	{
		DK_rescuePlace01 = +rescuePlace01;
		_nul = DK_rescuePlace01 deleteAt (DK_rescuePlace01 find _rescuePlace);
	};


	_rescuePlace
};

DK_MIS_TakeCar_01_loopRescue = {

	params ["_rescuePlace", "_tg_TakeCar", "_idMission"];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	private _center = _rescuePlace # 2;
	private _rescuePos = [_rescuePlace # 0, _rescuePlace # 1];

	while { (DK_MIS_var_missInProg) && { (!isNull _tg_TakeCar) && { (alive _tg_TakeCar) && { (_idMission isEqualTo DK_idMission) } } } } do
	{
		while { (DK_MIS_var_missInProg) && { (!isNull _tg_TakeCar) && { (alive _tg_TakeCar) && { (_idMission isEqualTo DK_idMission) } } } } do
		{
			uiSleep 5;

			if (_tg_TakeCar distance2D _center <= 160) exitWith {};
		};

		waitUntil { uiSleep 0.3; ( !(_rescuePos findIf {_tg_TakeCar distance2D _x < 4.2} isEqualTo -1) && { (speed _tg_TakeCar < 8) && { (alive driver _tg_TakeCar) } } ) OR (_tg_TakeCar distance2D _center > 160) OR !(DK_MIS_var_missInProg) };

		if ((DK_MIS_var_missInProg) && { !(_rescuePos findIf {_tg_TakeCar distance2D _x < 4.2} isEqualTo -1) && { (speed _tg_TakeCar < 8) && { (alive driver _tg_TakeCar) } } } ) exitWith
		{
			[_tg_TakeCar, _center] call DK_MIS_TakeCar_01_carIsRescue;
		};
	};


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;
};

DK_MIS_TakeCar_01_carIsRescue = {

	params ["_tg_TakeCar", "_rescuePlace"];


	[_tg_TakeCar, false] remoteExecCall ["DK_fnc_allowDmg", _tg_TakeCar];
	DK_MIS_TakeCarIsSafe = true;
	publicVariable "DK_MIS_TakeCarIsSafe";

	private _rewardLvl = _tg_TakeCar getVariable "rewardLvl";
	private _driver = driver _tg_TakeCar;

	[_tg_TakeCar, "LOCKED"] remoteExecCall ["DK_fnc_setVehLock", _tg_TakeCar];
	[_tg_TakeCar, 0] remoteExecCall ["DK_fnc_setFuel", _tg_TakeCar];
	_driver action ["lightOff", _tg_TakeCar];

	private "_nil";
	{
		if (alive _x) then
		{
			_nil = DK_MIS_playerRewardsMarkersList pushBackUnique _x;
			moveOut _x;
		};

	} count crew _tg_TakeCar;

	[_driver, _tg_TakeCar getVariable ["DK_score", 123]] call DK_fnc_addScr;

//	private _rwdrs = [nil, _center, _rewardLvl, nil, false] call DK_MIS_fnc_crtRwrdWthTabl;
	private _rwdrs = [_center, _rewardLvl] call DK_MIS_fnc_crtRwrd;
	_rwdrs spawn DK_MIS_fnc_deleteReward;

	if !(DK_MIS_playerRewardsMarkersList isEqualTo []) then
	{
		(_rwdrs # 0) remoteExecCall ["DK_MIS_fnc_rewards3dIcone_cl", DK_MIS_playerRewardsMarkersList];
	};

	// Disable Take Car & Add to Clean Up
	[_tg_TakeCar, DK_MIS_timeDelRescueVeh, DK_MIS_disDelRescueVeh, true] spawn DK_fnc_addVehTo_CUM;
	_tg_TakeCar enableDynamicSimulation true;

///	// Mission ending
	DK_MIS_var_missInProg = false;
};

DK_MIS_TakeCar_01_addScrAccordDisTraveled = {

	params ["_rescuePlace", "_tg_TakeCar", "_idMission"];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	private ["_driver", "_startDis"];
	private _goalDis = (_tg_TakeCar distance2D _rescuePlace) + 100;

	while { (DK_MIS_var_missInProg) && { (!isNull _tg_TakeCar) && { (alive _tg_TakeCar) && { (_idMission isEqualTo DK_idMission) } } } } do
	{
		waitUntil { uiSleep 0.2; (!alive _tg_TakeCar) OR (!isNull (driver _tg_TakeCar)) OR !(DK_MIS_var_missInProg) OR !(_idMission isEqualTo DK_idMission) };

		_driver = driver _tg_TakeCar;
		_startDis = _tg_TakeCar distance2D _rescuePlace;

		if (_tg_TakeCar distance2D _rescuePlace <= _goalDis) then
		{
			_goalDis = _startDis - 99.5;
		};

		waitUntil { uiSleep 0.2; (!alive _tg_TakeCar) OR ((_tg_TakeCar distance2D _rescuePlace) < _goalDis) OR !((_tg_TakeCar getVariable ["driverChange", objNull]) isEqualTo _driver) OR !(DK_MIS_var_missInProg) OR !(_idMission isEqualTo DK_idMission) };

		call
		{
			if ( !((_tg_TakeCar getVariable ["driverChange", objNull]) isEqualTo _driver) OR !(DK_MIS_var_missInProg) OR (isNull _tg_TakeCar) OR !(alive _tg_TakeCar) OR !(_idMission isEqualTo DK_idMission) ) exitWith {};

			if (_tg_TakeCar distance2D _rescuePlace < _goalDis) then
			{
				[driver _tg_TakeCar, DK_scrDisTC] call DK_fnc_addScr;
			};
		};
	};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;
};

DK_MIS_TakeCar_01_hideObjectAtShedSmall = {

	private "_objsHiden";

	{
		if ((_x # 3) isEqualTo "shedSmall") then
		{
			_objsHiden = (nearestObjects [_x # 0, [], 4.6]) + (nearestObjects [_x # 1, [], 4.6]) - (nearestObjects [_x # 2, ["Land_Shed_Small_F"], 5]);
			if !(_objsHiden isEqualTo []) then
			{
				_objsHiden apply
				{
					_x hideObjectGlobal true;
				};
			};
		};

	} forEach DK_rescuePlace01;

};

DK_MIS_TakeCar_01_addEH_killed = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		[_unit, DK_MIS_timeDelScdrU, DK_MIS_disDelScdrU, true] spawn DK_fnc_addAllTo_CUM;
	}];
};







