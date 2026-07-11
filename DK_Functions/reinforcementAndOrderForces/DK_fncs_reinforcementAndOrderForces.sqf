if !(isServer) exitWith {};

#define CNT(NB) DK_countNb_traffic_CLAG = DK_countNb_traffic_CLAG + NB

#define crtV(C) createVehicle [C, [random 500,random 500,2000 + (random 100)], [], 0, "CAN_COLLIDE"]
#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]
#define crtFLY(C) createVehicle [C, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"]
#define crtHeliPad createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 0, "CAN_COLLIDE"]
#define armyParaWpns ["CAR", "CAR", "SPAR_C", "SPAR_C", "SPAR_C", "SPAR_C", "SPAR_C", "SPAR_C"]

DK_manageNbRfr = 0;

// Creation Object
DK_MIS_fnc_crtVeh_Police = {

	params [["_initVeh", true], ["_sirenON", false], ["_beaconON", false]];

	_veh = crtV("I_G_Offroad_01_F");

	[
		_veh,

		["Guerilla_06",1], 
		[
			"HideDoor1", 0,
			"HideDoor2", 0,
			"HideDoor3", 0,
			"HideBackpacks", 1,
			"HideBumper1", 1,
			"HideBumper2", 0,
			"HideConstruction", 1,
			"hidePolice", 0,
			"HideServices", 1,
			"BeaconsStart", 0,
			"BeaconsServicesStart",0
		]

	] call BIS_fnc_initVehicle;

	_veh setObjectTextureGlobal [0, "DK_textures\Vehicles\Police_Offroad01.jpg"];

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_offRoad_police;

	// Add Siren & Beacon
	[_veh, _sirenON, _beaconON] call DK_fnc_sirenNbeacon_init;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_FBI = {

	params [["_initVeh", true], ["_sirenON", false], ["_beaconON", false]];

	_veh = crtV("B_GEN_Van_02_transport_F");

	[
		_veh,
		["Gendarmerie",1], 
		[
			"Door_1_source", 0,
			"Door_2_source", 0,
			"Door_3_source", 0,
			"Door_4_source", 0,
			"Hide_Door_1_source", 0,
			"Hide_Door_2_source", 0,
			"Hide_Door_3_source", 0,
			"Hide_Door_4_source", 0,
			"lights_em_hide", 0,
			"ladder_hide", 0,
			"spare_tyre_holder_hide", 1,
			"spare_tyre_hide", 1,
			"reflective_tape_hide", 1,
			"roof_rack_hide", 1,
			"LED_lights_hide", 1,
			"sidesteps_hide", 1,
			"rearsteps_hide", 1,
			"side_protective_frame_hide", 0,
			"front_protective_frame_hide", 0,
			"beacon_front_hide", 0,
			"beacon_rear_hide", 1
		]

	] call BIS_fnc_initVehicle;


	_veh setObjectTextureGlobal [0, "a3\soft_f_orange\van_02\data\van_body_black_co.paa"];

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_van_fbi;

	// Add Siren & Beacon
	[_veh, _sirenON, _beaconON] call DK_fnc_sirenNbeacon_init;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_Prowler = {

	params [["_initVeh", true]];

	_veh = crtV("B_T_LSV_01_unarmed_F");

	[
		_veh,
		["Olive",1], 
		["HideDoor1",0,"HideDoor2",0,"HideDoor3",0,"HideDoor4",0]

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_army_ProwlerVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_ProwlerHMG = {

	params [["_initVeh", true]];

	_veh = crtV("B_LSV_01_armed_F");

	[
		_veh,
		["Olive",1], 
		["HideDoor1",0,"HideDoor2",0,"HideDoor3",0,"HideDoor4",0]

	] call BIS_fnc_initVehicle;

	_veh disableTIEquipment true;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_army_ProwlerATVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_ProwlerAT = {

	params [["_initVeh", true]];

	_veh = crtV("B_T_LSV_01_AT_F");

	[
		_veh,
		["Olive",1], 
		["HideDoor1",0,"HideDoor2",0,"HideDoor3",0,"HideDoor4",0]

	] call BIS_fnc_initVehicle;

	_veh disableTIEquipment true;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_army_ProwlerATVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_Zamack = {

	params [["_initVeh", true]];


	private "_veh";

	if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 < 7) then
	{
		_veh = crtV("I_Truck_02_transport_F");
		[
			_veh,
			["Indep", 1], 
			true

		] call BIS_fnc_initVehicle;
	}
	else
	{
		_veh = crtV("I_Truck_02_covered_F");
		[
			_veh,
			["Indep", 1], 
			true

		] call BIS_fnc_initVehicle;
	};


	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_army_ZamackVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_MRAP = {

	params [["_initVeh", true], ["_gun", false]];


	private "_veh";

	call
	{
		if _gun exitWith
		{
			_veh = crtV("I_MRAP_03_hmg_F");
		};

		_veh = crtV("I_MRAP_03_F");
	};

	[
		_veh,
		["Indep",1], 
		true

	] call BIS_fnc_initVehicle;

	_veh disableTIEquipment true;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	// Weapon's in car
	_veh call DK_fnc_LO_army_MRAPveh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_Mora = {

	params [["_initVeh", true]];

	_veh = crtV("I_APC_tracked_03_cannon_F");

	[
		_veh,
		["Indep_01", 1], 
		[
			"showBags", 0,
			"showBags2", 0,
			"showCamonetHull", 0,
			"showCamonetTurret", 0,
			"showTools", 0,
			"showSLATHull", 0,
			"showSLATTurret", 0
		]

	] call BIS_fnc_initVehicle;

	_veh disableTIEquipment true;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setVehicleAmmoDef 0.5;

	// Weapon's in car
	_veh call DK_fnc_LO_army_MoraVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_Gorgon = {

	params [["_initVeh", true]];

	_veh = crtV("I_APC_Wheeled_03_cannon_F");

	[
		_veh,
		["Indep",1], 
		[
			"showCamonetHull", 0,
			"showBags", 0,
			"showBags2", 0,
			"showTools", 0,
			"showSLATHull", 0
		]

	] call BIS_fnc_initVehicle;

	_veh disableTIEquipment true;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setVehicleAmmoDef 0.6;

	// Weapon's in car
	_veh call DK_fnc_LO_army_GorgonVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Army_Kuma = {

	params [["_initVeh", true]];

	_veh = crtV("I_MBT_03_cannon_F");

	[
		_veh,
		["Indep_01", 1], 
		[
			"HideTurret", 0,
			"HideHull", 0,
			"showCamonetHull", 0,
			"showCamonetTurret", 0
		]

	] call BIS_fnc_initVehicle;

	_veh disableTIEquipment true;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setVehicleAmmoDef 0.6;

	// Weapon's in car
	_veh call DK_fnc_LO_army_KumaVeh;

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

#define vehArmyAllDel(STF) private _nul = DK_vehArmyAll deleteAt (DK_vehArmyAll find STF)
#define vehArmyAll [[DK_MIS_fnc_crtVeh_Army_Prowler, "uniform_Army_MRAP"], [DK_MIS_fnc_crtVeh_Army_ProwlerHMG, "uniform_Army_MRAP"], [DK_MIS_fnc_crtVeh_Army_Zamack, "uniform_Army_Zamack"], [DK_MIS_fnc_crtVeh_Army_MRAP, "uniform_Army_MRAP"], [DK_MIS_fnc_crtVeh_Army_Gorgon, "uniform_Army_Default"], [DK_MIS_fnc_crtVeh_Army_Kuma, "uniform_Army_Default"]]
DK_vehArmyAll = +vehArmyAll;

#define vehArmyDel(STF) private _nul = DK_vehArmy deleteAt (DK_vehArmy find STF)
#define vehArmy [[DK_MIS_fnc_crtVeh_Army_Prowler, "uniform_Army_MRAP"], [DK_MIS_fnc_crtVeh_Army_ProwlerHMG, "uniform_Army_MRAP"], [DK_MIS_fnc_crtVeh_Army_Zamack, "uniform_Army_Zamack"], [DK_MIS_fnc_crtVeh_Army_MRAP, "uniform_Army_MRAP"]]
DK_vehArmy = +vehArmy;


DK_MIS_fnc_slctCondLoop = {

	params [["_condLoop", 1], ["_objTarget", objNull], ["_idMission", "-1"]];


	private "_fnc_condSSVOR";

	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};
		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};
		};
	};


	_fnc_condSSVOR
};

DK_MIS_fnc_crtHeli_Police = {

	params [["_initVeh", true]];

	_heli = crtFLY("B_Heli_Light_01_F");

	[
		_heli,
		nil,
		["AddTread",1,"AddTread_Short",0]

	] call BIS_fnc_initVehicle;

	_heli setObjectTextureGlobal [0, "DK_textures\Vehicles\Police_Heli01.jpg"];

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	// Weapon's in heli
	_heli spawn DK_fnc_LO_heli_police;

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};

DK_MIS_fnc_crtHeli_Army = {

	params [["_initVeh", true], ["_rqt", false]];

	_heli = crtFLY("I_Heli_light_03_dynamicLoadout_F");

	[
		_heli,
		["Indep", 1], 
		true

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	// Weapon's in heli
	_heli spawn DK_fnc_LO_heli_army;

	_heli setUnloadInCombat [FALSE,FALSE]; 

	// Delete roquette
	_heli setPylonLoadout [1,""];

	if !(_rqt) then
	{
		_heli setPylonLoadout [2,""];
	};

	_heli
};

DK_MIS_fnc_crtHeli_ArmyBlackF = {

	params [["_initVeh", true]];

	_heli = crtFLY("B_Heli_Attack_01_dynamicLoadout_F");

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};

DK_MIS_fnc_crtHeli_ArmyKajman = {

	params [["_initVeh", true]];

	_heli = crtFLY("O_Heli_Attack_02_dynamicLoadout_F");

	[
		_heli,
		["Black",1], 
		true

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	_heli setPylonLoadout [1,""];
	_heli setPylonLoadout [2,"PylonRack_19Rnd_Rocket_Skyfire"];
	_heli setPylonLoadout [3,"PylonRack_19Rnd_Rocket_Skyfire"];
	_heli setPylonLoadout [4,""];

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};

DK_MIS_fnc_crtHeli_ArmyGhostH = {

	params [["_initVeh", true]];

	_heli = crtFLY("B_CTRG_Heli_Transport_01_sand_F");

	[
		_heli,
		["Black",1], 
		true

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};

DK_MIS_fnc_crtHeliPara_Army = {

	params [["_initVeh", true]];

	_heli = crtFLY("I_Heli_Transport_02_F");

	[
		_heli,
		["AAF", 1], 
		true

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	// Weapon's in heli
	clearBackpackCargoGlobal _heli;

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};

DK_MIS_fnc_crtHeli_Alban = {

	params [["_initVeh", true]];

	_heli = crtFLY("B_Heli_Light_01_F");

	[
		_heli,
		nil,
		["AddTread",1,"AddTread_Short",0]

	] call BIS_fnc_initVehicle;

	_heli setObjectTextureGlobal [0, "a3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa"];

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	// Weapon's in heli
	_heli spawn DK_fnc_LO_heli_Alban;

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};

DK_MIS_fnc_crtHeli_Domi = {

	params [["_initVeh", true]];

	_heli = crtFLY("O_Heli_Light_02_dynamicLoadout_F");

	[
		_heli,
		["Black", 1], 
		true

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};

	// Weapon's in heli
	_heli spawn DK_fnc_LO_heli_Alban;

	_heli setUnloadInCombat [FALSE,FALSE]; 


	_heli
};


///	//	// Pursuit / Reinforcement

/// // On vehicle
DK_fnc_init_rfr = {

	params ["_objTarget", ["_slpTimeMin", 60], ["_slpTimeMax", 60]];


	private _slpTime = _slpTimeMin + (random (_slpTimeMax - _slpTimeMin));


	// Get info mission at vehicle target
	private	_nfoMis = _objTarget getVariable "MIS_nfo";
	_nfoMis params ["_rescuePlace", "_className", "_classGuy", "_uniform", "_weapons", "_vest", "_idMission"];


	// Waiting condition for start reinforcement
	private _time = time + _slpTime;

	waitUntil
	{
		uiSleep 0.5; (isNil "_objTarget") OR (isNull _objTarget) OR !(alive _objTarget) OR (time > _time) OR (speed _objTarget > 10) OR (speed _objTarget < -10) OR !(_idMission isEqualTo DK_idMission)
	};

	if ((isNil "_objTarget") OR (isNull _objTarget) OR !(alive _objTarget) OR !(_idMission isEqualTo DK_idMission)) exitWith {};

	waitUntil
	{
		uiSleep 0.5; (isNil "_objTarget") OR (isNull _objTarget) OR !(alive _objTarget) OR !(playableUnits findIf { _x distance _objTarget < 250 } isEqualTo -1) OR !(_idMission isEqualTo DK_idMission)
	};

	if ((isNil "_objTarget") OR (isNull _objTarget) OR !(alive _objTarget) OR !(_idMission isEqualTo DK_idMission)) exitWith {};


	// Search position safe for spawn Reinforcement
	private _resultSrchSpwn = [_objTarget, nil, nil, _rescuePlace, 2, true, _idMission] call DK_fnc_searchSpawn_rfr; 
	_resultSrchSpwn params ["_spawnPos", "_dir"];

	if !(_spawnPos isEqualTo 0) then
	{
		// Create Reinforcement Vehicle & Crew 
		private _resultCrewVeh = [_className, _classGuy, _uniform, _weapons, _vest, _spawnPos, _dir] call DK_fnc_crtCrewVeh_rfr;
		_resultCrewVeh params ["_unitsCrew", "_grp", "_vehicle"];

		DK_nbSearchSpawnRoad_inProg = false;

		// Start Voice if order forces
		_grp spawn DK_fnc_selectLoopVoice;

		CNT(1);

		// Start AI Follow Objectif
		waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _vehicle) };

		[_unitsCrew, _grp, _vehicle, _objTarget, _idMission, 2, _rescuePlace] call DK_fnc_AiFollow_rfr;

		CNT(-1);
	}
	else
	{
		DK_nbSearchSpawnRoad_inProg = false;
		uiSleep 5;
	};


	// Start a new Renfort script if mission is not finish
	if ( (_idMission isEqualTo DK_idMission) && { (!isNull _objTarget) && { (alive _objTarget) } } ) then
	{
		if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 isEqualTo 1) exitWith
		{
			[_objTarget, 30, 60] spawn DK_fnc_init_rfr;
		};

		if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 > 4) exitWith
		{
			[_objTarget, 60, 120] spawn DK_fnc_init_rfr;
		};

		[_objTarget, 45, 75] spawn DK_fnc_init_rfr;
	};
};


DK_fnc_crtCrewVeh_rfr = {

	params ["_unitClass", "_ennemieType", "_uniform", "_weapons", "_vest", "_spawnPos", "_dir", ["_checkWtd", true], ["_haveMP3", false], ["_MP3on", true]];


	// Set side, Gangs = east ; Cops = Resistance
	private "_InSide";
	call
	{
		if (_unitClass isEqualTo "O_G_Survivor_F") exitWith
		{
			_InSide = east;
		};

		_InSide = resistance;
	};

	// Create Vehicle for reinforcement crew
	private ["_vehicle", "_vehType"];
	private _nbUnitsRfrToAdd = 1;
	private _driverFBIhg = false;

	call
	{
		if _checkWtd then
		{
			_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];

			if ((_wantedLevel >= 8) && {(_wantedLevel < 19)}) exitWith
			{
				_vehicle = [true, false, true] call DK_MIS_fnc_crtVeh_FBI;
				_uniform = "uniform_FBI";
				_vest = "vest_beltFBI";
				_weapons = "wpns_MXC";
				_vehicle setUnloadInCombat [FALSE,FALSE]; 

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

					if (_nbMaxFam isEqualTo 1) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};


					_driverFBIhg = true;

					if (_nbMaxFam > 6) then
					{
						_nbUnitsRfrToAdd = 2;
					};
				};

				_vehType = typeOf _vehicle;
			};

			if (_wantedLevel isEqualTo 19) exitWith
			{
				private _vehNstuffType = DK_vehArmy # 0;
				vehArmyDel(_vehNstuffType);
				_vehicle = [true] call (_vehNstuffType # 0);
				_uniform = _vehNstuffType # 1;
				_vehicle setUnloadInCombat [FALSE,FALSE]; 

				if (DK_vehArmy isEqualTo []) then
				{
					DK_vehArmy = +vehArmy;
					vehArmyDel(_vehNstuffType);
				};

				_vehType = typeOf _vehicle;

				if (_vehType in ["B_T_LSV_01_unarmed_F", "B_LSV_01_armed_F", "B_T_LSV_01_AT_F"]) exitWith
				{
					call
					{
						private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
						if (_nbMaxFam < 4) exitWith
						{
							_nbUnitsRfrToAdd = 0;
						};

						if ( (_nbMaxFam < 8) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
						{
							DK_manageNbRfr = 1;
							_nbUnitsRfrToAdd = 0;
						};

						if (_nbMaxFam isEqualTo 8) then
						{
							_nbUnitsRfrToAdd = 2;
						};

						DK_manageNbRfr = 0;
					};
				};

				if (_vehType in ["I_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F", "I_MBT_03_cannon_F"]) exitWith
				{
					_nbUnitsRfrToAdd = 0;
				};

				if (_vehType in ["I_Truck_02_transport_F", "I_Truck_02_covered_F"]) then
				{
					if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 < 7) then
					{
						_nbUnitsRfrToAdd = 3;
					}
					else
					{
						_nbUnitsRfrToAdd = 5;
					};
				};
			};
		};

		if (!isNil "_vehType") exitWith {};

		if (_ennemieType in ["pigs", "chickens"]) then
		{
			_ennemieType = "Police forces";
		};

		if (_ennemieType in ["Feds", "FIB agents"]) then
		{
			_ennemieType = "FIB agents";
		};

		switch ( _ennemieType ) do
		{
			case "Thugs" :
			{
				_vehicle = [] call DK_MIS_fnc_crtVeh_offrd;
				[_vehicle, 4, true] spawn DK_MIS_fnc_LO_ammo;

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "Looters" :
			{
				private _vehLooters = selectRandom [DK_MIS_fnc_crtVan_looters, DK_MIS_fnc_crtQuad_looters];
				_vehicle = [] call _vehLooters;
				[_vehicle, 4, true] spawn DK_MIS_fnc_LO_ammo;

				call
				{
					if (_vehLooters isEqualTo DK_MIS_fnc_crtQuad_looters) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "Ballas" :
			{
				_vehicle = [true, _haveMP3] call DK_MIS_fnc_crtVeh_ballas;
				[_vehicle, 4, true] spawn DK_MIS_fnc_LO_ammo;

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "Triads" :
			{
				_vehicle = [true, _haveMP3] call DK_MIS_fnc_crtVeh_triads;
				[_vehicle, 4, true] spawn DK_MIS_fnc_LO_ammo;

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "Dominicans" :
			{
				_vehicle = [] call DK_MIS_fnc_crtVeh_Domi;
				[_vehicle, 4, true] spawn DK_MIS_fnc_LO_ammo;

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "Albanians" :
			{
				_vehicle = [] call DK_MIS_fnc_crtVeh_Alban;
				[_vehicle, 4, true] spawn DK_MIS_fnc_LO_ammo;

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "Police forces" :
			{
				_vehicle = [true, false, true] call DK_MIS_fnc_crtVeh_Police;

				call
				{
					private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
					if (_nbMaxFam < 3) exitWith
					{
						_nbUnitsRfrToAdd = 0;
					};

					if ( (_nbMaxFam < 7) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
					{
						DK_manageNbRfr = 1;
						_nbUnitsRfrToAdd = 0;
					};

					DK_manageNbRfr = 0;
				};
			};

			case "FIB agents" :
			{
				_vehicle = [true, false, true] call DK_MIS_fnc_crtVeh_FBI;
				_uniform = "uniform_FBI";
				_vest = "vest_beltFBI";
				_weapons = "wpns_MXC";

				_driverFBIhg = true;
			};

			case "Army" :
			{
				private _vehNstuffType = DK_vehArmyAll # 0;
				vehArmyAllDel(_vehNstuffType);
				_vehicle = [true] call (_vehNstuffType # 0);
				_uniform = _vehNstuffType # 1;
				_vehicle setUnloadInCombat [FALSE,FALSE]; 

				if (DK_vehArmyAll isEqualTo []) then
				{
					DK_vehArmyAll = +vehArmyAll;
					vehArmyAllDel(_vehNstuffType);
				};

				_vehType = typeOf _vehicle;

				if (_vehType in ["B_T_LSV_01_unarmed_F", "B_LSV_01_armed_F", "B_T_LSV_01_AT_F"]) exitWith
				{
					call
					{
						private _nbMaxFam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
						if (_nbMaxFam < 4) exitWith
						{
							_nbUnitsRfrToAdd = 0;
						};

						if ( (_nbMaxFam < 8) && { (DK_manageNbRfr isEqualTo 0) } ) exitWith
						{
							DK_manageNbRfr = 1;
							_nbUnitsRfrToAdd = 0;
						};

						if (_nbMaxFam isEqualTo 8) then
						{
							_nbUnitsRfrToAdd = 2;
						};

						DK_manageNbRfr = 0;
					};
				};

				if (_vehType in ["I_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F", "I_MBT_03_cannon_F"]) exitWith
				{
					_nbUnitsRfrToAdd = 1;
				};

				if (_vehType in ["I_Truck_02_transport_F", "I_Truck_02_covered_F"]) then
				{
					if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 < 7) then
					{
						_nbUnitsRfrToAdd = 3;
					}
					else
					{
						_nbUnitsRfrToAdd = 5;
					};
				};
			};
		};

		_vehType = typeOf _vehicle;
	};

	_vehicle allowDamage false;
	_vehicle enableSimulationGlobal false;

	// Create reinforcement crew
	_grp = createGroup _InSide;

	_unit01 = crtU(_grp,_unitClass);
	_unit02 = crtU(_grp,_unitClass);

	_unitsCrew = [_unit01,_unit02];

	if !(_nbUnitsRfrToAdd isEqualTo 0) then
	{
		private "_unit";

		for "_i" from 1 to _nbUnitsRfrToAdd do
		{
			_unit = crtU(_grp,_unitClass);
			_unitsCrew pushBackUnique _unit;
		};
	};


	private _waitLO = [_unitsCrew, _uniform, _weapons, _vest] spawn DK_MIS_fnc_slctUnitsLO;

	call
	{
		if (_vehType isEqualTo "I_APC_tracked_03_cannon_F") exitWith
		{
			_unitsCrew apply
			{
				_x allowDamage false;
				_x call DK_MIS_addEH_selectSeat;
				_x setVariable ["vehLinkRfr", _vehicle];
				_x setVariable ["DK_roleUnit", "isRfr"];
				_x spawn DK_MIS_addEH_HandleDmg;
				_x spawn DK_MIS_EH_handleAmmoNweapons;
				_x spawn DK_MIS_addEH_secondDead;
				[_x, _vehType] call DK_addEH_getInOut_rfr;
				_x call DK_MIS_fnc_skillTurretVeh;
				DK_unitsStayUp pushBackUnique _x;

				_x moveInAny _vehicle;

				uiSleep 0.1;

				_x call DK_addEH_deadNdel_Mora_rfr;
			};
		};

		if (_vehType isEqualTo "I_MBT_03_cannon_F") exitWith
		{
			_unitsCrew apply
			{
				_x allowDamage false;
				_x call DK_MIS_addEH_selectSeat;
				_x setVariable ["vehLinkRfr", _vehicle];
				_x setVariable ["DK_roleUnit", "isRfr"];
				_x spawn DK_MIS_addEH_HandleDmg;
				_x spawn DK_MIS_EH_handleAmmoNweapons;
				_x spawn DK_MIS_addEH_secondDead;
				[_x, _vehType] call DK_addEH_getInOut_rfr;
				_x call DK_MIS_fnc_skillTurretVeh;
				DK_unitsStayUp pushBackUnique _x;

				_x moveInAny _vehicle;

				uiSleep 0.1;

				_x call DK_addEH_deadNdel_Kuma_rfr;
			};
		};

		if (_vehType isEqualTo "I_APC_Wheeled_03_cannon_F") exitWith
		{
			_unitsCrew apply
			{
				_x allowDamage false;
				_x call DK_MIS_addEH_selectSeat;
				_x setVariable ["vehLinkRfr", _vehicle];
				_x setVariable ["DK_roleUnit", "isRfr"];
				_x spawn DK_MIS_addEH_HandleDmg;
				_x spawn DK_MIS_EH_handleAmmoNweapons;
				_x spawn DK_MIS_addEH_secondDead;
				[_x, _vehType] call DK_addEH_getInOut_rfr;
				_x call DK_MIS_fnc_skillTurretVeh;
				DK_unitsStayUp pushBackUnique _x;

				_x moveInAny _vehicle;

				uiSleep 0.1;

				_x call DK_addEH_deadNdel_Gorgon_rfr;
			};
		};

		_unitsCrew apply
		{
			_x allowDamage false;
			_x call DK_MIS_addEH_selectSeat;
			_x setVariable ["vehLinkRfr", _vehicle];
			_x setVariable ["DK_roleUnit", "isRfr"];
			_x spawn DK_MIS_addEH_HandleDmg;
			_x spawn DK_MIS_EH_handleAmmoNweapons;
			_x spawn DK_MIS_addEH_secondDead;
			[_x, _vehType] call DK_addEH_getInOut_rfr;
			_x call DK_MIS_fnc_skillTurretVeh;
			DK_unitsStayUp pushBackUnique _x;

			_x moveInAny _vehicle;

			uiSleep 0.1;

			_x call DK_addEH_deadNdel_rfr;
		};
	};

	_grp deleteGroupWhenEmpty true;
	_grp setFormation "DIAMOND";
	_grp setBehaviour "COMBAT";
	_grp setCombatMode "RED";
	_grp setSpeedMode "FULL";
	_grp addVehicle _vehicle;

	_unitsCrew orderGetIn true;
	_unitsCrew allowGetIn true;


	_vehicle setDir _dir;
	_vehicle setPosATL _spawnPos;
	_vehicle setVectorUp surfaceNormal _spawnPos;

	_vehicle enableSimulationGlobal true;
	_vehicle allowDamage true;
	_vehicle engineOn true;
	_vehicle setVehicleLock "LOCKEDPLAYER";
	_vehicle setUnloadInCombat [FALSE,FALSE]; 

	_unitsCrew apply
	{
		_x allowDamage true;
		_x setVariable ["group", _grp];
	};

	_grp call DK_fnc_delAllWp;

	if _driverFBIhg then
	{
		[(driver _vehicle), _waitLO] spawn
		{
			params ["_driver", "_waitLO"];


			_driver removeWeapon (primaryWeapon _driver);
			[_waitLO, _driver] call DK_fnc_LO_FBIhg;
		};
	};


	[_unitsCrew, _grp, _vehicle]
};

DK_fnc_searchSpawn_rfr = {

	params ["_objTarget", ["_disMin", 250], ["_disMax", 550], "_rescuePlace", ["_condLoop", 1], ["_checkVis", true], ["_idMission", "-1"]];


	if (isNil "_objTarget") exitWith
	{
		[0, 0];
	};

	private ["_goodPos", "_goodPosASL", "_road", "_roads", "_lapsVis", "_fnc_rescueP"];

	private _fnc_condSSVOR = [_condLoop, _objTarget, _idMission] call DK_MIS_fnc_slctCondLoop;

	// Change rescue place to front target if isNil "_rescuePlace"
	call
	{
		if (isNil "_rescuePlace") exitWith
		{
			_fnc_rescueP = { _objTarget getPos [15, getDir _objTarget] };
		};

		_fnc_rescueP = { _rescuePlace };
	};


	// Secure for have only one search in same time, for prevent vehcile explose, spawn at same place, and friendly perf ;)
	waitUntil { uiSleep 0.2; !(DK_nbSearchSpawnRoad_inProg) OR !(call _fnc_condSSVOR) };

	if !(call _fnc_condSSVOR) exitWith
	{
		[0, 0];
	};

	DK_nbSearchSpawnRoad_inProg = true;

	call
	{
		if (_disMin < 400) exitWith
		{
			_lapsVis = 5;
		};

		_lapsVis = 0;
	};
	private _disToAdd = -10;
	private _lapsDirRescue = 0;

	private _directions = [0] + ([11.25, -11.25] call KK_fnc_arrayShuffle) + ([22.5, -22.5] call KK_fnc_arrayShuffle) + ([33.75, -33.75] call KK_fnc_arrayShuffle);
	private _actualDisDirRescue = _disMin;
	private _dirStep = -1;
	private _radiusDirRescue = 29.5;

	private _exit = false;
	while { call _fnc_condSSVOR } do
	{
		_dirStep = _dirStep + 1;

		if (_dirStep > 6) then
		{
			_dirStep = 0;
			_speedCar = speed _objTarget;
			if (_speedCar < 0) then
			{
				_speedCar = 0;
			};				

			_actualDisDirRescue = _actualDisDirRescue + (_disToAdd + 50) + (_speedCar);
			if (_actualDisDirRescue > (_disMax + _speedCar)) then
			{
				_lapsDirRescue = _lapsDirRescue + 1;

				_actualDisDirRescue = _disMin;
				_radiusDirRescue = 29.5;
			};

			_radiusDirRescue = _radiusDirRescue + 4;
		};

		if (_lapsDirRescue < 6) then
		{
			_roads = (_objTarget getPos [_actualDisDirRescue, (_objTarget getDir (call _fnc_rescueP)) + (_directions # _dirStep)]) nearRoads _radiusDirRescue;
		}
		else
		{
			_roads = (_objTarget getPos [_actualDisDirRescue, (getDir _objTarget) + (_directions # _dirStep)]) nearRoads _radiusDirRescue;
		};


		if !(_roads isEqualTo []) then
		{
			_road = selectRandom _roads;
			_goodPos = getPosATL _road;

			if ( ((DK_mkrs_spawnProtect findIf { _goodPos inArea _x; }) isEqualTo -1) && { (DK_mkrs_noSpawnVeh findIf { _goodPos inArea _x; } isEqualTo -1) && { ([_goodPos,35,25] call DK_fnc_placeOK) && { (playableUnits findIf { _x distance2D _goodPos < 80 } isEqualTo -1) && { ((nearestTerrainObjects [_goodPos, [], 15, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) } } } } ) then
			{
				if (_checkVis) then
				{
					_goodPosASL = getPosASL _road;
					_goodPosASL set [2, (_goodPosASL # 2) + 1];

					if (_lapsVis < 5) then
					{
						if (_actualDisDirRescue > _disMax) then
						{
							_lapsVis = _lapsVis + 1;
						};


//						if ( playableUnits findIf { ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _goodPosASL] > 0) && { (_x distance _goodPosASL < 450) } } isEqualTo -1 ) then
						if ( playableUnits findIf { !(lineIntersects [_x call DK_fnc_eyePlace, _goodPosASL]) && { (_x distance _goodPosASL < 450) } } isEqualTo -1 ) then
						{
/*							if (_actualDisDirRescue > _disMax) then
							{
								_lapsVis = _lapsVis + 1;
							};
*/
							_exit = true;
						};
					}
					else
					{
						if ( playableUnits findIf { !(lineIntersects [_x call DK_fnc_eyePlace, _goodPosASL]) && { (_x distance _goodPosASL < 200) } } isEqualTo -1 ) then
//						if ( playableUnits findIf { ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _goodPosASL] > 0) && { (_x distance _goodPosASL < 200) } } isEqualTo -1 ) then
						{
							_exit = true;
						};
					};
				}
				else
				{
					_exit = true;
				};
			};
		};

		if _exit exitWith {};

		uiSleep 0.03;
	};

	private _dir = 0;
	if (_exit) then
	{
		private _roadsCo = roadsConnectedTo _road;
		private _disAry = [];
		for "_i" from 0 to (count _roadsCo) - 1 step 1 do
		{
			_disAry pushBack ((_roadsCo # _i) distance2D _objTarget);
		};

		private _goodDis = _disAry findIf { (selectMin _disAry) isEqualTo _x };
		if !(_goodDis isEqualTo -1) then
		{
			_dir = ((_roadsCo # _goodDis) getRelDir _goodPos) - 180;
		}
		else
		{
			_dir = _road getRelDir _objTarget;
		};

		if (isNil "_dir") then
		{
			_dir = 0;
		};
	}
	else
	{
		_goodPos = 0;
	};

	[_goodPos,_dir]
};


DK_fnc_AiFollow_rfr = {

	params ["_unitsCrew", "_grp", "_vehicleRfr", "_objTarget", ["_idMission", "-1"], ["_condLoop", 1], "_rescuePlace", ["_combatMode", "RED"], ["_timeAdd", 12]];


	if (isNil "_objTarget") exitWith {};
	if (isNil "_rescuePlace") then
	{
		_rescuePlace = getMarkerPos "DK_mkr_middleMapSearch";
	};

	private "_idEHs";

	_grp call DK_fnc_delAllWp;
	_vehicleRfr forceSpeed 250;
	_vehicleRfr limitSpeed 200;
	_vehicleRfr forceFollowRoad false;

	// Only if is renfort patrol (no mission)
	if ( (_objTarget isKindOf "Man") && { (side _objTarget isEqualTo (side _grp)) && { ((leader _grp) getVariable ["DK_side", ""] in ["cops", "fbi", "army"]) } } ) exitWith
	{
		[_unitsCrew, _vehicleRfr, _grp, _objTarget] spawn DK_fnc_finishChase_CopsPatrol;
	};

	// AI Loop Pursuit START
	switch (typeOf _vehicleRfr) do
	{
		case "B_GEN_Van_02_transport_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_Van_rfr;
		};

		case "I_Truck_02_transport_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_Zamack_rfr;
		};

		case "I_Truck_02_covered_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_Zamack_rfr;
		};

		case "I_MRAP_03_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_MRAP_rfr;
		};

		case "I_APC_tracked_03_cannon_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_Mora_rfr;
		};

		case "I_APC_Wheeled_03_cannon_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_Gorgon_rfr;
		};

		case "I_MBT_03_cannon_F" :
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _timeAdd] call DK_loop_AiFollow_Kuma_rfr;
		};

		default
		{
			[_condLoop, _grp, _unitsCrew, _objTarget, _vehicleRfr, _rescuePlace, _idMission, _combatMode, _timeAdd] call DK_loop_AiFollow_offRoads_rfr;
		};
	};

	// AI Loop Pursuit END
	if ( (isNull _vehicleRfr) && {(units _grp findIf {alive _x} isEqualTo -1)} ) exitWith {};

	_unitsCrew = units _grp;

	// Only if is renfort patrol (no mission)
	if (_condLoop isEqualTo 1) exitWith
	{
		[_unitsCrew, _vehicleRfr, _grp, _objTarget] spawn DK_fnc_finishChase_CopsPatrol;
	};

	// Only for gangs mission 2
	if (_condLoop isEqualTo 3) exitWith
	{
		_grp call DK_fnc_delAllWp;
		if ( (!isNull (objectParent (leader _grp))) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) } } ) then
		{
			[_unitsCrew, _vehicleRfr, _grp, _objTarget] spawn DK_MIS_fnc_nextChase;
		}
		else
		{
			_grp addVehicle _vehicleRfr;
			_unitsCrew orderGetIn true;
			_unitsCrew allowGetIn true;

			_waypoint = [_grp, _vehicleRfr, " [thisList, (group this) getVariable 'assignedVeh', (group this)] spawn DK_MIS_fnc_nextChase ", "true", "GETIN", nil, if (!isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}, if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"AWARE"}] call DK_fnc_AddWaypointState;
		};
	};

	_vehicleRfr setVehicleLock "UNLOCKED";

	private _timeDel = 0;
	private _disDel = 130;
	if ( !(isNil "_vehicleRfr") && !(isNull _vehicleRfr) && { (canMove _vehicleRfr) && { (!(typeOf _vehicleRfr in ["I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"]) && {(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1)}) } } ) then
	{
		_timeDel = 90;
		_disDel = 250;
	};

	private "_waypoint";
	call
	{
	///	// Go Reinforcement to rescue place if they are near
		if ( (!isNil "_objTarget") && { (_objTarget distance (leader _grp) < 450) } ) exitWith
		{
			_unitsCrew apply
			{
				if ( (!isNull _x) && { (alive _x) } ) then
				{
					[_x,_timeDel,_disDel,true] spawn DK_fnc_addAllTo_CUM;
					if (_objTarget isEqualType []) then
					{
						_x doMove _objTarget;
					}
					else
					{
						_x doMove (getPosATL _objTarget);
					};
				};
			};

			_waypoint = [_grp, _rescuePlace, "GETOUT", "DIAMOND", "FULL", "AWARE", 40] call DK_fnc_AddWaypoint;
//			_waypoint = [_grp, _objTarget, "GETOUT", "DIAMOND", "FULL", "AWARE", 30] call DK_fnc_AddWaypoint;

			private _time01 = time + 20;
			private _time02 = time + 60;
			waitUntil { uiSleep 2; (_unitsCrew findIf {alive _x} isEqualTo -1) OR ( (speed leader _grp < 7) && { (leader _grp distance2D _objTarget < 40) OR (time > _time01) } ) OR (time > _time02) };

			if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicleRfr;

			uiSleep 0.7;

			if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

			if (time > _time02) then
			{
				_grp call DK_fnc_delAllWp;
				doStop _unitsCrew;
				_waypoint = [_grp, leader _grp, "GETOUT", "DIAMOND", "FULL", "AWARE", 10] call DK_fnc_AddWaypoint;
			};

			{
				if ( (!isNull (objectParent _x)) && {(alive _x)} ) then
				{
					moveOut _x;
				};

			} count _unitsCrew;

			_waypoint = [_grp, _objTarget, "SAD", "DIAMOND", "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
		};

	///	// Go Reinforcement to objectif target if is near
		_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfDisembark_rfr;

		if _haveDisembark exitWith
		{
			_unitsCrew apply
			{
				if ( (!isNull _x) && { (alive _x) } ) then
				{
					[_x,_timeDel,_disDel,true] spawn DK_fnc_addAllTo_CUM;
				};
			};
		};

		if !(playableUnits findIf {leader _grp distance2D _x < 80} isEqualTo -1) exitWith
		{
			_waypoint = [_grp, leader _grp, "GETOUT", "DIAMOND", "FULL", "AWARE", 50] call DK_fnc_AddWaypoint;
			_waypoint = [_grp, leader _grp, "SAD", "DIAMOND", "FULL", "COMBAT"] call DK_fnc_AddWaypoint;

			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicleRfr;
	
			_unitsCrew apply
			{
				if ( (!isNull _x) && { (alive _x) } ) then
				{
					unassignVehicle _x;
					[_x,_timeDel,_disDel,true] spawn DK_fnc_addAllTo_CUM;
				};
			};
		};

	///	// Or go to clean up and far away
		if !(_unitsCrew findIf {alive _x} isEqualTo -1) then
		{
			_unitsCrew apply
			{
				if ( (!isNull _x) && { (alive _x) } ) then
				{
					[_x,3,160,true] spawn DK_fnc_addAllTo_CUM;
					_idEHs = _x getVariable ["DK_idEhInOut_rfr", []];
					if !(_idEHs isEqualTo []) then
					{
						_x removeEventHandler ["GetInMan", _idEHs # 0];
						_x removeEventHandler ["GetOutMan", _idEHs # 1];
					};
					_x call (_x getVariable "DK_skill");
					_x allowFleeing 1;
					_x setSkill ["courage", 0];
				};
			};

			[_grp] spawn DK_fnc_moveAIfarAway_rfr;
		};
	};

	if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR (!(typeOf _vehicleRfr in ["I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"]) && {!(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1)}) ) then 
	{
		_unitsCrew apply
		{
			if ( (!isNull _x) && { (alive _x) } ) then
			{
				unassignVehicle _x;
			};
		};
	};

	if ( (!isNull _vehicleRfr) && { (alive _vehicleRfr) } ) then
	{
		_vehicleRfr call DK_MIS_fnc_vehicle_removeAllEH;
		_vehicleRfr call DK_MIS_reInitVehNormal;
		_vehicleRfr call DK_MIS_fnc_initVehWhenEnd;
	};
};

DK_loop_AiFollow_offRoads_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_vehicleRfr", "_rescuePlace", "_idMission", ["_combatMode", "RED"], ["_timeAdd", 12]];


	private ["_speedToDis", "_driver", "_fnc_move", "_disIsFar", "_fnc_condSSVOR", "_minCops"];
	private _time = time + _timeAdd;

	private _haveDisembark = false;
	if !(_unitsCrew findIf { isNull (objectParent _x) } isEqualTo -1) then
	{
		_haveDisembark = true;
	};

	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move = { _objTarget getPos [25 + _speedToDis, _objTarget getDir _rescuePlace] };
	}
	else
	{
		_fnc_move = { _objTarget getPos [20 + _speedToDis, getDir (vehicle _objTarget)] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};


	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

			_minCops = 1;
		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

			_minCops = 2;
		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

			_minCops = 1;
		};
	};

	_grp setSpeedMode "FULL";

	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;

		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		if (_speedToDis < 0) then
		{
			_speedToDis = 0;
		};
		_unitsCrew doMove (call _fnc_move);

		// Force fire Target objectif
		_driver = driver _objTarget;
		if (alive _driver) then
		{
			(_unitsCrew - [driver _vehicleRfr]) apply
			{
				_x reveal [_driver, 4];
				_x commandTarget _driver;
				_x doTarget _driver;
			};
		};

		_grp setCombatMode _combatMode;


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < _minCops) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		uiSleep 1.5;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < _minCops) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Check for Disembark crew
		if !(_haveDisembark) then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfDisembark_rfr;
		};
	
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < _minCops) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		uiSleep 1.5;

		// Check for Embark crew
		if _haveDisembark then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp, _disIsFar] call DK_fnc_checkIfEmbark_rfr;
		};


		// Exit
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < _minCops) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};
	};
};

DK_loop_AiFollow_Van_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_vehicleRfr", "_rescuePlace", "_idMission", ["_timeAdd", 12]];


	private ["_speedToDis", "_driver", "_fnc_move1", "_fnc_move2", "_disIsFar", "_fnc_condSSVOR"];

	if (_condLoop isEqualTo 4) then
	{
		_condLoop = 1;
	};
	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

		};
	};

	_vehicleRfr animateDoor ["Door_3_source", 1, false];
	_vehicleRfr animateDoor ["Door_4_source", 1, false];

	private _haveDisembark = false;
	private _time = time + _timeAdd;

	if !(_unitsCrew findIf { isNull (objectParent _x) } isEqualTo -1) then
	{
		_haveDisembark = true;
	};

	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move1 = { _objTarget getPos [15, _objTarget getDir _rescuePlace] };
		_fnc_move2 = { _objTarget getPos [50 + _speedToDis, (_objTarget getDir _rescuePlace) - 25] };
	}
	else
	{
		_fnc_move1 = { _objTarget getPos [15, getDir (vehicle _objTarget)] };
		_fnc_move2 = { _objTarget getPos [50 + _speedToDis, (getDir (vehicle _objTarget)) - 25] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};

	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;

		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		call
		{
			if (_speedToDis < 7) exitWith
			{
				_unitsCrew doMove (call _fnc_move1);
			};

			_unitsCrew doMove (call _fnc_move2);;
		};

		// Force fire Target objectif
		_driver = driver _objTarget;
		if (alive _driver) then
		{
			(_unitsCrew - [driver _vehicleRfr]) apply
			{
				_x reveal [_driver, 4];
				_x commandTarget _driver;
				_x doTarget _driver;
			};
		};


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		uiSleep 1.5;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Check for Disembark crew
		if !(_haveDisembark) then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfDisembark_Van_rfr;
		};
	
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		// Check for Embark crew
		if _haveDisembark then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfEmbark_Van_rfr;
		};


		// Exit
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 115) ) exitWith {};

		uiSleep 1.5;
	};
};

