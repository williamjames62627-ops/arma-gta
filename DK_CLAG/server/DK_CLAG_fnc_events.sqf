if (!isServer) exitWith {};


DK_countNb_event_CLAG = 0;

// Count Events & Civilians
#define CNT(NB) DK_countNb_civ_CLAG = DK_countNb_civ_CLAG + NB
#define CNTEVT(NB) DK_countNb_event_CLAG = DK_countNb_event_CLAG + NB

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []
#define PlaceOKhey(P) (nearestObjects [P, [], 6]) findIf { typeOf _x isEqualTo "Land_HayBale_01_stack_F"} isEqualTo -1

// Apply Delete
#define LogicEvtDel(LGC) _nul = DK_CLAG_LogicsEvents deleteAt (DK_CLAG_LogicsEvents find LGC)

// Apply Pushback
#define LogicEvtPuBa(LGC) DK_CLAG_LogicsEvents pushBackUnique LGC

// Create Civilian Agent
#define crtA createAgent [classH, [0,0,100], [], 0, "CAN_COLLIDE"]
#define crtF createAgent ["C_Farmer_01_enoch_F", [0,0,100], [], 0, "CAN_COLLIDE"]
#define crtRepMAN call DK_fnc_crtRepMan
#define crtFarmMAN call DK_fnc_crtFarmerMan
#define crtDealer call DK_fnc_crtMarketMan
#define crtCIV call DK_fnc_crtCivAgent
#define crtCIVCONS call DK_fnc_crtCivConstruAgent

// Create Vehicles
#define crtV(C) createVehicle [C, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]
#define crtVPKREP(DIS) DIS call DK_fnc_crtEVT_REPAIR
#define crtVPKCLV(DIS) DIS call DK_fnc_crtVPK_CLV
#define crtVPKTRCTR(DIS) DIS call DK_fnc_crtEVT_Tractor
#define crtVPKMKRT(DIS) DIS call DK_fnc_crtEVT_Market

#define crtJUMPzam(DIS) DIS call DK_fnc_crtJUMPzam
#define crtJUMPlightTT(DIS) DIS call DK_fnc_crtJUMPlightTT


// Define Classname
#define classH selectRandom ["C_man_polo_1_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_asia"]
#define classREP "C_Offroad_01_repair_F"
#define classZAM "C_Truck_02_transport_F"
#define classLTT "C_Van_01_transport_F"
#define classTRACT "C_Tractor_01_F"
#define classMRKT selectRandom ["C_Van_02_vehicle_F", "C_Van_01_transport_F", "C_Van_01_box_F"]

// Define color vehicles
#define ZamTcol ["Orange","Blue"]
#define LTcol ["Black","Red","White"]


// Anims
#define anmsChat_A [toLower "Acts_PointingLeftUnarmed",toLower "HubStandingUB_move1",toLower "HubStandingUC_move2",toLower "acts_StandingSpeakingUnarmed"]
#define anmsChat_B [toLower "HubStandingUC_idle3",toLower "HubStandingUC_idle2",toLower "HubStandingUC_idle1"]
#define anmsChat_C [toLower "HubStandingUB_idle1",toLower "HubStandingUB_idle2",toLower "HubStandingUB_idle3"]
#define anmsChat_BC [anmsChat_B,anmsChat_C]
#define slctAnimsBC selectRandom (selectRandom anmsChat_BC)
#define delAnimsA(ANM) selectRandom (anmsChat_A - [ANM])

#define slctAnimsA selectRandom anmsChat_A
#define slctAnimsB selectRandom anmsChat_B
#define slctAnimsC selectRandom anmsChat_C

// Insult civ control
#define insultAll selectRandom ["C_civSay02", "seeGun01", "insult01", "C_civSay02", "A_civSay07", "A_civSay01"]
#define insultCar selectRandom ["jackedCar02", "jackedCar01"]

// Sleep
#define slpPlacTake 45					// Time for OK after they are ALREADY a CIV SPAWNED at this place
#define slpPuBaEVT 600 					// Time for OK if ANY PLAYER HAS LEFT area spawn civ.



#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]

//////////// ---- FUNCTIONS ---- \\\\\\\\\\\\

