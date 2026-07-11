if !(isServer) exitWith {};


#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []
#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]
#define crtFLY(C) createVehicle [C, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"]

#define airCivDel(C) private _nul = DK_airCiv deleteAt (DK_airCiv find C)
#define airCiv ["C_Heli_Light_01_civil_F", "C_Plane_Civil_01_racing_F"]
#define heliCiv ["C_Heli_Light_01_civil_F"]
#define planeCiv ["C_Plane_Civil_01_racing_F"]

#define airMedDel(C) private _nul = DK_airMed deleteAt (DK_airMed find C)
#define airMed ["O_Heli_Transport_04_medevac_F", "C_IDAP_Heli_Transport_02_F"]

#define airGangCopsDel(C) private _nul = DK_heliGangCops deleteAt (DK_heliGangCops find C)
#define airGangDel(C) private _nul = DK_heliGang deleteAt (DK_heliGang find C)
#define heliGangCops ["cops", "alba", "domi"]
#define heliGang ["alba", "domi"]

#define heliArmyDel(C) private _nul = DK_heliArmy deleteAt (DK_heliArmy find C)
#define heliArmy ["B_Heli_Attack_01_dynamicLoadout_F", "O_Heli_Attack_02_dynamicLoadout_F", "B_CTRG_Heli_Transport_01_sand_F"]

DK_airCiv = +airCiv;
DK_airMed = +airMed;
DK_heliGangCops = +heliGangCops;
DK_heliGang = +heliGang;
DK_heliArmy = +heliArmy;


#define DK_gangType1Del(T) private _nul = DK_gangType1 deleteAt (DK_gangType1 find T)
#define gangType1 ["uniform_thug_N1", "uniform_thug_N2", "uniform_looter"]
DK_gangType1 = +gangType1;

#define DK_gangType2Del(T) private _nul = DK_gangType2 deleteAt (DK_gangType2 find T)
#define gangType2 ["uniform_thug_N2", "uniform_thug_N2", "uniform_Ballas", "uniform_Triads"]
DK_gangType2 = +gangType2;

#define DK_gangType3Del(T) private _nul = DK_gangType3 deleteAt (DK_gangType3 find T)
#define gangType3 ["uniform_thug_N2", "uniform_Ballas", "uniform_Triads", "uniform_Ballas", "uniform_Triads"]
DK_gangType3 = +gangType3;

#define DK_gangType4Del(T) private _nul = DK_gangType4 deleteAt (DK_gangType4 find T)
#define gangType4 ["uniform_Dominicans", "uniform_Albanians", "uniform_Ballas", "uniform_Triads"]
DK_gangType4 = +gangType4;