DK_loop_AiFollow_Zamack_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_vehicleRfr", "_rescuePlace", "_idMission", ["_timeAdd", 13]];


	private ["_speedToDis", "_driver", "_fnc_move", "_disIsFar", "_fnc_condSSVOR"];

	if (_condLoop isEqualTo 4) then
	{
		_condLoop = 1;
	};
	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

		};
	};

	private _haveDisembark = false;
	private _time = time + _timeAdd;

	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move = { _objTarget getPos [40 + _speedToDis, _objTarget getDir _rescuePlace] };
	}
	else
	{
		_fnc_move = { _objTarget getPos [40 + _speedToDis, getDir (vehicle _objTarget)] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};


	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;

		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		if (_speedToDis < 0) then
		{
			_speedToDis = 0;
		};

		call
		{
			if (leader _grp isEqualTo (vehicle (leader _grp))) then
			{
				_unitsCrew doMove (getPosATL _objTarget);
			};

			_unitsCrew doMove (call _fnc_move);
		};


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		uiSleep 1.5;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Check for Disembark crew
		if !(_haveDisembark) then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfDisembark_Zamack_rfr;
		};
	
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		// Check for Embark crew
		if _haveDisembark then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfDisembark_Zamack_rfr;
		};


		// Exit
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		uiSleep 1.5;
	};
};