// Agents (Units)
DK_fnc_crtRepMan = {

	_civ = crtA;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_RepairSafe;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

		private _grpAry = (_entity getVariable "DK_logic") getVariable "DK_group";
		private _nil = _grpAry deleteAt (_grpAry find _entity);
		{
			if (_x getVariable "DK_behaviour" isEqualTo "chat") then
			{
				if !(_x getVariable "DK_sittingBench") then
				{
					_x enableDynamicSimulation false;
					_x setVariable ["DK_behaviour", "walk"];

					_x spawn
					{
//						// sleep (random 0.7);
						if (alive _this) then
						{
							[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						};
					};

					_x enableAI "MOVE";
					_x setUnitPos "UP";
					_x forceWalk true;
					_x setSpeedMode "NORMAL";
					_x allowFleeing 0.1;

					_nil = [_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

					_x forceSpeed (_x getSpeed "SLOW");
				};
			};

		} count _grpAry;


	///	// Delete Trigger Hurt
		private _trgHurt = _entity getVariable ["trgHurtCiv", "empty"];
		if !(_trgHurt isEqualTo "empty") then
		{
			deleteVehicle _trgHurt;
		};

	/// // DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_civ spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "mil_triangle";
			_mkrNzme setMarkerColor "ColorCIV";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtFarmerMan = {

	_civ = crtF;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ setSkill 0.1;
	_civ disableAI "AUTOCOMBAT";

	_civ setVariable ["DK_side", "civ"];

	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

	///	// React Unit Mate
		private _grpAry = (_entity getVariable "DK_logic") getVariable "DK_group";
		private _nil = _grpAry deleteAt (_grpAry find _entity);
		{
			if ( (alive _x) && { (_x getVariable "DK_behaviour" isEqualTo "chat") && { !(_x getVariable "DK_sittingBench") } } ) then
			{
				_x enableDynamicSimulation false;
				_x setVariable ["DK_behaviour", "walk"];

				[_x,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_x enableAI "MOVE";
				_x setUnitPos "UP";
				_x forceWalk true;
				_x setSpeedMode "NORMAL";
				_x allowFleeing 0.1;

				[_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

				_x forceSpeed (_x getSpeed "SLOW");
			};

		} count _grpAry;


	///	// Delete Trigger Hurt
		private _trgHurt = _entity getVariable ["trgHurtCiv", "empty"];
		if !(_trgHurt isEqualTo "empty") then
		{
			deleteVehicle _trgHurt;
		};

	/// // DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_civ spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "mil_triangle";
			_mkrNzme setMarkerColor "ColorCIV";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtMarketMan = {

	_civ = crtA;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_marketDealer;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

	///	// React Unit Mate
		private _grpAry = (_entity getVariable "DK_logic") getVariable "DK_group";
		private _nil = _grpAry deleteAt (_grpAry find _entity);
		{
			if ( (alive _x) && { (_x getVariable "DK_behaviour" isEqualTo "chat") && { !(_x getVariable "DK_sittingBench") } } ) then
			{
				_x enableDynamicSimulation false;
				_x setVariable ["DK_behaviour", "walk"];

				[_x,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_x enableAI "MOVE";
				_x setUnitPos "UP";
				_x forceWalk true;
				_x setSpeedMode "NORMAL";
				_x allowFleeing 0.1;

				[_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

				_x forceSpeed (_x getSpeed "SLOW");
			};

		} count _grpAry;


	///	// Delete Trigger Hurt
		private _trgHurt = _entity getVariable ["trgHurtCiv", "empty"];
		if !(_trgHurt isEqualTo "empty") then
		{
			deleteVehicle _trgHurt;
		};

	/// // DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_civ spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "mil_triangle";
			_mkrNzme setMarkerColor "ColorCIV";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};
/// // DEBUG MOD END

	_civ
};



// Car Breakdown & Repair man/offroad
DK_fnc_crtEVT_REPAIR = {

	_veh = crtV(classREP);

	[_veh,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_init_veh;

	[
		_veh,
		nil,
		["BeaconsServicesStart",1]

	] call BIS_fnc_initVehicle;

	CNTEVT(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTEVT(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

	_id2 = _veh addEventHandler ["Engine",
	{
		params ["_veh"];


		_EHs = _veh getVariable "DK_CLAG_EHs";

		_veh removeEventHandler ["Engine", _EHs # 1];
		_veh removeEventHandler ["deleted", _EHs # 0];

		CNTEVT(-1);
	}];

	_veh setVariable ["DK_CLAG_EHs", [_id1,_id2]];


	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "b_service";
			_mkrNzme setMarkerColor "ColorOrange";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_CLAG_crtEVT_CBD = {

	params ["_mkrPos","_logic"];


	private _dirVeh = ((_logic getVariable "dir") + (selectRandom [0,180]));

	if (isNil "_dirVeh") exitWith {};

	_posVeh = _mkrPos getPos [-4,_dirVeh];
	_posVeh set [2,0];
	private _posOfrdRep = _mkrPos getPos [4,_dirVeh];

	if ((isOnRoad _posVeh) OR (isOnRoad _posOfrdRep)) exitWith {};

	if ( !( PlaceOK(_mkrPos,6,4) ) OR !( PlaceOK(_posVeh,6,4) ) OR !( PlaceOK(_posOfrdRep,6,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPlacTake)];
/*
		_logic spawn
		{
			uiSleep slpPlacTake;
			LogicEvtPuBa(_this);
		};
*/	};

	private _dis = _logic getVariable "choiceDis";

	private _civ01 = crtCIV;
	private _repMan = crtRepMAN;

	private _veh01 = crtVPKCLV(_dis);
	private _repOfrd = crtVPKREP(_dis);

	_veh01 setDir _dirVeh;
	_veh01 setPosATL _posVeh;
	_veh01 setVectorUp surfaceNormal _posVeh;

	_posOfrdRep = _veh01 getPos [7.5,_dirVeh];
	_repOfrd setDir ((_dirVeh + 175) + (random 10));
	_repOfrd setPosATL _posOfrdRep;
	_repOfrd setVectorUp surfaceNormal _posOfrdRep;

	private ["_nil", "_posManRep"];
	private _placement = selectRandom [1,2];
	call
	{
		_classVeh = typeOf _veh01;

		if (_classVeh in ["B_G_Offroad_01_F", "C_Offroad_01_F"]) exitWith
		{
			call
			{
				if (_placement isEqualTo 1) exitWith
				{
					_posManRep = [0,3.25,0];
				};

				_posManRep = [-1.7,1.6,0];
			};
		};

		if (_classVeh isEqualTo "C_SUV_01_F") exitWith
		{
			call
			{
				if (_placement isEqualTo 1) exitWith
				{
					_posManRep =  [0,3.06,0];
				};

				_posManRep = [-1.6,1.5,0];
			};
		};

		if (_classVeh isEqualTo "C_Offroad_02_unarmed_F") exitWith
		{
			call
			{
				if (_placement isEqualTo 1) exitWith
				{
					_posManRep = [0,2.95,0];
				};

				_posManRep = [-1.6,1.5,0];
			};
		};

		call
		{
			if (_placement isEqualTo 1) exitWith
			{
				_posManRep = [0,2.76,0];
			};

			_posManRep = [-1.5,1.3,0];
		};
	};

	_posManRep = _veh01 modelToWorldVisual _posManRep;
	_posManRep set [2,0];
	_repMan setPosATL _posManRep;

	private "_dirRepMan";
	call
	{
		if (_placement isEqualTo 1) exitWith
		{
			_veh01 spawn DK_fnc_CLAG_eventCBD_smokeEngine;

			_dirRepMan = _dirVeh + 180;
			_repMan setVariable ["setDir", _dirRepMan];
		};

		_dirRepMan = _dirVeh + 90;
		_repMan setVariable ["setDir", _dirRepMan];
		_veh01 setHitPointDamage ["HitLFWheel", 0.9];
	};
	_repMan setdir _dirRepMan;

	_civ01 setPosATL (_repMan modelToWorldVisual [-1.8,0,0]);
	_civ01 setdir (_civ01 getRelDir _repMan);

	_repMan setVariable ["animeOn", true];

	_grpAry = [_civ01,_repMan];

	[_veh01,_grpAry] call DK_fnc_CLAG_EH_vehicleEvt;
	[_repOfrd,_grpAry] call DK_fnc_CLAG_EH_vehicleEvt;

	_repMan setVariable ["setPos", _posManRep];

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];

	} count _grpAry;


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_repMan, _dis + 5] call DK_fnc_addEH_CivFoot;
	[_civ01, _dis + 5] call DK_fnc_addEH_CivFoot;
	_civ01 addVest "V_Safety_yellow_F";

	_repMan call DK_fnc_addEH_repairManAnim;
	[_civ01,slctAnimsBC] remoteExecCall ["DK_fnc_AnimSwitch", 0];


	///	// Create Cones
	_road = getPosWorld ([_mkrPos, 20] call BIS_fnc_nearestRoad);

	private _cone01 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone02 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone03 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone04 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone05 = "RoadCone_L_F" createVehicle [0,0,0];

	_cones = [_cone01,_cone02,_cone03,_cone04,_cone05];
	private _dirCones = _dirVeh - 8;
	{
		_x setDir (_dirCones + (random 16));
		_nil = [_x,7,_dis + 50] spawn DK_fnc_addAllTo_CUM;

	} count _cones;

	call
	{
		if (_veh01 modelToWorldVisual [1,0,0] distance2D _road < _veh01 modelToWorldVisual [-1,0,0] distance2D _road) exitWith
		{
			_pos1 = _veh01 getPos [2.8,_dirVeh + 90];
			_cone01 setPosATL _pos1;
			_cone01 setVectorUp surfaceNormal _pos1;

			_pos2 = _cone01 getPos [4,_dirVeh - 2];
			_cone02 setPosATL _pos2;
			_cone02 setVectorUp surfaceNormal _pos2;

			_pos3 = _cone01 getPos [-4,_dirVeh + 8];
			_cone03 setPosATL _pos3;
			_cone03 setVectorUp surfaceNormal _pos3;

			_pos4 = _cone02 getPos [4,_dirVeh];
			_cone04 setPosATL _pos4;
			_cone04 setVectorUp surfaceNormal _pos4;

			_pos5 = _cone04 getPos [4,_dirVeh - 5];
			_cone05 setPosATL _pos5;
			_cone05 setVectorUp surfaceNormal _pos5;
		};

		_pos1 = _veh01 getPos [2.8,_dirVeh - 90];
		_cone01 setPosATL _pos1;
		_cone01 setVectorUp surfaceNormal _pos1;

		_pos2 = _cone01 getPos [4,_dirVeh + 2];
		_cone02 setPosATL _pos2;
		_cone02 setVectorUp surfaceNormal _pos2;

		_pos3 = _cone01 getPos [-4,_dirVeh - 8];
		_cone03 setPosATL _pos3;
		_cone03 setVectorUp surfaceNormal _pos3;

		_pos4 = _cone02 getPos [4,_dirVeh];
		_cone04 setPosATL _pos4;
		_cone04 setVectorUp surfaceNormal _pos4;

		_pos5 = _cone04 getPos [4,_dirVeh + 5];
		_cone05 setPosATL _pos5;
		_cone05 setVectorUp surfaceNormal _pos5;
	};

	/// Create stuff repair man
	_obj01 = "Land_CanisterFuel_Blue_F" createVehicle [0,0,0];
	_obj02 = "Land_FireExtinguisher_F" createVehicle [0,0,0];
	_obj03 = "Land_CanisterOil_F" createVehicle [0,0,0];
	_obj04 = createSimpleObject ["Land_DuctTape_F", [0,0,0]];
	_obj05 = createSimpleObject ["Land_Wrench_F", [0,0,0]];

	_objects = [_obj01,_obj02,_obj03,_obj04,_obj05];
	{
		_x setDir (random 360);
		_nil = [_x,7,_dis + 25] spawn DK_fnc_addAllTo_CUM;

	} count _objects;

	_posStuff1 = _repMan modelToWorldVisual [0.6,-0.6,0];
	_posStuff1 set [2,0];
	_obj01 setPosATL _posStuff1;
	_obj01 setVectorUp surfaceNormal _posStuff1;

	_posStuff2 = _repMan modelToWorldVisual [-1,-0.8,0];
	_posStuff2 set [2,0];
	_obj02 setPosATL _posStuff2;
	_obj02 setVectorUp surfaceNormal _posStuff2;

	_posStuff3 = _repMan modelToWorldVisual [0.7,0.2,0];
	_posStuff3 set [2,0];
	_obj03 setPosATL _posStuff3;
	_obj03 setVectorUp surfaceNormal _posStuff3;

	_posStuff4 = _repMan modelToWorldVisual [0.4,0,0];
	_posStuff4 set [2,0];
	_obj04 setPosATL _posStuff4;
	_obj04 setVectorUp surfaceNormal _posStuff4;


	_posStuff5 = _repMan modelToWorldVisual [0.4,0.25,0];
	_posStuff5 set [2,0];
	_obj05 setPosATL _posStuff5;
	_obj05 setVectorUp surfaceNormal _posStuff5;

	{
		_x enableDynamicSimulation true;

	} count _objects;

	/// Activate Lights
	call
	{
		if (call DK_fnc_checkIfNight) exitWith
		{
			_repOfrd call DK_fnc_addEH_repOFR_beacons;
		};

		{
			_x enableDynamicSimulation true;

		} count _cones;
	};

	/// // WAITING
	[_civ01,_repMan,_logic] spawn
	{
		params ["_civ01","_repMan","_logic"];

		uiSleep 2;
		_civ01 enableDynamicSimulation true;
		_repMan enableDynamicSimulation true;

		if (isDedicated) then
		{
			[0.2,[_civ01,_repMan],_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPuBaEVT)];

/*		uiSleep slpPuBaEVT;

		LogicEvtPuBa(_logic);
*/	};
};


// Stunt Jump
DK_fnc_crtJUMPzam = {

	private _veh = crtV(classZAM);

	[_veh,7,_this + 25,true] spawn DK_fnc_addAllTo_CUM;

	[
		_veh,
		[selectRandom ZamTcol,1], 
		true

	] call BIS_fnc_initVehicle;

	CNTEVT(1);

	_veh lock 2;
	_veh setFuel 0;
	clearItemCargoGlobal _veh;

	private _plate1 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate2 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate3 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate4 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate5 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate6 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate7 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate8 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate9 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _elements = [_plate1,_plate2,_plate3,_plate4,_plate5,_plate6,_plate7,_plate8,_plate9];

	{
		_x allowDamage false;
		_x enableSimulationGlobal false;

	} count _elements;


	_plate1 attachTo [_veh,[0.46,-5.2,-0.675]];
	_plate1 setVectorDirAndUp [[-8.74228e-008,0.344282,-0.938866],[0,-0.938866,-0.344282]]; 

	_plate2 attachTo [_plate1, [0.95,0,0]];

	_plate3 attachTo [_veh, [0.46,-8.4,-1.73]];
	_plate3 setVectorDirAndUp [[-0.000717314,0.286778,-0.957997],[0.000328366,-0.957997,-0.286779]];

	_plate4 attachTo [_plate3, [0.95,0,0]];

	_plate5 attachTo [_veh, [0.46,-10.2,-2.07]];
	_plate5 setVectorDirAndUp [[-0.00101337,0.191172,-0.981556],[0.000331704,-0.981556,-0.191172]];;

	_plate6 attachTo [_plate5, [0.95,0,0]];

	_plate7 attachTo [_plate5, [0,-0.025,3.3]];
	_plate8 attachTo [_plate7, [0.95,0,0]];

	_plate9 attachTo [_veh, [-0.68,-0.7,-0.45]];
	_plate9 setVectorDirAndUp [[-0.955146,-1.69385e-007,-0.296136],[-1.63787e-007,1,-4.37114e-008]];



	private _bricks1a = createVehicle ["Land_Bricks_V1_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _bricks2a = createVehicle ["Land_Bricks_V2_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _bricks1b = createVehicle ["Land_Bricks_V1_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _bricks2b = createVehicle ["Land_Bricks_V2_F",[0,0,0],[],0,"CAN_COLLIDE"];

	_bricks1a attachTo [_veh, [0,-4.5,-2.25]];
	_bricks2a attachTo [_bricks1a, [0,-0.025,0.75]]; 
	_bricks2a setDir ((getDir _bricks1a) + 180);

	_bricks1b attachTo [ _veh, [0.2,-5.7,-2.25]];
	_bricks1b setDir ((getDir _veh) + 95);
	_bricks2b attachTo [ _bricks1b, [0,-0.025,0.23]];
	_bricks2b setDir ((getDir _bricks1b) + 180);

	

	private _elements = _elements + [_bricks1a,_bricks1b,_bricks2a,_bricks2b];

	_veh setVariable ["DK_elements", _elements];

	_veh addEventHandler ["Deleted",
	{
		params ["_veh"];

	//	CNTEVT(-1);

		{
			deleteVehicle _x;

		} count (_veh getVariable "DK_elements");

	///	// DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_veh getVariable "mkr_DEBUG");
		};
	}];

	_veh addEventHandler ["Killed",
	{
		params ["_veh"];

		_veh enableSimulationGlobal true;
		[_veh,7,150,true] spawn DK_fnc_addAllTo_CUM;
		addToRemainsCollector [_veh];
	}];


///	// DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "b_service";
			_mkrNzme setMarkerColor "ColorOrange";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};

	_veh
};

DK_fnc_crtJUMPlightTT = {

	private _veh = crtV(classLTT);

	[_veh,7,_this + 25,true] spawn DK_fnc_addAllTo_CUM;

	[
		_veh,
		[selectRandom LTcol,1], 
		true

	] call BIS_fnc_initVehicle;

	CNTEVT(1);

	_veh lock 2;
	_veh setFuel 0;
	clearItemCargoGlobal _veh;

	private _plate1 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate2 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate3 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate4 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate5 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate6 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate7 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _plate8 = createVehicle ["Land_BackAlley_02_l_1m_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _elements = [_plate1,_plate2,_plate3,_plate4,_plate5,_plate6,_plate7,_plate8];

	{
		_x allowDamage false;
		_x enableSimulationGlobal false;

	} count _elements;


	_plate1 attachTo [_veh,[0.46,-4.9,-0.675]];
	_plate1 setVectorDirAndUp [[-8.74228e-008,0.344282,-0.938866],[0,-0.938866,-0.344282]]; 

	_plate2 attachTo [_plate1, [0.95,0,0]];

	_plate3 attachTo [_veh, [0.46,-8.1,-1.73]];
	_plate3 setVectorDirAndUp [[-0.000717314,0.286778,-0.957997],[0.000328366,-0.957997,-0.286779]];

	_plate4 attachTo [_plate3, [0.95,0,0]];

	_plate5 attachTo [_veh, [0.46,-9.9,-2.07]];
	_plate5 setVectorDirAndUp [[-0.00101337,0.191172,-0.981556],[0.000331704,-0.981556,-0.191172]];;

	_plate6 attachTo [_plate5, [0.95,0,0]];

	_plate7 attachTo [_plate5, [0,-0.025,3.3]];
	_plate8 attachTo [_plate7, [0.95,0,0]];


	private _bricks1a = createVehicle ["Land_Bricks_V1_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _bricks2a = createVehicle ["Land_Bricks_V2_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _bricks1b = createVehicle ["Land_Bricks_V1_F",[0,0,0],[],0,"CAN_COLLIDE"];
	private _bricks2b = createVehicle ["Land_Bricks_V2_F",[0,0,0],[],0,"CAN_COLLIDE"];

	_bricks1a attachTo [_veh, [0,-4.2,-2.25]];
	_bricks2a attachTo [_bricks1a, [0,-0.025,0.75]]; 
	_bricks2a setDir ((getDir _bricks1a) + 180);

	_bricks1b attachTo [ _veh, [0.2,-5.4,-2.25]];
	_bricks1b setDir ((getDir _veh) + 95);
	_bricks2b attachTo [ _bricks1b, [0,-0.025,0.23]];
	_bricks2b setDir ((getDir _bricks1b) + 180);

	

//	private _elements = _elements + [_bricks1a,_bricks1b,_bricks2a,_bricks2b];
	_elements append [_bricks1a,_bricks1b,_bricks2a,_bricks2b];

	_veh setVariable ["DK_elements", _elements];

	_veh addEventHandler ["Deleted",
	{
		params ["_veh"];

	//	CNTEVT(-1);

		{
			deleteVehicle _x;

		} count (_veh getVariable "DK_elements");

	///	// DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_veh getVariable "mkr_DEBUG");
		};
	}];

	_veh addEventHandler ["Killed",
	{
		params ["_veh"];

		_veh enableSimulationGlobal true;
		[_veh,7,150,true] spawn DK_fnc_addAllTo_CUM;
	}];


///	// DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "b_service";
			_mkrNzme setMarkerColor "ColorOrange";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};

	_veh
};

DK_fnc_crtJUMPconsMen = {

	params ["_logic", "_dis", "_mkrPos"];


	private ["_grpAry", "_civ01", "_nil"];

	private _nbCiv = selectRandom [2,3];
	call
	{
		if (_nbCiv isEqualTo 2) exitWith
		{
		///	// 2 CIVS
			_civ01 = crtCIVCONS;
			private _civ02 = crtCIVCONS;

			_civ02 attachTo [_civ01,[0,1.54,0.1]];

			_civ01 setPos _mkrPos;
			_civ01 setDir (random 360);
			_civ02 setDir 180;

			_anim_01 = slctAnimsA;
			_anim_02 = selectRandom [delAnimsA(_anim_01),slctAnimsBC];
			[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01,_civ02];
		};

	///	// 3 CIVS
		_civ01 = crtCIVCONS;
		private _civ02 = crtCIVCONS;
		private _civ03 = crtCIVCONS;

		_civ02 attachTo [_civ01,[-0.6,1.54,0.1]];
		_civ03 attachTo [_civ01,[0.6,1.54,0.1]];

		_civ01 setPos _mkrPos;
		_civ01 setDir (random 360);
		_civ02 setDir 150;
		_civ03 setDir 200;

		private _anim_01 = slctAnimsA;

		private ["_anim_02","_anim_03"];
		call
		{
			if (selectRandom [1,2] isEqualTo 1) exitWith
			{
				_anim_02 = slctAnimsB;
				_anim_03 = selectRandom [delAnimsA(_anim_01),slctAnimsC];
			};

			_anim_02 = selectRandom [delAnimsA(_anim_01),slctAnimsC];
			_anim_03 = slctAnimsB;
		};

		[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];

		_grpAry = [_civ01,_civ02,_civ03];
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];

	} count _grpAry;

	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	{
		_nil = [_x, _dis + 32] call DK_fnc_addEH_CivFoot;

	} count _grpAry;

	/// // WAITING
	[_civ01,_logic,_mkrPos,_grpAry] spawn
	{
		params ["_civ01", "_logic", "_mkrPos", "_grp"];


//		uiSleep 0.25;
		uiSleep 1;
		{
			detach _x;
			uiSleep 0.07;

		} count _grp;

		if (isDedicated) then
		{
			[0.2,_grp,_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		uiSleep 1.5;
		{
			_x enableDynamicSimulation true;

		} count _grp;
	};
};

DK_fnc_CLAG_crtEVT_JUMPcons = {

	params ["_mkrPos","_logic"];


	private _dirVeh = ((_logic getVariable "dir") + (selectRandom [0,180]));

	if (isNil "_dirVeh") exitWith {};

	_posVeh = _mkrPos getPos [4.5,_dirVeh];
	_posVeh set [2,0];
	private _posOfrdRep = _mkrPos getPos [-4.5,_dirVeh];

	if ( (isOnRoad _posVeh) OR (isOnRoad _posOfrdRep) OR (isOnRoad (_mkrPos getPos [6,_dirVeh])) OR (isOnRoad (_mkrPos getPos [-6,_dirVeh])) ) exitWith {};

	if ( !( PlaceOK(_mkrPos,11,6) ) OR !( PlaceOK(_posVeh,11,6) ) OR !( PlaceOK(_posOfrdRep,11,6) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPlacTake)];
	};

	private _dis = _logic getVariable "choiceDis";

	private ["_nil", "_baseJump", "_posJump"];
	private _rd = selectRandom [1,2,2,2,2];
	call
	{
		if (_rd isEqualTo 1) exitWith
		{
			_baseJump = crtJUMPzam(_logic getVariable "choiceDis");
		};

		_baseJump = crtJUMPlightTT(_logic getVariable "choiceDis");
	};

	_baseJump setDir _dirVeh;
	_baseJump setPosATL _posVeh;
	_baseJump setVectorUp surfaceNormal _posVeh;

	///	// Create Cones
	_road = getPosWorld ([_mkrPos, 20] call BIS_fnc_nearestRoad);

	uiSleep 0.2;

	private _cone01 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone02 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone03 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone04 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone05 = "RoadCone_L_F" createVehicle [0,0,0];

	uiSleep 0.1;

	_cones = [_cone01,_cone02,_cone03,_cone04,_cone05];
	private _dirCones = _dirVeh - 8;
	{
		_x setDir (_dirCones + (random 16));
		_nil = [_x,7, _dis + 50] spawn DK_fnc_addAllTo_CUM;

	} count _cones;

	private _elements = _baseJump getVariable "DK_elements";
	private ["_light","_motor","_palet1","_palet2","_posUnits", "_sidePad"];
	call
	{
		if (_baseJump modelToWorldVisual [1,0,0] distance2D _road < _baseJump modelToWorldVisual [-1,0,0] distance2D _road) exitWith
		{
			_sidePad = 1.3;

			_pos1 = _baseJump modelToWorldVisual [2.8,-7,0];
			_pos1 set [2,0];
			_cone01 setPosATL _pos1;
			_cone01 setVectorUp surfaceNormal _pos1;

			_pos2 = _cone01 getPos [4,_dirVeh - 2];
			_cone02 setPosATL _pos2;
			_cone02 setVectorUp surfaceNormal _pos2;

			_pos3 = _cone01 getPos [-4,_dirVeh + 8];
			_cone03 setPosATL _pos3;
			_cone03 setVectorUp surfaceNormal _pos3;

			_pos4 = _cone02 getPos [4,_dirVeh];
			_cone04 setPosATL _pos4;
			_cone04 setVectorUp surfaceNormal _pos4;

			_pos5 = _cone04 getPos [4,_dirVeh - 5];
			_cone05 setPosATL _pos5;
			_cone05 setVectorUp surfaceNormal _pos5;


			_palet1 = crtV("Land_CinderBlocks_F");
			_palet2 = crtV("Land_Pallets_stack_F");

			_posPal1 = _baseJump modelToWorldVisual [-2,-2,0];
			_posPal1 set [2,0];
			_palet1 setPos _posPal1;
			_palet1 setDir (_dirVeh - 80);
			_posPal2 = _baseJump modelToWorldVisual [-2.5,-4,0];
			_posPal2 set [2,0];
			_palet2 setPos _posPal2;
			_palet2 setDir (random 360);

			_elements append [_palet1,_palet2];

			_posUnits = _baseJump modelToWorldVisual [-3.5,-9,-1];

			if (call DK_fnc_checkIfNight) then
			{
				_light = crtV("Land_PortableLight_single_F");
				_motor = crtV("Land_Portable_generator_F");

				_light setDir (_dirVeh + 195);
				_posLight = _baseJump modelToWorldVisual [-2.5,-13,0];
				_posLight set [2,0];
				_light setPosATL _posLight;
				_light setVectorUp surfaceNormal _posLight;
				_motor setPosATL (_light modelToWorldVisual [1.25,0,0]);

				_elements append [_light,_motor];
			};
		};

		_sidePad = -1.3;

		_pos1 = _baseJump modelToWorldVisual [-2.8,-7,0];
		_pos1 set [2,0];
		_cone01 setPosATL _pos1;
		_cone01 setVectorUp surfaceNormal _pos1;

		_pos2 = _cone01 getPos [4,_dirVeh + 2];
		_cone02 setPosATL _pos2;
		_cone02 setVectorUp surfaceNormal _pos2;

		_pos3 = _cone01 getPos [-4,_dirVeh - 8];
		_cone03 setPosATL _pos3;
		_cone03 setVectorUp surfaceNormal _pos3;

		_pos4 = _cone02 getPos [4,_dirVeh];
		_cone04 setPosATL _pos4;
		_cone04 setVectorUp surfaceNormal _pos4;

		_pos5 = _cone04 getPos [4,_dirVeh + 5];
		_cone05 setPosATL _pos5;
		_cone05 setVectorUp surfaceNormal _pos5;

		_palet1 = crtV("Land_CinderBlocks_F");
		_palet2 = crtV("Land_Pallets_stack_F");

		_posPal1 = _baseJump modelToWorldVisual [2,-2,0];
		_posPal1 set [2,0];
		_palet1 setPos _posPal1;
		_palet1 setDir (_dirVeh - 80);
		_posPal2 = _baseJump modelToWorldVisual [2.5,-4,0];
		_posPal2 set [2,0];
		_palet2 setPos _posPal2;
		_palet2 setDir (random 360);

		_elements append [_palet1,_palet2];

		_posUnits = _baseJump modelToWorldVisual [3.5,-9,-1];

		if (call DK_fnc_checkIfNight) then
		{
			_light = crtV("Land_PortableLight_single_F");
			_motor = crtV("Land_Portable_generator_F");

			_light setDir (_dirVeh - 195);
			_posLight = _baseJump modelToWorldVisual [2.5,-13,0];
			_posLight set [2,0];
			_light setPosATL _posLight;
			_light setVectorUp surfaceNormal _posLight;
			_motor setPosATL (_light modelToWorldVisual [-1.25,0,0]);

			_elements append [_light,_motor];
		};
	};

	[_logic, _dis, _posUnits] call DK_fnc_crtJUMPconsMen;

	{
		_x hideObjectGlobal true;

	} count (nearestTerrainObjects [(_elements # 0) modelToWorldVisual [-0.46,0,0], ["Small Tree","Tree","Bush"], 3, true]);
	{
		_x hideObjectGlobal true;

	} count (nearestTerrainObjects [(_elements # 2) modelToWorldVisual [-0.46,0,0], ["Small Tree","Tree","Bush"], 3, true]);
	{
		_x hideObjectGlobal true;

	} count (nearestTerrainObjects [(_elements # 4) modelToWorldVisual [-0.46,0,0], ["Small Tree","Tree","Bush"], 3, true]);

	// Indicator if jump is On
	private _padG = crtV("PortableHelipadLight_01_green_F");
	_padG allowDamage false;
	_padG setDir _dirVeh;
	private _pos = _baseJump modelToWorldVisual [_sidePad,-7,0];
	_pos set [2,0];
	_padG setMass 700;
	_padG setPosATL _pos;
	_padG setVectorUp surfaceNormal _pos;
	_padG enableDynamicSimulation true;
	_elements pushBackUnique _padG;

	_baseJump setVariable ["DK_elements", _elements];

	_baseJump setVariable ["jumpOn", true, true];
	call
	{
		if (_rd isEqualTo 1) exitWith
		{
			_posJump = _baseJump modelToWorldVisual [0, -0.338, 3.25];
		};

		_posJump = _baseJump modelToWorldVisual [0, -1.338, 2.7];
	};
	_nil = [_baseJump, _rd, _padG, _posJump] remoteExecCall ["DK_fnc_crt_trgJump_cl", DK_isDedi, _baseJump];

	/// // WAITING
	[_baseJump,_logic,_elements] spawn
	{
		params ["_baseJump","_logic","_elements"];

		uiSleep 2;

		_baseJump enableSimulationGlobal false;

		_baseJump spawn
		{
			waitUntil { uiSleep 5; (isNil "_this") OR (isNull _this) };

			CNTEVT(-1);
		};

		for "_i" from 0 to 7 step 1 do
		{
			detach (_elements # _i);
		};

		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPuBaEVT)];
	};
};

DK_fnc_padRjump = {

	params ["_veh", "_padG"];

	if ((isNil "_veh") OR (isNil "_padG") OR (isNull _padG) OR (isNull _veh)) exitWith {};

	private _elements = _veh getVariable ["DK_elements", []];
	private _nil = _elements deleteAt (_elements find _padG);

	private _padR = crtV("PortableHelipadLight_01_red_F");
	_padR allowDamage false;
	_padR setDir (getDir _padG);
	private _pos = getPosATLVisual _padG;
	deleteVehicle _padG;
	_padG setMass 700;
	_padR setPosATL _pos;
	_padR setVectorUp surfaceNormal _pos;
	_padR enableDynamicSimulation true;

	_elements pushBackUnique _padR;
	_veh setVariable ["DK_elements", _elements];
};


// Tractor and farmer or hey bale
DK_fnc_crtEVT_Tractor = {

	_veh = crtV(classTRACT);

	[_veh,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_init_veh;

	[
		_veh,
		[selectRandom ["Red", "Green", "Blue"], 1], 
		["Door_LF", 0, "Door_RF", 0]

	] call BIS_fnc_initVehicle;

	CNTEVT(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTEVT(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

	_id2 = _veh addEventHandler ["Engine",
	{
		params ["_veh"];


		_EHs = _veh getVariable "DK_CLAG_EHs";

		_veh removeEventHandler ["Engine", _EHs # 1];
		_veh removeEventHandler ["deleted", _EHs # 0];

		CNTEVT(-1);
	}];

	_veh setVariable ["DK_CLAG_EHs", [_id1,_id2]];


	// Allow driver for no owner Apex
	private "_nil";
	{
		if !("Contact" in (_x getVariable ["listDLCs", []])) then
		{
			_nil = _veh remoteExecCall ["DK_allowBoat_cl", _x];
		};

	} count allPlayers;


	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "b_service";
			_mkrNzme setMarkerColor "ColorOrange";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_CLAG_crtEVT_Tractor = {

	params ["_mkrPos","_logic"];


	private _dirVeh = ((_logic getVariable "dir") + (selectRandom [0,180]));

	if (isNil "_dirVeh") exitWith {};

	_posVeh = _mkrPos getPos [4,_dirVeh];
	_posVeh set [2,0];
	private _posProps = _mkrPos getPos [-4,_dirVeh];

	if ((isOnRoad _posVeh) OR (isOnRoad _posProps)) exitWith {};

	if ( !( PlaceOK(_mkrPos,6,4) ) OR !( PlaceOK(_posVeh,6,4) ) OR !( PlaceOK(_posProps,6,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPlacTake)];

/*		_logic spawn
		{
			uiSleep slpPlacTake;
			LogicEvtPuBa(_this);
		};
*/	};

	private _dis = _logic getVariable "choiceDis";

	private _civ01 = crtFarmMAN;
	private _veh01 = crtVPKTRCTR(_dis);


	private "_posManFarm";
	private _props = [];
	switch (selectRandom [1,2]) do
	{
		case 1 :
		{
			_veh01 setDir ((_dirVeh - 15) + (random 30));
			_veh01 setPosATL _posVeh;
			_veh01 setVectorUp surfaceNormal _posVeh;

			_cistern = crtV("Land_TrailerCistern_wreck_F");
			_cistern setDir (_dirVeh + 260 + (random 10));
			_posProps = _mkrPos getPos [-3.3,_dirVeh];
			_cistern setPosATL _posProps;
			_cistern setVectorUp surfaceNormal _posProps;

			_props pushBackUnique _cistern;

			_posManFarm = _veh01 modelToWorldVisual [selectRandom [1.9,-1.9], -4 + (random 2), 0];
		};

		case 2 :
		{
			_veh01 setDir ((_dirVeh - 70) + (random 40));
			_veh01 setPosATL _posVeh;
			_veh01 setVectorUp surfaceNormal _posVeh;

			private "_clsPaquet";
			if (rain isEqualTo 0) then
			{
				_clsPaquet = selectRandom ["Land_HayBale_01_packed_F", "Land_HayBale_01_F"];
			}
			else
			{
				_clsPaquet = "Land_HayBale_01_decayed_F";
			};
			private ["_posProps", "_paquet"];
			_nb = selectRandom [1,2];
			for "_i" from 0 to _nb do
			{
				_paquet = crtV(_clsPaquet);
				_paquet setDir (_dirVeh + 84 + (random 12));
				if (_i isEqualTo 0) then
				{
					_posProps = _mkrPos getPos [-0.9, _dirVeh];
					_paquet setPosATL _posProps;
				}
				else
				{
					_posProps = (_props # (_i - 1)) getPos [-1.7, _dirVeh];
					_paquet setPosATL _posProps;
				};
				_paquet setVectorUp surfaceNormal _posProps;

				_props pushBackUnique _paquet;

				_posManFarm = (_props # 0) modelToWorldVisual [1.5, selectRandom [1.1,-1.1], 0];
			};

		};

	};

	_posManFarm set [2,0];
	_civ01 setPosATL _posManFarm;

	_civ01 setDir (_civ01 getRelDir (_props # 0));

	_grpAry = [_civ01];

	[_veh01, _grpAry] call DK_fnc_CLAG_EH_vehicleEvt;

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];

	} count _grpAry;

	private "_nil";
	{
		_nil = [_x, 7, _dis + 50] spawn DK_fnc_addAllTo_CUM;
		_x enableDynamicSimulation true;

	} count _props;


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civ01, _dis + 32] call DK_fnc_addEH_CivFoot;
	[_civ01, selectRandom anmsChat_B] remoteExecCall ["DK_fnc_AnimSwitch", 0];


	/// // WAITING
	[_civ01, _logic] spawn
	{
		params ["_civ01", "_logic"];


		uiSleep 2;
		_civ01 enableDynamicSimulation true;

		if (isDedicated) then
		{
			[0.2, [_civ01], _civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPuBaEVT)];

/*		uiSleep slpPuBaEVT;

		LogicEvtPuBa(_logic);
*/	};
};

DK_fnc_CLAG_crtEVT_HeyBale = {

	params ["_mkrPos", "_logic"];


	private _dirVeh = ((_logic getVariable "dir") + (selectRandom [0,180]));

	if (isNil "_dirVeh") exitWith {};

	_posVeh = _mkrPos getPos [3.2,_dirVeh];
	_posVeh set [2,0];
	private _posProps = _mkrPos getPos [-3.2,_dirVeh];

	if ((isOnRoad _posVeh) OR (isOnRoad _posProps)) exitWith {};

	if ( !( PlaceOK(_mkrPos,7,5) ) OR !( PlaceOK(_posVeh,7,5) ) OR !( PlaceOK(_posProps,7,5) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPlacTake)];

/*		_logic spawn
		{
			uiSleep slpPlacTake;
			LogicEvtPuBa(_this);
		};
*/	};

	CNTEVT(0.5);

	private _dis = _logic getVariable "choiceDis";


	private _props = [];
	switch (selectRandom [1,2]) do
	{
		case 1 :
		{
			_heybale01 = createSimpleObject ["Land_HayBale_01_stack_F", [0,0,0]];
			_heybale01 setDir _dirVeh;
			_heybale01 setPosATL _mkrPos;
			_heybale01 setVectorUp surfaceNormal _mkrPos;
			_props pushBackUnique _heybale01;
		};

		case 2 :
		{
			_heybale01 = createSimpleObject ["Land_HayBale_01_stack_F", [0,0,0]];
			_heybale01 setDir _dirVeh;
			_heybale01 setPosATL _posVeh;
			_heybale01 setVectorUp surfaceNormal _posVeh;
			_props pushBackUnique _heybale01;

			_heybale02 = createSimpleObject ["Land_HayBale_01_stack_F", [0,0,0]];
			_heybale02 setDir _dirVeh;
			_heybale02 setPosATL _posProps;
			_heybale02 setVectorUp surfaceNormal _posProps;
			_props pushBackUnique _heybale02;
		};

	};

	private "_nil";
	{
		_nil = [_x, 7, _dis + 25] spawn DK_fnc_addAllTo_CUM;
		_x enableDynamicSimulation true;

	} count _props;


	(_props # 0) spawn
	{
		waitUntil { uiSleep 5; (isNil "_this") OR (isNull _this) };

		CNTEVT(-0.5);
	};


	/// // WAITING
	DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPuBaEVT)];

/*	_logic spawn
	{

		uiSleep slpPuBaEVT;

		LogicEvtPuBa(_this);
	};
*/
};


// Market with Van/Truck
DK_fnc_crtEVT_Market = {

	private _class = classMRKT;
	_veh = crtV(_class);

	[_veh,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_init_veh;

	call
	{
		if (_class in ["C_Van_01_transport_F", "C_Van_01_box_F"]) exitWith
		{
			[
				_veh,
				[selectRandom ["White", "Red", "Black"], 1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_veh,
			[selectRandom ["Masked", "Red", "Orange", "Green", "White"], 1], 
			["Enable_Cargo",0,"Door_1_source",0,"Door_2_source",0,"Door_3_source",0,"Door_4_source",0,"Hide_Door_1_source",0,"Hide_Door_2_source",0,"Hide_Door_3_source",0,"Hide_Door_4_source",0,"lights_em_hide",0,"ladder_hide",1,"spare_tyre_holder_hide",1,"spare_tyre_hide",1,"reflective_tape_hide",1,"roof_rack_hide",1,"LED_lights_hide",1,"sidesteps_hide",1,"rearsteps_hide",0,"side_protective_frame_hide",1,"front_protective_frame_hide",1,"beacon_front_hide",1,"beacon_rear_hide",1]

		] call BIS_fnc_initVehicle;
	};

	CNTEVT(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTEVT(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

	_id2 = _veh addEventHandler ["Engine",
	{
		params ["_veh"];


		_EHs = _veh getVariable "DK_CLAG_EHs";

		_veh removeEventHandler ["Engine", _EHs # 1];
		_veh removeEventHandler ["deleted", _EHs # 0];

		CNTEVT(-1);
	}];

	_veh setVariable ["DK_CLAG_EHs", [_id1,_id2]];


	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "b_service";
			_mkrNzme setMarkerColor "ColorOrange";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_CLAG_crtEVT_Market = {

	params ["_mkrPos","_logic"];


	private _dirVeh = _logic getVariable "dir";

	if (isNil "_dirVeh") exitWith {};

	private _nearRoad = [_mkrPos, 12] call BIS_fnc_nearestRoad;
	if ((_mkrPos getPos [1, _dirVeh + 90] distance2D _nearRoad) < (_mkrPos getPos [-1, _dirVeh + 90] distance2D _nearRoad)) then
	{
		_dirVeh = _dirVeh + 180;
	};

	_posVeh = _mkrPos getPos [4,_dirVeh];
	_posVeh set [2,0];
	private _posProps = _mkrPos getPos [-4,_dirVeh];

	if ((isOnRoad _posVeh) OR (isOnRoad _posProps)) exitWith {};

	if ( !( PlaceOK(_mkrPos,6,4) ) OR !( PlaceOK(_posVeh,7,5) ) OR !( PlaceOK(_posProps,7,5) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPlacTake)];
	};

	private _dis = _logic getVariable "choiceDis";

	private _veh01 = crtVPKMKRT(_dis);

	_veh01 setDir ((_dirVeh - 16) + (random 32));
	_veh01 setPosATL _posVeh;
	_veh01 setVectorUp surfaceNormal _posVeh;

	/// Props
	private _props = [];

	private _class = selectRandom ["Land_ClothShelter_01_F", "Land_ClothShelter_02_F"];
	private _shelter = createSimpleObject [_class, [0,0,0]];
	_shelter setDir (_dirVeh + 266 + (random 8));

	_posProps = _mkrPos getPos [-3, _dirVeh];
	_shelter setPosATL (_posProps getPos [1, _dirVeh + 90]);
	_shelter setVectorUp surfaceNormal _posProps;
	_props pushBackUnique _shelter;

	private _table = createSimpleObject ["Land_WoodenCounter_01_F", [0,0,0]];
	private _posP = _shelter modelToWorldVisual [0, 0.7, 0];
	_posP set [2,-0.05];
	_table setDir (_dirVeh + 85 + (random 10));
	_table setPosATL _posP;
	_table setVectorUp surfaceNormal _posP;
	_props pushBackUnique _table;

	private "_propsA";
	_class = selectRandom ["Land_CratesWooden_F", "Land_WoodenCart_F", "Land_StallWater_F"];
	if (_class isEqualTo "Land_WoodenCart_F") then
	{
		_propsA = crtV(_class);
	}
	else
	{
		_propsA = createSimpleObject [_class, [0,0,0]];
	};
	_posP = _shelter modelToWorldVisual [-5.6, -1.1, 0];
	_posP set [2,0];
	_propsA setDir (random 360);
	_propsA setPosATL _posP;
	_propsA setVectorUp surfaceNormal _posP;
	_props pushBackUnique _propsA;

	_class = selectRandom ["Land_Cages_F", "Land_Sacks_goods_F"];
	private _propsB = createSimpleObject [_class, [0,0,0]];
	_posP = _shelter modelToWorldVisual [-2.3, 0, 0];
	_posP set [2,0];
	_propsB setDir (random 360);
	_propsB setPosATL _posP;
	_propsB setVectorUp surfaceNormal _posP;
	_props pushBackUnique _propsB;

	_class = selectRandom ["Land_Sacks_heap_F", "Land_CratesShabby_F"];
	private _propsC = createSimpleObject [_class, [0,0,0]];
	_posP = _shelter modelToWorldVisual [2.2, 0, 0];
	_posP set [2,0];
	_propsC setDir (random 360);
	_propsC setPosATL _posP;
	_propsC setVectorUp surfaceNormal _posP;
	_props pushBackUnique _propsC;

	_class = selectRandom ["Land_CratesPlastic_F", "Land_Basket_F", "Land_Sack_F"];
	private _propsD = createSimpleObject [_class, [0,0,0]];
	switch (_class) do
	{
		case "Land_CratesPlastic_F" :
		{
			_propsD attachTo [_table, [selectRandom [-0.76,0.76], -0.04, 0.7]];
		};

		case "Land_Basket_F" :
		{
			_propsD attachTo [_table, [selectRandom [-0.76,0.76], -0.04, 0.8]];
		};

		case "Land_Sack_F" :
		{
			_propsD attachTo [_table, [selectRandom [-0.76,0.76], 0, 0.87]];
		};
	};
	_props pushBackUnique _propsD;

	/// Animals
	private "_animal";
	private _animals = [];
	for "_i" from 0 to 3 do
	{
		_animal = createAgent [selectRandom ["Rabbit_F", "Hen_random_F", "Hen_random_F"], [0,0,100], [], 0, "CAN_COLLIDE"];
		_animal allowDamage false;
		_animal setBehaviour "CARELESS";
		_animal disableAI "FSM";
		_animal setVariable ["BIS_fnc_animalBehaviour_disable", true];
		_animal setDir (random 360);
		_animal setPosATL (_shelter getPos [0.9, _dirVeh + (_i * 40)]);

		_animals pushBackUnique _animal;
		_animal allowDamage true;
	};
	_props append _animals;


	private _civ01 = crtDealer;
	_posManFarm = _shelter modelToWorldVisual [0,-0.5,0];
	_posManFarm set [2,0];
	_civ01 setPosATL _posManFarm;
	_civ01 setDir (_dirVeh - 90);

	_grpAry = [_civ01];

	if (selectRandom [true, false]) then
	{
		private "_civTmp";

		[_civ01, slctAnimsA] remoteExecCall ["DK_fnc_AnimSwitch", 0];

		_nb = selectRandom [1,2,3];
		for "_i" from 1 to _nb do
		{
			_civTmp = crtCIV;
			_civTmp allowDamage false;
			_civTmp setDir (_dirVeh + 90);
			switch (_i) do
			{
				case 1 :
				{
					_civTmp setPosATL (_table getPos [1, _dirVeh - 90]);
					[_civTmp, slctAnimsBC] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};

				case 2 :
				{
					_civTmp setPosATL ((_grpAry # 1) getPos [0.8, _dirVeh]);
					[_civTmp, slctAnimsB] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};

				case 3 :
				{
					_civTmp setPosATL ((_grpAry # 1) getPos [-0.8, _dirVeh]);
					[_civTmp, slctAnimsC] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};
			};

			if (selectRandom [true, false]) then
			{
				_civTmp addBackpack (selectRandom ["B_Messenger_Olive_F", "B_Messenger_Black_F", "B_Messenger_Gray_F"]);
			};

			_grpAry pushBackUnique _civTmp;
		};
	}
	else
	{
		[_civ01, slctAnimsBC] remoteExecCall ["DK_fnc_AnimSwitch", 0];
	};


	[_veh01, _grpAry] call DK_fnc_CLAG_EH_vehicleEvt;

	{
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];
		[_x, _dis + 32] call DK_fnc_addEH_CivFoot;
		_x allowDamage true;

	} count _grpAry;

	private "_nil";
	{
		_nil = [_x, 7, _dis + 25] spawn DK_fnc_addAllTo_CUM;
		_x enableDynamicSimulation true;

	} count _props;


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	[_props, _shelter, _shelter modelToWorldVisual [0, -1, 0], _civ01] spawn DK_CLAG_EVT_moveAnimalsMrkt;

	/// // WAITING
	[_civ01, _grpAry, _logic] spawn
	{
		params ["_civ01", "_grpAry", "_logic"];


		uiSleep 2;
		{
			_x enableDynamicSimulation true;

		} count _grpAry;

		if (isDedicated) then
		{
			[0.2, _grpAry, _civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPuBaEVT)];

/*		uiSleep slpPuBaEVT;

		LogicEvtPuBa(_logic);
*/	};

};

DK_CLAG_EVT_moveAnimalsMrkt = {

	params ["_animals", "_shelter", "_posAn", "_civ01"];


	_posAn set [2,0];
	while { !(isNil "_shelter") && { !(isNull _shelter) && { (_civ01 getVariable ["DK_behaviour", ""] isEqualTo "chat") && { !(_animals findIf {alive _x} isEqualTo -1) } } } } do
	{
		{
			if ( (dynamicSimulationEnabled _x) && { (alive _x) } ) then
			{
				_x moveTo (_posAn getPos [1.7, random 360]);
			};

			uiSleep 1;

		} count _animals;

		uiSleep 5;
	};
};



/// -- EVENT HANDLERS -- \\\

// Add Event Handler
DK_fnc_CLAG_EH_vehicleEvt = {

	params ["_veh", "_grp"];


	_veh setVariable ["DK_CLAG_groupLinked", _grp];

	_veh addEventHandler ["deleted",
	{
		params ["_entity"];


		private "_nil";
		{
			if (_x getVariable "DK_behaviour" isEqualTo "chat") then
			{
				_x enableDynamicSimulation false;
				_x setVariable ["DK_behaviour", "walk"];

				_x spawn
				{
					uiSleep (random 0.7);
					if (alive _this) then
					{
						[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};
				};

				_x enableAI "MOVE";
				_x setUnitPos "UP";
				_x forceWalk true;
				_x setSpeedMode "NORMAL";
				_x allowFleeing 0.1;

				_nil = [_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

				_x forceSpeed (_x getSpeed "SLOW");
			};

		} count (_entity getVariable ["DK_CLAG_groupLinked", []]);
	}];

	_id = _veh addEventHandler ["GetIn",
	{
		params ["_veh"];


		private "_nil";
		_veh removeEventHandler ["GetIn", _thisEventHandler];
		_veh removeAllEventHandlers "Hit";
		_veh removeAllEventHandlers "EpeContactStart";
		_veh removeAllEventHandlers "Deleted";

		{
			_nil = [_x,_veh,false] call DK_fnc_EH_Flee_CivFoot;

		} count (_veh getVariable ["DK_CLAG_groupLinked", []]);
	}];

	_veh setVariable ["DK_CLAG_idEHgetIn", _id];

	_veh addEventHandler ["Hit",
	{
		params ["_veh", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};


		private "_nil";
		_veh removeAllEventHandlers "Hit";
		_veh removeAllEventHandlers "EpeContactStart";
		_veh removeEventHandler ["GetIn", _veh getVariable "DK_CLAG_idEHgetIn"];
		_veh removeAllEventHandlers "Deleted";

		{
			_nil = [_x, _instigator, false] call DK_fnc_EH_Flee_CivFoot;

		} count (_veh getVariable ["DK_CLAG_groupLinked", []]);
	}];

	_veh addEventHandler ["EpeContactStart",
	{
		params ["_veh","_shooter"];


		private "_nil";
		_veh removeAllEventHandlers "EpeContactStart";
		_veh removeAllEventHandlers "Hit";
		_veh removeEventHandler ["GetIn", _veh getVariable "DK_CLAG_idEHgetIn"];
		_veh removeAllEventHandlers "Deleted";

		{
			_nil = [_x,_shooter,true] call DK_fnc_EH_Flee_CivFoot;

		} count (_veh getVariable ["DK_CLAG_groupLinked", []]);
	}];
};

DK_fnc_addEH_repairManAnim = {

//	[_this,"Acts_carFixingWheel"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

	_this playMoveNow "Acts_carFixingWheel";

	_this addEventHandler ["AnimStateChanged",
	{
		params ["_repMan", "_anim"];


		if !((_repMan getVariable "DK_behaviour") isEqualTo "chat") exitWith
		{
			_repMan removeEventHandler ["AnimStateChanged", _thisEventHandler];
		};

			if (_repMan getVariable "animeOn") then
			{
				if !(_anim isEqualTo "acts_carfixingwheel") then
				{
					_repMan setVariable ["animeOn", false];
					_repMan playMoveNow "Acts_carFixingWheel";

					_repMan setPosATL (_repMan getVariable "setPos");
					_repMan setDir (_repMan getVariable "setDir");

					_repMan spawn
					{
						uiSleep 3;
						_this setVariable ["animeOn", true];
					};
				};
			};
	}];

};

DK_fnc_addEH_repOFR_beacons = {

	_this setPilotLight true;
	_this animateSource ["Beacons", 1];

	private _NetIdBeacon = _this remoteExecCall ["DK_loop_repOFR_beacon", DK_isDedi, true];
	_this setVariable ["NetIdBeacon",_NetIdBeacon];

	_this addEventHandler ["Deleted",
	{
		params ["_veh"];
	
	
		private _netIdBeacon = _veh getVariable "NetIdBeacon";
		if !(isNil "_netIdBeacon") then
		{
			remoteExecCall ["", _netIdBeacon];
			_veh setVariable ["NetIdBeacon", nil];
		};
	}];

	_this addMPEventHandler ["mpKilled",
	{
		params ["_veh"];

		if (isServer) then
		{
			private _netIdBeacon = _veh getVariable "NetIdBeacon";
			if !(isNil "_netIdBeacon") then
			{
				remoteExecCall ["", _netIdBeacon];
				_veh setVariable ["NetIdBeacon", nil];
			};
		};

		if (hasInterface) then
		{
			removeAllActions _veh;
		};
	}];
};


// Cops Controle
DK_fnc_crtCopsControl = {

	params [["_weapon", ""]];


	private _vehicle = [false, false, true] call DK_MIS_fnc_crtVeh_Police;

	private _grp = createGroup resistance;
	private _unitsCrew = [];

	for "_i" from 1 to (2 + (round (random 1))) do
	{
		_unitsCrew pushBackUnique (crtU(_grp,"I_officer_F"));
	};

	_grp addVehicle _vehicle;
	_unitsCrew apply
	{
		_x allowDamage false;
		_x setDamage 0;
		_x disableAI "AUTOTARGET";
		_x disableAI "TARGET";
		_x disableAI "MOVE";
//		_x allowFleeing 0;
		_x setVariable ["DK_behaviour", "drive"];

		_x call DK_MIS_addEH_selectSeat;
		_x setVariable ["vehLinkRfr", _vehicle];
		_x spawn DK_MIS_addEH_HandleDmg;
		_x spawn DK_MIS_EH_handleAmmoNweapons;
		_x spawn DK_MIS_addEH_secondDead;
		_x call DK_addEH_deadNdel_CopsCtrl;
		_x call DK_addEH_firedHit_CopsCtrl;
		_x call DK_addEH_getInOut_CopsPatrol;
		_x call DK_MIS_fnc_skillPolice;
		DK_unitsStayUp pushBackUnique _x;

		_x setVariable ["group", _grp];
	};

	_vehicle setVehicleLock "LOCKEDPLAYER";

	_grp deleteGroupWhenEmpty true;
	_grp setFormation "DIAMOND";
	_grp setBehaviour "CARELESS";
	_grp setSpeedMode "NORMAL";

	[_unitsCrew, "uniform_Police", "", "vest_mediumPolice"] spawn DK_MIS_fnc_slctUnitsLO;

	_vehicle call DK_addEH_veh_CopsCtrl;

	_unitsCrew apply
	{
		_x allowDamage true;
	};


	[_vehicle, _unitsCrew, _grp]
};

DK_fnc_CLAG_crtEVT_CopsCtrl = {

	params ["_mkrPos", "_logic"];


	private	_dirVeh = _logic getVariable "dir";

	if (isNil "_dirVeh") exitWith {};

	private _nearRoad = [_mkrPos, 12] call BIS_fnc_nearestRoad;
	if ( !(_nearRoad isEqualTo objNull) && { (_mkrPos getPos [1, _dirVeh + 90] distance2D _nearRoad) < (_mkrPos getPos [-1, _dirVeh + 90] distance2D _nearRoad) } ) then
	{
		_dirVeh = _dirVeh + 180;
	};

	private _posVeh = _mkrPos getPos [-4, _dirVeh];
	_posVeh set [2,0];
	private _posVehCop = _mkrPos getPos [4, _dirVeh];

	if ((isOnRoad _posVeh) OR (isOnRoad _posVehCop)) exitWith {};

	if ( !( PlaceOK(_mkrPos,6,4) ) OR !( PlaceOK(_posVeh,7,5) ) OR !( PlaceOK(_posVehCop,7,5) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPlacTake)];
	};


	private _dis = _logic getVariable "choiceDis";
	private _civil = createAgent [classH, [0,0,100], [], 0, "CAN_COLLIDE"];
	_civil allowDamage false;
	_civil setDamage 0;
	_civil disableAI "MOVE";
	_civil disableAI "FSM";
	_civil setBehaviour "CARELESS";
	_civil call DK_fnc_LO_Civ;

	CNTEVT(1);
	CNT(1);

	private _vehCivil = crtVPKCLV(0);

	private _vehCrew = [] call DK_fnc_crtCopsControl;

	_vehCrew params ["_vehCop", "_unitsCrew", "_grp"];

	private _grpAry = [_civil];
	_grpAry	append _unitsCrew;

	_vehCivil setDir (_dirVeh - 5 + (random 10));
	_vehCivil setPosATL _posVeh;
	_vehCivil setVectorUp surfaceNormal _posVeh;
	_civil moveInDriver _vehCivil;

	_posVehCop = _vehCivil getPos [7.5, _dirVeh - 5];
	_vehCop setDir (_dirVeh + (random 10));
	_vehCop setPosATL _posVehCop;
	_vehCop setVectorUp surfaceNormal _posVehCop;

	_unitsCrew params ["_cop01", "_cop02", "_cop03"];

	_grp selectLeader _cop01;
	_posManCop1 = _civil modelToWorldVisual [-1.3, 0, 0];
	_posManCop1 set [2,0];
	_cop01 setPosATL _posManCop1;

//	_cop01 setVariable ["animeOn", true];

	if (!isNil "_cop02") then
	{
		_posManCop2 = _vehCivil modelToWorldVisual [2, -1.5 + (random 1.5), 0];
		_posManCop2 set [2,0];
		_cop02 setPosATL _posManCop2;
		_cop02 setdir (random 360);
	};
	if (!isNil "_cop03") then
	{
		_posManCop3 = (selectRandom [_vehCivil, _vehCop]) modelToWorldVisual [-0.5 + (random 1), 3, 0];
		_posManCop3 set [2,0];
		_cop03 setPosATL _posManCop3;
		_cop03 setdir (random 360);
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];
		_x setVariable ["DK_group", _grpAry];

	} count _grpAry;

	{
		_x setVariable ["vehCivil", _vehCivil];

	} count (_unitsCrew + [_vehCop]);


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];


	// Add EH for civil & his car
	_vehCivil setVariable ["ctrlNfo", [_vehCop, _unitsCrew]];
	_vehCop setVariable ["ctrlNfo", [_vehCivil, _unitsCrew]];
	[_civil, _vehCivil] spawn DK_addEH_civCtrl;

	_vehCivil setVehicleLock "LOCKEDPLAYER";


	///	// Create Cones
	_road = getPosWorld ([_mkrPos, 25] call BIS_fnc_nearestRoad);

	private _cone01 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone02 = "RoadCone_L_F" createVehicle [0,0,0];
	private _cone03 = "RoadCone_L_F" createVehicle [0,0,0];

	_cones = [_cone01, _cone02, _cone03];
	private _dirCones = _dirVeh - 8;
	private "_nil";
	{
		_x setDir (_dirCones + (random 16));
		_nil = [_x,7,_dis + 50] spawn DK_fnc_addAllTo_CUM;

	} count _cones;

	call
	{
		if (_vehCivil modelToWorldVisual [1,0,0] distance2D _road < _vehCivil modelToWorldVisual [-1,0,0] distance2D _road) exitWith
		{
			_pos1 = _vehCivil getPos [2.65,_dirVeh + 90];
			_cone01 setPosATL _pos1;
			_cone01 setVectorUp surfaceNormal _pos1;

			_pos2 = _cone01 getPos [3.8,_dirVeh - 2];
			_cone02 setPosATL _pos2;
			_cone02 setVectorUp surfaceNormal _pos2;

			_pos3 = _cone01 getPos [-4,_dirVeh + 16];
			_cone03 setPosATL _pos3;
			_cone03 setVectorUp surfaceNormal _pos3;
		};

		_pos1 = _vehCivil getPos [2.65,_dirVeh - 90];
		_cone01 setPosATL _pos1;
		_cone01 setVectorUp surfaceNormal _pos1;

		_pos2 = _cone01 getPos [3.8,_dirVeh + 2];
		_cone02 setPosATL _pos2;
		_cone02 setVectorUp surfaceNormal _pos2;

		_pos3 = _cone01 getPos [-4,_dirVeh - 16];
		_cone03 setPosATL _pos3;
		_cone03 setVectorUp surfaceNormal _pos3;
	};

	/// Activate Lights
	call
	{
		if (call DK_fnc_checkIfNight) exitWith
		{
			_civil setBehaviour "COMBAT";
			_civil action ["LightOff", _vehCivil];
			bis_functions_mainscope action ["LightOff", _vehCop];

			private _chemLight = createVehicle ["Chemlight_green", [0,0,500], [], 0, "CAN_COLLIDE"];
			_chemLight setPosATL (_cop01 getPos [selectRandom [-1.05, 1.05], _dirVeh]);
			_chemLight setDir (random 360);

			[_chemLight, 60, _dis + 50] spawn DK_fnc_addAllTo_CUM;
		};

		{
			_x enableDynamicSimulation true;

		} count _cones;
	};

	/// // WAITING
	[_civil, _cop01, _logic, _unitsCrew] spawn
	{
		params ["_civil", "_cop01", "_logic", "_unitsCrew"];

		uiSleep 2;
		_civil enableDynamicSimulation true;
		{
			_x enableDynamicSimulation true;

		} count _unitsCrew;

		_cop01 setdir (getDir _civil) + 90;

		_civil doWatch _cop01;
		_civil lookat _cop01;
		_civil glanceAt _cop01;
		_cop01 doWatch _civil;
		_cop01 lookat _civil;
		_cop01 glanceAt _civil;

		DK_CLAG_arr_lgcsWtEvt pushBackUnique [_logic, (time + slpPuBaEVT)];
	};

	private _array = ([_dis + 25, _vehCivil, _vehCop, _civil] + _unitsCrew);
	_array spawn DK_fnc_CLAG_ctrlDelManager;
};

DK_fnc_CLAG_ctrlDelManager = {

	params ["_dis", "_vehCivil", "_vehCop", "_civil", "_cop01", "_cop02", "_cop03"];


	uiSleep 7;

	private "_toDels";
	call
	{
		if (!isNil "_cop03") exitWith
		{
			_toDels = [_vehCivil, _vehCop, _civil, _cop01, _cop02, _cop03];
		};

		if (!isNil "_cop02") exitWith
		{
			_toDels = [_vehCivil, _vehCop, _civil, _cop01, _cop02];
		};

		_toDels = [_vehCivil, _vehCop, _civil, _cop01];
	};

	if ( (isNil "_cop01") OR (isNull _cop01) OR (!alive _cop01) OR (_cop01 getVariable ["disrupt", false]) OR (_vehCivil getVariable ["disrupt", false]) OR (_vehCop getVariable ["disrupt", false]) ) exitWith {};


	while {  (!isNil "_cop01") && { (!isNull _cop01) && { (alive _cop01) && { !(_cop01 getVariable ["disrupt", false]) && { !(_vehCivil getVariable ["disrupt", false]) && { !(_vehCop getVariable ["disrupt", false]) } } } } }  } do
	{
		if ( ((playableUnits findIf {_x distance2D _cop01 < _dis}) isEqualTo -1) && { ((playableUnits findIf {[vehicle _cop01, "IFIRE"] checkVisibility [eyePos _cop01, eyePos _x] > 0.3}) isEqualTo -1) && { (alive _cop01) && { !(_cop01 getVariable ["disrupt", false]) && { !(_vehCivil getVariable ["disrupt", false]) && { !(_vehCop getVariable ["disrupt", false]) } } } } } ) exitWith
//		if ( (playableUnits findIf { (_x distance2D _cop01 < _dis) && { ([vehicle _cop01, "IFIRE"] checkVisibility [eyePos _cop01, _x call DK_fnc_eyePlace] > 0.3) } } isEqualTo -1) && { (alive _cop01) && { !(_cop01 getVariable ["disrupt", false]) && { !(_vehCivil getVariable ["disrupt", false]) && { !(_vehCop getVariable ["disrupt", false]) } } } } ) exitWith
		{
			{
				if ( (!isNil "_x") && { (!isNull _x) } ) then
				{
					if !(_x isEqualTo _civil) then
					{
						deleteVehicle _x;
					}
					else
					{
						_vehCivil deleteVehicleCrew _x;
					};
				};

			} count _toDels;
		};

		uiSleep 3;
	};

	if ( (!isNil "_civil") && { (!isNull _civil) && { (alive _civil) && { ((_cop01 getVariable ["disrupt", false]) OR (_vehCivil getVariable ["disrupt", false]) OR (_vehCop getVariable ["disrupt", false])) } } } ) then
	{
		[_civil, 0, _dis, true] spawn DK_fnc_addAllTo_CUM;
	};

	if ( (isNil "_vehCop") && { (isNull _vehCop) && { (!alive _vehCop) } } ) then
	{
		_vehCop call DK_fnc_init_veh;
	};

};



DK_addEH_civCtrl = {

	params ["_civil", "_vehCivil"];


	waitUntil { (!isNull objectParent _civil) OR (isNil "_civil") OR (isNull _civil) OR !(alive _civil) };

	if ( (isNil "_civil") OR (isNull _civil) OR !(alive _civil) ) exitWith {};

//	/// Civilian
	_civil addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);
		CNTEVT(-1);


	/// // DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];


//	/// Vehicle
	private _idEH_EPS = _vehCivil addEventHandler ["EpeContactStart",
	{
		_this call DK_fnc_EH_epeCtcCiv_CopsCtrl;
	}];

	private _idEH_HIT = _vehCivil addEventHandler ["Hit",
	{
		params ["_veh", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};


		[_veh, _instigator] call DK_fnc_EH_HitCiv_CopsCtrl;
	}];


	_civil addEventHandler ["GetOutMan",
	{
		params ["_unit", "_role", "_vehicle"];


		if ( (_role isEqualTo "driver") && { (alive _unit) && { (alive _vehicle) } } ) then
		{
			_vehicle engineOn false;
		};

		_unit removeEventHandler ["GetOutMan", _thisEventHandler];
	}];


	_vehCivil setVariable ["DK_ctrl_idEHs", [_idEH_EPS, _idEH_HIT]];
};


DK_fnc_EH_epeCtcCiv_CopsCtrl = {

		params ["_veh", "_object2"];


		if !(_veh getVariable ["EpeOk", true]) exitWith {};

		_veh setVariable ["EpeOk", false];

		_veh spawn
		{
			uiSleep 0.4;

			if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
			{
				_this setVariable ["EpeOk", true];
			};
		};

		if (typeName _object2 isEqualTo "STRING") exitWith {};

		private _shooter = driver (vehicle _object2);

		if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"]))  exitWith
		{
			_veh setVariable ["disrupt", true];

			_idEHs = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["EpeContactStart", _thisEventHandler];
			_veh removeEventHandler ["Hit", _idEHs # 1];
			_veh setVehicleLock "UNLOCKED";

			private _ctrlNfo = _veh getVariable ["ctrlNfo", []];

			if !(_ctrlNfo isEqualTo []) then
			{
				_ctrlNfo params ["_vehCop", "_unitsCrew"];

				private _idEHsCop = _vehCop getVariable "DK_ctrl_idEHs";

				_vehCop removeEventHandler ["Hit", _idEHsCop # 0];
				_vehCop removeEventHandler ["EpeContactStart", _idEHsCop # 1];

				_unitsCrew apply
				{
					_x removeAllEventHandlers "Hit";
					_x removeAllEventHandlers "FiredNear";
					_x setVariable ["DK_behaviour", "chase"];
				};

				[_unitsCrew, _vehCop, _shooter] spawn DK_fnc_startChase_CopsPatrol;
			};


			private _driverCiv = driver _veh;
			if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
			{
				_driverCiv allowFleeing 1;

				[_driverCiv, _veh] spawn
				{
					params ["_driverCiv", "_vehCivil"];

					_driverCiv setVariable ["DK_behaviour", "drive"];
					uiSleep (1 + (random 3));

					if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

					if (selectRandom [true, false]) exitWith
					{
						_driverCiv enableAI "MOVE";

						[_driverCiv, insultCar, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
						[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
						_driverCiv forceSpeed 200;
						if (alive _vehCivil) then
						{
							_vehCivil engineOn true;
						};
					};

					[_vehCivil, _driverCiv] spawn DK_CLAG_EH_hitTraffCivB;
				};
			};
		};
};

DK_fnc_EH_HitCiv_CopsCtrl = {

		params ["_veh", "_shooter"];


		if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
		{
			_veh setVariable ["disrupt", true];

			_idEHs = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["Hit", _thisEventHandler];
			_veh removeEventHandler ["EpeContactStart", _idEHs # 1];
			_veh setVehicleLock "UNLOCKED";

			private _ctrlNfo = _veh getVariable ["ctrlNfo", []];

			if !(_ctrlNfo isEqualTo []) then
			{
				_ctrlNfo params ["_vehCop", "_unitsCrew"];

				private _idEHsCop = _vehCop getVariable "DK_ctrl_idEHs";

				_vehCop removeEventHandler ["Hit", _idEHsCop # 1];
				_vehCop removeEventHandler ["EpeContactStart", _idEHsCop # 0];

				_unitsCrew apply
				{
					_x removeAllEventHandlers "Hit";
					_x removeAllEventHandlers "FiredNear";
					_x setVariable ["DK_behaviour", "chase"];
				};

				[_unitsCrew, _vehCop, _shooter] spawn DK_fnc_startChase_CopsPatrol;
			};


			private _driverCiv = driver _veh;
			if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
			{
				_driverCiv allowFleeing 1;

				[_driverCiv, _veh] spawn
				{
					params ["_driverCiv", "_vehCivil"];

					_driverCiv setVariable ["DK_behaviour", "drive"];
					uiSleep (1 + (random 3));

					if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

					if (selectRandom [true, false]) exitWith
					{
						_driverCiv enableAI "MOVE";

						[_driverCiv, insultCar, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
						[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
						_driverCiv forceSpeed 200;
						if (alive _vehCivil) then
						{
							_vehCivil engineOn true;
						};
					};

					[_vehCivil, _driverCiv] spawn DK_CLAG_EH_hitTraffCivB;
				};
			};
		};
};



DK_addEH_deadNdel_CopsCtrl = {

	_this addEventHandler ["Killed",
	{
		params ["_unit", "_killer", "_instigator"];

		[_unit, _killer, _instigator] call DK_fnc_EH_killed_CopsCtrl;
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

DK_addEH_firedHit_CopsCtrl = {

	_this addEventHandler ["FiredNear",
	{
		params ["_unit", "_shooter"];

		[_unit, _shooter] call DK_fnc_EH_frdNr_CopsCtrl;
	}];

	_this addEventHandler ["Hit",
	{
		params ["_unit", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		
		[_unit, _instigator] call DK_fnc_EH_hit_CopsCtrl;
	}];

};

DK_addEH_veh_CopsCtrl = {


	private _idEH_EPS = _this addEventHandler ["EpeContactStart",
	{
		params ["_veh", "_object2"];

		[_veh, _object2, _thisEventHandler] call DK_fnc_EH_epeCtc_CopsCtrl;
	}];

	private _idEH_HIT = _this addEventHandler ["Hit",
	{
		params ["_veh", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

	
		[_veh, _instigator, _thisEventHandler] call DK_fnc_EH_hitVeh_CopsCtrl;
	}];



	_this setVariable ["DK_ctrl_idEHs", [_idEH_EPS, _idEH_HIT]];
};


DK_fnc_EH_killed_CopsCtrl = {

	params ["_unit", "_killer", "_instigator"];


	_unit setVariable ["cleanUpOn", false];
	[_unit, 25, 150, true] spawn DK_fnc_addAllTo_CUM;

	private _grp = group _unit;
	private _unitsCrew = units _grp;
	private _idAlive = _unitsCrew findIf {alive _x};

	if (_idAlive isEqualTo -1) then
	{
		_vehicle = _unit getVariable "vehLinkRfr";
		if (!isNil "_vehicle") then
		{
			_vehicle setVehicleLock "UNLOCKED";
		};
	}
	else
	{
		_vehicle = _unit getVariable "vehLinkRfr";
		if ((!isNil "_vehicle") && { (_unit isEqualTo driver _vehicle) } ) then
		{
			(_unitsCrew # _idAlive) assignAsDriver _vehicle;
		};
	};

	if ( !(_unitsCrew findIf { _x getVariable ["DK_behaviour", ""] isEqualTo "chase" } isEqualTo -1) OR (_unitsCrew findIf {alive _x} isEqualTo -1) ) exitWith {};

	private _veh = _unit getVariable "vehLinkRfr";
	private _trg = _veh getVariable "DK_CLAG_trgAtch";
	if (!isNil "_trg") then
	{
		deleteVehicle _trg;
	};

	if (isNull _instigator) then
	{
		_instigator = _killer;
	};

	if ((isPlayer _instigator) OR (side (group _instigator) isEqualTo west) OR (_instigator getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
	{
		_unit setVariable ["disrupt", true];

		if ((!isNil "_veh") && { (alive _veh) }) then
		{
			_idEHs = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
			_veh removeEventHandler ["Hit", _idEHs # 1];
		};


		private _unitsCrew = units _unit;

		if !(_unitsCrew isEqualTo []) then
		{
			_unitsCrew apply
			{
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "FiredNear";
				_x setVariable ["DK_behaviour", "chase"];
			};

			[_unitsCrew, _veh, _instigator] spawn DK_fnc_startChase_CopsPatrol;
		};

		private _vehCivil = (leader _grp) getVariable "vehCivil";
		if ( !(isNil "_vehCivil") && { (!isNull _vehCivil) } ) then
		{
			_idEHs = _vehCivil getVariable "DK_ctrl_idEHs";

			_vehCivil removeEventHandler ["Hit", _idEHs # 0];
			_vehCivil removeEventHandler ["EpeContactStart", _idEHs # 1];
			_vehCivil setVehicleLock "UNLOCKED";
		};

		private _driverCiv = driver _vehCivil;
		if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
		{
			_driverCiv allowFleeing 1;

			[_driverCiv, _vehCivil] spawn
			{
				params ["_driverCiv", "_vehCivil"];

				_driverCiv setVariable ["DK_behaviour", "drive"];

				_driverCiv enableAI "MOVE";
				uiSleep (1 + (random 3));

				if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

				[_driverCiv, insultAll, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
				[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
				_driverCiv forceSpeed 200;
				if (alive _vehCivil) then
				{
					_vehCivil engineOn true;
				};
			};
		};
	};
};

DK_fnc_EH_frdNr_CopsCtrl = {

	params ["_unit", "_shooter"];
		

	if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
	{
		_unit setVariable ["disrupt", true];

		private _veh = _unit getVariable "vehLinkRfr";

		if ((!isNil "_veh") && { (alive _veh) }) then
		{
			_idEHs = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
			_veh removeEventHandler ["Hit", _idEHs # 1];
		};


		private _unitsCrew = units _unit;

		if !(_unitsCrew findIf {alive _x} isEqualTo -1) then
		{
			_unitsCrew apply
			{
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "FiredNear";
				_x setVariable ["DK_behaviour", "chase"];
			};

			[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;
		};

		private _vehCivil = (_unitsCrew # 0) getVariable "vehCivil";
		if ( !(isNil "_vehCivil") && { (!isNull _vehCivil) } ) then
		{
			_idEHs = _vehCivil getVariable "DK_ctrl_idEHs";

			_vehCivil removeEventHandler ["Hit", _idEHs # 0];
			_vehCivil removeEventHandler ["EpeContactStart", _idEHs # 1];
			_vehCivil setVehicleLock "UNLOCKED";
		};

		private _driverCiv = driver _vehCivil;
		if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
		{
			_driverCiv allowFleeing 1;

			[_driverCiv, _vehCivil] spawn
			{
				params ["_driverCiv", "_vehCivil"];

				_driverCiv setVariable ["DK_behaviour", "drive"];
				uiSleep (1 + (random 3));

				if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

				if (selectRandom [true, false]) exitWith
				{
					_driverCiv enableAI "MOVE";

					[_driverCiv, insultAll, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
					[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
					_driverCiv forceSpeed 200;
					if (alive _vehCivil) then
					{
						_vehCivil engineOn true;
					};
				};

				[_vehCivil, _driverCiv] spawn DK_CLAG_EH_hitTraffCivB;
			};
		};
	};
};

DK_fnc_EH_hit_CopsCtrl = {

	params ["_unit", "_shooter"];


	if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
	{
		_unit setVariable ["disrupt", true];

		private _veh = _unit getVariable "vehLinkRfr";

		if ((!isNil "_veh") && { (alive _veh) }) then
		{
			_idEHs = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
			_veh removeEventHandler ["Hit", _idEHs # 1];
		};


		private _unitsCrew = units _unit;

		if !(_unitsCrew findIf {alive _x} isEqualTo -1) then
		{
			_unitsCrew apply
			{
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "FiredNear";
				_x setVariable ["DK_behaviour", "chase"];
			};

			[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;
		};

		private _vehCivil = (_unitsCrew # 0) getVariable "vehCivil";
		if ( !(isNil "_vehCivil") && { (!isNull _vehCivil) } ) then
		{
			_idEHs = _vehCivil getVariable "DK_ctrl_idEHs";

			_vehCivil removeEventHandler ["Hit", _idEHs # 0];
			_vehCivil removeEventHandler ["EpeContactStart", _idEHs # 1];
			_vehCivil setVehicleLock "UNLOCKED";
		};

		private _driverCiv = driver _vehCivil;
		if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
		{
			_driverCiv allowFleeing 1;

			[_driverCiv, _vehCivil] spawn
			{
				params ["_driverCiv", "_vehCivil"];

				_driverCiv setVariable ["DK_behaviour", "drive"];
				uiSleep (1 + (random 3));

				if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

				if (selectRandom [true, false]) exitWith
				{
					_driverCiv enableAI "MOVE";

					[_driverCiv, insultAll, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
					[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
					_driverCiv forceSpeed 200;
					if (alive _vehCivil) then
					{
						_vehCivil engineOn true;
					};
				};

				[_vehCivil, _driverCiv] spawn DK_CLAG_EH_hitTraffCivB;
			};
		};
	};
};

DK_fnc_EH_epeCtc_CopsCtrl = {

		params ["_veh", "_object2", "_thisEventHandler"];


		if !(_veh getVariable ["EpeOk", true]) exitWith {};

		_veh setVariable ["EpeOk", false];

		_veh spawn
		{
			uiSleep 0.4;

			if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
			{
				_this setVariable ["EpeOk", true];
			};
		};

		if (typeName _object2 isEqualTo "STRING") exitWith {};

		private _shooter = driver (vehicle _object2);

		if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) exitWith
		{
			_veh setVariable ["disrupt", true];

			_idEHsCop = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["EpeContactStart", _thisEventHandler];
			_veh removeEventHandler ["Hit", _idEHsCop # 1];

			private _ctrlNfo = _veh getVariable ["ctrlNfo", []];

			if !(_ctrlNfo isEqualTo []) then
			{
				_ctrlNfo params ["_vehCivil", "_unitsCrew"];

				private _idEHs = _vehCivil getVariable "DK_ctrl_idEHs";

				_vehCivil removeEventHandler ["Hit", _idEHs # 1];
				_vehCivil removeEventHandler ["EpeContactStart", _idEHs # 0];

				_unitsCrew apply
				{
					_x removeAllEventHandlers "Hit";
					_x removeAllEventHandlers "FiredNear";
					_x setVariable ["DK_behaviour", "chase"];
				};

				[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;


				private _driverCiv = driver _vehCivil;
				if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
				{
					_driverCiv allowFleeing 1;

					[_driverCiv, _vehCivil] spawn
					{
						params ["_driverCiv", "_vehCivil"];

						_driverCiv setVariable ["DK_behaviour", "drive"];

						_driverCiv enableAI "MOVE";
						uiSleep (1 + (random 3));

						if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

						[_driverCiv, insultAll, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
						[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
						_driverCiv forceSpeed 200;
						if (alive _vehCivil) then
						{
							_vehCivil engineOn true;
						};
					};
				};
			};
		};
};

DK_fnc_EH_hitVeh_CopsCtrl = {

		params ["_veh", "_shooter", "_thisEventHandler"];


		if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
		{
			_veh setVariable ["disrupt", true];

			_idEHsCop = _veh getVariable "DK_ctrl_idEHs";

			_veh removeEventHandler ["EpeContactStart", _idEHsCop # 0];
			_veh removeEventHandler ["Hit", _thisEventHandler];

			private _ctrlNfo = _veh getVariable ["ctrlNfo", []];

			if !(_ctrlNfo isEqualTo []) then
			{
				_ctrlNfo params ["_vehCivil", "_unitsCrew"];

				private _idEHs = _vehCivil getVariable "DK_ctrl_idEHs";

				_vehCivil removeEventHandler ["Hit", _idEHs # 1];
				_vehCivil removeEventHandler ["EpeContactStart", _idEHs # 0];

				_unitsCrew apply
				{
					_x removeAllEventHandlers "Hit";
					_x removeAllEventHandlers "FiredNear";
					_x setVariable ["DK_behaviour", "chase"];
				};

				[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;


				private _driverCiv = driver _vehCivil;
				if ( (!isNil "_driverCiv") && { (alive _driverCiv) } ) then
				{
					_driverCiv allowFleeing 1;

					[_driverCiv, _vehCivil] spawn
					{
						params ["_driverCiv", "_vehCivil"];

						_driverCiv setVariable ["DK_behaviour", "drive"];

						_driverCiv enableAI "MOVE";
						uiSleep (1 + (random 3));

						if ( (isNil "_driverCiv") OR (isNull _driverCiv) OR (!alive _driverCiv) ) exitWith {};

						[_driverCiv, insultAll, 100, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
						[_driverCiv, 1000] spawn DK_fnc_CLAG_wpDriver;
						_driverCiv forceSpeed 200;
						if (alive _vehCivil) then
						{
							_vehCivil engineOn true;
						};
					};
				};
			};
		};
};


