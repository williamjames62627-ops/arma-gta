if !(isServer) exitWith {};


#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]


DK_MIS_Kill_02_create = {

	DK_MIS_loopsInProgress = 0;

	// Set Mission Type
	DK_MIS_missionType = "Kill";

	// Get Difficulty depending on number of missions completed (Ennemies Stuff, Weapons, Reward loot) (server)
	private _difficulties = call DK_MIS_fnc_slctDifficulty_K02;

	_difficulties params ["_vehClass","_nbUnits","_className","_uniform","_weapons","_vest","_disSeen","_behaviour","_speed","_rewardLvl", "_classGuy"];


	// Define ID mission (server)
	private _idMission = call DK_MIS_create_ID_mission;
	if (isNil "_idMission") then
	{
		_idMission = "error" + (str time);
	};
	DK_idMission = _idMission;
	publicVariable "DK_idMission";


	// Init mission (server)
	_result = _difficulties call DK_MIS_Kill_02_init;

	_result params ["_allGrps", "_allUnits", "_vehicles"];


	// Start Ai driving acrosse the map
	DK_MIS_arr_manageSafeWp = [];
	[_allGrps # 0, 1000] spawn DK_MIS_fnc_wpDriver;
	_idMission spawn DK_MIS_loop_manageSafeDriver;

	uiSleep 3;

	// Create various Trigger AI (server)
	[_allUnits, _disSeen, DK_MIS_K02_triggerAI] spawn DK_MIS_Kill_addIsSeen;


	// Start cooldown mission
	_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission;


	// Start Mission for players ! (local)
	_insult = call DK_MIS_slctInsult;
	_victorySnd = call DK_MIS_slctVictorySnd;
	DK_MIS_IdJIP_initCL = [_idMission, _allUnits, _insult, _classGuy, _victorySnd] remoteExecCall ["DK_MIS_fnc_K01_initClient_cl", DK_isDedi, true];

	// Create markers targets
	[_allUnits, _idMission] spawn DK_MIS_Kill_mkrTargets;


	/// DEBUG
/*	_allUnits spawn
	{
		uiSleep 7;
		DK_MIS_var_missInProg = false;
		_this apply
		{
			_x setDamage 1;
		};
	};
	/// DEBUG
*/

	// Handle & Waiting Ending (server)
	_result call DK_MIS_Kill_02_finished;
};

DK_MIS_Kill_02_init = {

	params ["_vehClass", "_nbUnits", "_className", "_uniform", "_weapons", "_vest", "", "_behaviour", "_speed", "_rewardLvl", "_ennemiesType"];


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
	private ["_veh01", "_veh02", "_veh03", "_grp01","_grp02", "_grp03", "_nil", "_dir", "_grpTemp", "_bbr", "_p1", "_p2", "_maxLength", "_unitsGrp01", "_unitsGrp02", "_unitsGrp03"];

	// Create Vehicles --
	private _vehicles = [];
	switch ( _vehClass ) do
	{
		case "veh_cls" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_cls;
			uiSleep 0.1;
			_veh02 = [] call DK_MIS_fnc_crtVeh_cls;
			_vehicles pushBackUnique _veh01;
			_vehicles pushBackUnique _veh02;
		};

		case "veh_looter" :
		{
			call
			{
				if (_nbUnits < 7) exitWith
				{
					_veh01 = [] call DK_MIS_fnc_crtQuad_looters;
					uiSleep 0.1;
					_veh02 = [] call DK_MIS_fnc_crtQuad_looters;
					_vehicles pushBackUnique _veh01;
					_vehicles pushBackUnique _veh02;
					if (_nbUnits isEqualTo 6) then
					{
						_veh03 = [] call DK_MIS_fnc_crtQuad_looters;
						_vehicles pushBackUnique _veh03;
					};
				};

				_veh01 = [] call DK_MIS_fnc_crtVan_looters;
				uiSleep 0.1;
				_veh02 = [] call DK_MIS_fnc_crtVan_looters;
				_vehicles pushBackUnique _veh01;
				_vehicles pushBackUnique _veh02;
			};
		};

		case "veh_sportOffroad" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
			uiSleep 0.1;
			_veh02 = [] call DK_MIS_fnc_crtVeh_sprtOffrd;
			_vehicles pushBackUnique _veh01;
			_vehicles pushBackUnique _veh02;
		};

		case "veh_Ballas" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_Ballas;
			uiSleep 0.1;
			_veh02 = [] call DK_MIS_fnc_crtVeh_Ballas;
			_vehicles pushBackUnique _veh01;
			_vehicles pushBackUnique _veh02;

			// Added MP3 Players
			[(selectRandom [_veh01, _veh02]), true, [["MP3music02", 18.125], ["MP3music03", 14.793], ["MP3music04", 24], ["MP3music07", 40.435], ["MP3music05", 8]]] spawn DK_fnc_MP3car_init;
		};

		case "veh_Triads" :
		{
			_veh01 = [] call DK_MIS_fnc_crtVeh_Triads;
			uiSleep 0.1;
			_veh02 = [] call DK_MIS_fnc_crtVeh_Triads;
			_vehicles pushBackUnique _veh01;
			_vehicles pushBackUnique _veh02;

			// Added MP3 Players
			[(selectRandom [_veh01, _veh02]), true, [["MP3music01", 32], ["MP3music06", 35.559], ["MP3music08", 23.001]]] spawn DK_fnc_MP3car_init;
		};

		case "veh_Dominicans" :
		{
			_veh01 = [true, "LMG"] call DK_MIS_fnc_crtVeh_DomiGun;
			uiSleep 0.1;
			_veh02 = [true, "AT"] call DK_MIS_fnc_crtVeh_DomiGun;
			_vehicles pushBackUnique _veh01;
			_vehicles pushBackUnique _veh02;
			if (_nbUnits isEqualTo 8) then
			{
				_veh03 = [] call DK_MIS_fnc_crtVeh_Domi;
				_vehicles pushBackUnique _veh03;
			};
		};

		case "veh_Albanians" :
		{
			_veh01 = [true, "HMG"] call DK_MIS_fnc_crtVeh_AlbanGun;
			uiSleep 0.1;
			_veh02 = [true, "AT"] call DK_MIS_fnc_crtVeh_AlbanGun;
			_vehicles pushBackUnique _veh01;
			_vehicles pushBackUnique _veh02;
			if (_nbUnits isEqualTo 8) then
			{
				_veh03 = [] call DK_MIS_fnc_crtVeh_Alban;
				_vehicles pushBackUnique _veh03;
			};
		};
	};

	// Protect Vehicles
	{
		_x allowDamage false;
//		_x setUnloadInCombat [FALSE,FALSE]; 
		_x engineOn true;
		_x enableSimulationGlobal false;

	} count _vehicles;

	uiSleep 0.15;

	// Create units --
	private _allGrps = [];
	_grp01 = createGroup _inSide;
	_grp02 = createGroup _inSide;
	_allGrps pushBackUnique _grp01;
	_allGrps pushBackUnique _grp02;
	if (!isNil "_veh03") then
	{
		_grp03 = createGroup _inSide;
		_allGrps pushBackUnique _grp03;
	};


	private _allUnits = [];
	call
	{
		if (_nbUnits isEqualTo 4) exitWith
		{
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp02,_className));
				uiSleep 0.02;
			};
		};

		if ( (_ennemiesType isEqualTo "Looters") && { (_nbUnits isEqualTo 6) } ) exitWith
		{
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp02,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp03,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 6) exitWith
		{
			for "_i" from 1 to 3 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 3 do
			{
				_allUnits pushBackUnique (crtU(_grp02,_className));
				uiSleep 0.02;
			};
		};

		if ( (_ennemiesType in ["Dominicans", "Albanians"]) && { (_nbUnits isEqualTo 8) } ) exitWith
		{
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 2 do
			{
				_allUnits pushBackUnique (crtU(_grp02,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 4 do
			{
				_allUnits pushBackUnique (crtU(_grp03,_className));
				uiSleep 0.02;
			};
		};

		if (_nbUnits isEqualTo 8) exitWith
		{
			for "_i" from 1 to 4 do
			{
				_allUnits pushBackUnique (crtU(_grp01,_className));
				uiSleep 0.02;
			};
			for "_i" from 1 to 4 do
			{
				_allUnits pushBackUnique (crtU(_grp02,_className));
				uiSleep 0.02;
			};
		};
	};

	// Protect Units & set variable
	{
		_x allowDamage false;
		_x disableAI "MOVE";
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x setVariable ["allGroups", _allGrps];
		_nil = _x call DK_MIS_Kill_02_addEH_getInOut;
		_nil = _x call DK_MIS_addEH_HandleDmg;
		_nil = DK_unitsStayUp pushBackUnique _x;
		_x hideObjectGlobal true;
		_x setCaptive true;

		uiSleep 0.03;

	} count _allUnits;

	// Define variables related to the mission (Only Server)
	DK_MIS_var_AiIsBlocked = true;
	DK_MIS_var_PlayersAreNotSeen = true;
	DK_MIS_var_missInProg = true;

	// Setup Groups & added car
	_allGrps apply
	{
		_x deleteGroupWhenEmpty true;
		_x setFormation "DIAMOND";
		_x setVariable ["allVehicles", _vehicles];
	};

	call
	{
		if !(_ennemiesType in ["Looters", "Dominicans", "Albanians"]) exitWith
		{
			{
				_grpTemp = _x;

				if (_grpTemp isEqualTo _grp01) then
				{
					_grpTemp addVehicle _veh01;
					_grpTemp setVariable ["assignedVeh", _veh01];
					{
						_nil = _x moveInAny _veh01;

					} forEach (units _grpTemp);
				};

				if (_grpTemp isEqualTo _grp02) then
				{
					_grpTemp addVehicle _veh02;
					_grpTemp setVariable ["assignedVeh", _veh02];
					{
						_nil = _x moveInAny _veh02;

					} forEach (units _grpTemp);

//					_stalk = [_grp02, _grp01, 5, 8, { !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg OR !(_unitsGrp01 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp02 findIf { !alive _x } isEqualTo -1) }, 0] spawn BIS_fnc_stalk;
					_nil = [_grp02, _grp01, _veh02, _veh01, 1] spawn DK_fnc_convoy;
				};

			} count _allGrps;
		};

		{
			_grpTemp = _x;

			if (_grpTemp isEqualTo _grp01) then
			{
				_grpTemp addVehicle _veh01;
				_grpTemp setVariable ["assignedVeh", _veh01];
				{
					_nil = _x moveInAny _veh01;

				} forEach (units _grpTemp);
			};

			if (_grpTemp isEqualTo _grp02) then
			{
				_grpTemp addVehicle _veh02;
				_grpTemp setVariable ["assignedVeh", _veh02];
				{
					_nil = _x moveInAny _veh02;

				} forEach (units _grpTemp);

				call
				{
					if (!isNil "_veh03") exitWith
					{
//						_stalk = [_grp02, _grp01, 5, 8, { !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg OR !(_unitsGrp01 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp02 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp03 findIf { !alive _x } isEqualTo -1) }, 0] spawn BIS_fnc_stalk;
						_nil = [_grp02, _grp01, _veh02, _veh01, 1] spawn DK_fnc_convoy;
					};

//					_stalk = [_grp02, _grp01, 5, 8, { !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg OR !(_unitsGrp01 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp02 findIf { !alive _x } isEqualTo -1) }, 0] spawn BIS_fnc_stalk;
					_nil = [_grp02, _grp01, _veh02, _veh01, 1] spawn DK_fnc_convoy;
				};
			};

			if ( (!isNil "_grp03") && { (_grpTemp isEqualTo _grp03) } ) then
			{
				_grpTemp addVehicle _veh03;
				_grpTemp setVariable ["assignedVeh", _veh03];
				{
					_nil = _x moveInAny _veh03;

				} forEach (units _grpTemp);

//				_stalk = [_grp03, _grp02, 5, 8, { !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg OR !(_unitsGrp01 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp02 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp03 findIf { !alive _x } isEqualTo -1) }, 0] spawn BIS_fnc_stalk;
				_nil = [_grp03, _grp02, _veh03, _veh02, 1] spawn DK_fnc_convoy;
			};

		} count _allGrps;
	};

	uiSleep 0.1;	// Sleep for performance

///	END // Create & manage entities to pre-initialize mission


	// Added Stuff
	private _waitLO = [_allUnits, _uniform, _weapons, _vest] spawn DK_MIS_fnc_slctUnitsLO;

	// Find place
	private _startingPosArray = call DK_MIS_fnc_slctSafePlace_03;
	private _startingPos = _startingPosArray # 0;

	// Move units
	private _cntAr = count _startingPosArray;
	call
	{
		if (_cntAr isEqualTo 1) exitWith
		{
			_dir = random 360;
		};

		_dir = (_startingPosArray # (round (random (_cntAr - 1)))) # 1;
	};
	{
		_x setDir _dir;

	} count _vehicles;

	_veh01 setPosATL (_startingPos getpos [3, _dir]);
	_veh01 forceFollowRoad true;
	_veh01 setVariable ["isForceRoad", true];
	private _vehsTmps = +_vehicles;
	_vehsTmps deleteAt (_vehsTmps find _veh01);
	private _nbVeh = (count _vehicles) - 1;
	private _dirR = _dir - 180;
	for "_i" from 0 to _nbVeh do
	{
		_vehTemp = _vehicles # _i;
		_bbr = boundingBoxReal _vehTemp;
		_p1 = _bbr # 0;
		_p2 = _bbr # 1;
		_maxLength = (abs ((_p2 # 1) - (_p1 # 1))) + 1;

		(_vehsTmps # _i) setPosATL (_vehTemp getPos [_maxLength, _dirR]);
	};

	call
	{
		if !((DK_CLAG_Traffic_mkr_mainRoads findIf {_veh01 inArea _x}) isEqualTo -1) exitWith
		{
			_veh01 limitSpeed 110;
		};

		if !((DK_CLAG_mkr_citySideWalk findIf {_veh01 inArea _x}) isEqualTo -1) exitWith
		{
			_veh01 limitSpeed 45;
		};

		_veh01 limitSpeed 60;
	};


	waitUntil { uiSleep 0.1; scriptDone _waitLO };


	// Create & Move Reward stuff crate
	{
		_nil = [_x, _rewardLvl] call DK_MIS_fnc_createRewardInVeh;

	} count _vehicles;


	// Added varied Trigger for start AI units
	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["MIS_center", _startingPos];
		_x call DK_MIS_Kill_02_unitsAddEH_trgAI;
		_x call DK_MIS_EH_handleAmmoNweapons;
		_x call DK_MIS_Kill_addEH_targetsDead;
		_x setVariable ["DK_behaviour", "drive"];

		uiSleep 0.05;
	};

	{
		_x enableSimulationGlobal true;
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["allVehicles", _vehicles];
		_nil = _x call DK_MIS_Kill_02_vehAddEH_trgAI;
		_nil = _x call DK_MIS_fnc_noDmgSafeDriver;
//		_nil = _x call DK_fnc_EH_dynSim;

		_x allowDamage true;

		uiSleep 0.05;

	} count _vehicles;

	// Define variables related to the mission (Only Server)
	DK_MIS_var_behaviour = _behaviour;
	DK_MIS_var_speedUnits = _speed;
	DK_MIS_playerRewardsMarkersList = [];
	DK_MIS_allTargets = _allUnits;

	// Define variables related to the mission (Clients & Server)
	DK_nbTargets_Goal = _nbUnits;
	publicVariable "DK_nbTargets_Goal";

	DK_nbTargets_Cnt = 0;
	publicVariable "DK_nbTargets_Cnt";


///	// Tweaking before starting mission for mafioso
	{
		_x enableSimulationGlobal true;
		_x hideObjectGlobal false;
		_x enableAI "MOVE";
		_x allowDamage true;
		_nil = _x call DK_MIS_Kill_01_addEH_AiInVEH_react;

	} count _allUnits;


//// /// MISSION IS FULL INIT /////

		// DEBUG
/*		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, _startingPos];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [60, 60];
		private _arrow = createVehicle ["Sign_Arrow_Large_Pink_F", _startingPos, [], 0, "CAN_COLLIDE"];
*/		// DEBUG


	[_allGrps, _allUnits, _vehicles]
};

DK_MIS_Kill_02_finished = {

	params ["_allGrps", "_allUnits", "_vehicles", "_props", "_propsLinkToAI"];


	private "_nil";
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

	// Add Rewards to Clean Up or delete if mission fail
	if !(DK_MIS_playerRewardsMarkersList isEqualTo []) then
	{
		{
			if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
			{
				_nil = _x remoteExecCall ["DK_MIS_fnc_rewards3dIcone_cl", DK_MIS_playerRewardsMarkersList];
			};
	
		} count _vehicles;
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
				_nil = [_x, DK_MIS_timeDelCorps, DK_MIS_disDelCorps, true] spawn DK_fnc_addAllTo_CUM;
			};
		};

	} count _allUnits;


	// Add VEHICLES to Clean Up
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


	// Delete group of units
	{
		if !(isNull _x) then
		{
			deleteGroup _x;
			_x = grpNull;
			_x = nil;
		};

	} count _allGrps;

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
	DK_MIS_arr_manageSafeWp = nil;


	uiSleep 1;

	// Start next mission
	call DK_MIS_fnc_slctDifficultyLevel;

};


// Varied Trigger for start AI
DK_MIS_Kill_02_unitsAddEH_trgAI = {

	_this addEventHandler ["FiredNear",
	{
		_this append [DK_MIS_K02_triggerAI];
		_this call DK_MIS_fnc_EhFiredNear_trgAI;
	}];

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K02_triggerAI, nil, nil, _thisEventHandler];
		_this call DK_MIS_fnc_EhHit_trgAI;
	}];

	private _idEhKilled = _this addEventHandler ["Killed",
	{
		_this append [DK_MIS_K02_triggerAI];
		_this call DK_MIS_fnc_EhKilled_trgAI;
	}];

	_this setVariable ["idEhHitTrgAI", _idEhHit];
	_this setVariable ["idEhKilledTrgAI", _idEhKilled];
};