DK_loop_AiFollow_MRAP_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_vehicleRfr", "_rescuePlace", "_idMission", ["_timeAdd", 13]];


	private ["_speedToDis", "_driver", "_fnc_move", "_disIsFar", "_fnc_condSSVOR"];

	if (_condLoop isEqualTo 4) then
	{
		_condLoop = 1;
	};
	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

		};
	};

	private _haveDisembark = false;
	private _time = time + _timeAdd;

	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move = { _objTarget getPos [25 + _speedToDis, _objTarget getDir _rescuePlace] };
	}
	else
	{
		_fnc_move = { _objTarget getPos [25 + _speedToDis, getDir (vehicle _objTarget)] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};


	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;

		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		if (_speedToDis < 0) then
		{
			_speedToDis = 0;
		};
		_unitsCrew doMove (call _fnc_move);


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		uiSleep 1.5;

		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Check for Disembark crew
		if !(_haveDisembark) then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfDisembark_MRAP_rfr;
		};
	
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		// Check for Embark crew
		if _haveDisembark then
		{
			_haveDisembark = [_vehicleRfr, _objTarget, _unitsCrew, _grp] call DK_fnc_checkIfEmbark_MRAP_rfr;
		};


		// Exit
		if ( (isNull _vehicleRfr) OR !(canMove _vehicleRfr) OR !(DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) OR ({alive _x} count _unitsCrew < 2) OR (leader _grp distance _vehicleRfr > 150) ) exitWith {};

		uiSleep 1.5;
	};
};

DK_loop_AiFollow_Mora_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_veh", "_rescuePlace", "_idMission", ["_timeAdd", 15]];


	private ["_speedToDis", "_driver", "_fnc_move1", "_fnc_move2", "_disIsFar", "_fnc_condSSVOR"];

	if (_condLoop isEqualTo 4) then
	{
		_condLoop = 1;
	};
	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

		};
	};


	private _time = time + _timeAdd;

	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move1 = { _objTarget getPos [25, _objTarget getDir _rescuePlace] };
		_fnc_move2 = { _objTarget getPos [30 + _speedToDis, _objTarget getDir _rescuePlace] };
	}
	else
	{
		_fnc_move1 = { _objTarget getPos [25, getDir (vehicle _objTarget)] };
		_fnc_move2 = { _objTarget getPos [30 + _speedToDis, getDir (vehicle _objTarget)] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};


	_grp setBehaviour "CARELESS";

	{
		_x disableAI "FSM";

	} count _unitsCrew;

	uiSleep 0.1;
	private _comm = effectiveCommander _veh;
	if (!isNil "_comm") then
	{
		_comm disableAI "ANIM";
//		_comm disableAI "TARGET";
//		_comm disableAI "AUTOTARGET";
	};

	_grp setBehaviour "AWARE";
	_grp setCombatMode "YELLOW";
	

	private _headTime0 = time + 20;
	private _headTime1 = time + 10;
	private _headTime2 = time + 10;
	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;

		// Take out heads
		call
		{
			if ((crew _veh) findIf {alive _x} isEqualTo -1) exitWith
			{
				_grp setBehaviour "COMBAT";
				_grp setCombatMode "YELLOW";
				{
					_x enableAI "TARGET";
					_x enableAI "AUTOTARGET";

				} count _unitsCrew;
			};

			call
			{
				if ( (time > _headTime1) OR (speed _veh > 45) ) exitWith
				{
					_headTime2 = time + 6;
					_headTime1 = time + 15;
					_grp setCombatMode "GREEN";
				};

				if ( (time > _headTime2) && { (speed _veh <= 45) } ) then
				{
					_headTime1 = time + 5;
					_headTime2 = time + 12;
					_grp setCombatMode "YELLOW";
				};
			};
		};


		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		call
		{
			if (_speedToDis < 7) exitWith
			{
				_unitsCrew doMove (call _fnc_move1);
			};

			_unitsCrew doMove (call _fnc_move2);
		};


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _veh, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		uiSleep 3;

		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _veh, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Exit
		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		uiSleep 2;
	};

	_grp setBehaviour "COMBAT";
	_grp setCombatMode "YELLOW";
	{
		_x enableAI "TARGET";
		_x enableAI "AUTOTARGET";
		_x enableAI "ANIM";

	} count _unitsCrew;
};

DK_loop_AiFollow_Kuma_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_veh", "_rescuePlace", "_idMission", ["_timeAdd", 15]];


	private ["_speedToDis", "_driver", "_fnc_move1", "_fnc_move2", "_disIsFar", "_fnc_condSSVOR"];

	if (_condLoop isEqualTo 4) then
	{
		_condLoop = 1;
	};
	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

		};
	};


	private _time = time + _timeAdd;

	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move1 = { _objTarget getPos [25, _objTarget getDir _rescuePlace] };
		_fnc_move2 = { _objTarget getPos [30 + _speedToDis, _objTarget getDir _rescuePlace] };
	}
	else
	{
		_fnc_move1 = { _objTarget getPos [25, getDir (vehicle _objTarget)] };
		_fnc_move2 = { _objTarget getPos [30 + _speedToDis, getDir (vehicle _objTarget)] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};


	_grp setBehaviour "CARELESS";

	{
		_x disableAI "FSM";

	} count _unitsCrew;

	uiSleep 0.1;
	private _comm = effectiveCommander _veh;
	if (!isNil "_comm") then
	{
		_comm disableAI "ANIM";
		_comm disableAI "TARGET";
		_comm disableAI "AUTOTARGET";
	};

	_grp setBehaviour "AWARE";
	_grp setCombatMode "YELLOW";


	private _headTime1 = time + 3;
	private _headTime2 = time + 10;
	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;

		// Take out heads
		call
		{
			if ((crew _veh) findIf {alive _x} isEqualTo -1) exitWith
			{
				_grp setBehaviour "COMBAT";
				_grp setCombatMode "YELLOW";
				{
					_x enableAI "TARGET";
					_x enableAI "AUTOTARGET";

				} count _unitsCrew;
			};

			call
			{
				if ( (time > _headTime1) OR (speed _veh > 45) ) exitWith
				{
					_headTime2 = time + 6;
					_headTime1 = time + 15;
					_grp setCombatMode "GREEN";
				};

				if ( (time > _headTime2) && { (speed _veh <= 45) } ) then
				{
					_headTime1 = time + 5;
					_headTime2 = time + 12;
					_grp setCombatMode "YELLOW";
				};
			};
		};


		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		call
		{
			if (_speedToDis < 7) exitWith
			{
				_unitsCrew doMove (call _fnc_move1);
			};

			_unitsCrew doMove (call _fnc_move2);
		};


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _veh, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		uiSleep 3;

		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _veh, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Exit
		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		uiSleep 2;
	};

	_grp setBehaviour "COMBAT";
	_grp setCombatMode "YELLOW";
	{
		_x enableAI "TARGET";
		_x enableAI "AUTOTARGET";
		_x enableAI "ANIM";

	} count _unitsCrew;
};

DK_loop_AiFollow_Gorgon_rfr = {

	params ["_condLoop", "_grp", "_unitsCrew", "_objTarget", "_veh", "_rescuePlace", "_idMission", ["_timeAdd", 12]];


	private ["_speedToDis", "_driver", "_fnc_move1", "_fnc_move2", "_disIsFar", "_fnc_condSSVOR"];

	if (_condLoop isEqualTo 4) then
	{
		_condLoop = 1;
	};
	switch (_condLoop) do
	{
		case 1 :
		{
			if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } }
				};
			}
			else
			{
				_fnc_condSSVOR = {

					(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
				};
			};

		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};

		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !(lifeState _objTarget isEqualTo "INCAPACITATED") } } } }
			};

		};
	};


	if ( (!isNil "_rescuePlace") && { !(_rescuePlace isEqualTo _objTarget) } ) then
	{
		_fnc_move1 = { _objTarget getPos [25, _objTarget getDir _rescuePlace] };
		_fnc_move2 = { _objTarget getPos [30 + _speedToDis, _objTarget getDir _rescuePlace] };
	}
	else
	{
		_fnc_move1 = { _objTarget getPos [25, getDir (vehicle _objTarget)] };
		_fnc_move2 = { _objTarget getPos [30 + _speedToDis, getDir (vehicle _objTarget)] };
	};

	if (_objTarget in DK_MIS_allTargets) then
	{
		_disIsFar = 100;
	}
	else
	{
		_disIsFar = 150;
	};


	_grp setBehaviour "CARELESS";

	{
		_x disableAI "FSM";

	} count _unitsCrew;

	uiSleep 0.1;
	private _comm = effectiveCommander _veh;
	if (!isNil "_comm") then
	{
		_comm disableAI "ANIM";
		_comm disableAI "TARGET";
		_comm disableAI "AUTOTARGET";
	};

	_grp setBehaviour "AWARE";
	_grp setCombatMode "YELLOW";


	private _headTime1 = time + 3;
	private _headTime2 = time + 10;
	private _time = time + _timeAdd;
	while { call _fnc_condSSVOR } do
	{
		_unitsCrew = units _grp;


		// Take out heads
		call
		{
			if ((crew _veh) findIf {alive _x} isEqualTo -1) exitWith
			{
				_grp setBehaviour "COMBAT";
				_grp setCombatMode "YELLOW";
				{
					_x enableAI "TARGET";
					_x enableAI "AUTOTARGET";

				} count _unitsCrew;
			};

			call
			{
				if ( (time > _headTime1) OR (speed _veh > 45) ) exitWith
				{
					_headTime2 = time + 6;
					_headTime1 = time + 15;
					_grp setCombatMode "GREEN";
				};

				if ( (time > _headTime2) && { (speed _veh <= 45) } ) then
				{
					_headTime1 = time + 5;
					_headTime2 = time + 12;
					_grp setCombatMode "YELLOW";
				};
			};
		};


		// Move units at Target objectif
		_speedToDis = speed _objTarget;
		call
		{
			if (_speedToDis < 7) exitWith
			{
				_unitsCrew doMove (call _fnc_move1);
			};

			_unitsCrew doMove (call _fnc_move2);
		};


		// Check if renfort is so far 1st
		[_time, _grp, _objTarget, _veh, _disIsFar] call DK_fnc_delIfFar_rfr;

		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		uiSleep 3;

		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		// Check if renfort is so far 2scnd
		[_time, _grp, _objTarget, _veh, _disIsFar] call DK_fnc_delIfFar_rfr;


		// Exit
		if ( (isNull _veh) OR !(canMove _veh) OR ({alive _x} count _unitsCrew < 3) OR (leader _grp distance _veh > 115) ) exitWith {};

		uiSleep 2;
	};

	_grp setBehaviour "COMBAT";
	_grp setCombatMode "YELLOW";
	{
		_x enableAI "TARGET";
		_x enableAI "AUTOTARGET";
		_x enableAI "ANIM";

	} count _unitsCrew;
};