DK_MIS_K05_create = {

	DK_MIS_loopsInProgress = 0;

	// Set Mission Type
	DK_MIS_missionType = "Kill";

	// Get Difficulty depending on number of missions completed (Ennemies Stuff, Weapons, Reward loot) (server)
	private _difficulties = call DK_MIS_fnc_slctDifficulty_K05;

	_difficulties params ["_airClass", "_className", "_behaviour", "_speed", "_height", "_disSeen", "_nbUnits", "_rewardLvl", "_canSitting"];


	// Define ID mission (server)
	private _idMission = call DK_MIS_create_ID_mission;
	if (isNil "_idMission") then
	{
		_idMission = "error" + (str time);
	};
	DK_idMission = _idMission;
	publicVariable "DK_idMission";


	// Init mission (server)
	_result = _difficulties call DK_MIS_K05_init;

	_result params ["_allGrps", "_allUnits", "_vehicles", "_airClass", "_class"];


	// Create various Trigger AI (server)
	[_allUnits, _disSeen, DK_MIS_K05_triggerAI] spawn DK_MIS_Kill_addIsSeenAir;


	// Start cooldown mission
	_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission;


	// Start Mission for players ! (local)
	_victorySnd = call DK_MIS_slctVictorySnd;
	_role = [(typeOf (_vehicles # 0)), _class, _allUnits # 0] call DK_MIS_slctAirUnitRole;
	DK_MIS_IdJIP_initCL = [_idMission, _allUnits, _role, _victorySnd] remoteExecCall ["DK_MIS_fnc_K05_initClient_cl", DK_isDedi, true];

	// Create markers targets
	[_allUnits, _idMission] spawn DK_MIS_Kill_mkrTargets;


	// Start Gangs place manager
	[_idMission, _airClass, _nbUnits, _canSitting] spawn DK_MIS_K05_gangsPlaceMngr;



/*	_allUnits spawn
	{
/*		hideObject player;
		uiSleep 6;
		player setpos ((_this # 0) modelToWorldVisual [0,2,1]);
*/
/*		uiSleep 180;
		DK_MIS_allUnits apply { _x setdamage 1 };
	};
*/

	// Handle & Waiting Ending (server)
	_result spawn DK_MIS_K05_finished;
};

DK_MIS_K05_init = {

	params ["_airClass", "_className", "_behaviour", "_speed", "_height", "_disSeen", "_nbUnits", "_rewardLvl", "_canSitting"];


	// Set side, Gangs = _side ; Cops = Resistance
	private ["_grp", "_nil", "_pos", "_roadC", "_roadCore", "_inSide"];

	// Create Vehicles --
	private _airClassNFO = _airClass call DK_MIS_K05_slctAir;
	_airClassNFO params ["_air", "_class"];

	_air enableSimulationGlobal false;

	call
	{
		if (_class in ["army", "armyGH", "cops"]) exitWith
		{
			_inSide = resistance;
			_className = "I_officer_F";
		};

		_inSide = east;
	};


///	START // Create & manage entities to pre-initialize mission

	_grp = createGroup [_inSide, true];
	private _target = crtU(_grp,_className);
	private _allUnits = [_target];
	private _allGrps = [_grp];

	// Protect Units & set variable
	_allUnits apply
	{
		_x allowDamage false;
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x setVariable ["allGroups", _allGrps];
		_x hideObjectGlobal true;
		_x setCaptive true;

		uiSleep 0.03;
	};

	uiSleep 0.1;

/*	_air spawn
	{
		waitUntil { hintSilent ( "Speed: " +  (str (speed _this)) + " ; Alt.: " + (str ((getPosATL _this) # 2)) ); (!alive _this) };
	};
*/

	_air enableSimulationGlobal true;
	_grp addVehicle _air;
	_allUnits orderGetIn true;
	_allUnits allowGetIn true;
	_target moveInDriver _air;
	_grp setVariable ["assignedVeh", _air];
	_grp setVariable ["useVehicle", true];


	// Protect Vehicles
	private _vehicles = [_air];
	{
		_nil = _x call DK_fnc_init_vehFlyAir;
		_x setUnloadInCombat [FALSE,FALSE]; 
		_x enableSimulationGlobal false;

		uiSleep 0.1;

	} count _vehicles;


	// Setup Groups & added car
	_allGrps apply
	{
		_x setFormation "DIAMOND";
		_x setVariable ["allVehicles", _vehicles];
	};


	uiSleep 0.05;


///	END // Create & manage entities to pre-initialize mission


	// Added Stuff
	private _waitLO = [_target, _air, _allUnits, _class] spawn DK_MIS_K05_selectPilotLO;
	
	// Find place
	private _startPos = call DK_MIS_fnc_slctSafePlace_06;

	// Move units
	_air setDir (random 360);
	_air setPosATL _startPos;

	[_air, _target] call DK_MIS_addEH_airScrTargetWthRewardsAir;


	waitUntil { uiSleep 0.1; (scriptDone _waitLO) };

	call
	{
		if (_class isEqualTo "cops") exitWith
		{
			_target setVariable ["DK_score", DK_scrVIPcop];
			[_air, _grp] spawn DK_MIS_K05_crtHeliCrew_cops;
		};

		if (_class isEqualTo "alba") exitWith
		{
			_target setVariable ["DK_score", DK_scrVIPalba];
			[_air, _grp] spawn DK_MIS_K05_crtHeliCrew_alba;
		};

		if (_class isEqualTo "domi") exitWith
		{
			_target setVariable ["DK_score", DK_scrVIPdomi];
		};

		if (_class isEqualTo "army") exitWith
		{
			_target setVariable ["DK_score", DK_scrVIParmy];
			[_air, _grp, 0] spawn DK_MIS_K05_crtHeliCrew_army;
		};

		if (_class isEqualTo "armyGH") then
		{
			_target setVariable ["DK_score", DK_scrVIParmy];
			[_air, _grp, 1] spawn DK_MIS_K05_crtHeliCrew_army;
		};
	};

	// Added varied Trigger for start AI units
	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["lvlStuff", _rewardLvl];
		_x setVariable ["DK_spawnProtectOn", false];

		uiSleep 0.05;

		// DEBUG
		if (((getPosATL _x) # 0) < 1) then
		{
			_x moveInDriver _air;
		};
	};

	{
		_x setVariable ["targetsMission", _allUnits];
		_x setVariable ["allVehicles", _vehicles];
		_x call DK_MIS_K05_vehAddEH_trgAI;
		_x enableSimulationGlobal true;
		_nil = _x call DK_MIS_addEH_rewardsAir;
		_x limitSpeed _speed;
		_x setVariable ["speed", (_speed + 30)];

		uiSleep 0.05;

	} count _vehicles;



	// Define variables related to the mission (Only Server)
	DK_MIS_var_AiIsBlocked = true;
	DK_MIS_var_PlayersAreNotSeen = true;
	DK_MIS_var_behaviour = "CARELESS";
	DK_MIS_var_speedUnits = "NORMAL";
	DK_MIS_var_missInProg = true;
	DK_MIS_playerRewardsMarkersList = [];
	DK_MIS_allTargets = _allUnits;

	// Define variables related to the mission (Clients & Server)
	DK_nbTargets_Goal = count _allUnits;
	publicVariable "DK_nbTargets_Goal";

	DK_nbTargets_Cnt = 0;
	publicVariable "DK_nbTargets_Cnt";


	uiSleep 0.3;

///	// Tweaking before starting mission for mafioso

	// Add EH to units for Hud player & Ending mission
	_allUnits apply
	{
		_x call DK_MIS_Kill_addEH_targetsDead;
		_x hideObjectGlobal false;
		_x allowDamage true;
	};


	{
		_x setBehaviour _behaviour;
		_x setSpeedMode "NORMAL";

		_x setVariable ["wpHeight", _height];

		_x spawn DK_MIS_K05_wpAirRnd;

		uiSleep 0.1;

	} count _allGrps;

	_vehicles apply
	{
		[_x, _speed] spawn DK_MIS_K05_limitSpdAir;
	};

//// /// MISSION IS FULL INIT /////

/*
		// DEBUG
		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, _startPos];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [30, 30];
		// DEBUG
*/


	[_allGrps, _allUnits, _vehicles, _airClass, _class]
};

DK_MIS_K05_finished = {

	params ["_allGrps", "_allUnits", "_vehicles", "", "_class"];


	private "_veh";
	private _allUnits = +_allUnits;
	private _vehicles = +_vehicles;
	private _allGrps = +_allGrps;
	private _time = time + DK_MIS_maxTimeMission;

	waitUntil { uiSleep 0.3; !(DK_MIS_var_missInProg) OR (time > _time) OR (_allUnits findIf { uiSleep 0.02; !isNil "_x" } isEqualTo -1) OR (_allUnits findIf { uiSleep 0.02; alive _x } isEqualTo -1) };

	// Delete markers zone gangs place
	{
		deleteMarker _x;

	} count DK_MIS_K05_mkrs_gp;
	
	// Ending the game if counter is down
	if ((call BIS_fnc_missionTimeLeft) isEqualTo 0) exitWith
	{
		call DK_fnc_endSelectWinner;
	};

	// Start reinforcement if needed
	if !(DK_MIS_playerRewardsMarkersList isEqualTo []) then
	{
		private _target = DK_MIS_playerRewardsMarkersList # 0;
		uiSleep 1;
		private _maxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

		if (_class in ["O_Heli_Transport_04_medevac_F", "C_IDAP_Heli_Transport_02_F"]) exitWith
		{
			[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;

			if (_maxFam > 6) exitWith
			{
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 3) exitWith
			{
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_hguns", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 1) then
			{
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};
		};

		if (_class isEqualTo "cops") exitWith
		{
			[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
			[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_hguns", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;

			if (_maxFam > 4) exitWith
			{
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 2) then
			{
				[_target, ["I_officer_F", "Police forces", "uniform_Police", "wpns_smgs", "vest_mediumPolice"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};
		};

		if (_class isEqualTo "alba") exitWith
		{
			[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;

			if (_maxFam > 6) exitWith
			{
				[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 4) exitWith
			{
				[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 1) then
			{
				[_target, ["O_G_Survivor_F", "Albanians", "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};
		};

		if (_class isEqualTo "domi") then
		{
			[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;

			if (_maxFam > 6) exitWith
			{
				[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 4) then
			{
				[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 1) then
			{
				[_target, ["O_G_Survivor_F", "Dominicans", "uniform_Dominicans", "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"]] spawn DK_MIS_fnc_rfrAtPlayer;
			};
		};

		if (_class in ["army", "armyGH"]) then
		{
			[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
			[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;

			if (_maxFam > 7) exitWith
			{
				[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 4) then
			{
				[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
				[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
			};

			if (_maxFam > 1) then
			{
				[_target, ["I_officer_F", "Army", "", "", ""]] spawn DK_MIS_fnc_rfrAtPlayer;
			};
		};
	};

	// Delete info for local player from JIP
	remoteExecCall ["", DK_MIS_IdJIP_initCL];

	// Variable to be sure that Ending mission
	DK_MIS_var_missInProg = false;


	// Add UNITS to Clean Up
	{
		if !(isNull _x) then
		{
			if (alive _x) then
			{
				call
				{
					_veh = objectParent _x;

					if (isNull _veh) exitWith
					{
						deleteVehicle _x;
					};

					_veh deleteVehicleCrew _x;

					waitUntil { ( ((crew _veh) isEqualTo []) && { ((crew _veh) findIf { ( !(isNil "_x") && { !(isNull _x) } ) } isEqualTo -1) } ) };

					deleteVehicle _veh;
				};
			}
			else
			{
				[_x, DK_MIS_timeDelCorps, DK_MIS_disDelCorps, true] spawn DK_fnc_addAllTo_CUM;
			};
		};

	} forEach _allUnits;


	// Add VEHICLES to Clean Up
	{
		uiSleep 0.05;

		if ( (!isNil "_x") && { (alive _x) } ) then
		{
			if (_x isKindOf "Air") exitWith
			{
				 _x call DK_fnc_initHeliBoatEnd;
				_nil = [_x, DK_MIS_timeDelVeh, DK_MIS_disDelVeh, true] spawn DK_fnc_addVehTo_CUM;
			};

			if (_x isKindOf "LandVehicle") exitWith
			{
				_x call DK_MIS_fnc_vehicle_removeAllEH;
				_x call DK_MIS_reInitVehNormal;
				_x call DK_MIS_fnc_initVehWhenEnd;
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
	DK_MIS_missionType = "";
	DK_MIS_K05_mkrs_gp = nil;


	uiSleep 1;

	// Start next mission
	call DK_MIS_fnc_slctDifficultyLevel;

};


DK_MIS_K05_slctAir = {

	private "_airClass";

	call
	{
		if (_this in ["gangCops_heli", "gang_heli", "cops_heli"]) exitWith
		{
			_airClass = [_this] call DK_MIS_K05_slctAirGangCops;
		};

		if (_this isEqualTo "med_heli") exitWith
		{
			_airClass = [_this] call DK_MIS_K05_slctAirMed;
		};

		if (_this in ["civ_plane", "civ_heli", "civ_heliPlane"]) exitWith
		{
			_airClass = call DK_MIS_K05_slctAirCiv;
		};

		if (_this isEqualTo "army_heli") then
		{
			_airClass = call DK_MIS_K05_slctAirArmy;
		};
	};


	_airClass
};

DK_MIS_K05_slctAirCiv = {

	params [["_type", "civ_heliPlane"]];


	private "_class";

	switch (_type) do
	{
		case "civ_heli":
		{
			_class = selectRandom heliCiv;
		};

		case "civ_plane":
		{
			_class = selectRandom planeCiv;
		};

		case "civ_heliPlane":
		{
			_class = selectRandom DK_airCiv;
		};
	};

	_class call DK_MIS_fnc_K05_delAirCiv;
	private _air = crtFLY(_class);

	switch _class do
	{
		case "C_Heli_Light_01_civil_F" :
		{
			_air call DK_fnc_textureCivHeliL;
		};

		case "C_Plane_Civil_01_racing_F" :
		{
			_air call DK_fnc_textureCivJet;
		};
	};


	[_air, _class]
};

DK_MIS_K05_slctAirMed = {

	private _class = selectRandom DK_airMed;

	_class call DK_MIS_fnc_K05_delAirMed;
	private _air = crtFLY(_class);

	if (_class isEqualTo "O_Heli_Transport_04_medevac_F") then
	{
		_air call DK_fnc_textureMedHeli;
	};


	[_air, _class]
};

DK_MIS_K05_slctAirGangCops = {

	params [["_type", "gangCops_heli"]];


	private ["_air", "_class"];

	switch (_type) do
	{
		case "cops_heli":
		{
			_air = [false] call DK_MIS_fnc_crtHeli_Police;
			_class = "cops";
		};

		case "gang_heli":
		{
			_class = selectRandom DK_heliGang;
			_class call DK_MIS_fnc_K05_delAirGang;
			call
			{
				if (_class isEqualTo "alba") exitWith
				{
					_air = [false] call DK_MIS_fnc_crtHeli_Alban;
				};

				_air = [false] call DK_MIS_fnc_crtHeli_Domi;
			};
		};

		case "gangCops_heli":
		{
			_class = selectRandom DK_heliGangCops;
			call
			{
				if (_class isEqualTo "alba") exitWith
				{
					_air = [false] call DK_MIS_fnc_crtHeli_Alban;
					_class call DK_MIS_fnc_K05_delAirGang;
				};

				if (_class isEqualTo "domi") exitWith
				{
					_air = [false] call DK_MIS_fnc_crtHeli_Domi;
					_class call DK_MIS_fnc_K05_delAirGang;
				};

				_air = [false] call DK_MIS_fnc_crtHeli_Police;
			};
		};
	};

	_class call DK_MIS_fnc_K05_delAirGangCops;


	[_air, _class]
};

DK_MIS_K05_slctAirArmy = {

	private _class = selectRandom DK_heliArmy;
	_class call DK_MIS_fnc_K05_delAirArmy;

	private "_air";
	call
	{
		if (_class isEqualTo "B_Heli_Attack_01_dynamicLoadout_F") exitWith
		{
			_air = [false] call DK_MIS_fnc_crtHeli_ArmyBlackF;
			_class = "army";
		};

		if (_class isEqualTo "O_Heli_Attack_02_dynamicLoadout_F") exitWith
		{
			_air = [false] call DK_MIS_fnc_crtHeli_ArmyKajman;
			_class = "army";
		};

		_air = [false] call DK_MIS_fnc_crtHeli_ArmyGhostH;
		_class = "armyGH";
	};


	[_air, _class]
};

DK_MIS_fnc_K05_delAirCiv = {

	airCivDel(_this);

	if (DK_airCiv isEqualTo []) then
	{
		DK_airCiv = +airCiv;
		airCivDel(_this);
	};
};

DK_MIS_fnc_K05_delAirMed = {

	airMedDel(_this);

	if (DK_airMed isEqualTo []) then
	{
		DK_airMed = +airMed;
		airMedDel(_this);
	};
};

DK_MIS_fnc_K05_delAirGangCops = {

	airGangCopsDel(_this);

	if (DK_heliGangCops isEqualTo []) then
	{
		DK_heliGangCops = +heliGangCops;
		airGangCopsDel(_this);
	};
};

DK_MIS_fnc_K05_delAirGang = {

	airGangDel(_this);

	if (DK_heliGang isEqualTo []) then
	{
		DK_heliGang = +heliGang;
		airGangDel(_this);
	};
};

DK_MIS_fnc_K05_delAirArmy = {

	heliArmyDel(_this);

	if (DK_heliArmy isEqualTo []) then
	{
		DK_heliArmy = +heliArmy;
		heliArmyDel(_this);
	};
};

DK_MIS_K05_wpAirRnd = {

	if ( (isNil "_this") OR (_this isEqualTo grpNull) OR (units _this findIf { alive _x } isEqualTo -1) ) exitWith {};

	_this call DK_fnc_delAllWp;

	private "_road";
	private "_mkr";
	private _unit = leader _this;

	vehicle _unit flyInHeight (_this getVariable ["wpHeight", 80]);

	call
	{
		if ( (behaviour _unit isEqualTo "COMBAT") && { (_unit getVariable ["DK_side", ""] in ["army", "cops", "mis_alban", "mis_domi"]) } ) exitWith
		{
			_unit doMove (getPosATL _unit);

			private _idPly = playableUnits findIf {_x distance2D _unit < 700};

			if (_idPly isEqualTo -1) exitWith
			{
				_road = _unit call DK_MIS_K05_wpAirSrchRoad;
				[_this, _road, "SAD", nil, "UNCHANGED", "UNCHANGED", 150] call DK_fnc_AddWaypoint;


//				systemChat ((str time) + " : SAD on road");
//				_mkr = _road call DK_fnc_mkrTemp;


				private	_time = time + 300;

				waitUntil { uiSleep 5; if ( (!isNil "_unit") && { (alive _unit) && { (_unit distance2D _road < 300) } } ) then { _unit doMove (_unit getpos [(100 + (random 100)), random 360]) }; (time > _time) OR (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_unit distance2D _road < 10) };
			};

			[_this, playableUnits # _idPly, "SAD", nil, "UNCHANGED", "UNCHANGED", 0] call DK_fnc_AddWaypoint;
			_this reveal [playableUnits # _idPly, 4];


//			systemChat ((str time) + " : SAD on heli");
//			_mkr = _road call DK_fnc_mkrTemp;


			private	_time = time + 300;

			waitUntil { uiSleep 7; if ( (!isNil "_unit") && { (alive _unit) && { (speed _unit < 5) } } ) then { _unit doMove (_unit getpos [250, random 360]) }; (time > _time) OR (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (playableUnits findIf {_x distance2D _unit < 1200} isEqualTo -1) };
		};

		_road = _unit call DK_MIS_K05_wpAirSrchRoad;
		_unit doMove _road;

//		_mkr = _road call DK_fnc_mkrTemp;

		waitUntil { uiSleep 3; (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_unit distance2D _road < 700) };
	};


	///	// DEBUG Marker
/*	if (!isNil "_mkr") then
	{
		deleteMarker _mkr;
	};
*/	///	// DEBUG


	if ((isNil "_unit") OR (isNull _unit) OR (!alive _unit)) exitWith {};

	_this spawn DK_MIS_K05_wpAirRnd;
};

/*
DK_fnc_mkrTemp = {
	///	// DEBUG Marker
		private _mkr = createMarker [("DK_mkr" + (str time)), _this];
		_mkr setMarkerSize [150, 150];
		_mkr setMarkerShape "ELLIPSE";
		_mkr setMarkerBrush "SolidBorder";
		_mkr setMarkerColor "ColorGreen";
	///	// DEBUG

	_mkr
};
*/

DK_MIS_K05_wpAirSrchRoad = {

	private "_road";

//	private _id = DK_CLAG_LogicsTrafficMain findIf { ( ((_x # 0) distance2D _this > 2000) && { ((_x # 0) distance2D _this < 10000) } ) };
	private _id = DK_CLAG_LogicsTrafficMain findIf { ( ((_x # 0) distance2D _this > 2000) && { ((_x # 0) distance2D _this < 6000) } ) };
	if !(_id isEqualTo -1) then
	{
		_road = (DK_CLAG_LogicsTrafficMain # _id) # 0;
	}
	else
	{
		_road = (selectRandom DK_CLAG_LogicsTrafficMain) # 0;
	};


	_road
};

DK_MIS_K05_limitSpdAir = {

	params ["_air", "_speed"];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	while { ( (alive _air) && { (DK_MIS_var_PlayersAreNotSeen) } ) } do
	{
		call
		{
			if ( (surfaceIsWater (getPosATL _air)) OR !(DK_mkrs_spawnProtect findIf {_air inArea _x} isEqualTo -1) ) exitWith
			{
				_air forceSpeed 500;
				_air limitSpeed 500;
			};

			_air forceSpeed -1;
			_air limitSpeed _speed;
		};


		uiSleep 5;
	};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;
};

DK_MIS_K05_selectPilotLO = {

	params ["_target", "_air", "_allUnits", "_class"];


	call
	{
		if (_class isEqualTo "cops") exitWith
		{
			_target call DK_fnc_LO_PoliceHeli_pilot;
		};

		if (_class isEqualTo "alba") exitWith
		{
			_target call DK_fnc_LO_AlbanHeli_pilot;
		};

		if (_class isEqualTo "domi") exitWith
		{
			_target call DK_fnc_LO_DomiHeli_pilot;
		};

		if (_class in ["army","armyGH"]) exitWith
		{
			_target call DK_fnc_LO_ArmyHeli_pilot;
		};

		[_allUnits, typeOf _air] call DK_MIS_fnc_slctUnitsLO;
	};
};

DK_MIS_K05_crtAA = {

	params ["_unit", "_stuff"];


	private "_fireTy";

	call
	{
		if ( (call DK_fnc_checkIfNight) OR (overcast > 0.45) ) exitWith
		{
			_fireTy = "FirePlace_burning_F";
		};

		_fireTy = "Land_FirePlace_F";
	};

	private _fire = createVehicle [_fireTy, _unit, [], 0.2, "NONE"];


	private _crate = createVehicle ["Box_Syndicate_WpsLaunch_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	private _crate2 = createVehicle ["Box_Syndicate_Ammo_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	private _crates = [_crate, _crate2];

	_crates apply
	{
		_x allowDammage false;
		_x setDir (random 360);
	 
		clearWeaponCargoGlobal _x;
		clearMagazineCargoGlobal _x;
		clearItemCargoGlobal _x;
		clearBackpackCargoGlobal _x;
	};
//	} count _crates;


	_crate setVehiclePosition [getPosATL _fire, [], 0.4, "NONE"];
	private _grassCut = createVehicle ["Land_ClutterCutter_medium_F", _fire getPos [((_fire distance _crate) / 2), (_fire getRelDir _crate)], [], 0, "CAN_COLLIDE"];
	_grassCut setVectorUp surfaceNormal (getPosATL _grassCut);

	_crate2 setVehiclePosition [getPosATL _fire, [], 0.4, "NONE"];
	private _grassCut2 = createVehicle ["Land_ClutterCutter_medium_F", _fire getPos [((_fire distance _crate2) / 2), (_fire getRelDir _crate2)], [], 0, "CAN_COLLIDE"];
	_grassCut2 setVectorUp surfaceNormal (getPosATL _grassCut2);
	
	uiSleep 0.1;

	_crate addWeaponWithAttachmentsCargoGlobal [[selectRandom ["launch_I_Titan_F", "launch_O_Titan_F", "launch_B_Titan_F"], "", "", "", ["Titan_AA", 1], [], ""], 1];
	_crate addItemCargoGlobal ["Titan_AA", 1];
	[_crate2, 1] call _stuff;

	_crate allowDammage true;
	_crate2 allowDammage true;


	[_crate, _crate2, _fire, _grassCut, _grassCut2]
};

DK_MIS_K05_animsSafe = {

	params ["_allUnits", "_canSitting", ["_slpTime", 10]];


	uiSleep _slpTime;


/*	{
//		_x disableAI "ANIM";

	} count _allUnits;
*/

	call
	{
		if ( _canSitting && { (selectRandom [true, false]) } ) exitWith
		{
			{
				_x disableAI "ANIM";

				_x setVariable ["DK_behaviour", "sit"];
				_x playMoveNow "AmovPsitMstpSnonWnonDnon_ground";
				uiSleep 0.1;

			} count _allUnits;
		};

		if (selectRandom [true,false]) exitWith
		{
			{
				_x disableAI "ANIM";

				_x action ["WeaponOnBack", _x];
				uiSleep 0.1;

			} count _allUnits;
		};

		{
			_x disableAI "ANIM";

			_x playMoveNow "AmovPercMstpSnonWnonDnon";
			uiSleep 0.1;

		} count _allUnits;

	};

	uiSleep 1;

	{
		_x allowDamage true;

	} count _allUnits;
};


DK_MIS_K05_crtHeliCrew_cops = {

	params ["_air", "_grp"];


	private _unitsCrew = [];
	for "_i" from 0 to 1 do
	{
		_unitsCrew pushBack (crtU(_grp,"I_officer_F"));
		(_unitsCrew # _i) allowDamage false;
	};

	private "_nil";
	call
	{
		if (time > (DK_cntTmGameStart / 3)) exitWith
		{
			{
				_nil = [_x, "P90"] spawn DK_fnc_LO_PoliceHeli_crew;

			} count _unitsCrew;
		};

		if (time > ((DK_cntTmGameStart / 3) * 2)) exitWith
		{
			{
				_nil = [_x, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;

			} count _unitsCrew;
		};

		{
			_nil = [_x, "wpns_hgunsSmgs", 2] spawn DK_fnc_LO_PoliceHeli_crew;

		} count _unitsCrew;
	};

	[_air, _unitsCrew] call DK_MIS_fnc_K05_heliCrew_end;
};

DK_MIS_K05_crtHeliCrew_alba = {

	params ["_air", "_grp"];


	private _unitsCrew = [];
	for "_i" from 0 to 1 do
	{
		_unitsCrew pushBack (crtU(_grp,"O_G_Survivor_F"));
		(_unitsCrew # _i) allowDamage false;
	};

	call
	{
		if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 isEqualTo 1) exitWith
		{
			[_unitsCrew, "uniform_Albanians", "wpns_AlbanKalashsATAA", ""] spawn DK_MIS_fnc_slctUnitsLO;
		};

		[_unitsCrew, "uniform_Albanians", "wpns_AlbanKalashsATAA", "vest_mediumAlban"] spawn DK_MIS_fnc_slctUnitsLO;
	};

	_unitsCrew apply
	{
		_x call DK_MIS_fnc_skillTurretVeh;
	};

	[_air, _unitsCrew] call DK_MIS_fnc_K05_heliCrew_end;
};

DK_MIS_K05_crtHeliCrew_army = {

	params ["_air", "_grp", ["_2Gunner", 1]];


	private _unitsCrew = [];
	for "_i" from 0 to _2Gunner do
	{
		_unitsCrew pushBack (crtU(_grp,"I_officer_F"));
		(_unitsCrew # _i) allowDamage false;
	};

	[_unitsCrew, "uniform_Army_Default"] spawn DK_MIS_fnc_slctUnitsLO;

	_unitsCrew apply
	{
		_x call DK_MIS_fnc_skillTurretVeh;
	};

	[_air, _unitsCrew, _2Gunner] call DK_MIS_fnc_K05_heliCrew_end;
};

DK_MIS_fnc_K05_heliCrew_end = {

	params ["_air", "_unitsCrew", ["_2Gunner", 1]];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	private "_nil";

	_unitsCrew orderGetIn true;
	_unitsCrew allowGetIn true;

	{
		call
		{
			if (_2Gunner isEqualTo 1 )exitWith
			{
				_x moveInCargo _air;
			};

			_x moveInGunner _air;		
		};

		_x spawn DK_MIS_addEH_HandleDmg;
		_x spawn DK_MIS_EH_handleAmmoNweapons;

		uiSleep 0.1;

		_x spawn DK_MIS_addEH_secondDead;
		_nil = _x spawn DK_addEH_killed_heliCrew_rfr;

		uiSleep 0.2;

		_x allowDamage true;

	} count _unitsCrew;


	private _driver = driver _air;

	waitUntil { uiSleep 0.2; (isNil "_driver") OR (!alive _driver) OR (_unitsCrew findIf { (alive _x) } isEqualTo -1) OR (!alive _air) OR (!canMove _air) };

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;

	if (_unitsCrew findIf { (alive _x) } isEqualTo -1) exitWith {};

	if (!alive (driver _air)) then
	{
		_unitsCrew orderGetIn false;
		_unitsCrew allowGetIn false;

		{
			if (alive _x) then
			{
				_nil = _x call DK_addEH_getOut_heliCrew_rfr;
				unassignVehicle _x;
				uiSleep (0.02 + (random 0.3));

				moveOut _x;
			};

		} count ((crew _air) - [driver _air]);
	};

	uiSleep 0.1;

	if ( (!isNil "_air") && { (alive _air) } ) then
	{
		{
			_air deleteVehicleCrew _x;
			uiSleep 0.02;

		} count (crew _air);
	};

	uiSleep 0.1;

	{
		if !(_x getVariable ["cleanUpOn", false]) then
		{
			_nil = [_x, DK_MIS_timeDelCorps, DK_MIS_disDelCorps, true] spawn DK_fnc_addAllTo_CUM;
		};

		uiSleep 0.1;

	} count _unitsCrew;
};


// Varied Trigger for start AI
DK_MIS_K05_vehAddEH_trgAI = {

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K05_triggerAI];
		_this call DK_MIS_fnc_EhHitNear_trgAI_Veh;
	}];


	_this setVariable ["idEhHitTrgAI", _idEhHit];
};

DK_MIS_K05_vehAddEH_trgAI_gp = {

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K05_triggerAI_gp];
		_this call DK_MIS_fnc_EhHitNear_trgAI_Veh_gp;
	}];


	_this setVariable ["idEhHitTrgAI", _idEhHit];
};

DK_MIS_K05_unitsAddEH_trgAI_gp = {

	_this addEventHandler ["FiredNear",
	{
		_this append [DK_MIS_K05_triggerAI_gp];
		_this call DK_MIS_fnc_EhFiredNear_trgAI_gp;
	}];

	private _idEhHit = _this addEventHandler ["Hit",
	{
		_this append [DK_MIS_K05_triggerAI_gp, nil, nil, _thisEventHandler];
		_this call DK_MIS_fnc_EhHit_trgAI_gp;
	}];

	private _idEhKilled = _this addEventHandler ["Killed",
	{
		_this append [DK_MIS_K05_triggerAI_gp];
		_this call DK_MIS_fnc_EhKilled_trgAI_gp;
	}];

	_this setVariable ["idEhHitTrgAI", _idEhHit];
	_this setVariable ["idEhKilledTrgAI", _idEhKilled];
};


DK_MIS_K05_triggerAI = {


	params ["_allUnits"];


	DK_MIS_var_PlayersAreNotSeen = false;

	if (_allUnits findIf { (alive _x) } isEqualTo -1) exitWith {};


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
	{
		_x forceSpeed -1;
		_x limitSpeed (_x getVariable ["speed", 150]);

	} count _vehicles;


	[_allUnits, (group (_allUnits # 0))] call DK_MIS_fnc_removeEhTrgAi;


	// Activate AI target
	_allUnits apply
	{
		if (alive _x) then
		{
			_x enableAI "TARGET";
			_x enableAI "AUTOTARGET";
			if (side _x isEqualTo resistance) then
			{
				_x setCaptive false;
			};

			_x spawn DK_MIS_K05_checkManageHeliCrew;

			uiSleep (random 0.3);

			if (_x getVariable ["DK_side", ""] in ["army", "cops", "mis_alban", "mis_domi"]) then
			{
				if (_x getVariable ["DK_side", ""] in ["army", "mis_domi"]) then
				{
					[(vehicle _x), _x] spawn DK_fnc_handleAmmoVeh;
				};

				_x doMove (getPosATL _x);
				[group _x, _x, "SAD", nil, "UNCHANGED", "COMBAT", 150] call DK_fnc_AddWaypoint;
			};
		};
	};


	// Move units if they have a linked Vehicle
	private ["_grp", "_nil"];
	{
		call
		{
			_grp = _x;

			if (units _grp findIf { alive _x } isEqualTo -1) exitWith {};

			_grp setBehaviour "COMBAT";
			_grp setCombatMode "RED";

			_grp setSpeedMode "NORMAL";
		};

		uiSleep 0.3;

	} count _allGrps;

};

DK_MIS_K05_checkManageHeliCrew = {

	if ( (isNil "_this") OR (!alive _this) ) exitWith {};

	private _air = group _this getVariable "assignedVeh";

	if ( (isNil "_air") OR (!alive _air) ) exitWith {};


	if ((_this getVariable ["DK_side", ""]) in ["cops", "mis_alban"]) exitWith
	{
		private _cargoCrew = fullCrew [_air, "cargo", true];

		private _unitToMove = (_cargoCrew # 0) # 0;
		if ( !(isNil "_unitToMove") && { (alive _unitToMove) } ) then
		{
			moveOut _unitToMove;
			uiSleep 0.02;
			_unitToMove moveInTurret [_air, [3]];
		};

		_unitToMove = (_cargoCrew # 1) # 0;
		if ( !(isNil "_unitToMove") && { (alive _unitToMove) } ) then
		{
			moveOut _unitToMove;
			uiSleep 0.02;
			_unitToMove moveInTurret [_air, [1]];
		};
	};

	if ( ((_this getVariable ["DK_side", ""]) isEqualTo "army") && { ((typeOf (vehicle _this)) isEqualTo "B_CTRG_Heli_Transport_01_sand_F") } ) exitWith
	{
		private _cargoCrew = fullCrew [_air, "cargo", true];

		private _unitToMove = (_cargoCrew # 0) # 0;
		if ( !(isNil "_unitToMove") && { !(isNull _unitToMove) && { (alive _unitToMove) } } ) then
		{
			moveOut _unitToMove;
			uiSleep 0.02;
			_unitToMove moveInTurret [_air, [1]];
		};

		_unitToMove = (_cargoCrew # 1) # 0;
		if ( !(isNil "_unitToMove") && { !(isNull _unitToMove) && { (alive _unitToMove) } } ) then
		{
			moveOut _unitToMove;
			uiSleep 0.02;
			_unitToMove moveInTurret [_air, [2]];
		};
	};
};



/// Gang Place
DK_MIS_K05_triggerAI_gp = {

//	systemChat "AI Start Gang Place !!!";

	params ["_allUnits", ["_disMax", 80], ["_disMin", 25]];


	(group (_allUnits # 0)) setVariable ["playersAreNotSeen", false];

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
	private "_nil";
	{
		if (alive _x) then
		{
			_x enableAI "ANIM";
			_x enableAI "MOVE";
			_x enableAI "TARGET";
			_x enableAI "AUTOTARGET";
			_x enableAI "FSM";
			_x setCaptive false;

			uiSleep (random 0.2);
		};

	} count _allUnits;


	private ["_grp", "_nil"];
	{
		call
		{
			_grp = _x;

			if (units _grp findIf { alive _x } isEqualTo -1) exitWith {};

			_nil = _grp spawn DK_fnc_selectLoopVoice;

			_grp call DK_fnc_delAllWp;
			_grp setBehaviour "AWARE";
			_grp setCombatMode "YELLOW";
			_grp setSpeedMode "NORMAL";

			_nil = [_grp, _disMax, _disMin] spawn DK_MIS_fnc_stayCloseArea;
		};

		uiSleep 0.3;

	} count _allGrps;
};

DK_MIS_K05_gangsPlaceMngr = {

	params ["_idMission", "_airClass", "_nbUnits", "_canSitting"];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	DK_MIS_K05_gangsPlace = [];
	DK_MIS_K05_mkrs_gp = [];

	for "_i" from 1 to 5 do
	{
		_this call DK_MIS_K05_searchGangsPlace;

		uiSleep 1;
	};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;
};

DK_MIS_K05_searchGangsPlace = {

	params ["_idMission", "_airClass", "_nbUnits", "_canSitting"];


	if !(DK_idMission isEqualTo _idMission) exitWith {};

	if (count DK_MIS_K05_gangsPlace > 10) then
	{
		DK_MIS_K05_gangsPlace = [];
	};

	private "_pos";

	private _allPos = +DK_MIS_posStart_K05_gangs;
	_allPos = +(_allPos - DK_MIS_K05_gangsPlace);
	_allPos call KK_fnc_arrayShuffle;
	private _laps = (count _allPos) - 1;
	private _disMin = 4000;

	private _exit = false;

//	private _debugTime = time;
//	private _debug_i = -0;
//	compt = 0;

	while { ( !(_exit) && { (_idMission isEqualTo DK_idMission) } ) } do
	{
//		compt = compt + 1;

		uiSleep 0.1;

		if !(_idMission isEqualTo DK_idMission) exitWith {};

		for "_i" from 0 to _laps do
		{
//			_debug_i = _i;

			call
			{
				_pos = _allPos # _i;

				if (isNil "_pos") exitWith {};

				if (DK_MIS_K05_gangsPlace isEqualTo []) exitWith
				{
					if ( (PlaceOK(_pos,25,20)) && { (playableUnits findIf { (_x distance2D _pos) < 500 } isEqualTo -1) } ) then
					{
						[_pos, _idMission, _airClass, _nbUnits, _canSitting] spawn DK_MIS_K05_crtGangPlace;

						_exit = true;
					};
				};

				if ( (DK_MIS_K05_gangsPlace findIf {_x distance2D _pos < _disMin} isEqualTo -1) && { (PlaceOK(_pos,28,20)) && { (playableUnits findIf { (_x distance2D _pos) < 500 } isEqualTo -1) } } ) then
				{
					[_pos, _idMission, _airClass, _nbUnits, _canSitting] spawn DK_MIS_K05_crtGangPlace;

					_exit = true;
				};
			};

			if (_exit OR !(_idMission isEqualTo DK_idMission) OR (isNil "_pos")) exitWith {};

			uiSleep 0.1;
		};

		if (_exit OR !(_idMission isEqualTo DK_idMission)) exitWith {};

		call
		{
			if (_disMin < 2000) exitWith
			{
				_disMin = 3000;
			};

			_disMin = _disMin - 500;
		};

		uiSleep 0.1;

		_allPos = +DK_MIS_posStart_K05_gangs;
		_allPos = +(_allPos - DK_MIS_K05_gangsPlace);
		_allPos call KK_fnc_arrayShuffle;
	};


//	hint ( "Gang place ; Schr time: " + (str (time - _debugTime)) + " ; Laps: " + (str [compt, _debug_i]) +  " ; DisMin: " + (str _disMin) );
//	systemChat ( "Gang place ; Schr time: " + (str (time - _debugTime)) + " ; Laps: " + (str [compt, _debug_i]) + " ; DisMin: " + (str _disMin) );

};

DK_MIS_K05_crtGangPlace = {

	params ["_pos", "_idMission", "_airClass", "_nbUnits", "_canSitting"] ;


	DK_MIS_K05_gangsPlace pushBackUnique _pos;

	private ["_nil", "_unit", "_unitOld", "_vehClass", "_waitLO"];


	// Create & SetUp Units
	private _grp = createGroup [east, true];
	_grp setVariable ["aiIsBlocked", true];
	_grp setVariable ["playersAreNotSeen", true];
	private _allGrps = [_grp];
	private _allUnits = [];

	private _allDirs = [0, -35, 35, 0, -35, 35];

	for "_i" from 0 to ((selectRandom _nbUnits) -1) do
	{
		_unit = crtU(_grp,"O_G_Survivor_F");

		_unit allowDamage false;
		_unit disableAI "MOVE";
		_unit disableAI "TARGET";
		_unit disableAI "AUTOTARGET";
		_unit disableAI "FSM";
		_unit setVariable ["allGroups", _allGrps];
		_unit call DK_MIS_addEH_HandleDmg;
		_unit call DK_MIS_addEH_secondDead;
		_nil = DK_unitsStayUp pushBackUnique _unit;
		_unit hideObjectGlobal true;
		_unit setCaptive true;

		uiSleep 0.05;

		_unit call DK_MIS_K05_unitsAddEH_trgAI_gp;
		_unit call DK_MIS_EH_handleAmmoNweapons;
		_unit call DK_MIS_EH_deadCUM_gp;

		_allUnits pushBack _unit;

		call
		{
			if (_i in [0,3]) exitWith
			{
				_unit setVehiclePosition [_pos, [], 30, "NONE"];
			};

			if (_i in [1,4]) exitWith
			{
				_unitOld = (_allUnits # (_i - 1));
				_unit setposATL (_unitOld getPos [1.8, ((getDir _unitOld) + (_allDirs # _i))]);
				uiSleep 0.1;
				_unit setDir (_unit getRelDir _unitOld);
			};

			if (_i in [2,5]) then
			{
				_unitOld = (_allUnits # (_i - 2));
				_unit setposATL (_unitOld getPos [1.8, ((getDir _unitOld) + (_allDirs # _i))]);
				uiSleep 0.1;
				_unit setDir (_unit getRelDir _unitOld);
			};
		};

		uiSleep 0.05;
	};

	call
	{
		if (_airClass in ["civ_heliPlane", "civ_heli", "civ_plane"]) exitWith
		{
			private _gangType = selectRandom DK_gangType1;
			DK_gangType1Del(_gangType);

			if (DK_gangType1 isEqualTo []) then
			{
				DK_gangType1 = +gangType1;
				DK_gangType1Del(_gangType);
			};

			switch (_gangType) do
			{
				case "uniform_thug_N1" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_hgunsSmg", ""] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtVeh_cls], DK_MIS_fnc_LO_5x56_c];
				};

				case "uniform_thug_N2" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_hgunsSmgs", "vest_bandoBelt"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtVeh_cls], DK_MIS_fnc_LO_5x56];
				};

				case "uniform_looter" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_SGsaweHgun", ""] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtQuad_looters], selectRandom [DK_MIS_fnc_LO_5x56_c, DK_MIS_fnc_LO_P90_c]];
				};
			};
		};

		if (_airClass in ["med_heli", "med_heli", "med_heli"]) exitWith
		{
			private _gangType = selectRandom DK_gangType2;
			DK_gangType2Del(_gangType);

			if (DK_gangType2 isEqualTo []) then
			{
				DK_gangType2 = +gangType2;
				DK_gangType2Del(_gangType);
			};

			switch (_gangType) do
			{
				case "uniform_thug_N2" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_smgs", "vest_bandoBelt"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtVeh_cls], DK_MIS_fnc_LO_5x56];
				};

				case "uniform_Ballas" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_BallasSmgsMg", "vest_bando"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[true, true], DK_MIS_fnc_crtVeh_ballas], if (call DK_fnc_allPlayersHaveDLC_contact) then {DK_MIS_fnc_LO_SparCar_gl} else {DK_MIS_fnc_LO_5x56_gl} ];
					_canSitting = false;
				};

				case "uniform_Triads" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_TriadsSmgsAT", "vest_belt"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[true, true], DK_MIS_fnc_crtVeh_Triads], if (call DK_fnc_allPlayersHaveDLC_contact) then {DK_MIS_fnc_LO_SparCar_c} else {DK_MIS_fnc_LO_P90} ];
					_canSitting = false;
				};
			};
		};

		if ( (_airClass in ["gangCops_heli", "gang_heli", "cops_heli"]) && { (time < ((DK_cntTmGameStart / 3) * 2)) } ) exitWith
		{
			private _gangType = selectRandom DK_gangType3;
			DK_gangType3Del(_gangType);

			if (DK_gangType3 isEqualTo []) then
			{
				DK_gangType3 = +gangType3;
				DK_gangType3Del(_gangType);
			};

			switch (_gangType) do
			{
				case "uniform_thug_N2" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_smgs", "vest_bandoBelt"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtVeh_cls], DK_MIS_fnc_LO_5x56];
				};

				case "uniform_Ballas" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_BallasSmgsMg", "vest_bando"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[true, true], DK_MIS_fnc_crtVeh_ballas], if (call DK_fnc_allPlayersHaveDLC_contact) then {DK_MIS_fnc_LO_SparCar_gl} else {DK_MIS_fnc_LO_5x56_gl} ];
					_canSitting = false;
				};

				case "uniform_Triads" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_TriadsSmgsAT", "vest_belt"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[true, true], DK_MIS_fnc_crtVeh_Triads], if (call DK_fnc_allPlayersHaveDLC_contact) then {DK_MIS_fnc_LO_SparCar_c} else {DK_MIS_fnc_LO_P90} ];
					_canSitting = false;
				};
			};
		};

		if (_airClass in ["gangCops_heli", "gang_heli", "cops_heli", "army_heli"]) then
		{
			private _gangType = selectRandom DK_gangType4;
			DK_gangType4Del(_gangType);

			if (DK_gangType4 isEqualTo []) then
			{
				DK_gangType4 = +gangType4;
				DK_gangType4Del(_gangType);
			};

			switch (_gangType) do
			{
				case "uniform_Dominicans" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_DomiTrgMK14ZafirAA", "vest_mediumDomi"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtVeh_Domi], DK_MIS_fnc_LO_Mx_Kat_c];
				};

				case "uniform_Albanians" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_AlbanKalashsATAA", "vest_mediumAlban"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[], DK_MIS_fnc_crtVeh_Alban], DK_MIS_fnc_LO_Mk18];
				};

				case "uniform_Ballas" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_BallasSmgsMg", "vest_bando"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[true, true], DK_MIS_fnc_crtVeh_ballas], if (call DK_fnc_allPlayersHaveDLC_contact) then {DK_MIS_fnc_LO_SparCar_gl} else {DK_MIS_fnc_LO_5x56_gl} ];
					_canSitting = false;
				};

				case "uniform_Triads" :
				{
					_waitLO = [_allUnits, _gangType, "wpns_TriadsSmgsAT", "vest_belt"] spawn DK_MIS_fnc_slctUnitsLO;
					_vehClass = [[[true, true], DK_MIS_fnc_crtVeh_Triads], if (call DK_fnc_allPlayersHaveDLC_contact) then {DK_MIS_fnc_LO_SparCar_c} else {DK_MIS_fnc_LO_P90} ];
					_canSitting = false;
				};
			};
		};

	};

	waitUntil { uiSleep 0.5; (scriptDone _waitLO) };

	// Create & Setup Vehicles
	private _veh01 = ((_vehClass # 0) # 0) call ((_vehClass # 0) # 1);

	_veh01 allowDamage false;
	_veh01 setUnloadInCombat [FALSE,FALSE]; 
	_veh01 setDir (random 360);
	_veh01 enableSimulationGlobal false;

	private _leader = leader _grp;
	_veh01 setVehiclePosition [getPosATL _leader, [], 7, "NONE"];

	uiSleep 0.3;

	_veh01 enableSimulationGlobal true;
	_veh01 setVariable ["allVehicles", [_veh01]];
	_veh01 setVariable ["targetsMission", _allUnits];
	_veh01 call DK_MIS_K05_vehAddEH_trgAI_gp;


	_grp setFormation "DIAMOND";
	_grp setVariable ["allVehicles", [_veh01]];
//	_grp setBehaviour "CARELESS";

	_allUnits apply
	{
		_x setVariable ["targetsMission", _allUnits];
		_x hideObjectGlobal false;
	};

	uiSleep 1;

	[_allUnits, 50, DK_MIS_K05_triggerAI_gp, 80, 25] spawn DK_MIS_Kill_addIsSeen_gp;


	// Marker zone
	private _mkr = createMarker [("DK_mkr" + (str _pos)), _pos];
	_mkr setMarkerSize [100, 100];
	_mkr setMarkerShape "ELLIPSE";
	_mkr setMarkerBrush "SolidBorder";
	_mkr setMarkerColor "ColorRed";
	DK_MIS_K05_mkrs_gp pushBack _mkr;

	uiSleep 1.2;

	private _propsAA = [_leader, (_vehClass # 1)] call DK_MIS_K05_crtAA;

	uiSleep 2.5;

	[_allUnits, _canSitting, 5] spawn DK_MIS_K05_animsSafe;


	_veh01 allowDamage true;
	_veh01 enableDynamicSimulation true;


	// Waiting end
	[_allUnits, _grp, _veh01, _mkr, _idMission, _propsAA, _this] spawn DK_MIS_fnc_waitEnd_gp;
};

DK_MIS_fnc_waitEnd_gp = {

	params ["_allUnits", "_grp", "_veh", "_mkr", "_idMission", "_propsAA", "_nfoNext"];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	waitUntil { uiSleep 10; !(_allUnits findIf { !alive _x } isEqualTo -1) OR !(DK_idMission isEqualTo _idMission) OR !(_grp getVariable ["playersAreNotSeen", true]) };

	private _time = time + 120;

	waitUntil { uiSleep 10; (time > _time) OR (_allUnits findIf { alive _x } isEqualTo -1) OR !(DK_idMission isEqualTo _idMission) };

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;

	private "_nil";
	{
		if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
		{
			_nil = [_x, 5, 150, true] spawn DK_fnc_addAllTo_CUM;
		};

	} count _allUnits;

	{
		if ( (!isNil "_x") && { (!isNull _x) } ) then
		{
			_nil = [_x, 5, 150, true] spawn DK_fnc_addAllTo_CUM;
		};

	} count _propsAA;

	if (alive _veh) then
	{
		_veh call DK_MIS_fnc_vehicle_removeAllEH;
		_veh call DK_MIS_reInitVehNormal;
		_veh call DK_MIS_fnc_initVehWhenEnd;
		[_veh, 5, 150, true] spawn DK_fnc_addVehTo_CUM;
	};

	uiSleep (15 + (random 15));

	if (!isNil "_mkr") then
	{
		deleteMarker _mkr;
	};

	uiSleep (5 + (random 20));


	_nfoNext deleteAt 0;
	_nfoNext spawn DK_MIS_K05_searchGangsPlace;
};

DK_MIS_EH_deadCUM_gp = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		_unit setVariable ["cleanUpOn", false];
		[_unit, 25, 150, true] spawn DK_fnc_addAllTo_CUM;
	}];
};