DK_MIS_Kill_02_vehAddEH_trgAI = {

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K02_triggerAI];
		_this call DK_MIS_fnc_EhHitNear_trgAI_Veh;
	}];


	_this setVariable ["idEhHitTrgAI", _idEhHit];
};


// Trigger Script for start AI
DK_MIS_K02_triggerAI = {

	params ["_allUnits", "", "", "_shooter"];


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

	[_allUnits, (group (_allUnits # 0))] call DK_MIS_fnc_removeEhTrgAi;

	// Activate AI target
	_allUnits apply
	{
		if (alive _x) then
		{
			_x setVariable ["DK_behaviour", "combat"];
			_x enableAI "TARGET";
			_x enableAI "AUTOTARGET";
			_x setCaptive false;

			uiSleep (random 0.3);
		};
	};

	// Move units if they have a linked Vehicle
	private ["_grpTmp", "_vehTemp", "_idEH_HD"];
	private _nbGrps = (count _allGrps) - 1;

	_allGrps apply
	{
		_grpTmp = _x;

		call
		{
			if (units _grpTmp findIf { alive _x } isEqualTo -1) exitWith {};

			_nil = _grpTmp spawn DK_fnc_selectLoopVoice;

			_grpTmp call DK_fnc_delAllWp;
			_vehTemp = _grpTmp getVariable "assignedVeh";
			_vehTemp forceFollowRoad false;
			_vehTemp limitSpeed 200;
			_vehTemp setVariable ["inAlert", true];
			_idEH_HD = _vehTemp getVariable "idEhDmgSafe";
			if !(isNil "_idEH_HD") then
			{
				_vehTemp removeEventHandler ["HandleDamage", _idEH_HD];
				_vehTemp setVariable ["idEhDmgSafe", nil];
			};


			if ( (selectRandom [true, false, false]) OR { (uniform (_allUnits # 0) isEqualTo "U_OrestesBody") OR { (isNil "_shooter") } } ) exitWith
			{
				[_grpTmp, _vehTemp] spawn DK_MIS_Kill_02_AiInVeh_flee;
			};

			private _idMission = DK_idMission;
			[units _grpTmp, _grpTmp, _vehTemp, _shooter, _idMission, 3, nil, "RED", 20000] spawn DK_fnc_AiFollow_rfr;
		};

		uiSleep 0.3;
	};
};


//// // Custome AI : Vehicles
DK_MIS_Kill_02_addEH_getInOut = {

	_this call DK_MIS_addEH_selectSeat;

	_this addEventHandler ["GetInMan",
	{
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

			_vehicle spawn DK_MIS_Kill_02_crtTrg_AiInVeh_react;
		};

		_grp addVehicle _vehicle;
		_unitsGrp orderGetIn true;
		_unitsGrp allowGetIn true;
		_grp setVariable ["assignedVeh", _vehicle];
	}];


	_this addEventHandler ["GetOutMan",
	{
		params ["_unit", "", "_vehicle"];


		if (alive _unit) then
		{
			private _grp = group _unit;

			_grp setBehaviour (if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"AWARE"});

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

			_vehicle call DK_MIS_Kill_01_delTrg_AiInVeh_react;

			if ((!canMove _vehicle) OR !(DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1)) then
			{
				_grp call DK_fnc_delAllWp;
				_grp setVariable ["AiInVeh_WpIsDeleted", true];
				_grp setVariable ["AiInVeh_attackOnFoot", true];
			};
		};
	}];

};

DK_MIS_Kill_02_crtTrg_AiInVeh_react = {

	if !(isNil {_this getVariable "trgAiInVehReact"} ) exitWith {};


	private _trg = createTrigger ["EmptyDetector", [0,0,0], false];
	_trg setTriggerArea [26, 26, 0, false, 10];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [" this ",
	"
		if DK_MIS_var_AiIsBlocked exitWith {};

		private _vehicle = attachedTo thisTrigger;
		private _vehCrew = crew _vehicle;
		_vehicle call DK_MIS_Kill_01_delTrg_AiInVeh_react;

		if !( _vehCrew findIf {alive _x} isEqualTo -1 ) then
		{
			private _grp = group (_vehCrew select (_vehCrew findIf {alive _x}));

			_grp call DK_fnc_delAllWp;
			_grp setVariable ['AiInVeh_WpIsDeleted', true];
			_grp setVariable ['AiInVeh_attackOnFoot', true];
		};
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

DK_MIS_Kill_02_AiInVeh_flee = {

	params ["_grp", "_vehicle"];


	_grp setCombatMode "RED";
	_grp setSpeedMode DK_MIS_var_speedUnits;

	if ( !(canMove _vehicle) OR !(DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1) ) exitWith
	{
		_grp setBehaviour DK_MIS_var_behaviour;
		_waypoint = [_grp, ((leader _grp) getVariable "MIS_center"), "SAD", "DIAMOND"] call DK_fnc_AddWaypoint;
	};

	private _unitsGrp = units _grp;

	// Limite speed vehicle if player has so far
	[_grp, _unitsGrp] spawn DK_MIS_fnc_limitSpeedIfAlone;

	// EH related to this loop
	_unitsGrp apply
	{
		_x call DK_MIS_Kill_01_addEH_AiInVEH_react;
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

		_waypoint = [_grp, _posWp, "MOVE", "DIAMOND", DK_MIS_var_speedUnits] call DK_fnc_AddWaypoint;

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
				_grp setBehaviour DK_MIS_var_behaviour;
				_unitsGrp apply
				{
					if (alive _x) then
					{
						unassignVehicle _x;
						moveOut _x;
					};

					uiSleep (random 0.3);
				};

				_waypoint = [_grp, leader _grp, "SAD", nil, if (!isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}, if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"AWARE"}] call DK_fnc_AddWaypoint;

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
						
								_grp setBehaviour DK_MIS_var_behaviour;
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