DK_fnc_checkIfDisembark_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp"];


	private _haveDisembark = false;

	if ( (speed _objTarget < 12) && { (speed _vehicleRfr < 17) && { (_objTarget distance _vehicleRfr < 55) && { !((crew _vehicleRfr) findIf {alive _x} isEqualTo -1) } } } ) then
	{
		_grp call DK_fnc_delAllWp;
		_unitsCrew doFollow (leader _grp);
		_unitsCrew apply
		{
			doStop _x;
		};

		private _driver = driver _vehicleRfr;
		_driver disableAI "MOVE";

		waitUntil { (!isNull _vehicleRfr) OR ((speed _vehicleRfr < 6) && { (isTouchingGround _vehicleRfr) }) };

		_driver enableAI "MOVE";

		private _unitsCrew = units _grp;
		if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) } ) then
		{
			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicleRfr;
			_unitsCrew apply
			{
				unassignVehicle _x;
				if (alive _x) then
				{
					doGetOut _x;
					uiSleep (random 0.2);
					moveOut _x;
				};
			};

			_haveDisembark = true;

			_waypoint = [_grp, if ( (!isNil "_objTarget") && { (!isNull _objTarget) } ) then { _objTarget } else { leader _grp }, "SAD", nil,  "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
		};
	};


	_haveDisembark
};

DK_fnc_checkIfDisembark_Van_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp"];


	private _haveDisembark = false;

	if ( (speed _objTarget < 15) && { (speed _vehicleRfr < 15) && { (_objTarget distance _vehicleRfr < 80) && { !((crew _vehicleRfr) findIf {alive _x} isEqualTo -1) } } } ) then
	{
		_grp call DK_fnc_delAllWp;
		_unitsCrew doFollow (leader _grp);
		_unitsCrew apply
		{
			doStop _x;
		};

		private _driver = driver _vehicleRfr;
		_driver disableAI "MOVE";

		waitUntil { (!isNull _vehicleRfr) OR ((speed _vehicleRfr < 6) && { (isTouchingGround _vehicleRfr) }) };

		_driver enableAI "MOVE";

		private _unitsCrew = units _grp;
		if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) } ) then
		{
			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicleRfr;
			_unitsCrew apply
			{
				unassignVehicle _x;
				if (alive _x) then
				{
					doGetOut _x;
					uiSleep (random 0.2);
					moveOut _x;
				};
			};


			_haveDisembark = true;

			_waypoint = [_grp, if ( (!isNil "_objTarget") && { (!isNull _objTarget) } ) then { _objTarget } else { leader _grp }, "SAD", nil,  "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
		};
	};


	_haveDisembark
};

DK_fnc_checkIfDisembark_Zamack_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp"];


	private _haveDisembark = false;

	if ( (speed _objTarget < 25) && { (speed _vehicleRfr < 25) && { (_objTarget distance _vehicleRfr < 100) && { !((crew _vehicleRfr) findIf {alive _x} isEqualTo -1) } } } ) then
	{
		_grp call DK_fnc_delAllWp;
		_unitsCrew doFollow (leader _grp);
		_unitsCrew apply
		{
			doStop _x;
		};

		private _driver = driver _vehicleRfr;
		_driver disableAI "MOVE";

		waitUntil { (!isNull _vehicleRfr) OR ((speed _vehicleRfr < 6) && { (isTouchingGround _vehicleRfr) }) };

		_driver enableAI "MOVE";

		private _unitsCrew = units _grp;
		if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) } ) then
		{
			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicleRfr;
			_unitsCrew apply
			{
				unassignVehicle _x;
				if (alive _x) then
				{
					doGetOut _x;
				};
			};

			_haveDisembark = true;

			_waypoint = [_grp, if ( (!isNil "_objTarget") && { (!isNull _objTarget) } ) then { _objTarget } else { leader _grp }, "SAD", nil,  "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
		};
	};


	_haveDisembark
};

DK_fnc_checkIfDisembark_MRAP_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp"];


	private _haveDisembark = false;

	if ( (speed _objTarget < 20) && { (speed _vehicleRfr < 20) && { (_objTarget distance _vehicleRfr < 80) && { !((crew _vehicleRfr) findIf {alive _x} isEqualTo -1) } } } ) then
	{
		_grp call DK_fnc_delAllWp;
		_unitsCrew doFollow (leader _grp);
		_unitsCrew apply
		{
			doStop _x;
		};

		private _driver = driver _vehicleRfr;
		_driver disableAI "MOVE";

		waitUntil { (!isNull _vehicleRfr) OR ((speed _vehicleRfr < 7) && { (isTouchingGround _vehicleRfr) }) };

		_driver enableAI "MOVE";

		private _unitsCrew = units _grp;
		if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) } ) then
		{
			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicleRfr;
			_unitsCrew apply
			{
				unassignVehicle _x;
				if (alive _x) then
				{
					doGetOut _x;
				};
			};


			_haveDisembark = true;

			_waypoint = [_grp,  if ( (!isNil "_objTarget") && { (!isNull _objTarget) } ) then { _objTarget } else { leader _grp }, "SAD", nil,  "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
		};
	};


	_haveDisembark
};

DK_fnc_checkIfEmbark_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp", ["_disIsFar", 80]];


	{
		_x setVariable ["stopEmbark", false];

	} count _unitsCrew;

	private _haveDisembark = true;
	private _dis = _objTarget distance (leader _grp);

	if ( (_dis >= 65) OR ( (_dis > 20) && { (speed _objTarget >= 26) } ) ) then
	{
		if ( (({alive _x} count crew _vehicleRfr) isEqualTo 0) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) } } ) then
		{
			_grp call DK_fnc_delAllWp;

			_grp addVehicle _vehicleRfr;
			_unitsCrew allowGetIn true;
			_unitsCrew orderGetIn true;
			_grp setBehaviour "CARELESS";

			_waypoint = [_grp, _vehicleRfr, " if (!isServer) exitWith {}; (group this) setVariable ['AiInVeh_WpIsDeleted', true]; (group this) setBehaviour 'COMBAT' ", "true", "GETIN", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypointState;


			_unitsCrew apply
			{
				[_x, _vehicleRfr, _grp] spawn DK_fnc_forceEmbark_rfr;
			};

			waitUntil { uiSleep 0.7; [0, _grp, _objTarget, _vehicleRfr, _disIsFar] call DK_fnc_delIfFar_rfr; (isNil "_vehicleRfr") OR (isNull _vehicleRfr) OR (!alive _vehicleRfr) OR (({alive _x} count crew _vehicleRfr) isEqualTo ({alive _x} count _unitsCrew)) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR ( ((leader _grp) distance _objTarget < 65) && { (speed _objTarget < 26) } ) };


		///	// Re-Embark if Objectif target is near while boarding
			_unitsCrew = units _grp;
			if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) && { (alive _vehicleRfr) } } ) then
			{
				_grp call DK_fnc_delAllWp;

				call
				{
					if ( ((leader _grp) distance _objTarget <= 66) && { (speed _objTarget <= 27) } ) exitWith
					{
						{
							_x setVariable ["stopEmbark", true];

						} count _unitsCrew;

						_unitsCrew orderGetIn false;
						_unitsCrew allowGetIn false;
						_grp leaveVehicle _vehicleRfr;
						{
							if (alive _x) then
							{
								unassignVehicle _x;
								moveOut _x;
								uiSleep (random 0.3);
							};

						} count _unitsCrew;

						_waypoint = [_grp, leader _grp, "SAD", nil, "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
					};

					_grp setBehaviour "COMBAT";
					_haveDisembark = false;
				};
			};
		};
	};


	_haveDisembark
};

DK_fnc_checkIfEmbark_Van_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp"];


	{
		_x setVariable ["stopEmbark", false];

	} count _unitsCrew;


	private _haveDisembark = true;
	private _dis = _objTarget distance (leader _grp);

	if ( (_dis >= 100) OR ( (_dis > 40) && { (speed _objTarget >= 35) } ) ) then
	{
		if ( (({alive _x} count crew _vehicleRfr) isEqualTo 0) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) } } ) then
		{
			_grp call DK_fnc_delAllWp;

			_grp addVehicle _vehicleRfr;
			_unitsCrew allowGetIn true;
			_unitsCrew orderGetIn true;
			_grp setBehaviour "CARELESS";

			_waypoint = [_grp, _vehicleRfr, " if (!isServer) exitWith {}; (group this) setVariable ['AiInVeh_WpIsDeleted', true]; ", "true", "GETIN", nil, "FULL", "COMBAT"] call DK_fnc_AddWaypointState;

			_unitsCrew apply
			{
				[_x, _vehicleRfr, _grp, _objTarget] spawn DK_fnc_forceEmbark_rfr;
			};

			waitUntil { uiSleep 0.7; [0, _grp, _objTarget, _vehicleRfr] call DK_fnc_delIfFar_rfr; (isNil "_vehicleRfr") OR (isNull _vehicleRfr) OR (!alive _vehicleRfr) OR (({alive _x} count crew _vehicleRfr) isEqualTo ({alive _x} count _unitsCrew)) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR ( ((leader _grp) distance _objTarget < 101) && { (speed _objTarget < 35) } ) };

		///	// Re-Embark if Objectif target is near while boarding
			_unitsCrew = units _grp;
			if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) && { (alive _vehicleRfr) } } ) then
			{
				_grp call DK_fnc_delAllWp;

				call
				{
					if ( ((leader _grp) distance _objTarget <= 101) && { (speed _objTarget <= 36) } ) exitWith
					{
						{
							_x setVariable ["stopEmbark", true];

						} count _unitsCrew;

						_unitsCrew orderGetIn false;
						_unitsCrew allowGetIn false;
						_grp leaveVehicle _vehicleRfr;
						{
							if (alive _x) then
							{
								unassignVehicle _x;
								moveOut _x;
								uiSleep (random 0.3);
							};

						} count _unitsCrew;

						_waypoint = [_grp, leader _grp, "SAD", nil, "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
					};

					_haveDisembark = false;
				};
			};
		};
	};


	_haveDisembark
};

DK_fnc_checkIfEmbark_MRAP_rfr = {

	params ["_vehicleRfr", "_objTarget", "_unitsCrew", "_grp"];


	{
		_x setVariable ["stopEmbark", false];

	} count _unitsCrew;

	private _haveDisembark = true;
	private _dis = _objTarget distance (leader _grp);

	if ( (_dis >= 100) OR ( (_dis > 80) && { (speed _objTarget >= 26) } ) ) then
	{
		if ( (({alive _x} count crew _vehicleRfr) isEqualTo 0) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) } } ) then
		{
			_grp call DK_fnc_delAllWp;

			_grp addVehicle _vehicleRfr;
			_unitsCrew allowGetIn true;
			_unitsCrew orderGetIn true;
			_grp setBehaviour "CARELESS";

			_waypoint = [_grp, _vehicleRfr, " if (!isServer) exitWith {}; (group this) setVariable ['AiInVeh_WpIsDeleted', true]; ", "true", "GETIN", nil, "FULL", "COMBAT"] call DK_fnc_AddWaypointState;

			_unitsCrew apply
			{
				[_x, _vehicleRfr, _grp, _objTarget] spawn DK_fnc_forceEmbark_rfr;
			};

			waitUntil { uiSleep 0.7; [0, _grp, _objTarget, _vehicleRfr] call DK_fnc_delIfFar_rfr; (isNil "_vehicleRfr") OR (isNull _vehicleRfr) OR (!alive _vehicleRfr) OR (({alive _x} count crew _vehicleRfr) isEqualTo ({alive _x} count _unitsCrew)) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR ( ((leader _grp) distance _objTarget < 80) && { (speed _objTarget < 26) } ) };

		///	// Re-Embark if Objectif target is near while boarding
			_unitsCrew = units _grp;
			if ( !(_unitsCrew findIf { alive _x } isEqualTo -1) && { (!isNull _vehicleRfr) && { (alive _vehicleRfr) } } ) then
			{
				_grp call DK_fnc_delAllWp;

				call
				{
					if ( ((leader _grp) distance _objTarget <= 81) && { (speed _objTarget <= 27) } ) exitWith
					{
						{
							_x setVariable ["stopEmbark", true];

						} count _unitsCrew;

						_unitsCrew orderGetIn false;
						_unitsCrew allowGetIn false;
						_grp leaveVehicle _vehicleRfr;
						_unitsCrew apply
						{
							unassignVehicle _x;
							moveOut _x;

							uiSleep (random 0.3);
						};

						_waypoint = [_grp, leader _grp, "SAD", nil, "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
					};

					_haveDisembark = false;
				};
			};
		};
	};


	_haveDisembark
};

DK_fnc_forceEmbark_rfr = {

	params ["_unit", "_vehicleRfr", "_grp"];


	waitUntil { uiSleep 0.2; (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_unit distance _vehicleRfr < 6.2) OR (_unit getVariable ["stopEmbark", false]) };

	if ( (isNil "_unit") && { (isNull _unit) && { (alive _unit) && { (_unit distance _vehicleRfr <= 6.3) && { !(_unit getVariable ["stopEmbark", false]) } } } } ) then
	{
		_unit moveInAny _vehicleRfr;
	};
};


DK_fnc_delIfFar_rfr = {

	params [ ["_time", 0], "_grp", "_objTarget", "_vehicle", ["_disIsFar", 80]];


	if ((time > _time) && { (leader _grp distance _objTarget > 300) && { (playableUnits findIf { ([vehicle _vehicle, "IFIRE", _vehicle] checkVisibility [_x call DK_fnc_eyePlace, getPosASLVisual _vehicle] > 0.05) && { (_x distance _vehicle < _disIsFar) } } isEqualTo -1) } } ) then
	{
		{
			call
			{
				if (isNull objectParent _x) exitWith
				{
					deleteVehicle _x;
				};

				if (alive _x) exitWith
				{
					deleteVehicle _x;
				};

				[objectParent _x, _x] remoteExecCall ["deleteVehicleCrew", objectParent _x];
			};

		} forEach units _grp;


		waitUntil { (isNil "_vehicle") OR (isNull _vehicle) OR (!alive _vehicle) OR ((crew _vehicle) isEqualTo []) OR !((crew _vehicle) findIf { (isPlayer _x) OR (side (group _x) isEqualTo west) } isEqualTo -1) };

		if ( (isNil "_vehicle") OR (isNull _vehicle) OR (!alive _vehicle) OR !((crew _vehicle) findIf { (isPlayer _x) OR (side (group _x) isEqualTo west) } isEqualTo -1) ) exitWith {};

		deleteVehicle _vehicle;
	};
};

DK_fnc_moveAIfarAway_rfr = {

	params ["_grp"];


	private _leader = leader _grp;
	private _unitsCrew = units _grp;

	private _allRoads = (_leader getPos [700, (getDir _leader) - 180 ]) nearRoads 350;

	call
	{
		if (_allRoads isEqualTo []) exitWith
		{
			private _nb = selectRandom [[110,-110],[-110,110]];

			_allRoads = (_leader getPos [700, (getDir _leader) - (_nb # 0)]) nearRoads 500;

			if (_allRoads isEqualTo []) exitWith
			{
				private _nb = selectRandom [[110,-110],[-110,110]];

				_allRoads = (_leader getPos [700, (getDir _leader) - (_nb # 1)]) nearRoads 500;
			};
		};
	};

	if (_allRoads isEqualTo []) exitWith {};


	private _road = selectRandom _allRoads;
	[_grp, _road, "MOVE", "DIAMOND", "FULL"] call DK_fnc_AddWaypoint;
	_unitsCrew doMove getPosASL _road;


	while { !(_unitsCrew findIf { alive _x } isEqualTo -1) } do
	{
		waitUntil { uiSleep 0.5; (_unitsCrew findIf { alive _x } isEqualTo -1) OR (_road distance2D (leader _grp) < 120) };

		if (_unitsCrew findIf { alive _x } isEqualTo -1) exitWith {};

		_grp call DK_fnc_delAllWp;
		_road = [_unitsCrew, 1400] call DK_MIS_fnc_searchWpPos_veh;
		[_grp, _road, "MOVE", "DIAMOND", "FULL"] call DK_fnc_AddWaypoint;
		_unitsCrew doMove _road;

		uiSleep 10;
	};

};


DK_addEH_getInOut_rfr = {

	params ["_unit", "_vehType"];


		// Order forces
		if ((_unit getVariable ["DK_side", ""]) in ["cops", "fbi"]) then
		{
			private _ideh1 = _unit addEventHandler ["GetInMan",
			{
				params ["_unit", "_role", "_vehicle"];


				if (!alive _unit) exitWith {};


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


				if ( (_role isEqualTo "driver") && { !(_vehicle getVariable ["DK_sirenIsON", true]) } ) then
				{		
					[_vehicle, false] call DK_fnc_police_siren_OnOff;
				};
			}];

			private _ideh2 = _unit addEventHandler ["GetOutMan",
			{
				params ["_unit", "_role", "_vehicle"];


				if (!alive _unit) exitWith {};


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


				if ( (_role isEqualTo "driver") && { (_vehicle getVariable ["DK_sirenIsON", false]) } ) then
				{		
					[_vehicle, true] call DK_fnc_police_siren_OnOff;
				};
			}];

			_unit setVariable ["DK_idEhInOut_rfr", [_ideh1, _ideh2]];
		};
};

DK_addEH_deadNdel_rfr = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		_unit setVariable ["cleanUpOn", false];
		[_unit, 25, 120, true, 150] spawn DK_fnc_addAllTo_CUM;
		addToRemainsCollector [_unit];

		private _grp = group _unit;
		private _unitsGrp = units _grp;
		private _idAlive = _unitsGrp findIf {alive _x};

		if (_idAlive isEqualTo -1) then
		{
			private _vehicle = _unit getVariable "vehLinkRfr";
			if (!isNil "_vehicle") then
			{
				_vehicle setVehicleLock "UNLOCKED";
			};
		}
		else
		{
			private _vehicle = _unit getVariable "vehLinkRfr";
			if ( (!isNil "_vehicle") && { (_unit isEqualTo driver _vehicle) } ) then
			{
				(_unitsGrp # _idAlive) assignAsDriver _vehicle;
			};
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_unit"];


		private _vehicle = _unit getVariable "vehLinkRfr";

		if ( (!isNil "_vehicle") && { (!isNull _vehicle) && { (units (_unit getVariable "group") findIf {alive _x} isEqualTo -1) } } ) then
		{
			_vehicle setVehicleLock "UNLOCKED";
		};
	}];
};

DK_addEH_deadNdel_para_rfr = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		_unit setVariable ["cleanUpOn", false];
		[_unit,25,150,true] spawn DK_fnc_addAllTo_CUM;

		_unit removeAllEventHandlers "Deleted";

		if ((_unit getVariable ["DK_unitsCrew", []]) findIf { alive _x } isEqualTo -1) then
		{
			_objTarget = _unit getVariable ["objTarget", _unit];
			_objTarget setVariable ["paraTime", (time + 300)];
			_objTarget setVariable ["paraWaiting", true];
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_unit"];


		if (((_unit getVariable ["DK_unitsCrew", []]) - [_unit]) findIf { alive _x } isEqualTo -1) then
		{
			_objTarget = _unit getVariable ["objTarget", _unit];
			_objTarget setVariable ["paraTime", (time + 30)];
			_objTarget setVariable ["paraWaiting", true];
		};
	}];
};

DK_addEH_deadNdel_Mora_rfr = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		_unit setVariable ["cleanUpOn", false];
		[_unit, 15, 80, true, 180] spawn DK_fnc_addAllTo_CUM;


		private _vehicle = vehicle _unit;
		private _grp = group _unit;

		private _veh = _unit getVariable "vehLinkRfr";
		if (!isNil "_veh") then
		{
			_veh setVehicleLock "UNLOCKED";
		};

		if (_vehicle isEqualTo _unit) exitWith {};

		private _unitsCrew = units _grp;
		if ({alive _x} count _unitsCrew in [2,3]) then
		{
			doStop _unitsCrew;

			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicle;

			_unitsCrew apply
			{
				if (alive _x) then
				{
					unassignVehicle _x;
					doGetOut _x;
				};
			};

			_waypoint = [_grp, leader _grp, "SAD", nil, "FULL", "AWARE"] call DK_fnc_AddWaypoint;
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_unit"];


		if ((units (group _unit)) - [_unit] findIf {alive _x } isEqualTo -1) then
		{
			_vehicle = _unit getVariable "vehLinkRfr";
			if (!isNil "_vehicle") then
			{
				_vehicle setVehicleLock "UNLOCKED";
			};
		};
	}];
};

DK_addEH_deadNdel_Kuma_rfr = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		_unit setVariable ["cleanUpOn", false];
		[_unit, 15, 80, true, 180] spawn DK_fnc_addAllTo_CUM;


		private _vehicle = vehicle _unit;
		private _grp = group _unit;

		private _veh = _unit getVariable "vehLinkRfr";
		if (!isNil "_veh") then
		{
			_veh setVehicleLock "UNLOCKED";
		};

		if (_vehicle isEqualTo _unit) exitWith {};

		private _unitsCrew = units _grp;
		if ({alive _x} count _unitsCrew in [1,2]) exitWith
		{
			doStop _unitsCrew;

			_unitsCrew orderGetIn false;
			_unitsCrew allowGetIn false;
			_grp leaveVehicle _vehicle;

			_unitsCrew apply
			{
				if (alive _x) then
				{
					unassignVehicle _x;
					doGetOut _x;
				};
			};

			_waypoint = [_grp, leader _grp, "SAD", nil, "FULL", "AWARE"] call DK_fnc_AddWaypoint;
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_unit"];


		if ((units (group _unit)) - [_unit] findIf {alive _x } isEqualTo -1) then
		{
			_vehicle = _unit getVariable "vehLinkRfr";
			if (!isNil "_vehicle") then
			{
				_vehicle setVehicleLock "UNLOCKED";
			};
		};
	}];
};

DK_addEH_deadNdel_Gorgon_rfr = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		_unit setVariable ["cleanUpOn", false];
		[_unit, 15, 80, true, 180] spawn DK_fnc_addAllTo_CUM;

		call
		{
			private _vehicle = vehicle _unit;
			private _grp = group _unit;

			private _veh = _unit getVariable "vehLinkRfr";
			if (!isNil "_veh") then
			{
				_veh setVehicleLock "UNLOCKED";
			};

			if (_vehicle isEqualTo _unit) exitWith {};

			private _unitsCrew = units _grp;
			if ({alive _x} count _unitsCrew in [1,2]) exitWith
			{
				doStop _unitsCrew;

				_unitsCrew orderGetIn false;
				_unitsCrew allowGetIn false;
				_grp leaveVehicle _vehicle;

				_unitsCrew apply
				{
					if (alive _x) then
					{
						unassignVehicle _x;
						doGetOut _x;
					};
				};

				_waypoint = [_grp, leader _grp, "SAD", nil, "FULL", "AWARE"] call DK_fnc_AddWaypoint;
			};
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_unit"];


		if ((units (group _unit)) - [_unit] findIf {alive _x } isEqualTo -1) then
		{
			_vehicle = _unit getVariable "vehLinkRfr";
			if (!isNil "_vehicle") then
			{
				_vehicle setVehicleLock "UNLOCKED";
			};
		};
	}];
};



DK_MIS_fnc_rfrAtPlayer = {

	params ["_target", "_crewNFO", ["_checkWtd", false], ["_timeAdd", 180]];


	// Search position safe for spawn Reinforcement
	private _resultPos = [_target, 360, 700, 12, 6, true] call DK_fnc_MTW_searchSpawnVeh_OnRoad;
	_resultPos params ["_spawnPos", "_dir"];

	if !(_spawnPos isEqualTo 0) then
	{
		// Create Reinforcement Vehicle & Crew 
		_resultPos pushBack false;
		_crewNFO append _resultPos;
		_crewNFO pushBack _checkWtd;


		private _resultCrewVeh = _crewNFO call DK_fnc_crtCrewVeh_rfr;
		_resultCrewVeh params ["_unitsCrew", "_grp", "_vehicle"];

		DK_nbSearchSpawnRoad_inProg = false;


		waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _vehicle) };


		[_unitsCrew, _grp, _vehicle, _target, nil, 1, nil, "RED", _timeAdd] spawn DK_fnc_AiFollow_rfr;

		if ((_crewNFO # 0) isEqualTo "I_officer_F") exitWith
		{
			if (alive _target) then
			{
				[_target, _unitsCrew] spawn DK_fnc_manageWantedLvlPly;
			};
		};

		(_crewNFO # 1) remoteExecCall ["DK_fnc_hudKillRfr", _target];
	};
};


/// // On helicopter
DK_fnc_searchSpawn_rfr_heli = {

	params ["_objTarget", ["_disMin", 1500], ["_disMax", 3000], ["_rescuePlace", []], ["_condLoop", 1], ["_idMission", "-1"], ["_disMaxCond3", 300]];


	if (isNil "_objTarget") exitWith
	{
		[0, 0];
	};

	private "_fnc_condSSVOR";

	switch (_condLoop) do
	{
		case 1 :
		{
			_fnc_condSSVOR = {

				(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
			};
		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};
		};

		case 3 :
		{
			_fnc_condSSVOR = {

				!(playableUnits findIf { _x distance2D _objTarget < _disMaxCond3 } isEqualTo -1)
			};
		};

		case 4 :
		{
			_fnc_condSSVOR = {

				(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !((lifeState _objTarget) isEqualTo "INCAPACITATED") } } }
			};
		};

	};

	// Secure for have only one search in same time, for prevent vehcile explose, spawn at same place, and friendly perf ;)
	waitUntil { uiSleep 0.3; !(DK_nb_searchSpawn_rfr_heli_inProg) OR !(call _fnc_condSSVOR) };

	private	_schPos = 0;
	private _dir = 0;

	if !(call _fnc_condSSVOR) exitWith
	{
		[_schPos,_dir]
	};

	DK_nb_searchSpawn_rfr_heli_inProg = true;

	private _disToAdd = -10;
	private _lapsDirRescue = 0;

	private _directions = [0] + ([11.25, -11.25] call KK_fnc_arrayShuffle) + ([22.5, -22.5] call KK_fnc_arrayShuffle) + ([33.75, -33.75] call KK_fnc_arrayShuffle);
	private _actuDisDirR = _disMin;
	private _dirStep = -1;
	private _posIsOk = false;
	private _dirHouse = random 360;

	private _exit = false;
	while { call _fnc_condSSVOR } do
	{
		_dirStep = _dirStep + 1;

		if (_dirStep > 6) then
		{
			_dirStep = 0;
			_dirHouse = random 360;

			_actuDisDirR = _actuDisDirR + (_disToAdd + 50);
			if (_actuDisDirR > _disMax) then
			{
				_lapsDirRescue = _lapsDirRescue + 1;

				_actuDisDirR = _disMin;
			};
		};

		call
		{
			if ( (_lapsDirRescue < 6) && { !(_rescuePlace isEqualTo []) } ) exitWith
			{
				_schPos = _objTarget getPos [_actuDisDirR, (_objTarget getDir _rescuePlace) + (_directions # _dirStep)];
			};

			if (typeName _objTarget isEqualTo "ARRAY") exitWith
			{
				_schPos = _objTarget getPos [_actuDisDirR, _dirHouse + (_dirStep * 60)];
			};
		
			if ( (_objTarget isKindOf "LandVehicle") OR (_objTarget isKindOf "Man") ) exitWith
			{
				_schPos = _objTarget getPos [_actuDisDirR, (getDir _objTarget) + (_directions # _dirStep)];
			};

			_schPos = _objTarget getPos [_actuDisDirR, _dirHouse + (_dirStep * 60)];
		};


		_schPos set [2, 250];

//		if ( ([_schPos,100,100] call DK_fnc_placeOK) && { (playableUnits findIf { _x distance _schPos < 400 } isEqualTo -1) } ) exitWith
		if (playableUnits findIf { _x distance _schPos < 400 } isEqualTo -1) exitWith
		{
			_posIsOk = true;
		};

		uiSleep 0.2;
	};


	if (_posIsOk) then
	{
		_dir = _schPos getDir _objTarget;

		if (isNil "_dir") then
		{
			_dir = 0;
		};
	}
	else
	{
		_schPos = 0;
	};


	[_schPos,_dir]
};

DK_fnc_crtCrewVeh_rfr_heli = {

	params ["_unitClass", "_ennemieType", "_uniform", "_weapons", "_vest", "_spawnPos", "_dir", "_idMission", ["_checkWtd", true]];


	// Set side, Gangs = east ; Cops = Resistance
	private "_InSide";
	call
	{
		if (_unitClass isEqualTo "O_G_Survivor_F") exitWith
		{
			_InSide = east;
		};

		_InSide = resistance;
	};

	private ["_helico", "_unit02", "_unit03", "_unit04", "_unit05", "_nil"];

	private _grp = createGroup _InSide;

	private _unit01 = crtU(_grp,_unitClass);
	_unitsCrew = [_unit01];
	if !(_ennemieType isEqualTo "Dominicans") then
	{
		uiSleep 0.1;
		_unit02 = crtU(_grp,_unitClass);
		_unitsCrew pushBack _unit02;
		uiSleep 0.1;
		_unit03 = crtU(_grp,_unitClass);
		_unitsCrew pushBack _unit03;
	};

	uiSleep 0.05;

	private	_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];
	call
	{
		if ( (_checkWtd) && { (_wantedLevel >= 8) } ) exitWith
		{
			if ((_wantedLevel >= 8) && {(_wantedLevel < 19)}) exitWith
			{
				_helico = [] call DK_MIS_fnc_crtHeli_Police;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_PoliceHeli_pilot;
				uiSleep 0.1;

				if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 isEqualTo 1) then
				{
					[_unit02, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					[_unit03, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
				}
				else
				{
					_unit04 = crtU(_grp,_unitClass);
					uiSleep 0.1;
					_unit05 = crtU(_grp,_unitClass);
					_unitsCrew pushBackUnique _unit04;
					_unitsCrew pushBackUnique _unit05;

					[_unit02, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					[_unit03, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					[_unit04, "P90"] spawn DK_fnc_LO_PoliceHeli_crew;
					[_unit05, "P90"] spawn DK_fnc_LO_PoliceHeli_crew;
				};

				_unit02 moveInTurret [_helico, [1]];
				_unit03 moveInTurret [_helico, [3]];
			};

			if (_wantedLevel isEqualTo 19) exitWith
			{
				_helico = [] call DK_MIS_fnc_crtHeli_Army;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_ArmyHeli_pilot;
				uiSleep 0.1;

				[_unit02, "CAR_LMG"] spawn DK_fnc_LO_ArmyHeli_crew;
				[_unit03, "CAR_LMG"] spawn DK_fnc_LO_ArmyHeli_crew;

				_unit02 moveInTurret [_helico, [1]];
				_unit03 moveInTurret [_helico, [2]];

				// Handle ammo heli
				[_helico, _unit01] spawn DK_fnc_handleAmmoVeh;
			};
		};


		if (_ennemieType in ["pigs", "chickens"]) then
		{
			_ennemieType = "Police forces";
		};

		if (_ennemieType in ["Feds", "FIB agents"]) then
		{
			_ennemieType = "FIB agents";
		};

		switch ( _ennemieType ) do
		{
			case "Thugs" :
			{
				_helico = [] call DK_MIS_fnc_crtHeli_thugs;
			};

			case "Ballas" :
			{
				_helico = [] call DK_MIS_fnc_crtHeli_ballas;
			};

			case "Dominicans" :
			{
				_helico = [] call DK_MIS_fnc_crtHeli_Domi;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_DomiHeli_pilot;
				uiSleep 0.1;

				// Handle ammo heli
				[_helico, _unit01] spawn DK_fnc_handleAmmoVeh;
			};

			case "Albanians" :
			{
				_helico = [] call DK_MIS_fnc_crtHeli_Alban;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_AlbanHeli_pilot;
				uiSleep 0.1;

				if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 isEqualTo 1) then
				{
					[[_unit02,_unit03], _uniform, _weapons, ""] call DK_MIS_fnc_slctUnitsLO;
				}
				else
				{
					_unit04 = crtU(_grp,_unitClass);
					uiSleep 0.1;
					_unit05 = crtU(_grp,_unitClass);
					_unitsCrew pushBackUnique _unit04;
					_unitsCrew pushBackUnique _unit05;

					[[_unit02,_unit03,_unit04,_unit05], _uniform, _weapons, _vest] call DK_MIS_fnc_slctUnitsLO;
				};

				_unit02 moveInTurret [_helico, [1]];
				_unit03 moveInTurret [_helico, [3]];
			};

			case "Police forces" :
			{
				_helico = [] call DK_MIS_fnc_crtHeli_Police;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_PoliceHeli_pilot;
				uiSleep 0.1;

				call
				{
					if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 isEqualTo 1) exitWith
					{
						[_unit02, _weapons, 2] spawn DK_fnc_LO_PoliceHeli_crew;
						uiSleep 0.1;
						[_unit03, _weapons, 2] spawn DK_fnc_LO_PoliceHeli_crew;
					};

					_unit04 = crtU(_grp,_unitClass);
					uiSleep 0.1;
					_unit05 = crtU(_grp,_unitClass);
					_unitsCrew pushBackUnique _unit04;
					_unitsCrew pushBackUnique _unit05;

					[_unit02, _weapons, 2] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
					[_unit03, _weapons, 2] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
					[_unit04, _weapons, 2] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
					[_unit05, _weapons, 2] spawn DK_fnc_LO_PoliceHeli_crew;
				};

				_unit02 moveInTurret [_helico, [1]];
				_unit03 moveInTurret [_helico, [3]];
			};

			case "FIB agents" :
			{
				_helico = [] call DK_MIS_fnc_crtHeli_Police;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_PoliceHeli_pilot;
				uiSleep 0.1;

				call
				{
					if (([] call DK_fnc_cntMaxPlyrsByFam) # 0 isEqualTo 1) exitWith
					{
						[_unit02, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
						[_unit03, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					};

					_unit04 = crtU(_grp,_unitClass);
					uiSleep 0.1;
					_unit05 = crtU(_grp,_unitClass);
					_unitsCrew pushBackUnique _unit04;
					_unitsCrew pushBackUnique _unit05;

					[_unit02, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
					[_unit03, "MXM"] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
					[_unit04, "P90"] spawn DK_fnc_LO_PoliceHeli_crew;
					uiSleep 0.1;
					[_unit05, "P90"] spawn DK_fnc_LO_PoliceHeli_crew;
				};

				_unit02 moveInTurret [_helico, [1]];
				_unit03 moveInTurret [_helico, [3]];
			};

			case "Army" :
			{
				_helico = [true, true] call DK_MIS_fnc_crtHeli_Army;
				_grp addVehicle _helico;
				_unit01 moveInDriver _helico;
				_unit01 spawn DK_fnc_LO_ArmyHeli_pilot;
				uiSleep 0.1;

				[_unit02, "CAR_LMG"] spawn DK_fnc_LO_ArmyHeli_crew;
				uiSleep 0.1;
				[_unit03, "CAR_LMG"] spawn DK_fnc_LO_ArmyHeli_crew;

				_unit02 moveInTurret [_helico, [1]];
				_unit03 moveInTurret [_helico, [2]];

				// Handle ammo heli
				[_helico, _unit01] spawn DK_fnc_handleAmmoVeh;
			};
		};
	};


	uiSleep 0.1;

	_helico allowDamage false;
	_helico setUnloadInCombat [FALSE,FALSE]; 

	_grp selectLeader _unit01;
	_grp setBehaviour "CARELESS";
	_grp setCombatMode "RED";

	{
		_x allowDamage false;
		_x setVariable ["vehLinkRfr", _helico];
		_x setVariable ["DK_roleUnit", "isRfr"];
		_x setVariable ["DK_idMission", _idMission];
		_x spawn DK_MIS_addEH_HandleDmg;
		uiSleep 0.07;
		_x spawn DK_MIS_EH_handleAmmoNweapons;
		_x spawn DK_MIS_addEH_secondDead;
		uiSleep 0.07;
		[_x, typeOf _helico] call DK_addEH_getInOut_rfr;
		_x spawn DK_addEH_killed_heliCrew_rfr;
		DK_unitsStayUp pushBackUnique _x;
		_x disableAI "FSM";

		uiSleep 0.07;
		if !(_x isEqualTo _unit01) then
		{
			_x call DK_MIS_addEH_selectSeat;
		};

		_nil = _x call DK_addEH_deadNdel_rfr;

		uiSleep 0.1;

	} count _unitsCrew;

	if ( (!isNil "_unit04") && {(!isNil "_unit05")} ) then
	{
		_unit04 moveInAny _helico;
		_unit05 moveInAny _helico;
	};

	_grp deleteGroupWhenEmpty true;
	_grp setFormation "DIAMOND";
	_grp setSpeedMode "FULL";

	_unitsCrew orderGetIn true;
	_unitsCrew allowGetIn true;

	_helico setDir _dir;
	_helico setPosATL _spawnPos;
	_helico setVehicleLock "LOCKEDPLAYER";
	_helico spawn DK_addEH_helicopter_rfr;

	_unitsCrew apply
	{
		_x allowDamage true;
	};

	// Lights if night
	if (call DK_fnc_checkIfNight) then
	{
		_unit01 disableAI "LIGHTS";
		_helico setPilotLight true;
		_helico setCollisionLight true;
	};


	[_unitsCrew, _grp, _helico, _wantedLevel]
};

DK_fnc_init_rfr_heli = {

	params ["_objTarget", ["_slpTimeMin", 30], ["_slpTimeMax", 120]];


	private _slpTime = _slpTimeMin + (random (_slpTimeMax - _slpTimeMin));

	// Get info mission at vehicle target
	private _infoMission = _objTarget getVariable "MIS_nfo";
	_infoMission params ["_rescuePlace", "_className", "_classGuy", "_uniform", "_weapons", "_vest", "_idMission"];


	// Waiting condition for start reinforcement
	private _time = time + _slpTime;

	waitUntil
	{
		uiSleep 1; (time > _time) OR (isNull _objTarget) OR !(alive _objTarget) OR !(_idMission isEqualTo DK_idMission)
	};

	if ((isNull _objTarget) OR !(alive _objTarget) OR !(_idMission isEqualTo DK_idMission)) exitWith {};

	waitUntil
	{
		uiSleep 1; !(playableUnits findIf { _x distance _objTarget < 500 } isEqualTo -1) OR (isNull _objTarget) OR !(alive _objTarget) OR !(_idMission isEqualTo DK_idMission)
	};

	if ((isNull _objTarget) OR !(alive _objTarget) OR !(_idMission isEqualTo DK_idMission)) exitWith {};


	// Search position safe for spawn Reinforcement
	private _resultSrchSpwn = [_objTarget, nil, nil, _rescuePlace, 2, _idMission] call DK_fnc_searchSpawn_rfr_heli; 
	_resultSrchSpwn params ["_spawnPos", "_dir"];

	if !(_spawnPos isEqualTo 0) then
	{
		// Create Reinforcement Heli & Crew 
		private _resultCrewVeh = [_className, _classGuy, _uniform, _weapons, _vest, _spawnPos, _dir, _idMission] call DK_fnc_crtCrewVeh_rfr_heli;
		_resultCrewVeh params ["_unitsCrew", "_grp", "_helico", "_wantedLevel"];

		DK_nb_searchSpawn_rfr_heli_inProg = false;

		// Create Helipads around target
		uiSleep 0.2;
		_heliPads = [_objTarget, _helico] call DK_fnc_heliPadAroundTarget;

		// Start AI to follow target
		uiSleep 0.5;
		if (_wantedLevel < 19) then
		{
			[_unitsCrew, _grp, _helico, _idMission, 2, _rescuePlace] call DK_loop_AiFollow_heli_rfr;
		}
		else
		{
			[_unitsCrew, _grp, _helico, _idMission, 2, _rescuePlace] call DK_loop_AiFollow_heli_army_rfr;
		};

		// Deleting Helipads
		_heliPads apply
		{
			deleteVehicle _x;
		};
	}
	else
	{
		DK_nb_searchSpawn_rfr_heli_inProg = false;
		uiSleep 5;
	};


	// Start a new Renfort script if mission is not finish
	if ( (_idMission isEqualTo DK_idMission) && { (!isNull _objTarget) && { (alive _objTarget) } } ) then
	{
		[_objTarget, 40, 110] spawn DK_fnc_init_rfr_heli;
	};
};

DK_fnc_init_wanted_heliCops = {

	params ["_objTarget", ["_type", 1]];


	if ((isNull _objTarget) OR !(alive _objTarget) OR ((lifeState _objTarget) isEqualTo "INCAPACITATED")) exitWith {};


	// Search position safe for spawn Reinforcement
	private _resultSrchSpwn = [_objTarget, 350, 700, [], 4] call DK_fnc_searchSpawn_rfr_heli; 
	_resultSrchSpwn params ["_spawnPos", "_dir"];

	private "_heliPads";

	if !(_spawnPos isEqualTo 0) then
	{
		call
		{
			if (_type isEqualTo 1) exitWith
			{
				// Create Reinforcement Heli & Crew 
				private _resultCrewVeh = ["I_officer_F", "Police forces", nil, "wpns_hgunsSmgs", nil, _spawnPos, _dir, "-1", false] call DK_fnc_crtCrewVeh_rfr_heli;
				_resultCrewVeh params ["_unitsCrew", "_grp", "_helico"];

				DK_nb_searchSpawn_rfr_heli_inProg = false;

				// Create Helipads around target
				uiSleep 0.2;
				_heliPads = [_objTarget, _helico] call DK_fnc_heliPadAroundTarget;

				// Update wanted lvl for player
				[_objTarget, _unitsCrew] spawn DK_fnc_manageWantedLvlPly;

				// Start AI to follow target
				uiSleep 0.5;

				[_unitsCrew, _grp, _helico, nil, 3, _objTarget] call DK_loop_AiFollow_heli_rfr;
			};

			if (_type isEqualTo 2) exitWith
			{
				// Create Reinforcement Heli & Crew 
				private _resultCrewVeh = ["I_officer_F", "FIB agents", nil, nil, nil, _spawnPos, _dir, "-1", false] call DK_fnc_crtCrewVeh_rfr_heli;
				_resultCrewVeh params ["_unitsCrew", "_grp", "_helico"];

				DK_nb_searchSpawn_rfr_heli_inProg = false;

				// Create Helipads around target
				uiSleep 0.2;
				_heliPads = [_objTarget, _helico] call DK_fnc_heliPadAroundTarget;

				// Update wanted lvl for player
				[_objTarget, _unitsCrew] spawn DK_fnc_manageWantedLvlPly;

				// Start AI to follow target
				uiSleep 0.5;

				[_unitsCrew, _grp, _helico, nil, 3, _objTarget] call DK_loop_AiFollow_heli_rfr;
			};

			if (_type isEqualTo 3) exitWith
			{
				// Create Reinforcement Heli & Crew 
				private _resultCrewVeh = ["I_officer_F", "Army", nil, nil, nil, _spawnPos, _dir, "-1", false] call DK_fnc_crtCrewVeh_rfr_heli;
				_resultCrewVeh params ["_unitsCrew", "_grp", "_helico"];

				DK_nb_searchSpawn_rfr_heli_inProg = false;

				// Create Helipads around target
				uiSleep 0.2;
				_heliPads = [_objTarget, _helico] call DK_fnc_heliPadAroundTarget;

				// Update wanted lvl for player
				[_objTarget, _unitsCrew] spawn DK_fnc_manageWantedLvlPly;

				// Start AI to follow target
				uiSleep 0.5;

				[_unitsCrew, _grp, _helico, nil, 3, _objTarget] call DK_loop_AiFollow_heli_army_rfr;
			};

		};


		// Deleting Helipads
		if (!isNil "_heliPads") then
		{
			_heliPads apply
			{
				deleteVehicle _x;
			};
		};

//		uiSleep 60;
	}
	else
	{
		DK_nb_searchSpawn_rfr_heli_inProg = false;
		uiSleep 5;
	};



	call
	{
		if (_type isEqualTo 3) exitWith
		{
			_objTarget setVariable ["DK_chaseTimeHeli", time + 80];
		};

		if (_type isEqualTo 2) exitWith
		{
			_objTarget setVariable ["DK_chaseTimeHeli", time + 110];
		};

		_objTarget setVariable ["DK_chaseTimeHeli", time + 140];
	};

	_objTarget setVariable ["heliChase", false];
};



DK_loop_AiFollow_heli_rfr = {

	params ["_unitsCrew", "_grp", "_helico", "_idMission", ["_condLoop", 1], "_rescuePlace"];


	if (isNil "_objTarget") exitWith {};

	private ["_fnc_condSSVOR", "_driver", "_speedToDis", "_unitsCrewFoot", "_disObjHeli", "_grp", "_grpFoot", "_result", "_chaseDir"];


	if (isNil "_rescuePlace") then
	{
		_rescuePlace = getMarkerPos "DK_mkr_middleMapSearch";
	};

	call
	{
		if (_rescuePlace isEqualTo _objTarget) exitWith
		{
			_chaseDir = { getDir _objTarget };
		};

		_chaseDir = { _objTarget getDir _rescuePlace };
	};


	switch (_condLoop) do
	{
		case 1 :
		{
			_fnc_condSSVOR = {

				(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
			};
		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};
		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !((lifeState _objTarget) isEqualTo "INCAPACITATED") && { (_objTarget distance2D _helico < 900) } } } }
			};
		};
	};

	uiSleep 0.5;
	_unitsCrew apply
	{
		_x call DK_addEH_getOut_heliCrew_rfr;
	};


	waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _helico) };

///	// AI Loop Pursuit Start
	private _pilotHeli = driver _helico;
	private _haveDisembark = false;
	private _ending = "";
	[_pilotHeli, _objTarget] spawn DK_fnc_selectLoopVoiceHeli;


	while { call _fnc_condSSVOR } do
	{
		_grp = group _pilotHeli;
		_grp call DK_fnc_delAllWp;
		_unitsCrew = units _grp;

	///	// Move Helicopter at Target objectif
		call
		{
			_disObjHeli = _objTarget distance2D _helico;

			if (_disObjHeli < 350) exitWith
			{
				if (speed _objTarget < 12) exitWith
				{
					_unitsCrew doMove (_objTarget getPos [70 + random 70, random 360]);
					_grp setSpeedMode "LIMITED";
					_helico limitSpeed 50;
					_helico flyInHeight 20;
				};

//				_unitsCrew doMove (_objTarget getPos [80 + (speed _objTarget), _objTarget getDir _rescuePlace]);
				_unitsCrew doMove (_objTarget getPos [80 + (speed _objTarget), call _chaseDir]);
				_grp setSpeedMode "FULL";
				_helico limitSpeed 120;
				_helico flyInHeight 50;
			};

//			_unitsCrew doMove (_objTarget getPos [100 + (speed _objTarget), _objTarget getDir _rescuePlace]);
			_unitsCrew doMove (_objTarget getPos [100 + (speed _objTarget), call _chaseDir]);
			_grp setSpeedMode "FULL";
			_helico limitSpeed 1000;
			_helico flyInHeight 80;
		};

		uiSleep 0.15;

	///	// Force fire Target objectif
		_driver = driver _objTarget;
		if (alive _driver) then
		{
			(_unitsCrew - [driver _helico]) apply
			{
				_x reveal [_driver, 4];
				_x commandTarget _driver;
				_x doTarget _driver;
			};
		};

		uiSleep 0.15;

	///	// Check for Disembark crew
		if !(_haveDisembark) then
		{
			_result = [_helico, _objTarget, _grp] call DK_fnc_checkIfDisembark_heli_rfr;

			_haveDisembark = _result # 0;
			_grpFoot = _result # 1;
		};
	
		call
		{
			if (speed _objTarget > 30) exitWith
			{
				uiSleep 3;
			};

			uiSleep 5;
		};


	///	// Check for Exit loop
		if !(call _fnc_condSSVOR) exitWith {};


		if ( ({alive _x} count crew _helico isEqualTo 1) && { (alive _pilotHeli) } ) exitWith
		{
			_ending = "A";
		};

		uiSleep 0.15;

		if (!alive _pilotHeli) exitWith
		{
			if !(units _grp findIf {alive _x} isEqualTo -1) exitWith
			{
				_ending = "B";
			};

			_ending = "C";
		};

		uiSleep 0.15;

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

	if ( (!isNil "_objTarget") && { (_objTarget isKindOf "Man") && { (!alive _objTarget) OR (lifeState _objTarget isEqualTo "INCAPACITATED") } } ) exitWith
	{
		call DK_fnc_moveFarAway_heli;
	};

	// Start Ending for heli
	call
	{
		if !(typeName _rescuePlace isEqualTo "ARRAY") exitWith
		{
			_rescuePlace = getPosATL _rescuePlace;
		};

		if ( (isNil "_rescuePlace") OR ( (typeName _rescuePlace isEqualTo "OBJECT") && { (!alive _rescuePlace) } ) ) then
		{
			_rescuePlace = getMarkerPos "DK_mkr_middleMapSearch";
		};
	};

	call DK_loop_AiFollowEnd_heli_rfr; 
};

DK_loop_AiFollowEnd_heli_rfr = {

	switch (_ending) do
	{
		case "A" :	// Pilot alone in heli
		{
			_helico flyInHeight 100;
			uiSleep 10;

			if ( (!isNil "_grpFoot") && { !(units _grpFoot findIf {alive _x} isEqualTo -1) } ) then
			{
				_unitsCrew doMove (_objTarget getPos [70 + random 70, random 360]);
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

			[_objTarget, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
		};

		case "C" :	// Pilot heli dead, not crew in heli
		{
			
		};

		case "" :	// Mission terminée / il n'y a plus d'objectif
		{
			private _crew = crew _helico;
	
			if !(_crew findIf {alive _x} isEqualTo -1) then
			{
				if ( (!isNil "_objTarget") && { (_objTarget distance2D _rescuePlace < 50) && { (_helico distance2D _rescuePlace < 700) } } ) exitWith
				{
					// Create Helipads around target
					private _heliPad00 = crtHeliPad;
					_heliPad00 setPosATL _rescuePlace;
					private _angle = random 360;
					private _heliPad01 = crtHeliPad;
					_heliPad01 setPosATL (_rescuePlace getPos [22, _angle]);
					private _heliPad02 = crtHeliPad;
					_heliPad02 setPosATL (_rescuePlace getPos [22, _angle + 90]);
					private _heliPad03 = crtHeliPad;
					_heliPad03 setPosATL (_rescuePlace getPos [22, _angle + 180]);
					private _heliPad04 = crtHeliPad;
					_heliPad04 setPosATL (_rescuePlace getPos [22, _angle + 270]);


					// Land at objectif/rescue place
					_helico flyInHeight 30;
					_waypoint = [_grp, _rescuePlace, "UNLOAD", nil,  "FULL", "CARELESS"] call DK_fnc_AddWaypoint;
					_waypoint = [_grp, _rescuePlace, "SAD", nil,  "FULL", "COMBAT", 13] call DK_fnc_AddWaypoint;
					_crew orderGetIn false;
					_crew allowGetIn false;
					_grp leaveVehicle _helico;

					(units _grp) apply
					{
						unassignVehicle _x;
					};

					[_helico, 80, 500, true] spawn DK_fnc_addVehTo_CUM;

					[[_heliPad00, _heliPad01, _heliPad02, _heliPad03, _heliPad04], _helico, _unitsCrew, _rescuePlace, _grp] spawn
					{
						params ["_heliPads", "_helico", "_unitsCrew", "_rescuePlace", "_grp"];


						private _time = time + 180;

						waitUntil { uiSleep 0.5; (time > _time) OR (!canMove _helico) OR ((getPosATL _helico) # 2 < 2) OR (crew _helico findIf {alive _x} isEqualTo -1) OR !(crew _helico findIf { (isPlayer _x) OR (side (group _x) isEqualTo west) } isEqualTo -1) };

						if !(_unitsCrew findIf {alive _x} isEqualTo -1) then
						{
				//			_unitsCrew doMove _rescuePlace;
							[_rescuePlace, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
						};

						_heliPads apply
						{
							deleteVehicle _x;
						};
					};
				};

				if ( (!isNil "_objTarget") && { (_helico distance2D _objTarget < 700) } ) then
				{
					// Create Helipads around target
					private _heliPads = [_objTarget, _helico] call DK_fnc_heliPadAroundTarget;

					// Land at objectif/rescue place
					_helico flyInHeight 30;
					_waypoint = [_grp, _objTarget, "UNLOAD", nil,  "FULL", "CARELESS"] call DK_fnc_AddWaypoint;
					_waypoint = [_grp, _objTarget, "SAD", nil,  "FULL", "COMBAT", 13] call DK_fnc_AddWaypoint;
					_crew orderGetIn false;
					_crew allowGetIn false;
					_grp leaveVehicle _helico;

					(units _grp) apply
					{
						unassignVehicle _x;
					};

					[_helico, 80, 500, true] spawn DK_fnc_addVehTo_CUM;

					[_heliPads, _helico, _unitsCrew, _objTarget, getPosATL _objTarget, _grp] spawn
					{
						params ["_heliPads", "_helico", "_unitsCrew", "_objTarget", "_posObjTarget", "_grp"];


						private _time = time + 180;

						waitUntil { uiSleep 0.5; (time > _time) OR (!canMove _helico) OR ((getPosATL _helico) # 2 < 2) OR (crew _helico findIf {alive _x} isEqualTo -1) OR !(crew _helico findIf { (isPlayer _x) OR (side (group _x) isEqualTo west) } isEqualTo -1) };

						if !(_unitsCrew findIf {alive _x} isEqualTo -1) then
						{
							if (isNil "_objTarget") then
							{
								_unitsCrew apply
								{
									_x setVariable ["cleanUpOn", false];
									[_x, 120, 200, true] spawn DK_fnc_addAllTo_CUM;
								};

								_unitsCrew doMove _posObjTarget;
							}
							else
							{
								[_objTarget, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
							};
						};

						_heliPads apply
						{
							deleteVehicle _x;
						};
					};
				}
				else
				{
					call DK_fnc_moveFarAway_heli;
				};
			};
		};
	};
};


DK_loop_AiFollow_heli_army_rfr = {

	params ["_unitsCrew", "_grp", "_helico", ["_idMission", "-1"], ["_condLoop", 1], "_rescuePlace"];


	if (isNil "_objTarget") exitWith {};

	private ["_fnc_condSSVOR", "_driver", "_speedToDis", "_chaseDir"];

	if (isNil "_rescuePlace") then
	{
		_rescuePlace = getMarkerPos "DK_mkr_middleMapSearch";
	};

	call
	{
		if (_rescuePlace isEqualTo _objTarget) exitWith
		{
			_chaseDir = { getDir _objTarget };
		};

		_chaseDir = { _objTarget getDir _rescuePlace };
	};



		///	// DEBUG MKR
/*			private _mkrNzme6 = "3" + (str (random 1000));
			private _markerstr6 = createMarker [_mkrNzme6, _helico];
			_markerstr6 setMarkerShape "ICON";
			_markerstr6 setMarkerType "mil_arrow2";
			_markerstr6 setMarkerColor "ColorRed";
			_markerstr6 setMarkerSize [1, 1];

			[_helico, _markerstr6] spawn
			{
				params ["_helico", "_markerstr6"];

				waitUntil
				{
					uiSleep 0.3;
					_markerstr6 setMarkerPos (getPosVisual _helico);
					_markerstr6 setMarkerDir (getDirVisual _helico);

					!(alive _helico)
				};

				deleteMarker _markerstr6;
			};
*/		///	// DEBUG MKR


	switch (_condLoop) do
	{
		case 1 :
		{
			_fnc_condSSVOR = {

				(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } }
			};
		};

		case 2 :
		{
			_fnc_condSSVOR = {

				(_idMission isEqualTo DK_idMission) && { (!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) } } }
			};
		};

		case 3 :
		{
			_fnc_condSSVOR = {

				(!isNil "_objTarget") && { (!isNull _objTarget) && { (alive _objTarget) && { !((lifeState _objTarget) isEqualTo "INCAPACITATED") && { (_objTarget distance2D _helico < 1200) } } } }
			};
		};
	};

	uiSleep 0.5;
	_unitsCrew apply
	{
		_x call DK_addEH_getOut_heliCrew_rfr;
	};


	waitUntil { uiSleep 0.1; ({alive _x} count _unitsCrew) isEqualTo ({alive _x} count crew _helico) };

///	// AI Loop Pursuit Start
	private ["_unitsCrewFoot", "_disObjHeli", "_grp", "_result"];
	private _pilotHeli = driver _helico;
	private _ending = "";
	_objTarget setVariable ["paraWaiting", true];
	_objTarget setVariable ["paraWaiting2", true];
	_objTarget setVariable ["paraTime", (time + 30)];
	private _time = time + 60;

	while { call _fnc_condSSVOR } do
	{
		_grp = group (driver _helico);
		_grp call DK_fnc_delAllWp;
		_unitsCrew = units _grp;

	///	// Move Helicopter at Target objectif
		call
		{
			_disObjHeli = _objTarget distance2D _helico;

			if (_disObjHeli < 400) exitWith
			{
				if (speed _objTarget < 12) exitWith
				{
					_unitsCrew doMove (_objTarget getPos [70 + random 70, random 360]);
					_grp setSpeedMode "LIMITED";
					_helico limitSpeed 50;
					_helico flyInHeight 80;
				};

				_unitsCrew doMove (_objTarget getPos [80 + (speed _objTarget), call _chaseDir]);
				_grp setSpeedMode "FULL";
				_helico limitSpeed 120;
				_helico flyInHeight 50;
			};

			_unitsCrew doMove (_objTarget getPos [100 + (speed _objTarget), call _chaseDir]);
			_grp setSpeedMode "FULL";
			_helico limitSpeed 1000;
			_helico flyInHeight 120;
		};

		uiSleep 0.15;

	///	// Force fire Target objectif
		_driver = driver _objTarget;
		if (alive _driver) then
		{
			(_unitsCrew - [driver _helico]) apply
			{
				_x reveal [_driver, 4];
				_x commandTarget _driver;
				_x doTarget _driver;
			};
		};

		uiSleep 0.15;

	///	// Check start Heli with Para
		if ( !(_idMission isEqualTo "-1") && { (_objTarget getVariable ["paraWaiting", false]) && { (_objTarget getVariable ["paraWaiting2", false]) && { (time > (_objTarget getVariable ["paraTime", _time])) && { (_objTarget getHitPointDamage "HitEngine" isEqualTo 1) } } } } ) then
		{
			_objTarget setVariable ["paraWaiting", false];
			_objTarget setVariable ["paraWaiting2", false];
//			if !(_idMission isEqualTo "-1") then
//			{
				[_objTarget, _idMission] spawn DK_fnc_start_heliPara_army_rfr;
//			};
		};

		call
		{
			if (speed _objTarget > 30) exitWith
			{
				uiSleep 3;
			};

			uiSleep 5;
		};


	///	// Check for Exit loop
		if !(call _fnc_condSSVOR) exitWith {};


		if ( (alive _pilotHeli) && {({alive _x} count _unitsCrew isEqualTo 1)} ) exitWith
		{
			_ending = "A";
		};

		uiSleep 0.15;

		if ( (!alive _pilotHeli) && {!(units _grp findIf {alive _x} isEqualTo -1)} ) exitWith
		{
			_ending = "B";
		};

		uiSleep 0.15;

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

	if ( (!isNil "_objTarget") && { (_objTarget isKindOf "Man") && { (!alive _objTarget) OR (lifeState _objTarget isEqualTo "INCAPACITATED") } } ) exitWith
	{
		call DK_fnc_moveFarAway_heli;
	};

	// Start Ending for heli
	call DK_loop_AiFollowEnd_heli_army_rfr;
};

DK_loop_AiFollowEnd_heli_army_rfr = {

	switch (_ending) do
	{
		case "A" :	// Pilot alone in heli & crew foot deads
		{
			(crew _helico) doMove (_helico getPos [30000, random 360]);


			if (alive (driver _helico)) then
			{
				[(driver _helico), 19, 545, true] spawn DK_fnc_addAllTo_CUM;
			};
			if (alive _helico) then
			{
				_helico limitSpeed 1000;
				_helico forceSpeed -1;
				[_helico, 21, 600, true] spawn DK_fnc_addVehTo_CUM;
			};
		};

		case "B" :	// Pilot heli dead, crew in heli alive // Heli HS with crew
		{
			{
				if (alive _x) then
				{
					moveOut _x;
					uiSleep (random 0.4);
				};
				
			} count (crew _helico);	

			[_objTarget, _grp] spawn DK_loop_crewOnFoot_heli_rfr;
		};

		case "C" :
		{
		};

		case "" :	// Mission terminée / il n'y a plus d'objectif
		{
			private _crew = crew _helico;
	
			if !(_crew findIf {alive _x} isEqualTo -1) then
			{
				private _driver = driver _helico;
				private _haveDisembark = false;

				if (!isNil "_objTarget") then
				{
					_result = [_helico, _objTarget, _grp] call DK_fnc_checkIfDisembark_heli_army_rfr;
					_haveDisembark = _result # 0;
					if _haveDisembark then
					{
						_grp = _result # 1;
					};
				};

				// Move far away
				if (alive _driver) then
				{
					[_driver, 25, 545, true] spawn DK_fnc_addAllTo_CUM;

					_helico flyInHeight 200;
					_waypointGrp = [_grp, (_helico getPos [15000, random 360]), "MOVE", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypoint;

					_helico limitSpeed 1000;
					_helico forceSpeed -1;

					_helico spawn
					{
						uiSleep 80;
						if ( (!isNil "_helico") && {(!isNull _helico) && {(alive _helico) } } ) then
						{
							_helico flyInHeight 800;
						};
					};
				};

				if !(_haveDisembark) then
				{
					((crew _helico) - [_driver]) apply
					{
						[_x, 25, 545, false] spawn DK_fnc_addAllTo_CUM;
					};
				};
			};
		};
	};
};


DK_fnc_moveFarAway_heli = {

	// Delete from Wanted player
	private "_nil";
	private _cops = _objTarget getVariable ["wantedLvl", []];
	{
		_nil = _cops deleteAt (_cops find _x);

	} count _cops;

	// Move far away
	private _heliCrew = crew _helico;

	if !(_heliCrew findIf {alive _x} isEqualTo -1) then
	{
		_grp setBehaviour "CARELESS";
		_heliCrew doMove (_helico getPos [30000, random 360]);

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



DK_fnc_checkIfDisembark_heli_rfr = {

	params ["_helico", "_objTarget", "_grp"];


	// Set side, Gangs = east ; Cops = Resistance
	private _InSide = side _grp;;

	private ["_waypointGrp", "_waypointGrpFoot", "_grpBis", "_grpFoot", "_unitsCrew"];
	private _driver = driver _helico;
	private _haveDisembark = false;
	private _result = [_haveDisembark, nil];


	if ( (speed _objTarget < 12) && { (_objTarget distance2D _helico < 400) && { ({alive _x} count (crew _helico) > 1) && { !(playableUnits findIf {_x distance2D _objTarget < 120} isEqualTo -1) && { ((_objTarget nearEntities [["landVehicle","Man"], 140]) findIf {side (driver _x) isEqualTo (side _driver)} isEqualTo -1) } } } } ) then
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
			if ( ((getPosATL _helico) # 2 < 2.7) OR (_helico getVariable ["haveDisembark", false]) ) exitwith
			{
				_helico setVariable ["haveDisembark", true];
				_grpFoot = createGroup _InSide;

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
				_grpBis = createGroup _InSide;
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
		//		_grpFoot setCombatMode "RED";
				_grpFoot setCombatMode "YELLOW";
				_grpFoot setBehaviour "COMBAT";
				[_objTarget, _grpFoot] spawn DK_loop_crewOnFoot_heli_rfr;

				_haveDisembark = true;
			};

			uiSleep 0.5;

			if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (!alive _driver) OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) ) exitWith {};

			if ( (speed _objTarget > 12) OR (speed _objTarget < -12) OR ( ({alive _x} count (units _grp) < 2) && { (alive (driver _helico)) && { !(_helico getVariable ["haveDisembark", false]) } } ) OR (_objTarget distance2D _helico > 700) OR (((playableUnits findIf {_x distance2D _objTarget < 120} isEqualTo -1) OR !((_objTarget nearEntities [["landVehicle","Man"], 80]) findIf {side (driver _x) isEqualTo (side _driver)} isEqualTo -1)) && {((getPosATL _helico) # 2 > 50)}) ) exitWith
			{
				_grp call DK_fnc_delAllWp;
				_grp setBehaviour "CARELESS";

				if ( (alive _helico) && { (canMove _helico) && { (alive (driver _helico)) } } ) then
				{
					// Force Driver helico to cancel Landing
					_grpBis = createGroup _InSide;
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

DK_fnc_checkIfDisembark_heli_army_rfr = {

	params ["_helico", "_objTarget", "_grp"];


	private ["_waypointGrp", "_waypointGrpFoot", "_grpBis", "_grpFoot", "_unitsCrew"];
	private _driver = driver _helico;
	private _haveDisembark = false;
	private _result = [_haveDisembark, nil];


	if ( (_objTarget distance2D _helico < 800) && { ({alive _x} count (crew _helico) > 1) && { !(playableUnits findIf {_x distance2D _objTarget < 800} isEqualTo -1) } } ) then
	{
		_grp call DK_fnc_delAllWp;
		_helico flyInHeight 95;
		_helico limitSpeed 60;
		_driver doMove (getPosATL _objTarget);
		_waypointGrp = [_grp, _objTarget, "MOVE", nil, "LIMITED", "CARELESS"] call DK_fnc_AddWaypoint;

	///	// LOOP for UNLOAD
		private _time = time + 180;
		private _exitLand = false;
		while { (time < _time) } do
		{
			_unitsCrew = units _grp;

			if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (!alive _driver) OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) ) exitWith {};

			// Distance & Altitude OK, Allow para jump
			if ( ((speed _helico < 60 ) && { (_helico distance2D _objTarget < 90) && { ((getPosATL _helico) # 2 > 75) && { ((getPosATL _helico) # 2 < 110) } } }) OR (_helico getVariable ["haveDisembark", false]) ) exitwith
			{
				_helico setVariable ["haveDisembark", true];
				_grpFoot = createGroup resistance;

				(_unitsCrew - [_driver]) join _grpFoot;
				private _unitsCrewFoot = units _grpFoot;

				_unitsCrewFoot orderGetIn false;
				_unitsCrewFoot allowGetIn false;
				_grpFoot leaveVehicle _helico;

				{
					if (alive _x) then
					{
						unassignVehicle _x;
						moveOut _x;

						uiSleep (0.1 + (random 0.3));
					};

				} forEach _unitsCrewFoot;

				_unitsCrew doFollow (leader _grp);
				_grp call DK_fnc_delAllWp;
				_grpFoot call DK_fnc_delAllWp;

				// Force Driver helico to cancel Landing
				_grpBis = createGroup resistance;
				[_driver] join _grpBis;
				_grpBis deleteGroupWhenEmpty true;
				_driver doFollow (leader _grpBis);
				_helico flyInHeight 130;
				_helico land "NONE";
	//			_waypointGrp = [_grpBis, (_objTarget getPos [6000, random 360]), "MOVE", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypoint;

				_waypointGrpFoot = [_grpFoot, _objTarget, "SAD", nil,  if (!isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}, if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"}] call DK_fnc_AddWaypoint;

				uiSleep 5;
				_grpFoot setBehaviour "COMBAT";
				[_objTarget, _grpFoot] spawn DK_loop_crewOnFoot_heli_rfr;

				_haveDisembark = true;
			};

			uiSleep 0.5;

			if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR (isNull _helico) OR (isNil "_helico") OR (!alive _helico) OR (!canMove _helico) ) exitWith {};

			if ( ( ({alive _x} count (units _grp) < 2) && { (alive (driver _helico)) && { !(_helico getVariable ["haveDisembark", false]) } } ) OR (_objTarget distance2D _helico > 800) OR (playableUnits findIf {_x distance2D _objTarget < 800} isEqualTo -1) ) exitWith
			{
				_grp call DK_fnc_delAllWp;
				_grp setBehaviour "CARELESS";

				if ( (alive _helico) && { (canMove _helico) && { (alive (driver _helico)) } } ) then
				{
					// Force Driver helico to cancel Landing
					_grpBis = createGroup resistance;
					_unitsCrew join _grpBis;
					_grpBis deleteGroupWhenEmpty true;
					_unitsCrew apply
					{
						doStop _x;
						_x doFollow (leader _grpBis);
					};
					_helico flyInHeight 80;
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
					_helico forceSpeed 500;
				};
			};
		};
	};


	if _haveDisembark then
	{
		_result = [_haveDisembark, _grpBis];
	};


	_result
};


DK_loop_crewOnFoot_heli_rfr = {

	params [["_objTarget", []], "_grpFoot"];


	if ( (units _grpFoot findIf {alive _x} isEqualTo -1) OR (_objTarget isEqualTo []) ) exitWith {};

	private ["_fnc_cond1", "_fnc_cond2"];

	call
	{
		if (typeName _objTarget isEqualTo "ARRAY") exitWith
		{
			_fnc_cond1 = {

				!(_objTarget isEqualTo [])
			};

			_fnc_cond2 = {

				(time > _time)
			};
		};

		_fnc_cond1 = {

			(!isNil "_objTarget") && { (!isNull _objTarget) }
		};

		_fnc_cond2 = {

			(time > _time) OR (isNil "_objTarget") OR (isNull _objTarget) OR (speed _objTarget > 30)
		};
	};


	(units _grpFoot) apply
	{
		_x setVariable ["cleanUpOn", false];
		[_x, 120, 200, true] spawn DK_fnc_addAllTo_CUM;
	};

	_grpFoot spawn DK_fnc_selectLoopVoice;

	private "_time";
	while { !(units _grpFoot findIf {alive _x} isEqualTo -1) && { call _fnc_cond1 } } do
	{
		_grpFoot call DK_fnc_delAllWp;
		
		_waypoint = [_grpFoot, _objTarget, "SAD", "DIAMOND", "FULL", "AWARE", 13] call DK_fnc_AddWaypoint;

		uiSleep 5;
		_time = time + 15;

		waitUntil { uiSleep 1; call _fnc_cond2 };
	};
};

DK_fnc_start_heliPara_army_rfr = {

	params ["_objTarget", "_idMission"];

	private ["_unit04", "_unit05", "_unit06", "_unit07", "_unit08", "_unit09"];


	private _resultSrchSpwn = [_objTarget, 800, nil, nil, 2, _idMission] call DK_fnc_searchSpawn_rfr_heli; 
	_resultSrchSpwn params ["_spawnPos", "_dir"];

	private _grp = createGroup resistance;

	private _unit01 = crtU(_grp, "I_officer_F");
	private _unit02 = crtU(_grp, "I_officer_F");
	private _unit03 = crtU(_grp, "I_officer_F");

	uiSleep 0.15;

	call
	{
		_nbPlyMax = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

		if ((_nbPlyMax > 1) && {(_nbPlyMax < 4)} ) exitWith
		{
			for "_i" from 1 to 2 do
			{
				uiSleep 0.08;
				crtU(_grp, "I_officer_F");
			};
		};

		if ((_nbPlyMax > 4) && {(_nbPlyMax < 8)} ) exitWith
		{
			for "_i" from 1 to 4 do
			{
				uiSleep 0.08;
				crtU(_grp, "I_officer_F");
			};
		};

		if (_nbPlyMax isEqualTo 8) then
		{
			for "_i" from 1 to 6 do
			{
				uiSleep 0.08;
				crtU(_grp, "I_officer_F");
			};
		};
	};


	private _unitsCrew = units _grp;

	private _helico = [true] call DK_MIS_fnc_crtHeliPara_Army;

	_unit01 moveInDriver _helico;
	_unit01 spawn DK_fnc_LO_ArmyHeli_pilot;

	{
		[_x, (armyParaWpns # _forEachIndex)] spawn DK_fnc_LO_ArmyHeli_crew;
		_x setVariable ["objTarget", _objTarget];

		uiSleep 0.05;

	} forEach (_unitsCrew - [_unit01]);

	_helico allowDamage false;

	_grp selectLeader _unit01;
	_grp setBehaviour "CARELESS";
	_grp setCombatMode "YELLOW";

	_unitsCrew apply
	{
		_x allowDamage false;
	//	_x allowFleeing 0;
		_x setVariable ["DK_idMission", _idMission];
		_x setVariable ["DK_unitsCrew", _unitsCrew];
		_x spawn DK_MIS_addEH_HandleDmg;
		_x spawn DK_MIS_EH_handleAmmoNweapons;
		_x spawn DK_MIS_addEH_secondDead;
		DK_unitsStayUp pushBackUnique _x;
		_x disableAI "FSM";

		if !(_x isEqualTo _unit01) then
		{
			_x moveInCargo _helico;
		};

		uiSleep 0.2;

		_x call DK_addEH_deadNdel_para_rfr;
	};

	_grp deleteGroupWhenEmpty true;
	_grp setFormation "DIAMOND";
	_grp setSpeedMode "FULL";
	_grp addVehicle _helico;

	_unitsCrew orderGetIn true;
	_unitsCrew allowGetIn true;


	_helico setDir _dir;
	_helico setPosATL _spawnPos;

	DK_nb_searchSpawn_rfr_heli_inProg = false;

	_unitsCrew apply
	{
		_x allowDamage true;
	};

	_helico forceSpeed 400;
	_unitsCrew doMove (getPosATL _objTarget);

	_helico allowDamage true;

	uiSleep 2;

	_helico flyInHeight 90;

	///	// LOOP for UNLOAD Para
	private ["_grpFoot"];
	private _time = time + 100;
	while { uiSleep 0.7; (time < _time) } do
	{
		if ( (isNil "_objTarget") OR (isNull _objTarget) OR (speed _objTarget > 30) OR ({alive _x} count _unitsCrew < 2) OR (!alive _unit01) OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) OR (_objTarget distance2D _helico > 5000) ) exitWith {};

		_unitsCrew = units _grp;

		if ( (_helico getVariable ["needSlow", true]) && {(_helico distance2D _objTarget < 250)} ) then
		{
			_helico setVariable ["needSlow", false];
			_helico limitSpeed 75;
		};

		if (_helico getVariable ["needMove", true]) then
		{
			if (_helico distance2D _objTarget < 450) then
			{
				_helico setVariable ["needMove", false];
				_grp call DK_fnc_delAllWp;
				_unitsCrew doMove (_objTarget getPos [4000, _helico getDir _objTarget]);
			}
			else
			{
				_unitsCrew doMove (getPosATL _objTarget);
			};
		};


		// Distance & Altitude OK, Allow para jump
		if ( !(_helico getVariable ["needMove", true]) && { (speed _helico < 150) && { (_helico distance2D _objTarget < 150) && { ((getPosATL _helico) # 2 > 70) && { !(playableUnits findIf {_x distance2D _objTarget < 500} isEqualTo -1) } } } } ) exitwith
		{
			_grpFoot = createGroup resistance;

			(_unitsCrew - [_unit01]) join _grpFoot;
			_unitsCrewFoot = units _grpFoot;

			_unitsCrewFoot orderGetIn false;
			_unitsCrewFoot allowGetIn false;
			_grpFoot leaveVehicle _helico;

			{
				if (alive _x) then
				{
					unassignVehicle _x;
					moveOut _x;
					[_x, _helico] spawn DK_fnc_getNopenPara;

					uiSleep 0.1 + (random 0.3);
				};

			} forEach _unitsCrewFoot;

			_grpFoot call DK_fnc_delAllWp;
			_waypointGrpFoot = [_grpFoot, _objTarget, "SAD", nil,  if (!isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"}, if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"COMBAT"}] call DK_fnc_AddWaypoint;

			private _grpBis = createGroup resistance;
			[_unit01] join _grpBis;
			_grpBis deleteGroupWhenEmpty true;
			_grpBis call DK_fnc_delAllWp;
			_unit01 doFollow (leader _grpBis);

			_unit01 enableAI "MOVE";
			doStop _unit01;
			_helico land "NONE";

			(crew _helico) apply
			{
				[_x, 40, 800, true] spawn DK_fnc_addAllTo_CUM;
			};

			[_grpFoot, _objTarget] spawn
			{
				params ["_grpFoot", "_objTarget"];

				uiSleep 5;
				_grpFoot setBehaviour "COMBAT";
				[_objTarget, _grpFoot] spawn DK_loop_crewOnFoot_heli_rfr;
			};

		};
	};

	if (isNil "_grpFoot") then
	{
		((crew _helico) - [_unit01]) apply
		{
			_helico deleteVehicleCrew _x;
		};
	};

	if ( (!isNil "_helico") && { (!isNull _helico) && { (alive _helico) } } ) then
	{
		_helico limitSpeed 1000;
		_helico forceSpeed -1;
	};

	if ( (!isNil "_unit01") && { (!isNull _unit01) && { (alive _unit01) } } ) then
	{
		[_unit01, 1, 800, true] spawn DK_fnc_addAllTo_CUM;
		_grp = group _unit01;
		_grp setBehaviour "CARELESS";
		_grp setSpeedMode "FULL";
		_unit01 doMove (_unit01 getPos [8000, getDir _unit01]);
	};

	waitUntil { uiSleep 5; (isNil "_helico") OR (isNull _helico) OR (!alive _helico) OR (!canMove _helico) };

	if ((isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget)) exitWith {};

	_objTarget setVariable ["paraWaiting2", true];
};


DK_addEH_killed_heliCrew_rfr = {
	
	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		[_unit, vehicle _unit] spawn DK_fnc_EH_killed_heliCrew_rfr;
	}];


};

DK_fnc_EH_killed_heliCrew_rfr = {

	params ["_unit", "_vehicle"];

	uiSleep 0.65;

	// Drop corps of unit dead & Move crew on the bench
	call
	{
		_heliType = typeOf _vehicle;

		if (_heliType isEqualTo "B_Heli_Light_01_F") then
		{
			_turretCrew = fullCrew [_vehicle, "turret", true];

			if (((_turretCrew # 3) # 0) isEqualTo _unit) exitWith
			{
				_unit setPosWorld (getPosASLVisual _unit);
				
				uiSleep 3 + (random 4);
				private _cargoCrew = fullCrew [_vehicle, "cargo", true];

				private _unitToMove = (_cargoCrew # 0) # 0;
				if ( !(_unitToMove isEqualTo objNull) && { (alive _unitToMove) && { (side _unitToMove isEqualTo (side _unit)) } } ) exitWith
				{
					moveOut _unitToMove;
					_unitToMove moveInAny _vehicle;
				};

				_unitToMove = (_cargoCrew # 1) # 0;
				if ( !(_unitToMove isEqualTo objNull) && { (alive _unitToMove) && { (side _unitToMove isEqualTo (side _unit)) } } ) then
				{
					moveOut _unitToMove;
					_unitToMove moveInAny _vehicle;
				};
			};

			if (((_turretCrew # 1) # 0) isEqualTo _unit) then
			{
				_unit setPosWorld (getPosASLVisual _unit);
				
				uiSleep 3 + (random 4);
				private _cargoCrew = fullCrew [_vehicle, "cargo", true];

				private _unitToMove = (_cargoCrew # 1) # 0;
				if ( !(_unitToMove isEqualTo objNull) && { (alive _unitToMove) && { (side _unitToMove isEqualTo (side _unit)) } } ) exitWith
				{
					moveOut _unitToMove;
					_unitToMove moveInAny _vehicle;
				};

				_unitToMove = (_cargoCrew # 0) # 0;
				if ( !(_unitToMove isEqualTo objNull) && { (alive _unitToMove) && { (side _unitToMove isEqualTo (side _unit)) } } ) then
				{
					moveOut _unitToMove;
					_unitToMove moveInAny _vehicle;
				};
			};
		};


		if (_heliType isEqualTo "I_Heli_light_03_dynamicLoadout_F") then
		{
			_turretCrew = fullCrew [_vehicle, "turret", true];

			if (((_turretCrew # 1) # 0) isEqualTo _unit) exitWith
			{
				_unit setPosWorld (getPosASLVisual _unit);
			};

			if (((_turretCrew # 2) # 0) isEqualTo _unit) then
			{
				_unit setPosWorld (getPosASLVisual _unit);
			};
		};
	};

};

DK_addEH_getOut_heliCrew_rfr = {

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit", "", "_heli"];


		_unit removeEventHandler ["GetOutMan", _thisEventHandler];

		if (!alive _unit) exitWith {};

		if ({alive _x} count crew _heli < 2) then
		{
			_heli setVariable ["haveDisembark", true];
		};

		[_unit, _heli] spawn DK_fnc_getNopenPara;

		_unit setCombatMode "YELLOW";
		_unit call (_unit getVariable "DK_skill");

		[_unit,40,180,true] spawn DK_fnc_addAllTo_CUM;
	}];

};

DK_addEH_helicopter_rfr = {

	private _idEh01 = _this addEventHandler ["EpeContactStart",
	{
		params ["_heli", "_whoHasTouch"];


		if !(_heli getVariable ["EpeOk", true]) exitWith {};

		_heli setVariable ["EpeOk", false];

		_heli spawn
		{
			uiSleep 0.5;

			if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
			{
				_this setVariable ["EpeOk", true];
			};
		};

		[_heli, _whoHasTouch, _thisEventHandler] call DK_fnc_EH_epeContact_helicopter_rfr;
	}];

	private _idEh02 = _this addEventHandler ["GetIn",
	{
		params ["_heli", "", "_unit"];


		if ( (isPlayer _unit) OR (side (group _unit) isEqualTo west) && { ((!alive (driver _heli)) OR (isPlayer (driver _heli) OR (side (group (driver _heli)) isEqualTo west))) } ) then
		{
			_heli removeEventHandler ["EpeContactStart", (_heli getVariable "idEhHeliRfr") # 0];
			_heli removeEventHandler ["GetIn", _thisEventHandler];
		};
	}];


	_this setVariable ["idEhHeliRfr", [_idEh01, _idEh02]];
};

DK_fnc_EH_epeContact_helicopter_rfr = {

	params ["_heli", "_whoHasTouch", "_thisEventHandler"];


	private _heliDriver = driver _heli;
	private _grp = group _heliDriver;

	if ( ((!alive driver _heli) OR ( (waypointType [_grp, currentWaypoint _grp] isEqualTo "UNLOAD") && { (!isPlayer _whoHasTouch) OR !(side (group _whoHasTouch) isEqualTo west)} )) OR (!canMove _heli) ) then
	{
		_heli removeEventHandler ["EpeContactStart", _thisEventHandler];

		private _crew = crew _heli;
		if (canMove _heli) then
		{
			private _nil = _crew deleteAt (_crew find _heliDriver);
		};

		if ( (!isNil "_crew") && { !(_crew isEqualTo []) } ) then
		{
			_crew orderGetIn false;
			_crew allowGetIn false;

			{
				if (alive _x) then
				{
					unassignVehicle _x;
					moveOut _x;
				};

			} count _crew;

			_heli setVariable ["haveDisembark", true];
			// Function Walking units
		};
	};
};


DK_fnc_heliPadAroundTarget = {

	params ["_objTarget", "_helico"];


	_heliPadcar01 = crtHeliPad;
	_heliPadcar01 attachTo [_objTarget, [0,15,0.5]];

	uiSleep 0.2;
	_heliPadcar02 = crtHeliPad;
	_heliPadcar02 attachTo [_objTarget, [-13,0,0.5]];

	uiSleep 0.2;
	_heliPadcar03 = crtHeliPad;
	_heliPadcar03 attachTo [_objTarget, [13,0,0.5]];

	uiSleep 0.2;
	_heliPadcar04 = crtHeliPad;
	_heliPadcar04 attachTo [_objTarget, [0,-15,0.5]];


	[_heliPadcar01, _heliPadcar02, _heliPadcar03, _heliPadcar04]
};


// Wanted count stars (mission)
DK_fnc_sendWantedLevel_toPlayer = {

	call
	{
		if (_this isEqualTo 19) exitWith
		{
			missionNamespace setVariable ["wantedMissionLvl_cl", 3, true];
		};

		if ((_this isEqualTo 7) OR (_this isEqualTo 7.5)) exitWith
		{
			missionNamespace setVariable ["wantedMissionLvl_cl", 1, true];
		};

		if ((_this isEqualTo 8) OR (_this isEqualTo 8.5) OR (_this isEqualTo 18) OR (_this isEqualTo 18.5)) then
		{
			missionNamespace setVariable ["wantedMissionLvl_cl", 2, true];
		};

	};

};

DK_MIS_fnc_addPointsToWantedLvl = {

	private _actuWantedMisLvl = missionNamespace getVariable ["wantedMissionVal", 0];
	if ( !(_actuWantedMisLvl isEqualTo 0) && { !(_actuWantedMisLvl isEqualTo 19) OR (_this < 0) } ) then
	{
		private _futureWantedMisLvl = _actuWantedMisLvl + _this;

		if (_futureWantedMisLvl > 19) then
		{
			_futureWantedMisLvl = 19;
		};

		_futureWantedMisLvl call DK_fnc_sendWantedLevel_toPlayer;

		missionNamespace setVariable ["wantedMissionVal", _futureWantedMisLvl];

//		hint (("Wanted Jauge : ") + str (missionNamespace getVariable "wantedMissionVal"));
	};

};

DK_MIS_loop_checkForSubstractPointsToWantedLvl = {

	params ["_objTarget", "_idMission"];


	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	waitUntil { uiSleep 0.1; (missionNamespace getVariable ["wantedMissionLvl_cl", 0] > 0) OR !(DK_MIS_var_missInProg) OR (isNull _objTarget) OR (!alive _objTarget) OR !(_idMission isEqualTo DK_idMission) };

	private "_time";
	private _startingLvlStars = missionNamespace getVariable ["wantedMissionLvl_cl", 1];

	uiSleep 30;

	if ( (missionNamespace getVariable ["wantedMissionLvl_cl", 0] isEqualTo 0) OR !(DK_MIS_var_missInProg) OR (isNull _objTarget) OR (!alive _objTarget) OR !(_idMission isEqualTo DK_idMission) ) exitWith
	{
		DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;
	};

	while { !(missionNamespace getVariable ["wantedMissionLvl_cl", 0] isEqualTo 0) && { (DK_MIS_var_missInProg) && { (!isNull _objTarget) && { (alive _objTarget) && { (_idMission isEqualTo DK_idMission) } } } } } do
	{
		if ( (missionNamespace getVariable ["wantedMissionVal", 0] > 0) && { (missionNamespace getVariable ["wantedMissionLvl_cl", 0] > _startingLvlStars) && { (playableUnits findIf {_x distance _objTarget < 525} isEqualTo -1) } } ) then
		{
			-0.5 call DK_MIS_fnc_addPointsToWantedLvl;

			_time = time + 10;
			waitUntil { uiSleep 2; (time > _time) OR !(DK_MIS_var_missInProg) OR !(_idMission isEqualTo DK_idMission) }
		};

		_time = time + 10;
		waitUntil { uiSleep 2; (time > _time) OR !(DK_MIS_var_missInProg) OR !(_idMission isEqualTo DK_idMission) }
	};

	missionNamespace setVariable ["wantedMissionLvl_cl", 0, true];

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;
};



// Wanted count stars (local, patrol)
DK_fnc_manageWantedLvlPly = {

	params ["_player", "_copsCrew"];


	private _startHUD = false;
	private _wantedLvl = _player getVariable ["wantedLvl", []];

	if ( (missionNamespace getVariable ["wantedMissionVal", 0] isEqualTo 0) && { ({alive _x} count _wantedLvl isEqualTo 0) } ) then
	{
		_startHUD = true;
	};

	_wantedLvl append _copsCrew;

	_player setVariable ["wantedLvl", _wantedLvl, true];

	if (_startHUD) then
	{
		_player remoteExecCall ["DK_add_HUD_wantedLvl_cl", _player];
	};

	// Manage Heli cops 3 Stars
	if (_player getVariable ["rfrHeliMng", false]) exitWith {};

	_player setVariable ["rfrHeliMng", true];
	_player setVariable ["DK_chaseTime1", time + 90];
	_player setVariable ["DK_chaseTime2", time + 270];
	_player setVariable ["DK_chaseTime3", time + 390];
/*	_player setVariable ["DK_chaseTime1", time + 10];
	_player setVariable ["DK_chaseTime2", time + 10];
	_player setVariable ["DK_chaseTime3", time + 10];
*/
	_player setVariable ["DK_chaseTimeHeli", 0];


	private "_cops";
	while { (alive _player) && { !(lifeState _player isEqualTo "INCAPACITATED") && { !((_player getVariable ["wantedLvl", []]) findIf {alive _x} isEqualTo -1) } } } do
	{
		_cops =  _player getVariable ["wantedLvl", []];
		_cntCops= { (alive _x) && {!(_x getVariable ["onHeli", false])} } count _cops;


		// Heli cops
		if ( !(_player getVariable ["heliChase", false]) && { (_cntCops > 7) && { (time > _player getVariable ["DK_chaseTimeHeli", 0]) && { (_cops findIf { (objectParent _x isEqualTo "B_Heli_Light_01_F") } isEqualTo -1) } } } ) then
		{
			_player setVariable ["heliChase", true];

			call
			{
				if !(_cops findIf { (_x getVariable ["DK_side", ""]) isEqualTo "army" } isEqualTo -1) exitWith
				{
					[_player, 3] spawn DK_fnc_init_wanted_heliCops;
				};

				if !(_cops findIf { (_x getVariable ["DK_side", ""]) isEqualTo "fbi" } isEqualTo -1) exitWith
				{
					[_player, 2] spawn DK_fnc_init_wanted_heliCops;
				};

				[_player, 1] spawn DK_fnc_init_wanted_heliCops;
			};
		};

		call
		{
			// Rfr for 5 Stars
			if ( (time > (_player getVariable ["DK_chaseTime3", time])) && { (_cntCops < 8) } ) exitWith
			{
				[_player, ["I_officer_F", "Army", "", "", ""], false, 25] spawn DK_MIS_fnc_rfrAtPlayer;
				_player setVariable ["DK_chaseTime3", time + 20];

				_player setVariable ["DK_chaseTime2", 0];
				_player setVariable ["DK_chaseTime1", time + 45];
			};

			// Rfr for 4 Stars
			if ( (time > (_player getVariable ["DK_chaseTime2", time])) && { (_cntCops < 8) } ) exitWith
			{
				[_player, ["I_officer_F", "FIB agents", "uniform_FBI", "wpns_MXC", "vest_beltFBI"], false, 20] spawn DK_MIS_fnc_rfrAtPlayer;
				_player setVariable ["DK_chaseTime2", time + 30];
			};

			// Rfr for 3 Stars
			if ( (time > (_player getVariable ["DK_chaseTime1", time])) && { (_cntCops < 8) } ) then
			{
				_player spawn DK_fnc_initCopsPatrol_2sRfr;
				_player setVariable ["DK_chaseTime1", time + 45];
			};
		};


		uiSleep 10;
	};

	_player setVariable ["rfrHeliMng", false];
	_player setVariable ["DK_chaseTime1", -1];
	_player setVariable ["DK_chaseTime2", -1];
	_player setVariable ["DK_chaseTime3", -1];

};

DK_fnc_manageWantedLvlPlyEndMiss = {

	if !(missionNamespace getVariable ["wantedMissionVal", 0] isEqualTo 0) then
	{
		missionNamespace setVariable ["wantedMissionVal", 0];
		{
			if !( {alive _x} count (_x getVariable ["wantedLvl", []]) isEqualTo 0 ) then
			{
				_x remoteExecCall ["DK_add_HUD_wantedLvl_cl", _x];
			};

			uiSleep 0.05;


		} forEach playableUnits;
	};
};


