if (!isServer) exitWith {};


DK_CLAG_HutAlive = false;
DK_CLAG_pedDriver = false;

DK_countNb_dog_CLAG = 0;
DK_countNb_civ_CLAG = 0;
DK_countNb_ped_CLAG = 0;
DK_countNb_faun_CLAG = 0;
DK_countNb_veh_CLAG = 0;


// Count civilians number
#define CNTDOGS(NB) DK_countNb_dog_CLAG = DK_countNb_dog_CLAG + NB
#define CNT(NB) DK_countNb_civ_CLAG = DK_countNb_civ_CLAG + NB
#define CNTPED(NB) DK_countNb_ped_CLAG = DK_countNb_ped_CLAG + NB
#define CNTFAUN(NB) DK_countNb_faun_CLAG = DK_countNb_faun_CLAG + NB
#define CNTFAUNCHECK DK_CLAG_limitNumbersFaun - DK_countNb_faun_CLAG
#define CNTVEH(NB) DK_countNb_veh_CLAG = DK_countNb_veh_CLAG + NB
#define CNTDOGCHECK DK_countNb_dog_CLAG < DK_CLAG_limitNumbersDog

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []
#define disDelFlee 150

// Apply Delete
#define logicDel(LGC) _nul = DK_CLAG_Logics deleteAt (DK_CLAG_Logics find LGC)
#define logicTeTrDel(LGC) _nul = DK_CLAG_LogicsTechsTramps deleteAt (DK_CLAG_LogicsTechsTramps find LGC)
#define logicPedDel(LGC) _nul = DK_CLAG_LogicsPeds deleteAt (DK_CLAG_LogicsPeds find LGC)
#define logicGasDel(LGC) _nul = DK_CLAG_logicsGasStation deleteAt (DK_CLAG_logicsGasStation find LGC)

// Apply Pushback
#define logicPuBa(LGC) DK_CLAG_Logics pushBackUnique LGC
#define logicTeTrPuBa(LGC) DK_CLAG_LogicsTechsTramps pushBackUnique LGC
#define logicPedPuBa(LGC) DK_CLAG_LogicsPeds pushBackUnique LGC
#define logicGasPuBa(LGC) DK_CLAG_logicsGasStation pushBackUnique LGC
#define logicFaunPuBa(LGC) DK_CLAG_LogicsFaun pushBackUnique LGC

// Create Civilians agent
#define crtU createAgent [selectRandom classH, [0,0,100], [], 0, "CAN_COLLIDE"]
#define crtCIV call DK_fnc_crtCivAgent
#define crtCIVATM call DK_fnc_crtCivAtmAgent
#define crtPED call DK_fnc_crtCivPedAgent
#define crtHUT call DK_fnc_crtCivHutAgent
#define crtHW call DK_fnc_crtCivHikerWalkerAgent
#define crtTRP call DK_fnc_crtCivTrampAgent; 
#define crtTECH call DK_fnc_crtCivTechWhAgent
#define crtTECHS call DK_fnc_crtCivTechsWhAgent
#define crtBOSS call DK_fnc_crtCivBossTechWhAgent
#define crtPEDBDT call DK_fnc_crtCivPedBanditUnit
#define crtREP call DK_fnc_crtCivRepAgent
#define crtCIVCONS call DK_fnc_crtCivConstruAgent
#define crtCIVsitFlr call DK_fnc_crtCivCivSitFlrAgent

// Create Vehicles
#define crtV(C) createVehicle [C, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]

#define crtVPKCLV(DIS) DIS call DK_fnc_crtVPK_CLV
#define crtVPKVANT(DIS) DIS call DK_fnc_crtVPK_VANT
#define crtVPKLT(DIS) DIS call DK_fnc_crtVPK_LT
#define crtVPKREP(POS,DIS) [POS,DIS] call DK_fnc_crtVPK_REPAIR
#define crtVPKFUELT(POS,DIS) [POS,DIS] call DK_fnc_crtVPK_FUELT

// Define Classname
#define classH ["C_man_polo_1_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_asia"]
#define classDogs selectRandom ["Fin_sand_F", "Fin_blackwhite_F", "Fin_ocherwhite_F", "Fin_tricolour_F", "Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]
#define classFaun selectRandom ["Sheep_random_F","Goat_random_F"]
#define classVeh selectRandom ["C_SUV_01_F","C_SUV_01_F","B_G_Offroad_01_F","B_G_Offroad_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F"]
#define classVT "C_Van_02_transport_F"
#define classV selectRandom ["C_Van_02_transport_F","C_Van_02_vehicle_F"]
#define classLT selectRandom ["C_Van_01_transport_F","C_Van_01_box_F"]
#define classREP selectRandom ["C_Van_02_service_F","C_Offroad_01_repair_F"]
#define classFUELT "C_Van_01_fuel_F"

//#define txtrOffR01 ["a3\soft_f\offroad_01\data\offroad_01_ext_base01_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base04_co.paa","a3\soft_f_enoch\offroad_01\data\offroad_01_ext_grn_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base02_co.paa"]

// Sleep
#define slpFlee 180						// Time for OK after civ FLEE
#define slpDead 300 					// Time for OK after civ KILLED
#define slpPlacTake 90					// Time for OK after they are ALREADY a CIV SPAWNED at this place
#define slpPuBa 360 					// Time for OK if ANY PLAYER HAS LEFT area spawn civ.
#define slpPuBaPed 24 					// Time for OK if ANY PLAYER HAS LEFT area spawn civ.
#define slpBandit 300					// Time for spawn another Bandit unit.

// Probability to pawn a dog
#define probDog 15

// Bandit vocals
#define vocsBandit ["bandit01","bandit02","bandit03","bandit04"]

/// -- Animations -- \\\
// Chatting
#define anmsChat_A [toLower "Acts_PointingLeftUnarmed",toLower "HubStandingUB_move1",toLower "HubStandingUC_move2",toLower "acts_StandingSpeakingUnarmed"]
#define anmsChat_B [toLower "HubStandingUC_idle3",toLower "HubStandingUC_idle2",toLower "HubStandingUC_idle1"]
#define anmsChat_C [toLower "HubStandingUB_idle1",toLower "HubStandingUB_idle2",toLower "HubStandingUB_idle3"]
#define anmsChat_BC [anmsChat_B,anmsChat_C]
#define anmsBoss [toLower "Acts_A_M01_briefing", toLower "Acts_A_M02_briefing", toLower "Acts_A_M03_briefing", toLower "Acts_A_M04_briefing"]

#define delAnimsBC(ANM1,ANM2) selectRandom (selectRandom ((anmsChat_BC - [ANM1]) - [ANM2]))
#define delAnimsBC_2(ANM1,ANM2,ANM3) selectRandom (selectRandom (((anmsChat_BC - [ANM1]) - [ANM2]) - [ANM3]))
#define delAnimsBC_3(ANM1,ANM2,ANM3,ANM4) selectRandom (selectRandom ((((anmsChat_BC - [ANM1]) - [ANM2]) - [ANM3]) - [ANM4]))
#define delAnimsA(ANM) selectRandom (anmsChat_A - [ANM])
#define delAnimsA_2(ANM1,ANM2) selectRandom (anmsChat_A - [ANM1] - [ANM2])
#define delAnimsA_3(ANM1,ANM2,ANM3) selectRandom (anmsChat_A - [ANM1] - [ANM2] - [ANM3])

#define slctAnimsA selectRandom anmsChat_A
#define slctAnimsB selectRandom anmsChat_B
#define slctAnimsC selectRandom anmsChat_C
#define slctAnimsBC selectRandom (selectRandom anmsChat_BC)
#define slctAnimsBOSS selectRandom anmsBoss
#define delAnimsBOSS(ANM) selectRandom (anmsBoss - [ANM])

// Sitting
#define anmsBench_A ["hubsittingchairua_idle1","hubsittingchairua_idle2","hubsittingchairua_idle3","hubsittingchairua_move1"]
#define anmsBench_B  ["hubsittingchairub_idle1","hubsittingchairub_idle2","hubsittingchairub_idle3","hubsittingchairub_move1"]
#define anmsBench_C ["hubsittingchairuc_idle1","hubsittingchairuc_idle2","hubsittingchairuc_idle3","hubsittingchairuc_move1"]
#define anmsBnchChurch ["hubsittingchairub_idle1","hubsittingchairub_idle2","hubsittingchairub_idle3"]

#define slctAnimsSitABC selectRandom (selectRandom [anmsBench_A,anmsBench_B,anmsBench_C])
#define slctAnimsArySitABC selectRandom [anmsBench_A,anmsBench_B,anmsBench_C]
#define delAnimsSitABC(ANM) selectRandom ([anmsBench_A,anmsBench_B,anmsBench_C] - [ANM])
#define delAnimsSitABC_2(ANM1,ANM2) selectRandom (([anmsBench_A,anmsBench_B,anmsBench_C] - [ANM1]) - [ANM2])

execVM "DK_CLAG\server\DK_CLAG_loop_manageWpPeds.sqf";



//////////// ---- FUNCTIONS ---- \\\\\\\\\\\\

/// -- CIVILIANS -- \\\

// Create Agents (Unit only for Bandit)
DK_fnc_crtCivAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_Civ;
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
				_x allowFleeing 0;

				_nil = [_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

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

DK_fnc_crtCivAtmAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_Civ;
	CNTPED(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNTPED(-1);

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

DK_fnc_crtCivConstruAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_Constru;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

		private _grpAry = (_entity getVariable "DK_logic") getVariable "DK_group";
		private _nil = _grpAry deleteAt (_grpAry find _entity);
		{
			if ( (_x getVariable "DK_behaviour" isEqualTo "chat") && { (_x getVariable "DK_sittingBench") } ) then
			{
				_x enableDynamicSimulation false;
				_x setVariable ["DK_behaviour", "walk"];

				_x spawn
				{
					if (alive _this) then
					{
						[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};
				};

				_x enableAI "MOVE";
				_x setUnitPos "UP";
				_x forceWalk true;
				_x setSpeedMode "NORMAL";
				_x allowFleeing 0;

				_nil = [_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

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

DK_fnc_crtCivRepAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_Repair;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

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

DK_fnc_crtCivPedAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ forceWalk true;
	_civ allowFleeing 0;
	_civ setSpeedMode "NORMAL";
	_civ call DK_fnc_LO_Civ;
	CNTPED(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNTPED(-1);

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtCivHutAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ forceWalk true;
	_civ allowFleeing 0;
	_civ setSpeedMode "NORMAL";
	_civ call DK_fnc_LO_Hunter;
	CNTPED(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNTPED(-1);

		DK_CLAG_HutAlive = false;

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtCivHikerWalkerAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ forceWalk true;
	_civ allowFleeing 0;
	_civ setSpeedMode "NORMAL";
	_civ call DK_fnc_LO_Hiker;
	CNTPED(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNTPED(-1);

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtCivTrampAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "FSM";
	_civ disableAI "ANIM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_Tramp;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtCivTechWhAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_CivTech;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

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

DK_fnc_crtCivTechsWhAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_CivTech;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

		private _grpAry = (_entity getVariable "DK_logic") getVariable "DK_group";
		private _nil = _grpAry deleteAt (_grpAry find _entity);
		{
			if ( (_x getVariable "DK_behaviour" isEqualTo "chat") && { !(_x getVariable "DK_sittingBench") } ) then
			{
				_x enableDynamicSimulation false;
				_x setVariable ["DK_behaviour", "walk"];

				_x spawn
				{
					// sleep (random 0.7);
					if (alive _this) then
					{
						[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};
				};

				_x enableAI "MOVE";
				_x setUnitPos "UP";
				_x forceWalk true;
				_x setSpeedMode "NORMAL";
				_x allowFleeing 0;

				_nil = [_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

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

DK_fnc_crtCivBossTechWhAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "MOVE";
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ call DK_fnc_LO_CivBoss;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

		private _grpAry = (_entity getVariable "DK_logic") getVariable "DK_group";
		private _nil = _grpAry deleteAt (_grpAry find _entity);
		{
			if ( (_x getVariable "DK_behaviour" isEqualTo "chat") && { !(_x getVariable "DK_sittingBench") } ) then
			{
				_x enableDynamicSimulation false;
				_x setVariable ["DK_behaviour", "walk"];

				_x spawn
				{
					// sleep (random 0.7);
					if (alive _this) then
					{
						[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};
				};

				_x enableAI "MOVE";
				_x setUnitPos "UP";
				_x forceWalk true;
				_x setSpeedMode "NORMAL";
				_x allowFleeing 0;

				_nil = [_x,_x,500] spawn DK_fnc_rdm_civPanic_MoveTo;

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

DK_fnc_crtCivPedBanditUnit = {

	private _grp = createGroup east;
	_civ = _grp createUnit ["O_G_Survivor_F", [0,0,100], [], 0, "CAN_COLLIDE"];
	_civ allowDamage false;
	_civ setDamage 0;

	_civ disableAI "FSM";
	_civ disableAI "AUTOTARGET";
	_civ setBehaviour "CARELESS";
	_civ setCombatMode "BLUE";
	_civ setUnitPos "UP";
	_civ setCaptive true;

	_civ forceWalk true;
	_civ allowFleeing 0.1;
	_civ setSpeedMode "NORMAL";
	_civ call DK_fnc_LO_Civ_bandit;
	CNTPED(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNTPED(-1);

		[] spawn
		{
			uiSleep (slpBandit + (random slpBandit));
			DK_CLAG_noBandit = true;
		};

	/// // DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

	_grp deleteGroupWhenEmpty true;

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtCivHerdsmanAgent = {

	_civ = createAgent ["C_man_polo_1_F", [0,0,100], [], 0, "CAN_COLLIDE"];
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "FSM";
	_civ setBehaviour "STEALTH";
	_civ forceWalk true;
	_civ allowFleeing 0;
	_civ setSpeedMode "LIMITED";
	_civ setUnitPos "UP";
	_civ call DK_fnc_LO_Herdsman;

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};

			if (!alive _this) then
			{
				deleteMarker (_this getVariable "mkr_DEBUG");
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtCivCivSitFlrAgent = {

	_civ = crtU;
	_civ allowDamage false;
	_civ setDamage 0;
	_civ disableAI "FSM";
	_civ setBehaviour "CARELESS";
	_civ forceWalk true;
	_civ allowFleeing 0;
	_civ setSpeedMode "NORMAL";
	_civ call DK_fnc_LO_Civ;
	CNT(1);

	_civ addEventHandler ["deleted",
	{
		params ["_entity"];

		CNT(-1);

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

			while { alive _this } do
			{
				uiSleep 0.2;
				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};
/// // DEBUG MOD END

	_civ
};

DK_fnc_crtDog = {

		params ["_dir", "_pos", "_civToFo", ["_dis", 160]];


		CNTDOGS(1);

		private _grpDogs = createGroup civilian;
		private _dog = _grpDogs createUnit [classDogs, [0,0,100], [], 0, "CAN_COLLIDE"];

		_dog disableAI "MOVE";
		_dog setDir _dir;
		_dog setPosATL _pos;
		[_dog, 7, _dis, true] spawn DK_fnc_addAllTo_CUM;

		_dog addEventHandler ["deleted",
		{
			CNTDOGS(-1);
		}];


		uiSleep 3;
		_dog enableAI "MOVE";
		_grpDogs deleteGroupWhenEmpty true;

		call
		{
			_behav = _civToFo getVariable ["DK_behaviour", ""];
			if (_behav isEqualTo "chat") exitWith
			{
				call
				{
					_rdm = selectRandom [1,2];
					if (_rdm isEqualTo 1) exitWith
					{
						_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
					
						_dog playMove "Dog_Sit";
						while { ((_civToFo getVariable ["DK_behaviour", ""]) isEqualTo "chat") && (alive _dog) } do 
						{
							uiSleep 2;
						};
					};

					while { ((_civToFo getVariable ["DK_behaviour", ""]) isEqualTo "chat") && (alive _dog) } do 
					{
						uiSleep 2;
					};
					_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
				};
			};
			
		///	// chient qui suit un piéton ICI
			if (_behav isEqualTo "walk") exitWith
			{
				_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

				while { ((_civToFo getVariable ["DK_behaviour", ""]) isEqualTo "walk") && {(alive _dog)} } do 
				{
					_dog doMove (_civToFo getPos [3, getDir _civToFo]);
					call
					{
						private _dis = _dog distance2D _civToFo;

						if ((_dis > 3.5) && {(_dis < 8)}) exitWith
						{
							_dog playMove "Dog_Run";
						};

						if (_dis >= 8) exitWith
						{
							_dog playMove "Dog_Sprint";
						};

						if ((_dis < 1.5) && {(speed _civToFo < 1)}) exitWith
						{
							_dog playMove "Dog_Sit";
						};

						_dog playMove "Dog_Walk";
					};

					uiSleep 3;
				};
			};
		};

		if (alive _dog) then
		{
			while { (alive _civToFo) && {(alive _dog)} } do
			{
				_dog playMove "Dog_Sprint";
				call
				{
					if (speed _civToFo > 0) exitWith
					{
						_dog doMove (_civToFo getPos [5, getDir _civToFo]);
					};

					_pos = getPosATL _civToFo;
					_dog doMove _pos;

					waitUntil { uiSleep 0.5; ((_dog distance2D _pos) < 3) OR (speed _civToFo > 0) OR (!alive _dog) OR (!alive _civToFo) };
	
					if ( (alive _dog) && { (alive _civToFo) && { (speed _civToFo isEqualTo 0) } } ) then
					{
						_dog playMove "Dog_Sit";

						waitUntil { uiSleep 0.7; (speed _civToFo > 0) OR (!alive _dog) OR (!alive _civToFo) };
					};
				};

				uiSleep 2.5;
			};

			if (alive _dog) then
			{
				_pos = [[[(_dog getPos [400, random 360]),200]], [[getPosASL _dog,80],"water"]] call BIS_fnc_randomPos;
				_dog playMove "Dog_Sprint";
				_dog doMove _pos;

				for "_i" from 0 to 15 do
				{
					uiSleep 2;
					if (_dog distance2D _pos < 6) exitWith {};

					uiSleep 2;
					if (!alive _dog) exitWith {};
				};

				if (alive _dog) then
				{
					_pos = [[[(_dog getPos [400, getDir _dog]),200]], [[getPosASL _dog,80],"water"]] call BIS_fnc_randomPos;
					_dog doMove _pos;

					for "_i" from 0 to 10 do
					{
						uiSleep 3;
						if (_dog distance2D _pos < 6) exitWith {};

						uiSleep 3;
						if (!alive _dog) exitWith {};
					};

					if (alive _dog) then
					{
						_dog playMove "Dog_Idle_Stop";
						_dog setVariable ["BIS_fnc_animalBehaviour_disable", false];
					};
				};
			};
		};
};


// Spawn & Handle civilians chatting, sitting, retire cash, kiosk queu, hiker, tramp, worker & Gas Stations, repair garages (with vehicle for both)
DK_fnc_CLAG_crtCiv = {

	params ["_mkrPos","_logic","_grpAry","_civ01"];


	private _nbCiv = _logic getVariable "choiceNbCiv";

	if (_nbCiv isEqualType []) then
	{
		_nbCiv = selectRandom _nbCiv;
	};

	private	_continue = false;
	call
	{
		if (_nbCiv isEqualTo 2) exitWith
		{
		///	// 1 GROUP :  2 CIV'S
			if !( PlaceOK(_mkrPos,3,1.5) ) exitWith
			{
/*				_logic spawn
				{
					sleep slpPlacTake;

					logicPuBa(_this);
				};
*/
				DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
			};
			_continue = true;

			_civ01 = crtCIV;
			_civ02 = crtCIV;

			_civ02 attachTo [_civ01, [0,1.54,0.1]];

			call
			{
				_varChoiceDir = _logic getVariable "dir";

				if (_varChoiceDir isEqualTo -1) exitWith
				{
					_logic setDir (random 360);
				};

				_logic setDir _varChoiceDir;
			};

			_civ02 setDir 180;
			_civ01 attachTo [_logic, [0,-0.77,-0.7]];

			_anim_01 = slctAnimsA;
			_anim_02 = selectRandom [delAnimsA(_anim_01),slctAnimsBC];
			[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01,_civ02];

			if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
			{
				_civWdog = selectRandom _grpAry;
				[(getDir _civWdog) + ((random 20) - 10), _civWdog modelToWorldVisual [selectRandom [-0.75,0.75],0.75,-0.2],_civWdog] spawn DK_fnc_crtDog;
			};
		};

			if (_nbCiv isEqualTo 3) exitWith
			{
			///	// 1 GROUP :  3 CIV'S
				if !( PlaceOK(_mkrPos,4,1.7) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtCIV;
				_civ02 = crtCIV;
				_civ03 = crtCIV;

				_civ02 attachTo [_civ01,[-0.6,1.54,0.1]];
				_civ03 attachTo [_civ01,[0.6,1.54,0.1]];

				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_logic setDir (random 360);
					};

					_logic setDir _varChoiceDir;
				};
				_civ02 setDir 150;
				_civ03 setDir 200;

				_civ01 attachTo [_logic, [0,-0.77,-0.7]];

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

				if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
				{
						call
						{
							_rdm = selectRandom [1,2,3];
							if (_rdm isEqualTo 1) exitWith
							{
								[(getDir _civ01) + ((random 20) - 10), _civ01 modelToWorldVisual [selectRandom [-0.85,0.85],0.25,-0.2],_civ01] spawn DK_fnc_crtDog;
							};

							if (_rdm isEqualTo 2) exitWith
							{
								[(getDir _civ02) + ((random 20) - 10), _civ02 modelToWorldVisual [0.85,0.35,-0.2],_civ02] spawn DK_fnc_crtDog;
							};

							[(getDir _civ03) + ((random 20) - 10), _civ03 modelToWorldVisual [-0.85,0.35,-0.2],_civ03] spawn DK_fnc_crtDog;
						};
				};
			};

			if (_nbCiv isEqualTo 4) exitWith
			{
			///	// 1 GROUP :  4 CIV'S
				if !( PlaceOK(_mkrPos,4,1.9) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_logic setDir (random 360);
					};

					_logic setDir _varChoiceDir;
				};

				_civ01 = crtCIV;
				_civ02 = crtCIV;
				_civ03 = crtCIV;
				_civ04 = crtCIV;

				[_civ01, _civ02, _civ03, _civ04] call DK_fnc_4_chatting;
				_civ01 attachTo [_logic, [-0.7,-0.7,-0.5]];

				call
				{
					_rd = selectRandom [1,2,3];
					if (_rd isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsBC(_anim_02,_anim_03);

						[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ04,_anim_04] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};

					if (_rd isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsC;

						[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ04,_anim_04] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsB;
					_anim_03 = slctAnimsC;
					_anim_04 = delAnimsA(_anim_01);

					[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					[_civ04,_anim_04] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};

				_grpAry = [_civ01,_civ02,_civ03,_civ04];

				if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
				{
					_civWdog = selectRandom _grpAry;
					[(getDir _civWdog) + (selectRandom [-90,90]), _civWdog modelToWorldVisual [selectRandom [-0.15,0.15],-0.6,-0.2],_civWdog] spawn DK_fnc_crtDog;
				};
			};

			if (_nbCiv isEqualTo 5) exitWith
			{
			///	// 1 GROUP :  5 CIV'S
				if !( PlaceOK(_mkrPos,4.5,2.8) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtCIV;
				_civ02 = crtCIV;
				_civ03 = crtCIV;
				_civ04 = crtCIV;
				_civ05 = crtCIV;

				private "_dir";
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_dir = random 360;
					};

					_dir = _varChoiceDir;
				};

				_civ01 setPos ((_logic getPos [1.2 + (random 0.2), _dir]) vectorAdd [0,0,1.2]);
				_civ02 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 72]) vectorAdd [0,0,1.2]);
				_civ03 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 144]) vectorAdd [0,0,1.2]);
				_civ04 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 216]) vectorAdd [0,0,1.2]);
				_civ05 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 288]) vectorAdd [0,0,1.2]);

				_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
				_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
				_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
				_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
				_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);

				private ["_anim_01","_anim_02","_anim_03","_anim_04","_anim_05"];
				call
				{
					_rdm = selectRandom [1,2,3,4];
					if (_rdm isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsBC(_anim_02,_anim_03);
						_anim_05 = delAnimsBC_2(_anim_02,_anim_03,_anim_04);
					};
					if (_rdm isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = delAnimsA(_anim_01);
						_anim_03 = slctAnimsB;
						_anim_04 = slctAnimsC;
						_anim_05 = delAnimsBC(_anim_03,_anim_04);
					};
					if (_rdm isEqualTo 3) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsC;
						_anim_05 = delAnimsBC(_anim_02,_anim_04);
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsB;
					_anim_03 = slctAnimsC;
					_anim_04 = delAnimsA(_anim_01);
					_anim_05 = delAnimsBC(_anim_02,_anim_03);
				};

				private _anims = [];
				private _tmp = [_anim_01,_anim_02,_anim_03,_anim_04,_anim_05];
				for "_i" from 0 to 4 do
				{
					private _anm = selectRandom _tmp;
					_anims pushBack _anm;
					_nul = _tmp deleteAt (_tmp find _anm);
				};

				[_civ01,(_anims select 0)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,(_anims select 1)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ03,(_anims select 2)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ04,(_anims select 3)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ05,(_anims select 4)] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02,_civ03,_civ04,_civ05];

				if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
				{
					_civWdog = selectRandom _grpAry;
					[(getDir _civWdog) + (selectRandom [-90,90]), _civWdog modelToWorldVisual [selectRandom [-0.15,0.15],-0.6,-0.2],_civWdog] spawn DK_fnc_crtDog;
				};
			};

			if (_nbCiv isEqualTo 6) exitWith
			{
			///	// 1 GROUP :  6 CIV'S
				if !( PlaceOK(_mkrPos,6,3) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtCIV;
				_civ02 = crtCIV;
				_civ03 = crtCIV;
				_civ04 = crtCIV;
				_civ05 = crtCIV;
				_civ06 = crtCIV;

				private "_dir";
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_dir = random 360;
					};

					_dir = _varChoiceDir;
				};

				call
				{
					if (selectRandom [1,2] isEqualTo 1) exitWith
					{
						_civ01 setPos ((_logic getPos [1.2 + (random 0.2), _dir]) vectorAdd [0,0,1.2]);
						_civ02 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 60]) vectorAdd [0,0,1.2]);
						_civ03 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 120]) vectorAdd [0,0,1.2]);
						_civ04 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 180]) vectorAdd [0,0,1.2]);
						_civ05 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 240]) vectorAdd [0,0,1.2]);
						_civ06 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 300]) vectorAdd [0,0,1.2]);

						_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
						_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
						_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
						_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
						_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);
						_civ06 setDir (_civ06 getDir _logic) + ((random 30) - 15);
					};

					_civ01 setPos ((_logic getPos [1.3 + (random 0.2), _dir]) vectorAdd [0,0,1.2]);
					_civ02 setPos ((_logic getPos [1.3 + (random 0.2), _dir - 55]) vectorAdd [0,0,1.2]);
					_civ03 setPos ((_logic getPos [1.1 + (random 0.2), _dir - 120]) vectorAdd [0,0,1.2]);
					_civ04 setPos ((_logic getPos [1.3 + (random 0.2), _dir - 182.5]) vectorAdd [0,0,1.2]);
					_civ05 setPos ((_logic getPos [1.3 + (random 0.2), _dir - 237.5]) vectorAdd [0,0,1.2]);
					_civ06 setPos ((_logic getPos [1.1 + (random 0.2), _dir - 300]) vectorAdd [0,0,1.2]);

					_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
					_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
					_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
					_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
					_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);
					_civ06 setDir (_civ06 getDir _logic) + ((random 30) - 15);
				};

				private ["_anim_01","_anim_02","_anim_03","_anim_04","_anim_05","_anim_06"];
				call
				{
					_rdm = selectRandom [1,2,3,4];
					if (_rdm isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsA(_anim_01);
						_anim_05 = delAnimsBC(_anim_02,_anim_03);
						_anim_06 = delAnimsBC_2(_anim_02,_anim_03,_anim_05);
					};
					if (_rdm isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = delAnimsA(_anim_01);
						_anim_03 = slctAnimsB;
						_anim_04 = slctAnimsC;
						_anim_05 = delAnimsBC(_anim_03,_anim_04);
						_anim_06 = delAnimsBC_2(_anim_03,_anim_04,_anim_05);
					};
					if (_rdm isEqualTo 3) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsC;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsB;
						_anim_05 = delAnimsBC(_anim_04,_anim_02);
						_anim_06 = delAnimsA_2(_anim_01,_anim_03);
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsC;
					_anim_03 = delAnimsA(_anim_01);
					_anim_04 = slctAnimsB;
					_anim_05 = delAnimsA_2(_anim_01,_anim_03);
					_anim_06 = delAnimsBC(_anim_04,_anim_02);
				};

				private _anims = [];
				private _tmp = [_anim_01,_anim_02,_anim_03,_anim_04,_anim_05,_anim_06];
				for "_i" from 0 to 5 do
				{
					private _anm = selectRandom _tmp;
					_anims pushBack _anm;
					_nul = _tmp deleteAt (_tmp find _anm);
				};

				[_civ01,(_anims select 0)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,(_anims select 1)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ03,(_anims select 2)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ04,(_anims select 3)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ05,(_anims select 4)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ06,(_anims select 5)] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02,_civ03,_civ04,_civ05,_civ06];

				if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
				{
					_civWdog = selectRandom _grpAry;
					[(getDir _civWdog) + (selectRandom [-90,90]), _civWdog modelToWorldVisual [selectRandom [-0.15,0.15],-0.6,-0.2],_civWdog] spawn DK_fnc_crtDog;
				};
			};

			if (_nbCiv isEqualTo 7) then
			{
			///	// 1 GROUP :  7 CIV'S
				if !( PlaceOK(_mkrPos,6.5,3.1) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtCIV;
				_civ02 = crtCIV;
				_civ03 = crtCIV;
				_civ04 = crtCIV;
				_civ05 = crtCIV;
				_civ06 = crtCIV;
				_civ07 = crtCIV;

				private "_dir";
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_dir = random 360;
					};

					_dir = _varChoiceDir;
				};

				_civ01 setPos ((_logic getPos [1.25 + (random 0.35), _dir]) vectorAdd [0,0,1.2]);
				_civ02 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 51.42]) vectorAdd [0,0,1.2]);
				_civ03 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 102.85]) vectorAdd [0,0,1.2]);
				_civ04 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 154.28]) vectorAdd [0,0,1.2]);
				_civ05 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 205.71]) vectorAdd [0,0,1.2]);
				_civ06 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 257.14]) vectorAdd [0,0,1.2]);
				_civ07 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 308.57]) vectorAdd [0,0,1.2]);

				_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
				_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
				_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
				_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
				_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);
				_civ06 setDir (_civ06 getDir _logic) + ((random 30) - 15);
				_civ07 setDir (_civ07 getDir _logic) + ((random 30) - 15);

				private ["_anim_01","_anim_02","_anim_03","_anim_04","_anim_05","_anim_06","_anim_07"];
				call
				{
					_rdm = selectRandom [1,2,3,4];
					if (_rdm isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsA(_anim_01);
						_anim_05 = delAnimsBC(_anim_02,_anim_03);
						_anim_06 = delAnimsBC_2(_anim_02,_anim_03,_anim_05);
						_anim_07 = delAnimsA_2(_anim_01,_anim_04);
					};
					if (_rdm isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsC;
						_anim_03 = slctAnimsB;
						_anim_04 = delAnimsA(_anim_01);
						_anim_05 = delAnimsBC(_anim_03,_anim_02);
						_anim_06 = delAnimsBC_2(_anim_03,_anim_02,_anim_05);
						_anim_07 = delAnimsBC_3(_anim_03,_anim_02,_anim_05,_anim_06);
//						_anim_07 = slctAnimsC;
					};
					if (_rdm isEqualTo 3) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsC;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsB;
						_anim_05 = delAnimsBC(_anim_04,_anim_02);
						_anim_06 = delAnimsA_2(_anim_01,_anim_03);
						_anim_07 = delAnimsBC_2(_anim_02,_anim_04,_anim_05);
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsC;
					_anim_03 = delAnimsA(_anim_01);
					_anim_04 = slctAnimsB;
					_anim_05 = delAnimsA_2(_anim_01,_anim_03);
					_anim_06 = delAnimsBC(_anim_04,_anim_02);
					_anim_07 = delAnimsA_3(_anim_01,_anim_03,_anim_05);
				};

				private _anims = [];
				private _tmp = [_anim_01,_anim_02,_anim_03,_anim_04,_anim_05,_anim_06,_anim_07];
				for "_i" from 0 to 6 do
				{
					private _anm = selectRandom _tmp;
					_anims pushBack _anm;
					_nul = _tmp deleteAt (_tmp find _anm);
				};

				[_civ01,(_anims select 0)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,(_anims select 1)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ03,(_anims select 2)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ04,(_anims select 3)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ05,(_anims select 4)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ06,(_anims select 5)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ07,(_anims select 6)] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02,_civ03,_civ04,_civ05,_civ06,_civ07];

				if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
				{
					_civWdog = selectRandom _grpAry;
					[(getDir _civWdog) + (selectRandom [-90,90]), _civWdog modelToWorldVisual [selectRandom [-0.15,0.15],-0.6,-0.2],_civWdog] spawn DK_fnc_crtDog;
				};
			};
	};

	if (_continue) then
	{
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
		private _dis = _logic getVariable "choiceDis";
		{
			[_x,_dis] call DK_fnc_addEH_CivFoot;

		} forEach _grpAry;

	/// // WAITING
		[_civ01,_logic,_mkrPos,_grpAry] spawn
		{
			params ["_civ01","_logic","_mkrPos","_grpAry"];


			uiSleep 0.65;
			{
				detach _x;

			} forEach _grpAry;


			uiSleep 2;

			if (isDedicated) then
			{
				[0,_grpAry,_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
			};

			{
				_x enableDynamicSimulation true;

			} count _grpAry;

			DK_CLAG_arr_lgcsWtBehaCiv pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*			while { ((_civ01 getVariable ["DK_behaviour", ""]) isEqualTo "chat") } do
			{
				uiSleep 5;
			};

			_behaLogic = _logic getVariable "DK_behaviour";
			if (_behaLogic isEqualTo "flee") then
			{
				uiSleep slpFlee;
			};
			if (_behaLogic isEqualTo "dead") then
			{
				uiSleep slpDead;
			};

/*			private _dis = (_logic getVariable "choiceDis") + 5;
			for "_y" from 0 to slpPuBa step 6 do
			{
				private _bool = true;
				{
					if ((_x distance2D _mkrPos) < _dis) exitWith
					{
						_bool = false;
					};
					uiSleep 0.02;

				} count playableUnits;

				if (_bool) exitWith {};
				uiSleep 6;
			};

			logicPuBa(_logic);
*/
		};
	};
};

DK_fnc_CLAG_crtCivBench = {

	params ["_mkrPos", "_logic"];


	_bench = _logic getVariable "bench";

	if ((damage _bench) isEqualTo 1) exitWith
	{
		logicDel(_logic);
		deleteVehicle _logic;
	};


	if !( PlaceOK(_mkrPos,2,1.5) ) exitWith
	{
/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
	};


	private _dir = _logic getVariable "dir";
	private ["_grpAry","_civ01","_civ02","_civ03"];
	call
	{
		_nbCiv = selectRandom [1,1,1,2,2,3];
		if (_nbCiv isEqualTo 1) exitWith
		{
			_anim1 = slctAnimsSitABC;

			_civ01 = crtCIV;
			_civ01 setPos (selectRandom (_logic getVariable "benchPos"));
			[_civ01,_anim1] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ01 setDir _dir;

			_grpAry = [_civ01];
		};

		if (_nbCiv isEqualTo 2) exitWith
		{
			_placement = _logic getVariable "benchPos";
			_pos = selectRandom _placement;
			_placement = _placement - [_pos];

			_animsArray1 = slctAnimsArySitABC;
			_anim1 = selectRandom _animsArray1;

			_civ01 = crtCIV;
			_civ01 setPos _pos;
			[_civ01,_anim1] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ01 setDir _dir;

			_animsArray2 = delAnimsSitABC(_animsArray1);
			_anim2 = selectRandom _animsArray2;
			_pos = selectRandom _placement;

			_civ02 = crtCIV;
			_civ02 setPos _pos;
			[_civ02,_anim2] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ02 setDir _dir;


			_grpAry = [_civ01,_civ02];
		};

		if (_nbCiv isEqualTo 3) exitWith
		{
			_placement = _logic getVariable "benchPos";
			_pos = selectRandom _placement;
			_placement = _placement - [_pos];

			_animsArray1 = slctAnimsArySitABC;
			_anim1 = selectRandom _animsArray1;

			_civ01 = crtCIV;
			_civ01 setPos _pos;
			[_civ01,_anim1] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ01 setDir _dir;


			_animsArray2 = delAnimsSitABC(_animsArray1);
			_anim2 = selectRandom _animsArray2;
			_pos = selectRandom _placement;
			_placement = _placement - [_pos];

			_civ02 = crtCIV;
			_civ02 setPos _pos;
			[_civ02,_anim2] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ02 setDir _dir;


			_animsArray3 = delAnimsSitABC_2(_animsArray1,_animsArray2);
			_anim3 = selectRandom _animsArray3;
			_pos = selectRandom _placement;

			_civ03 = crtCIV;
			_civ03 setPos _pos;
			[_civ03,_anim3] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ03 setDir _dir;


			_grpAry = [_civ01,_civ02,_civ03];
		};
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_sittingBench", true];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_inChurch", false];
		_bench disableCollisionWith _x;
		_x disableCollisionWith _bench;

	} count _grpAry;

	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	private _dis = _logic getVariable "choiceDis";
	{
		[_x,_dis] call DK_fnc_addEH_CivFoot;

	} forEach _grpAry;


	if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
	{
		_civWdog = selectRandom _grpAry;
		[random 360,_civWdog modelToWorldVisual [(random 0.6) - 0.3,1.5,0],_civWdog] spawn DK_fnc_crtDog;
	};

	/// // WAITING
	[_civ01, _logic, _mkrPos, _bench, _grpAry] spawn
	{
		params ["_civ01", "_logic", "_mkrPos", "_bench", "_grpAry"];


		uiSleep 2;
		{
			_x enableDynamicSimulation true;

		} count _grpAry;

		DK_CLAG_arr_lgcsWtBehaCiv pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
		{
			uiSleep 5;
		};

		if (damage _bench isEqualTo 1) exitWith {};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPuBa(_logic);
*/	};

	[_bench,_logic,_civ01] spawn
	{
		params ["_bench", "_logic", "_civ01"];


		waitUntil { uiSleep 0.3; (isNil "_civ01") OR (isNull _civ01) OR (damage _bench isEqualTo 1) OR !(_civ01 getVariable ["DK_behaviour", "chat"] isEqualTo "chat") };

		if (damage _bench isEqualTo 1) then
		{
			[_civ01, _bench, true] spawn DK_fnc_EH_Flee_CivFoot;

			sleep 5;
			logicDel(_logic);
			deleteVehicle _logic;
		};
	};
};

DK_fnc_CLAG_crtCivChair = {

	params ["_mkrPos","_logic"];


	_chair = _logic getVariable "chair";
	if ((damage _chair) isEqualTo 1) exitWith
	{
		logicDel(_logic);
		deleteVehicle _logic;
	};


	if !( PlaceOK(_mkrPos,2,1) ) exitWith
	{
/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
	};


	_dir = _logic getVariable "dir";

	private	_civ01 = crtCIV;

	_chair disableCollisionWith _civ01;
	_civ01 disableCollisionWith _chair;

	private _animsArray = slctAnimsArySitABC;
	call
	{
		if ( _animsArray isEqualTo anmsBench_B) exitWith
		{
			_civ01 setPos _mkrPos vectorAdd [0.03,0.02,0];
		};
		if ( _animsArray isEqualTo anmsBench_C) exitWith
		{
			_civ01 setPos _mkrPos vectorAdd [0.01,0.02,0];
		};

		_civ01 setPos _mkrPos;
	};

	[_civ01,selectRandom _animsArray] remoteExecCall ["DK_fnc_AnimSwitch", 0];

	_civ01 setDir _dir;

	_grpAry = [_civ01];

	_civ01 allowDamage true;
	_civ01 setVariable ["DK_behaviour", "chat"];
	_civ01 setVariable ["DK_sittingBench", true];
	_civ01 setVariable ["DK_logic", _logic];
	_civ01 setVariable ["DK_inChurch", false];

	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civ01,_logic getVariable "choiceDis"] call DK_fnc_addEH_CivFoot;


	if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
	{
		[random 360,_civ01 modelToWorldVisual [(random 0.6) - 0.3,1.5,0],_civ01] spawn DK_fnc_crtDog;
	};

	/// // WAITING
	[_civ01,_logic,_mkrPos,_chair] spawn
	{
		params ["_civ01", "_logic", "_mkrPos", "_chair"];


		uiSleep 2;
		_civ01 enableDynamicSimulation true;

		DK_CLAG_arr_lgcsWtBehaCiv pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*		while { ((_civ01 getVariable ["DK_behaviour", ""]) isEqualTo "chat") } do
		{
			uiSleep 5;
		};

		if (damage _chair isEqualTo 1) exitWith {};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		if !(damage _chair isEqualTo 1) exitWith
		{
			logicPuBa(_logic);
		};
*/	};

	[_chair, _logic, _civ01] spawn
	{
		params ["_chair", "_logic", "_civ01"];


		waitUntil { uiSleep 0.3; (isNil "_civ01") OR (isNull _civ01) OR (damage _chair isEqualTo 1) OR !(_civ01 getVariable ["DK_behaviour", "chat"] isEqualTo "chat") };

		if (damage _chair isEqualTo 1) then
		{
			[_civ01, _chair, true] spawn DK_fnc_EH_Flee_CivFoot;

			sleep 5;
			logicDel(_logic);
			deleteVehicle _logic;
		};
	};
};

DK_fnc_CLAG_crtCivChurch = {


	_mkrsPos = _this getVariable "mkrsPos";

	if ((damage (_this getVariable "church")) isEqualTo 1) exitWith
	{
		logicDel(_logic);
		deleteVehicle _this;
	};

	if !( (_this nearEntities [["Man"], 4.3]) isEqualTo [] ) exitWith
	{
/*		_this spawn
		{
			sleep slpPlacTake;

			logicPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtCiv pushBackUnique [_this, (time + slpPlacTake)];
	};


	_dir = _this getVariable "dir";
	private ["_grpAry","_civ01","_civ02","_civ03"];
	call
	{
		_nbCiv = selectRandom [1,2,3];
		if (_nbCiv isEqualTo 1) exitWith
		{
			_anim1 = selectRandom anmsBnchChurch;

			_civ01 = crtCIV;
			_civ01 setPos (selectRandom _mkrsPos);
			[_civ01,_anim1] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ01 setDir _dir;

			_grpAry = [_civ01];
		};

		if (_nbCiv isEqualTo 2) exitWith
		{
			_anims = anmsBnchChurch;
			_anim1 = selectRandom _anims;
			private _nil = _anims deleteAt (_anims find _anim1);

			_civ01 = crtCIV;
			_pos = selectRandom _mkrsPos;
			private _nil = _mkrsPos deleteAt (_mkrsPos find _pos);
			_civ01 setPos _pos;
			[_civ01,_anim1] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ01 setDir _dir;


			_anim2 = selectRandom _anims;

			_civ02 = crtCIV;
			_civ02 setPos (selectRandom _mkrsPos);
			[_civ02,_anim2] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ02 setDir _dir;


			_grpAry = [_civ01,_civ02];
		};

		if (_nbCiv isEqualTo 3) exitWith
		{
			_anims = anmsBnchChurch;
			_anim1 = selectRandom _anims;
			private _nil = _anims deleteAt (_anims find _anim1);

			_civ01 = crtCIV;
			_pos = selectRandom _mkrsPos;
			private _nil = _mkrsPos deleteAt (_mkrsPos find _pos);
			_civ01 setPos _pos;
			[_civ01,_anim1] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ01 setDir _dir;


			_anim2 = selectRandom _anims;
			private _nil = _anims deleteAt (_anims find _anim1);

			_civ02 = crtCIV;
			_pos = selectRandom _mkrsPos;
			private _nil = _mkrsPos deleteAt (_mkrsPos find _pos);
			_civ02 setPos _pos;
			[_civ02,_anim2] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ02 setDir _dir;


			_anim3 = _anims # 0;

			_civ03 = crtCIV;
			_civ03 setPos (selectRandom _mkrsPos);
			[_civ03,_anim3] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			_civ03 setDir _dir;


			_grpAry = [_civ01,_civ02,_civ03];
		};
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "chat"];
		_x setVariable ["DK_sittingBench", true];
		_x setVariable ["DK_logic", _this];
		_x setVariable ["DK_inChurch", true];

	} count _grpAry;

	_this setVariable ["DK_behaviour", "chat"];
	_this setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	private _dis = _this getVariable "choiceDis";
	{
		[_x,_dis] call DK_fnc_addEH_CivFoot;

	} forEach _grpAry;

	/// // WAITING
	[_civ01, _this, _grpAry] spawn
	{
		params ["_civ01", "_logic", "_grpAry"];


		uiSleep 2;
		{
			_x enableDynamicSimulation true;

		} count _grpAry;

		DK_CLAG_arr_lgcsWtBehaCiv pushBackUnique [[_logic, slpPuBa, getPosATL _logic, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
		{
			sleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _logic) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			sleep 6;
		};

		logicPuBa(_logic);
*/	};
};


DK_fnc_CLAG_Ksk_civ1 = {
	params ["_civ01","_logic","_dir"];


	_civ01 setPos (_logic modelToWorld [0,0,0]);
	_civ01 setDir (_dir - 180);


	[_civ01]
};

DK_fnc_CLAG_Ksk_civ2 = {

	params ["_kiosk","_dir","_grpAry"];


	private _newPos = _kiosk modelToWorld [0,-3,-1.65];
	private _newPosASL = _kiosk modelToWorldVisualWorld [0,-3,-1.65];;

//	if ({ if ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _newPosASL] > 0) exitWith {1}; false } count playableUnits isEqualTo 1) exitWith
	if !(playableUnits findIf { ([vehicle _x, "IFIRE"] checkVisibility [_x call DK_fnc_eyePlace, _newPosASL] > 0) } isEqualTo -1) exitWith
	{
		[false,_grpAry]
	};

	if !( (((nearestObjects [_newPos,["AllVehicles"],3]) + (_newPos nearEntities [["Man"], 1.9])) - _grpAry) isEqualTo [] ) exitWith
	{
		[false,_grpAry]
	};

	private	_anims_a = ["HubStandingUC_idle3","HubStandingUC_idle2","HubStandingUC_idle1","HubStandingUC_move2"];
	private _civ02 = crtCIV;
	_civ02 setPos _newPos;
	_civ02 setDir (_this # 1);
	_grpAry pushBack _civ02;
	if (random 10 > 1) then
	{
		_anim = selectRandom _anims_a;
		private _nil = _anims_a deleteAt (_anims_a find _anim);
		[_civ02,_anim] remoteExecCall ["DK_fnc_AnimSwitch", 0];
	};


	[true,_grpAry,_anims_a]
};

DK_fnc_CLAG_Ksk_civ3 = {

	params ["_kiosk","_dir","_grpAry"];

	
	_anims_b = ["HubStandingUB_move1","HubStandingUB_idle1","HubStandingUB_idle2","HubStandingUB_idle3"];

	_civ03 = crtCIV;
	_civ03 setPos (_kiosk modelToWorld [0,-3.95 + ((random 0.225) - 0.1125),-1.65]);
	_civ03 setDir (_dir + (random 30) - 15);
	_grpAry pushBack _civ03;
	_anim = selectRandom _anims_b;
	private _nil = _anims_b deleteAt (_anims_b find _anim);
	[_civ03,_anim] remoteExecCall ["DK_fnc_AnimSwitch", 0];


	[_grpAry,_anims_b]
};

DK_fnc_CLAG_Ksk_civ4 = {

	params ["_kiosk","_dir","_grpAry"];


	_newPos = _kiosk modelToWorld [0,-4.95 + ((random 0.225) - 0.1125),-1.65];
	_newPosASL = _kiosk modelToWorldVisualWorld [0,-4.95,-1.65];

//	if ({ if ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _newPosASL] > 0) exitWith {1}; false } count playableUnits isEqualTo 1) exitWith
	if !(playableUnits findIf { ([vehicle _x, "IFIRE"] checkVisibility [_x call DK_fnc_eyePlace, _newPosASL] > 0) } isEqualTo -1) exitWith
	{
		[false,_grpAry]
	};

	if not ( (((nearestObjects [_newPos,["AllVehicles"],3]) + (_newPos nearEntities [["Man"], 1.9])) - _grpAry) isEqualTo [] ) exitWith
	{
		[false,_grpAry]
	};

	private	_anims_c = ["HubStandingUA_idle3","HubStandingUA_idle2","HubStandingUA_idle1"];
	private _civ04 = crtCIV;
	_civ04 setPos _newPos;
	_civ04 setDir (_dir + (random 30) - 15);
	_grpAry pushBack _civ04;
	if (random 10 > 1) then
	{
		_anim = selectRandom _anims_c;
		private _nil = _anims_c deleteAt (_anims_c find _anim);
		[_civ04,_anim] remoteExecCall ["DK_fnc_AnimSwitch", 0];
	};


	[true,_grpAry,_anims_c]
};

DK_fnc_CLAG_Ksk_civ5 = {

	params ["_kiosk","_dir","_grpAry","_anims_a"];

	
	_civ05 = crtCIV;
	_civ05 setPos (_kiosk modelToWorld [0,-5.95 + ((random 0.225) - 0.1125),-1.65]);
	_civ05 setDir (_dir + (random 30) - 15);
	_grpAry pushBack _civ05;
	_anim = selectRandom _anims_a;
	private _nil = _anims_a deleteAt (_anims_a find _anim);
	[_civ05,_anim] remoteExecCall ["DK_fnc_AnimSwitch", 0];


	_grpAry
};

DK_fnc_CLAG_Ksk_civ6 = {

	params ["_kiosk","_dir","_grpAry","_anims_b"];

	
	_newPos = _kiosk modelToWorld [0,-6.95 + ((random 0.225) - 0.1125),-1.65];
	_newPosASL = _kiosk modelToWorldVisualWorld [0,-6.95,-1.65];

//	if ({ if ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _newPosASL] > 0) exitWith {1}; false } count playableUnits isEqualTo 1) exitWith
	if !(playableUnits findIf { ([vehicle _x, "IFIRE"] checkVisibility [_x call DK_fnc_eyePlace, _newPosASL] > 0) } isEqualTo -1) exitWith
	{
		[false,_grpAry]
	};

	if !( (((nearestObjects [_newPos,["AllVehicles"],3]) + (_newPos nearEntities [["Man"], 1.9])) - _grpAry) isEqualTo [] ) exitWith
	{
		[false,_grpAry]
	};

	private _civ06 = crtCIV;
	_civ06 setPos _newPos;
	_civ06 setDir (_dir + (random 30) - 15);
	_grpAry pushBack _civ06;
	if (random 10 > 1) then
	{
		_anim = selectRandom _anims_b;
		private _nil = _anims_b deleteAt (_anims_b find _anim);
		[_civ06,_anim] remoteExecCall ["DK_fnc_AnimSwitch", 0];
	};

	[true,_grpAry]
};

DK_fnc_CLAG_Ksk_civ7 = {

	params ["_kiosk","_dir","_grpAry","_anims_c"];


	_civ07 = crtCIV;
	_civ07 setPos (_kiosk modelToWorld [0,-7.95 + ((random 0.225) - 0.1125),-1.65]);
	_civ07 setDir (_dir + (random 50) - 25);
	_grpAry pushBack _civ07;
	_anim = selectRandom _anims_c;
	[_civ07,_anim] remoteExecCall ["DK_fnc_AnimSwitch", 0];

	_grpAry
};

DK_fnc_CLAG_crtCivKsk = {

	params ["_mkrPos","_logic"];


	_kiosk = _logic getVariable "kiosk";

	if ((damage _kiosk) isEqualTo 1) exitWith
	{
		logicDel(_logic);
		deleteVehicle _logic;
	};	



//	if !( (_mkrPos nearEntities [["Man"], 1.8]) isEqualTo [] ) exitWith
	if !( PlaceOK(_mkrPos,2,1.8) ) exitWith
	{
		DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
	};


	_dir = _logic getVariable "dir";

	private ["_newPos","_grpAry","_civ01","_civ02","_civ03","_civ04","_civ05","_civ06","_civ07","_fncAry"];
	call
	{
		_nbCiv = selectRandom (_logic getVariable "nbCiv");
		if (_nbCiv isEqualTo 1) exitWith
		{
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;
		};

		if (_nbCiv isEqualTo 2) exitWith
		{
		/// // OK for 1 Civ
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;

		/// // Check for 2 Civ's
			_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ2;
			_grpAry = _fncAry # 1;
		};

		if (_nbCiv isEqualTo 3) exitWith
		{
		/// // OK for 1 Civ
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;

		/// // Check for 3 Civ's
			_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ2;
			_grpAry = _fncAry # 1;

			if (_fncAry # 0) then
			{
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ3;
				_grpAry = _fncAry # 0;
			};
		};

		if (_nbCiv isEqualTo 4) exitWith
		{
		/// // OK for 1 Civ
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;

		/// // Check for 3 Civ's
			_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ2;
			_grpAry = _fncAry # 1;

			if (_fncAry # 0) then
			{
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ3;
				_grpAry = _fncAry # 0;

			/// // Check for 4 Civ's
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ4;
				_grpAry = _fncAry # 1;
			};
		};

		if (_nbCiv isEqualTo 5) exitWith
		{
		/// // OK for 1 Civ
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;

		/// // Check for 3 Civ's
			_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ2;
			_grpAry = _fncAry # 1;
			private _anims_a = _fncAry # 2;

			if (_fncAry # 0) then
			{
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ3;
				_grpAry = _fncAry # 0;

			/// // Check for 5 Civ's
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ4;
				_grpAry = _fncAry # 1;

				if (_fncAry # 0) then
				{
					_grpAry = [_kiosk,_dir,_grpAry,_anims_a] call DK_fnc_CLAG_Ksk_civ5;
				};
			};
		};

		if (_nbCiv isEqualTo 6) exitWith
		{
		/// // OK for 1 Civ
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;

		/// // Check for 3 Civ's
			_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ2;
			_grpAry = _fncAry # 1;
			private _anims_a = _fncAry # 2;

			if (_fncAry # 0) then
			{
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ3;
				_grpAry = _fncAry # 0;
				private _anims_b = _fncAry # 1;

			/// // Check for 5 Civ's
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ4;
				_grpAry = _fncAry # 1;

				if (_fncAry # 0) then
				{
					_grpAry = [_kiosk,_dir,_grpAry,_anims_a] call DK_fnc_CLAG_Ksk_civ5;

					_fncAry = [_kiosk,_dir,_grpAry,_anims_b] call DK_fnc_CLAG_Ksk_civ6;
					_grpAry = _fncAry # 1;
				};
			};
		};

		if (_nbCiv isEqualTo 7) exitWith
		{
		/// // OK for 1 Civ
			_civ01 = crtCIV;
			_grpAry = [_civ01,_logic,_dir] call DK_fnc_CLAG_Ksk_civ1;

		/// // Check for 3 Civ's
			_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ2;
			_grpAry = _fncAry # 1;
			private _anims_a = _fncAry # 2;

			if (_fncAry # 0) then
			{
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ3;
				_grpAry = _fncAry # 0;
				private _anims_b = _fncAry # 1;

			/// // Check for 5 Civ's
				_fncAry = [_kiosk,_dir,_grpAry] call DK_fnc_CLAG_Ksk_civ4;
				_grpAry = _fncAry # 1;
				private _anims_c = _fncAry # 2;

				if (_fncAry # 0) then
				{
					_grpAry = [_kiosk,_dir,_grpAry,_anims_a] call DK_fnc_CLAG_Ksk_civ5;

					_fncAry = [_kiosk,_dir,_grpAry,_anims_b] call DK_fnc_CLAG_Ksk_civ6;
					_grpAry = _fncAry # 1;

				/// // Check for 7 Civ's
					if (_fncAry # 0) then
					{
						_grpAry = [_kiosk,_dir,_grpAry,_anims_c] call DK_fnc_CLAG_Ksk_civ7;
					};
				};
			};
		};
	};

	[_civ01,_logic,_mkrPos,_grpAry] spawn
	{
		params ["_civ01","_logic","_mkrPos","_grpAry"];


		uiSleep 1.5;
		{
			_x allowDamage true;
			_x setVariable ["DK_behaviour", "chat"];
			_x setVariable ["DK_logic", _logic];
			_x setVariable ["DK_sittingBench", false];
			_x setVariable ["DK_inChurch", false];
			_x enableDynamicSimulation true;

		} count _grpAry;

		_logic setVariable ["DK_behaviour", "chat"];
		_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
		private "_nul";
		private _dis = _logic getVariable "choiceDis";
		{
			_nul = [_x,_dis] call DK_fnc_addEH_CivFoot;

		} count _grpAry;

	///	// Trigger Hurt
		if (isDedicated) then
		{
			[0.5,_grpAry,_civ01,0.6] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtBehaCiv pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
		{
			uiSleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPuBa(_logic);
*/	};
};


DK_fnc_CLAG_crtCivATM = {

	params ["_mkrPos","_logic"];


	private	_continue = false;
	private ["_grpAry","_civ01"];


	if !( PlaceOK(_mkrPos,3,1.5) ) exitWith
	{
/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPedPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
	};

	_civ01 = crtCIVATM;
	_civ01 setDir (_logic getVariable "dir");
	_civ01 setPos _mkrPos;

	_civ01 spawn DK_fnc_CLAG_civActionATM_select;

	_grpAry = [_civ01];

	_civ01 setVariable ["DK_behaviour", "walk"];
	_civ01 setVariable ["DK_logic", _logic];
	_civ01 setVariable ["DK_sittingBench", false];
	_civ01 setVariable ["DK_inChurch", false];


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civ01,_logic getVariable "choiceDis"] call DK_fnc_addEH_CivFoot;

	/// // WAITING
	[_civ01,_logic,_mkrPos] spawn
	{
		params ["_civ01","_logic","_mkrPos"];


		uiSleep 1.2;
		_civ01 allowDamage true;

		if (isDedicated) then
		{
			[1,[_civ01],_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtBehaCivPed pushBackUnique [[_logic, (slpPuBa / 2), _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, ["chat", "walk"]];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") OR (_civ01 getVariable "DK_behaviour" isEqualTo "walk") } do
		{
			uiSleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 12 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPedPuBa(_logic);
*/	};
};

DK_fnc_CLAG_civActionATM_select = {

	private _exit = false;

	for "_i" from 0 to 60 do
	{
		sleep 3;

		{
			if (_x distance2D _this < 45) exitWith
			{
				_exit = true;

				call
				{
					if (selectRandom [true, false]) exitWith
					{
						_this call DK_fnc_CLAG_civActionATM_01;
					};

					_this call DK_fnc_CLAG_civActionATM_02;
				};
			};

			if (_exit) exitWith {};
			if (_i > 10) then
			{
				if ([vehicle _this, "IFIRE", vehicle _this] checkVisibility [_x call DK_fnc_eyePlace, eyePos _this] > 0) exitWith
				{
					_exit = true;

					call
					{
						if (selectRandom [true, false]) exitWith
						{
							_this call DK_fnc_CLAG_civActionATM_01;
						};

						_this call DK_fnc_CLAG_civActionATM_02;
					};
				};
			};

			if (_exit) exitWith {};
			uiSleep 0.08;

		} count playableUnits;

		uiSleep 1;
		if (_exit) exitWith {};

		uiSleep 1;
		if ( !(_this getVariable ["DK_behaviour", ""] isEqualTo "chat") && { !(_this getVariable ["DK_behaviour", ""] isEqualTo "walk") } ) exitWith {};
	};

	if (_this getVariable ["DK_behaviour", ""] isEqualTo "walk") then
	{
		private _trgHurt = _this getVariable ["trgHurtCiv", "empty"];
		if !(_trgHurt isEqualTo "empty") then
		{
			deleteVehicle _trgHurt;
		};

		if !(_exit) then
		{
			call
			{
				if (selectRandom [true, false]) exitWith
				{
					_this call DK_fnc_CLAG_civActionATM_01;
				};

				_this call DK_fnc_CLAG_civActionATM_02;
			};
		};

		_this enableAI "MOVE";
		_this setUnitPos "UP";
		_this forceWalk true;
		_this setSpeedMode "NORMAL";
		_this allowFleeing 0;

		[_this,_this,500] spawn DK_fnc_rdm_civPanic_MoveTo;

		_this forceSpeed (_this getSpeed "SLOW");
	};
};

DK_fnc_CLAG_civActionATM_01 = {

	_this playMoveNow "AinvPercMstpSnonWnonDnon";

	uiSleep 1.1;
	if ( (alive _this) && { !(_this getVariable ["DK_behaviour", ""] isEqualTo "flee") } ) then
	{
		_this setVariable ["DK_behaviour", "chat"];
		[_this,"AinvPercMstpSnonWnonDnon_G01"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

		uiSleep 6.4;
		if !(_this getVariable ["DK_behaviour", ""] isEqualTo "flee") then
		{
			_this setVariable ["DK_behaviour", "walk"];
		};

		if ( (alive _this) && { !(_this getVariable ["DK_behaviour", ""] isEqualTo "flee") } ) then
		{
			_this playMove "AmovPercMstpSnonWnonDnon";
		};
	};
};

DK_fnc_CLAG_civActionATM_02 = {


	[_this, "retireCash", 50, 1, true] call DK_fnc_say3D;

	_this action ["AddBag"];

	uiSleep 10.588;

	if ( (alive _this) && { !(_this getVariable ["DK_behaviour", ""] isEqualTo "flee") } ) then
	{
		_this spawn
		{
			_this action ["AddBag"];

			waitUntil { uiSleep 0.1; !alive _this };

			if ( (!isNil "_this") && { (!isNull _this) } ) then
			{
				[_this, 50 + (round (random 20))] call DK_fnc_createMoneyUnit;
			};
		};
	};
};


DK_fnc_CLAG_crtCivConstru = {

	params ["_mkrPos","_logic","_logics"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		logicTeTrDel(_logics);

		{
			deleteVehicle _x;

		} count _logics;
	};	


	private	_continue = false;
	private ["_grpAry","_civ01"];

	private _nbCiv = selectRandom [2,3];

	call
	{
		if (_nbCiv isEqualTo 2) exitWith
		{
		///	// 2 CIVS
			if !( PlaceOK(_mkrPos,3,1.5) ) exitWith
			{
/*				_logics spawn
				{
					sleep slpPlacTake;

					logicTeTrPuBa(_this);
				};
*/
				DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logics, (time + slpPlacTake)];
			};
			_continue = true;

			_civ01 = crtCIVCONS;
			_civ02 = crtCIVCONS;

			_civ02 attachTo [_civ01,[0,1.54,0.1]];

			_logic setDir (random 360);

			_civ02 setDir 180;
			_civ01 attachTo [_logic, [0,-0.77,-0.7]];

			_anim_01 = slctAnimsA;
			_anim_02 = selectRandom [delAnimsA(_anim_01),slctAnimsBC];
			[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01,_civ02];
		};

	///	// 3 CIVS
		if !( PlaceOK(_mkrPos,4,1.7) ) exitWith
		{
/*			_logics spawn
			{
				sleep slpPlacTake;

				logicTeTrPuBa(_this);
			};
*/
			DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logics, (time + slpPlacTake)];
		};
		_continue = true;

		_civ01 = crtCIVCONS;
		_civ02 = crtCIVCONS;
		_civ03 = crtCIVCONS;

		_civ02 attachTo [_civ01,[-0.6,1.54,0.1]];
		_civ03 attachTo [_civ01,[0.6,1.54,0.1]];

		_logic setDir (random 360);

		_civ02 setDir 150;
		_civ03 setDir 200;

		_civ01 attachTo [_logic, [0,-0.77,-0.7]];

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

	if (_continue) then
	{
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
		private "_nul";
		private _dis = _logic getVariable "choiceDis";
		{
			_nul = [_x,_dis] call DK_fnc_addEH_CivFoot;

		} count _grpAry;

	/// // WAITING
		[_civ01,_logic,_mkrPos,_grpAry,_logics] spawn
		{
			params ["_civ01","_logic","_mkrPos","_grp","_logics"];


			uiSleep 0.25;
			{
				detach _x;
				uiSleep 0.07;

			} count _grp;

			uiSleep 1.5;
			{
				_x enableDynamicSimulation true;

			} count _grp;

			if (isDedicated) then
			{
				[0.2,_grp,_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
			};

			DK_CLAG_arr_lgcsWtBehaTeTr pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*			while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
			{
				uiSleep 5;
			};

			_behaLogic = _logic getVariable "DK_behaviour";
			if (_behaLogic isEqualTo "flee") then
			{
				uiSleep slpFlee;
			};
			if (_behaLogic isEqualTo "dead") then
			{
				uiSleep slpDead;
			};

			private _dis = (_logic getVariable "choiceDis") + 5;
			for "_y" from 0 to slpPuBa step 6 do
			{
				private _bool = true;
				{
					if ((_x distance2D _mkrPos) < _dis) exitWith
					{
						_bool = false;
					};
					uiSleep 0.02;

				} count playableUnits;

				if (_bool) exitWith {};
				uiSleep 6;
			};

			logicTeTrPuBa(_logics);
*/		};
	};
};

DK_fnc_CLAG_crtCivHikerCamp = {

	params ["_mkrPos","_logic"];


	_logicLink = _logic getVariable "logicLink";
	if (!isNil "_logicLink") then
	{
		logicPedDel(_logicLink);
	};

///	// Check if spawn is ok
	if ((damage (_logic getVariable "house")) isEqualTo 1) exitWith
	{
		logicPedDel(_logic);
		deleteVehicle _logic;

		if (!isNil "_logicLink") then
		{
			deleteVehicle _logicLink;
		};
	};


	if !( PlaceOK(_mkrPos,6,4) ) exitWith
	{
		if (!isNil "_logicLink") exitWith
		{
/*			[_logic,_logicLink] spawn
			{
				sleep slpPlacTake;

				logicPedPuBa(_this # 0);
				logicPedPuBa(_this # 1);
			};
*/
			DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
			DK_CLAG_arr_lgcsWtPed pushBackUnique [_logicLink, (time + slpPlacTake)];
		};

/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPedPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
	};


///	// OK for spawn civilian
	private _dis = _logic getVariable "choiceDis";

	private _fr = createVehicle ["FirePlace_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
	_fr setPosATL _mkrPos;
	_fr setDir (random 360);
	_fr setVectorUp surfaceNormal _mkrPos;
	[_fr,25,_dis + 30,true] spawn DK_fnc_addAllTo_CUM;

	private _rdPlace = [-1.5,1.5];
	private ["_grpAry","_civ01","_civ02","_civ03"];
	call
	{
		_rd = selectRandom [1,2,3];
		if (_rd isEqualTo 1) exitWith
		{
			_civ01 = crtHW;
			_civ01 disableAI "ANIM";
			call
			{
				if (selectRandom [true,false]) exitWith
				{
					_civ01 setPos (_fr modelToWorldVisual[0,selectRandom _rdPlace,0.2]);
				};

				_civ01 setPos (_fr modelToWorldVisual[selectRandom _rdPlace,0,0.2]);
			};
			_civ01 setDir (_civ01 getRelDir _fr);
			[_civ01,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01];
		};

		if (_rd isEqualTo 2) exitWith
		{
			_civ01 = crtHW;
			_civ02 = crtHW;
			_civ01 disableAI "ANIM";
			_civ02 disableAI "ANIM";
			call
			{
				private _rd = selectRandom [1,2,3];
				if (_rd isEqualTo 1) exitWith
				{
					_civ01 setPos (_fr modelToWorldVisual[0,selectRandom _rdPlace,0.2]);
					_civ02 setPos (_fr modelToWorldVisual [selectRandom _rdPlace,0,0.2]);

					if (selectRandom [0,1] isEqualTo 0) exitWith
					{
						_civ01 setDir (_civ01 getRelDir _civ02);
						_civ02 setDir (_civ02 getRelDir _civ01);
					};

					_civ01 setDir (_civ01 getRelDir _fr);
					_civ02 setDir (_civ02 getRelDir _fr);
				};
				if (_rd isEqualTo 2) exitWith
				{
					_civ01 setPos (_fr modelToWorldVisual[0,1.5,0.2]);
					_civ02 setPos (_fr modelToWorldVisual [0,-1.5,0.2]);			
					_civ01 setDir (_civ01 getRelDir _fr);
					_civ02 setDir (_civ02 getRelDir _fr);
				};

				_civ01 setPos (_fr modelToWorldVisual[1.5,0,0.2]);
				_civ02 setPos (_fr modelToWorldVisual [-1.5,0,0.2]);			
				_civ01 setDir (_civ01 getRelDir _fr);
				_civ02 setDir (_civ02 getRelDir _fr);
			};

			[_civ01,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			[_civ02,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01,_civ02];
		};

		_civ01 = crtHW;
		_civ02 = crtHW;
		_civ03 = crtHW;
		_civ01 disableAI "ANIM";
		_civ02 disableAI "ANIM";
		_civ03 disableAI "ANIM";
		call
		{
			private _rd = selectRandom [1,2];
			if (_rd isEqualTo 1) exitWith
			{
				_civ01 setPos (_fr modelToWorldVisual[0,selectRandom _rdPlace,0.2]);
				_civ02 setPos (_fr modelToWorldVisual [1.5,0,0.2]);
				_civ03 setPos (_fr modelToWorldVisual [-1.5,0,0.2]);

				_civ03 setDir (_civ03 getRelDir _fr);

				if (selectRandom [0,1] isEqualTo 0) exitWith
				{
					_civ01 setDir (_civ01 getRelDir _civ02);
					_civ02 setDir (_civ02 getRelDir _civ01);
				};

				_civ01 setDir (_civ01 getRelDir _fr);
				_civ02 setDir (_civ02 getRelDir _fr);
			};

			_civ01 setPos (_fr modelToWorldVisual[-1.5,1.2,0.2]);
			_civ02 setPos (_fr modelToWorldVisual [1.5,1.2,0.2]);			
			_civ03 setPos (_fr modelToWorldVisual [0,1.4,0.2]);			
			_civ01 setDir (_civ01 getRelDir _fr);
			_civ02 setDir (_civ02 getRelDir _fr);
			_civ03 setDir (_civ03 getRelDir _fr);
		};

		[_civ01,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ02,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ03,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

		_grpAry = [_civ01,_civ02,_civ03];
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "simpleAnim"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];

	} count _grpAry;

	_logic setVariable ["DK_behaviour", "simpleAnim"];
	_logic setVariable ["DK_group", _grpAry];

	{
		[_x,_dis] call DK_fnc_addEH_civPed;

	} forEach _grpAry;

/// // WAITING
	[_logic,_mkrPos,_civ01,_grpAry] spawn
	{
		params ["_logic", "_mkrPos", "_civ01", "_grpAry"];


		uiSleep 2;
		{
			_x enableDynamicSimulation true;

		} count _grpAry;


		DK_CLAG_arr_lgcsWtBehaCivPed pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, ["simpleAnim"]];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "simpleAnim") } do
		{
			uiSleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPedPuBa(_logic);

		_logicLink = _logic getVariable "logicLink";
		if (!isNil "_logicLink") then
		{
			logicPedPuBa(_logicLink);
		};
*/	};
};

DK_fnc_CLAG_crtCivSittingFloor = {

	params ["_mkrPos","_logic"];


	if !( PlaceOK(_mkrPos,6,2) ) exitWith
	{
/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtCiv pushBackUnique [_logic, (time + slpPlacTake)];
	};

	private _nbCiv = _logic getVariable "choiceNbCiv";
	private _dis = _logic getVariable "choiceDis";


	private ["_grpAry","_civ01","_civ02","_civ03"];
	call
	{
		if (_nbCiv isEqualType []) then
		{
			_nbCiv = selectRandom _nbCiv;
		};

		if (_nbCiv isEqualTo 1) exitWith
		{
			private "_varChoiceDir";
			call
			{
				_varChoiceDir = _logic getVariable "dir";

				if (_varChoiceDir isEqualTo -1) exitWith
				{
					_logic setDir (random 360);
				};

				_logic setDir _varChoiceDir;
			};

			_civ01 = crtCIVsitFlr;
			_civ01 disableAI "ANIM";

			_civ01 setPosWorld (_logic modelToWorldVisual[0,0,0]);

			_civ01 setDir _varChoiceDir;
			[_civ01,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01];
		};

		private _rdPlace = [-1,1];
		if (_nbCiv isEqualTo 2) exitWith
		{
			_civ01 = crtCIVsitFlr;
			_civ02 = crtCIVsitFlr;
			_civ01 disableAI "ANIM";
			_civ02 disableAI "ANIM";
			call
			{
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_logic setDir (random 360);
					};

					_logic setDir _varChoiceDir;
				};

				private _rd = selectRandom [1,2];
				if (_rd isEqualTo 1) exitWith
				{
					_civ01 setPosWorld (_logic modelToWorldVisual[0,-1.3,0]);
					_civ02 setPosWorld (_logic modelToWorldVisual [selectRandom _rdPlace,-1.3,0]);

					if (selectRandom [0,1] isEqualTo 0) exitWith
					{
						_civ01 setDir (_civ01 getRelDir _civ02);
						_civ02 setDir (_civ02 getRelDir _civ01);
					};

					_civ01 setDir (_civ01 getRelDir _logic);
					_civ02 setDir (_civ02 getRelDir _logic);
				};

				_civ01 setPosWorld (_logic modelToWorldVisual[1,-0.3,0.2]);
				_civ02 setPosWorld (_logic modelToWorldVisual [-0.9,-0.4,0.2]);			
				_civ01 setDir (_civ01 getRelDir _logic);
				_civ02 setDir (_civ02 getRelDir _logic);
			};

			[_civ01,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
			[_civ02,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

			_grpAry = [_civ01,_civ02];
		};

		_civ01 = crtCIVsitFlr;
		_civ02 = crtCIVsitFlr;
		_civ03 = crtCIVsitFlr;
		_civ01 disableAI "ANIM";
		_civ02 disableAI "ANIM";
		_civ03 disableAI "ANIM";

		call
		{
			private _rd = selectRandom [1,2];
			if (_rd isEqualTo 1) exitWith
			{
				_logic setDir (random 360);

				_civ01 setPosWorld (_logic modelToWorldVisual[0,selectRandom _rdPlace,0]);
				_civ02 setPosWorld (_logic modelToWorldVisual [1,0,0.2]);
				_civ03 setPosWorld (_logic modelToWorldVisual [-1,0,0.2]);

				_civ03 setDir (_civ03 getRelDir _logic);

				if (selectRandom [0,1] isEqualTo 0) exitWith
				{
					_civ01 setDir (_civ01 getRelDir _civ02);
					_civ02 setDir (_civ02 getRelDir _civ01);
				};

				_civ01 setDir (_civ01 getRelDir _logic);
				_civ02 setDir (_civ02 getRelDir _logic);
			};

			call
			{
				_varChoiceDir = _logic getVariable "dir";

				if (_varChoiceDir isEqualTo -1) exitWith
				{
					_logic setDir (random 360);
				};

				_logic setDir _varChoiceDir;
			};

			_civ01 setPosWorld (_logic modelToWorldVisual[-1,-1.2,0.2]);
			_civ02 setPosWorld (_logic modelToWorldVisual [1,-1.2,0.2]);			
			_civ03 setPosWorld (_logic modelToWorldVisual [0,-1.4,0.2]);			
			_civ01 setDir (_civ01 getRelDir _logic);
			_civ02 setDir (_civ02 getRelDir _logic);
			_civ03 setDir (_civ03 getRelDir _logic);
		};

		[_civ01,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ02,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ03,"AmovPsitMstpSnonWnonDnon_ground"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

		_grpAry = [_civ01,_civ02,_civ03];
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "simpleAnim"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];

	} count _grpAry;

	_logic setVariable ["DK_behaviour", "simpleAnim"];
	_logic setVariable ["DK_group", _grpAry];

	{
		[_x,_dis] call DK_fnc_addEH_civPed;

	} forEach _grpAry;

/// // WAITING
	[_logic, _mkrPos, _civ01, _grpAry] spawn
	{
		params ["_logic", "_mkrPos", "_civ01", "_grpAry"];


		uiSleep 2;
		{
			_x enableDynamicSimulation true;

		} count _grpAry;


		DK_CLAG_arr_lgcsWtBehaCiv pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "simpleAnim"];

/*		while { ((_civ01 getVariable ["DK_behaviour", ""]) isEqualTo "simpleAnim") } do
		{
			uiSleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPuBa(_logic);

		_logicLink = _logic getVariable "logicLink";
		if (!isNil "_logicLink") then
		{
			logicPuBa(_logicLink);
		};
*/	};
};

DK_fnc_CLAG_crtCivHutTramp = {

	params ["_mkrPos","_logic"];


///	// Check if spawn is ok
	if ((damage (_logic getVariable "house")) isEqualTo 1) exitWith
	{
		logicTeTrDel(_logic);
		deleteVehicle _logic;
	};

	if !( PlaceOK(_mkrPos,6,4) ) exitWith
	{
/*		_logic spawn
		{
			sleep slpPlacTake;

			logicTeTrPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
	};


///	// OK for spawn civilian
	private _dis = _logic getVariable "choiceDis";

	private _fr = createVehicle ["MetalBarrel_burning_F", [0,0,0], [], 0, "CAN_COLLIDE"]; // MetalBarrel_burning_F
	_fr setPosATL _mkrPos;
	_fr setVectorUp surfaceNormal _mkrPos;
	_fr setDir (random 360);
	[_fr,25,_dis + 30,true] spawn DK_fnc_addAllTo_CUM;

	private _rdPlace = [-1,1];
	private ["_grpAry","_civ01","_civ02","_civ03", "_nil"];
	call
	{
		_rd = selectRandom [1,2,3];
		if (_rd isEqualTo 1) exitWith
		{
			_civ01 = crtTRP;
			call
			{
				if (selectRandom [true,false]) exitWith
				{
					_civ01 setPos (_fr modelToWorldVisual[0,selectRandom _rdPlace,0.2]);
				};

				_civ01 setPos (_fr modelToWorldVisual[selectRandom _rdPlace,0,0.2]);
			};
			_civ01 setDir (_civ01 getRelDir _fr);

			_grpAry = [_civ01];
		};

		if (_rd isEqualTo 2) exitWith
		{
			_civ01 = crtTRP;
			_civ02 = crtTRP;
			call
			{
				private _rd = selectRandom [1,2];
				if (_rd isEqualTo 1) exitWith
				{
					_civ01 setPos (_fr modelToWorldVisual[0,selectRandom _rdPlace,0]);
					_civ02 setPos (_fr modelToWorldVisual [selectRandom _rdPlace,0,0]);

					if (selectRandom [0,1] isEqualTo 0) exitWith
					{
						_civ01 setDir (_civ01 getRelDir _civ02);
						_civ02 setDir (_civ02 getRelDir _civ01);
					};

					_civ01 setDir (_civ01 getRelDir _fr);
					_civ02 setDir (_civ02 getRelDir _fr);
				};
				if (_rd isEqualTo 2) exitWith
				{
					_civ01 setPos (_fr modelToWorldVisual[0,1,0]);
					_civ02 setPos (_fr modelToWorldVisual [0,-1,0]);			
					_civ01 setDir (_civ01 getRelDir _fr);
					_civ02 setDir (_civ02 getRelDir _fr);
				};

				_civ01 setPos (_fr modelToWorldVisual[1,0,0]);
				_civ02 setPos (_fr modelToWorldVisual [-1,0,0]);			
				_civ01 setDir (_civ01 getRelDir _fr);
				_civ02 setDir (_civ02 getRelDir _fr);
			};

			_grpAry = [_civ01,_civ02];
		};

		_civ01 = crtTRP;
		_civ02 = crtTRP;
		_civ03 = crtTRP;
		call
		{
			private _rd = selectRandom [1,2];
			if (_rd isEqualTo 1) exitWith
			{
				_civ01 setPos (_fr modelToWorldVisual[0,selectRandom _rdPlace,0.2]);
				_civ02 setPos (_fr modelToWorldVisual [1,0,0]);
				_civ03 setPos (_fr modelToWorldVisual [-1,0,0]);

				_civ03 setDir (_civ03 getRelDir _fr);

				if (selectRandom [0,1] isEqualTo 0) exitWith
				{
					_civ01 setDir (_civ01 getRelDir _civ02);
					_civ02 setDir (_civ02 getRelDir _civ01);
				};

				_civ01 setDir (_civ01 getRelDir _fr);
				_civ02 setDir (_civ02 getRelDir _fr);
			};

			_civ01 setPos (_fr modelToWorldVisual[-1,0.8,0]);
			_civ02 setPos (_fr modelToWorldVisual [1,0.8,0]);			
			_civ03 setPos (_fr modelToWorldVisual [0,0.8,0]);			
			_civ01 setDir (_civ01 getRelDir _fr);
			_civ02 setDir (_civ02 getRelDir _fr);
			_civ03 setDir (_civ03 getRelDir _fr);
		};

		_grpAry = [_civ01,_civ02,_civ03];
	};

	{
		_x allowDamage true;
		_x setVariable ["DK_behaviour", "simpleAnim"];
		_x setVariable ["DK_logic", _logic];
		_x setVariable ["DK_sittingBench", false];
		_x setVariable ["DK_inChurch", false];
		_nil = [_x,_dis] call DK_fnc_addEH_civPed;

	} count _grpAry;

	_logic setVariable ["DK_behaviour", "simpleAnim"];
	_logic setVariable ["DK_group", _grpAry];

/// // WAITING
	[_logic, _mkrPos, _civ01, _grpAry] spawn
	{
		params ["_logic", "_mkrPos", "_civ01", "_grpAry"];


		uiSleep 2;
		{
			_x enableDynamicSimulation true;

		} count _grpAry;

		DK_CLAG_arr_lgcsWtBehaTeTr pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "simpleAnim"];

/*		while { ((_civ01 getVariable ["DK_behaviour", ""]) isEqualTo "simpleAnim") } do
		{
			uiSleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicTeTrPuBa(_logic);
*/	};
};


DK_fnc_CLAG_crtCivTechWH = {

	params ["_mkrPos","_logic","_logics"];


///	// Check if spawn is ok
	if ((damage (_logic getVariable "house")) isEqualTo 1) exitWith
	{
		logicTeTrDel(_logics);

		{
			deleteVehicle _x;

		} count _logics;
	};



	if !( PlaceOK(_mkrPos,6,1) ) exitWith
	{
/*		_logics spawn
		{
			sleep slpPlacTake;

			logicTeTrPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logics, (time + slpPlacTake)];
	};

	_civ01 = crtTECH;
	_civ01 setDir (_logic getVariable "dir");
	_civ01 setPos (_logic getVariable "mkrPos");

	[_civ01,"hubstandingub_move1"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

	_grpAry = [_civ01];


	_civ01 allowDamage true;
	_civ01 setVariable ["DK_behaviour", "chat"];
	_civ01 setVariable ["DK_logic", _logic];
	_civ01 setVariable ["DK_sittingBench", false];
	_civ01 setVariable ["DK_inChurch", false];

	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civ01,_logic getVariable "choiceDis"] call DK_fnc_addEH_CivFoot;

	/// // WAITING
	[_civ01,_logic,_mkrPos,_logics] spawn
	{
		params ["_civ01","_logic","_mkrPos","_logics"];


		detach _civ01;

		uiSleep 2;
		_civ01 enableDynamicSimulation true;

		if (isDedicated) then
//		if (true) then
		{
			[0.2,[_civ01],_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtBehaTeTr pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
		{
			uiSleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicTeTrPuBa(_logics);
*/	};
};

DK_fnc_CLAG_crtCivTechBossWH = {

	params ["_mkrPos","_logic","_logics"];


///	// Check if spawn is ok
	if ((damage (_logic getVariable "house")) isEqualTo 1) exitWith
	{
		logicTeTrDel(_logics);

		{
			deleteVehicle _x;

		} forEach _logics;
	};


	private _dis = _logic getVariable "choiceDis";
	private	_continue = false;
	private ["_grpAry","_civ01"];

	_nbCiv = selectRandom [2,3];

	call
	{
		if (_nbCiv isEqualTo 2) exitWith
		{
		///	// 1 BOSS :  1 WORKER
			if !( PlaceOK(_mkrPos,7,2) ) exitWith
			{
/*				_logics spawn
				{
					sleep slpPlacTake;

					logicTeTrPuBa(_this);
				};
*/
				DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logics, (time + slpPlacTake)];
			};
			_continue = true;

			_logic setDir (random 360);

			_civ01 = crtBOSS;
			_civ02 = crtTECHS;

			_civ02 attachTo [_civ01,[0,2.2,0.1]];

			_civ02 setDir 180;

			_civ01 setPos (_logic modelToWorldVisual [0,-1.1,-0.7]);

			_civ01 playMove slctAnimsBOSS;
			[_civ02,selectRandom [slctAnimsB,slctAnimsC]] remoteExecCall ["DK_fnc_AnimSwitch", 0];


			_grpAry = [_civ01,_civ02];

			if (isDedicated) then
			{
				[4.5,_grpAry,_civ02,0.8] spawn DK_fnc_CLAG_trgHurtCiv;
			};
		};

		///	// 1 BOSS :  2 WORKERS
		if !( PlaceOK(_mkrPos,6,3.5) ) exitWith
		{
/*			_logics spawn
			{
				sleep slpPlacTake;

				logicTeTrPuBa(_this);
			};
*/
			DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logics, (time + slpPlacTake)];
		};
		_continue = true;

		_logic setDir (random 360);

		_civ01 = crtBOSS;
		_civ02 = crtTECHS;
		_civ03 = crtTECHS;

		_civ02 attachTo [_civ01,[0.5,2,0.1]];
		_civ03 attachTo [_civ01,[-0.5,2,0.1]];

		_civ02 setDir 180;
		_civ03 setDir 180;

		_civ01 setPos (_logic modelToWorldVisual [0,-1.1,-0.7]);

		_civ01 playMove slctAnimsBOSS;
		[_civ02,slctAnimsB] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		[_civ03,slctAnimsC] remoteExecCall ["DK_fnc_AnimSwitch", 0];


		_grpAry = [_civ01,_civ02,_civ03];

		if (isDedicated) then
		{
			[4.5,_grpAry,_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};
	};

	if (_continue) then
	{
		{
			_x allowDamage true;
			_x setVariable ["DK_logic", _logic];
			_x setVariable ["DK_sittingBench", false];
			_x setVariable ["DK_inChurch", false];
			_x setVariable ["DK_behaviour", "chat"]; 

		} count _grpAry;

		_logic setVariable ["DK_behaviour", "chat"];
		_logic setVariable ["DK_group", _grpAry];

		{
			[_x,_dis] call DK_fnc_addEH_CivFoot;

		} forEach _grpAry;

	/// // Handler Boss Anime
		_civ01 addEventHandler ["AnimDone",
		{
			params ["_unit", "_anim"];

			call
			{
				if !((anmsBoss find _anim) isEqualTo -1) exitWith
				{
					[_unit,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];

					[_unit,_anim] spawn
					{
						_unit = _this # 0;

						uiSleep 2;
						if (_unit getVariable ["DK_behaviour", ""] isEqualTo "chat") then
						{
							_unit playMove delAnimsBOSS(_this # 1);
						};
					};
				};

				_unit removeEventHandler ["AnimDone", _thisEventHandler];
			};
		}];

	/// // WAITING
		[_civ01,_logic,_mkrPos,_grpAry,_logics] spawn
		{
			params ["_civ01","_logic","_mkrPos","_grp","_logics"];


			uiSleep 0.65;
			{
				detach _x;
				uiSleep 0.1;

			} count _grp;

			uiSleep 2;
			{
				_x enableDynamicSimulation true;

			} count _grp;

			DK_CLAG_arr_lgcsWtBehaTeTr pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];
		};
	};
};

DK_fnc_CLAG_crtCivTechsGroup = {

	params ["_mkrPos","_logic"];


	private	_continue = false;
	private _nbCiv = _logic getVariable "choiceNbCiv";
	private ["_grpAry","_civ01"];

		if (_nbCiv isEqualType []) then
		{
			_nbCiv = selectRandom _nbCiv;
		};

		call
		{
			if (_nbCiv isEqualTo 2) exitWith
			{
			///	// 1 GROUP :  2 CIV'S
				if !( PlaceOK(_mkrPos,3,1.5) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicTeTrPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtTECHS;
				_civ02 = crtTECHS;

				_civ02 attachTo [_civ01,[0,1.54,0.1]];

				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_logic setDir (random 360);
					};

					_logic setDir _varChoiceDir;
				};

				_civ02 setDir 180;
				_civ01 attachTo [_logic, [0,-0.77,-0.7]];

				_anim_01 = slctAnimsA;
				_anim_02 = selectRandom [delAnimsA(_anim_01),slctAnimsBC];
				[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02];
			};

			if (_nbCiv isEqualTo 3) exitWith
			{
			///	// 1 GROUP :  3 CIV'S
				if !( PlaceOK(_mkrPos,4,1.7) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicTeTrPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtTECHS;
				_civ02 = crtTECHS;
				_civ03 = crtTECHS;

				_civ02 attachTo [_civ01,[-0.6,1.54,0.1]];
				_civ03 attachTo [_civ01,[0.6,1.54,0.1]];

				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_logic setDir (random 360);
					};

					_logic setDir _varChoiceDir;
				};
				_civ02 setDir 150;
				_civ03 setDir 200;

				_civ01 attachTo [_logic, [0,-0.77,-0.7]];

				private _anim_01 = slctAnimsA;

				private ["_anim_02","_anim_03"];
				call
				{
					if (selectRandom [true,false]) exitWith
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

			if (_nbCiv isEqualTo 4) exitWith
			{
			///	// 1 GROUP :  4 CIV'S
				if !( PlaceOK(_mkrPos,4,1.9) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicTeTrPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_logic setDir (random 360);
					};

					_logic setDir _varChoiceDir;
				};

				_civ01 = crtTECHS;
				_civ02 = crtTECHS;
				_civ03 = crtTECHS;
				_civ04 = crtTECHS;

				[_civ01, _civ02, _civ03, _civ04] call DK_fnc_4_chatting;
				_civ01 attachTo [_logic, [-0.7,-0.7,-0.5]];

				call
				{
					_rd = selectRandom [1,2,3];
					if (_rd isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsBC(_anim_02,_anim_03);

						[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ04,_anim_04] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};

					if (_rd isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsC;

						[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];
						[_civ04,_anim_04] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsB;
					_anim_03 = slctAnimsC;
					_anim_04 = delAnimsA(_anim_01);

					[_civ01,_anim_01] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					[_civ02,_anim_02] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					[_civ03,_anim_03] remoteExecCall ["DK_fnc_AnimSwitch", 0];
					[_civ04,_anim_04] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};

				_grpAry = [_civ01,_civ02,_civ03,_civ04];
			};

			if (_nbCiv isEqualTo 5) exitWith
			{
			///	// 1 GROUP :  5 CIV'S
				if !( PlaceOK(_mkrPos,4.5,2.8) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicTeTrPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtTECHS;
				_civ02 = crtTECHS;
				_civ03 = crtTECHS;
				_civ04 = crtTECHS;
				_civ05 = crtTECHS;

				private "_dir";
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_dir = random 360;
					};

					_dir = _varChoiceDir;
				};

				_civ01 setPos ((_logic getPos [1.2 + (random 0.2), _dir]) vectorAdd [0,0,1.2]);
				_civ02 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 72]) vectorAdd [0,0,1.2]);
				_civ03 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 144]) vectorAdd [0,0,1.2]);
				_civ04 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 216]) vectorAdd [0,0,1.2]);
				_civ05 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 288]) vectorAdd [0,0,1.2]);

				_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
				_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
				_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
				_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
				_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);

				private ["_anim_01","_anim_02","_anim_03","_anim_04","_anim_05"];
				call
				{
					_rdm = selectRandom [1,2,3,4];
					if (_rdm isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsBC(_anim_02,_anim_03);
						_anim_05 = delAnimsBC_2(_anim_02,_anim_03,_anim_04);
					};
					if (_rdm isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = delAnimsA(_anim_01);
						_anim_03 = slctAnimsB;
						_anim_04 = slctAnimsC;
						_anim_05 = delAnimsBC(_anim_03,_anim_04);
					};
					if (_rdm isEqualTo 3) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsC;
						_anim_05 = delAnimsBC(_anim_02,_anim_04);
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsB;
					_anim_03 = slctAnimsC;
					_anim_04 = delAnimsA(_anim_01);
					_anim_05 = delAnimsBC(_anim_02,_anim_03);
				};

				private _anims = [];
				private _tmp = [_anim_01,_anim_02,_anim_03,_anim_04,_anim_05];
				for "_i" from 0 to 4 do
				{
					private _anm = selectRandom _tmp;
					_anims pushBack _anm;
					private _nil = _tmp deleteAt (_tmp find _anm);
				};

				[_civ01,(_anims select 0)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,(_anims select 1)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ03,(_anims select 2)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ04,(_anims select 3)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ05,(_anims select 4)] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02,_civ03,_civ04,_civ05];
			};

			if (_nbCiv isEqualTo 6) exitWith
			{
			///	// 1 GROUP :  6 CIV'S
				if !( PlaceOK(_mkrPos,6,3) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicTeTrPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtTECHS;
				_civ02 = crtTECHS;
				_civ03 = crtTECHS;
				_civ04 = crtTECHS;
				_civ05 = crtTECHS;
				_civ06 = crtTECHS;

				private "_dir";
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_dir = random 360;
					};

					_dir = _varChoiceDir;
				};

				call
				{
					if (selectRandom [true, false]) exitWith
					{
						_civ01 setPos ((_logic getPos [1.2 + (random 0.2), _dir]) vectorAdd [0,0,1.2]);
						_civ02 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 60]) vectorAdd [0,0,1.2]);
						_civ03 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 120]) vectorAdd [0,0,1.2]);
						_civ04 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 180]) vectorAdd [0,0,1.2]);
						_civ05 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 240]) vectorAdd [0,0,1.2]);
						_civ06 setPos ((_logic getPos [1.2 + (random 0.2), _dir - 300]) vectorAdd [0,0,1.2]);

						_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
						_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
						_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
						_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
						_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);
						_civ06 setDir (_civ06 getDir _logic) + ((random 30) - 15);
					};

					_civ01 setPos ((_logic getPos [1.3 + (random 0.2), _dir]) vectorAdd [0,0,1.2]);
					_civ02 setPos ((_logic getPos [1.3 + (random 0.2), _dir - 55]) vectorAdd [0,0,1.2]);
					_civ03 setPos ((_logic getPos [1.1 + (random 0.2), _dir - 120]) vectorAdd [0,0,1.2]);
					_civ04 setPos ((_logic getPos [1.3 + (random 0.2), _dir - 182.5]) vectorAdd [0,0,1.2]);
					_civ05 setPos ((_logic getPos [1.3 + (random 0.2), _dir - 237.5]) vectorAdd [0,0,1.2]);
					_civ06 setPos ((_logic getPos [1.1 + (random 0.2), _dir - 300]) vectorAdd [0,0,1.2]);

					_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
					_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
					_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
					_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
					_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);
					_civ06 setDir (_civ06 getDir _logic) + ((random 30) - 15);
				};

				private ["_anim_01","_anim_02","_anim_03","_anim_04","_anim_05","_anim_06"];
				call
				{
					_rdm = selectRandom [1,2,3,4];
					if (_rdm isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsA(_anim_01);
						_anim_05 = delAnimsBC(_anim_02,_anim_03);
						_anim_06 = delAnimsBC_2(_anim_02,_anim_03,_anim_05);
					};
					if (_rdm isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = delAnimsA(_anim_01);
						_anim_03 = slctAnimsB;
						_anim_04 = slctAnimsC;
						_anim_05 = delAnimsBC(_anim_03,_anim_04);
						_anim_06 = delAnimsBC_2(_anim_03,_anim_04,_anim_05);
					};
					if (_rdm isEqualTo 3) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsC;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsB;
						_anim_05 = delAnimsBC(_anim_04,_anim_02);
						_anim_06 = delAnimsA_2(_anim_01,_anim_03);
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsC;
					_anim_03 = delAnimsA(_anim_01);
					_anim_04 = slctAnimsB;
					_anim_05 = delAnimsA_2(_anim_01,_anim_03);
					_anim_06 = delAnimsBC(_anim_04,_anim_02);
				};

				private _anims = [];
				private _tmp = [_anim_01,_anim_02,_anim_03,_anim_04,_anim_05,_anim_06];
				for "_i" from 0 to 5 do
				{
					private _anm = selectRandom _tmp;
					_anims pushBack _anm;
					private _nil = _tmp deleteAt (_tmp find _anm);
				};

				[_civ01,(_anims select 0)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,(_anims select 1)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ03,(_anims select 2)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ04,(_anims select 3)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ05,(_anims select 4)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ06,(_anims select 5)] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02,_civ03,_civ04,_civ05,_civ06];
			};

			if (_nbCiv isEqualTo 7) exitWith
			{
			///	// 1 GROUP :  7 CIV'S
				if !( PlaceOK(_mkrPos,6.5,3.1) ) exitWith
				{
/*					_logic spawn
					{
						sleep slpPlacTake;

						logicTeTrPuBa(_this);
					};
*/
					DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_logic, (time + slpPlacTake)];
				};
				_continue = true;

				_civ01 = crtTECHS;
				_civ02 = crtTECHS;
				_civ03 = crtTECHS;
				_civ04 = crtTECHS;
				_civ05 = crtTECHS;
				_civ06 = crtTECHS;
				_civ07 = crtTECHS;

				private "_dir";
				call
				{
					_varChoiceDir = _logic getVariable "dir";

					if (_varChoiceDir isEqualTo -1) exitWith
					{
						_dir = random 360;
					};

					_dir = _varChoiceDir;
				};

				_civ01 setPos ((_logic getPos [1.25 + (random 0.35), _dir]) vectorAdd [0,0,1.2]);
				_civ02 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 51.42]) vectorAdd [0,0,1.2]);
				_civ03 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 102.85]) vectorAdd [0,0,1.2]);
				_civ04 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 154.28]) vectorAdd [0,0,1.2]);
				_civ05 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 205.71]) vectorAdd [0,0,1.2]);
				_civ06 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 257.14]) vectorAdd [0,0,1.2]);
				_civ07 setPos ((_logic getPos [1.25 + (random 0.35), _dir - 308.57]) vectorAdd [0,0,1.2]);

				_civ01 setDir (_civ01 getDir _logic) + ((random 30) - 15);
				_civ02 setDir (_civ02 getDir _logic) + ((random 30) - 15);
				_civ03 setDir (_civ03 getDir _logic) + ((random 30) - 15);
				_civ04 setDir (_civ04 getDir _logic) + ((random 30) - 15);
				_civ05 setDir (_civ05 getDir _logic) + ((random 30) - 15);
				_civ06 setDir (_civ06 getDir _logic) + ((random 30) - 15);
				_civ07 setDir (_civ07 getDir _logic) + ((random 30) - 15);

				private ["_anim_01","_anim_02","_anim_03","_anim_04","_anim_05","_anim_06","_anim_07"];
				call
				{
					_rdm = selectRandom [1,2,3,4];
					if (_rdm isEqualTo 1) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsB;
						_anim_03 = slctAnimsC;
						_anim_04 = delAnimsA(_anim_01);
						_anim_05 = delAnimsBC(_anim_02,_anim_03);
						_anim_06 = delAnimsBC_2(_anim_02,_anim_03,_anim_05);
						_anim_07 = delAnimsA_2(_anim_01,_anim_04);
					};
					if (_rdm isEqualTo 2) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsC;
						_anim_03 = slctAnimsB;
						_anim_04 = delAnimsA(_anim_01);
						_anim_05 = delAnimsBC(_anim_03,_anim_02);
						_anim_06 = delAnimsBC_2(_anim_03,_anim_02,_anim_05);
						_anim_07 = delAnimsBC_3(_anim_03,_anim_02,_anim_05,_anim_06);
//						_anim_07 = slctAnimsC;
					};
					if (_rdm isEqualTo 3) exitWith
					{
						_anim_01 = slctAnimsA;
						_anim_02 = slctAnimsC;
						_anim_03 = delAnimsA(_anim_01);
						_anim_04 = slctAnimsB;
						_anim_05 = delAnimsBC(_anim_04,_anim_02);
						_anim_06 = delAnimsA_2(_anim_01,_anim_03);
						_anim_07 = delAnimsBC_2(_anim_02,_anim_04,_anim_05);
					};

					_anim_01 = slctAnimsA;
					_anim_02 = slctAnimsC;
					_anim_03 = delAnimsA(_anim_01);
					_anim_04 = slctAnimsB;
					_anim_05 = delAnimsA_2(_anim_01,_anim_03);
					_anim_06 = delAnimsBC(_anim_04,_anim_02);
					_anim_07 = delAnimsA_3(_anim_01,_anim_03,_anim_05);
				};

				private _anims = [];
				private _tmp = [_anim_01,_anim_02,_anim_03,_anim_04,_anim_05,_anim_06,_anim_07];
				for "_i" from 0 to 6 do
				{
					private _anm = selectRandom _tmp;
					_anims pushBack _anm;
					private _nil = _tmp deleteAt (_tmp find _anm);
				};

				[_civ01,(_anims select 0)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ02,(_anims select 1)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ03,(_anims select 2)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ04,(_anims select 3)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ05,(_anims select 4)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ06,(_anims select 5)] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				[_civ07,(_anims select 6)] remoteExecCall ["DK_fnc_AnimSwitch", 0];

				_grpAry = [_civ01,_civ02,_civ03,_civ04,_civ05,_civ06,_civ07];
			};
		};

	if (_continue) then
	{
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
		private "_nul";
		private _dis = _logic getVariable "choiceDis";
		{
			_nul = [_x,_dis] call DK_fnc_addEH_CivFoot;

		} count _grpAry;

	/// // WAITING
		[_civ01,_logic,_mkrPos,_grpAry] spawn
		{
			params ["_civ01","_logic","_mkrPos","_grp"];


			uiSleep 0.65;
			{
				detach _x;
				uiSleep 0.05;

			} count _grp;

			uiSleep 2;
			{
				_x enableDynamicSimulation true;

			} count _grp;

			if (isDedicated) then
			{
				[0.2,_grp,_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
			};

			DK_CLAG_arr_lgcsWtBehaTeTr pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*			while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
			{
				sleep 5;
			};

			_behaLogic = _logic getVariable "DK_behaviour";
			if (_behaLogic isEqualTo "flee") then
			{
				uiSleep slpFlee;
			};
			if (_behaLogic isEqualTo "dead") then
			{
				uiSleep slpDead;
			};

			private _dis = (_logic getVariable "choiceDis") + 5;
			for "_y" from 0 to slpPuBa step 6 do
			{
				private _bool = true;
				{
					if ((_x distance2D _mkrPos) < _dis) exitWith
					{
						_bool = false;
					};
					uiSleep 0.02;

				} count playableUnits;

				if (_bool) exitWith {};
				uiSleep 6;
			};

			logicTeTrPuBa(_logic);
*/		};
	};
};



// Spawn & Handle civilians pedestrians, hikers walker, tramps, faun & herdsman
DK_fnc_CLAG_crtCivPed = {

	params ["_mkrPos","_logic","_civ","_grpAry","_foot"];


	if ((damage (_logic getVariable "house")) > 0.49) exitWith
	{
		logicPedDel(_logic);
		deleteVehicle _logic;
	};

		if !( PlaceOK(_mkrPos,6,1.5) ) exitWith
		{
			DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
		};

		_civ = crtPED;

		_logic setDir (_logic getVariable "dir");
		_civ attachTo [_logic, [0,0,-0.6]];

		_grpAry = [_civ];
		_civ allowDamage true;
		_civ setVariable ["DK_behaviour", "walk"];
		_civ setVariable ["DK_logic", _logic];
		_civ setVariable ["DK_sittingBench", false];
		_civ setVariable ["DK_inChurch", false];

		_logic setVariable ["DK_behaviour", "walk"];
		_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
		[_civ,_logic getVariable "choiceDis"] call DK_fnc_addEH_CivPed;

	/// // WAITING
		_foot = true;
		call
		{
			private "_rd";
			call
			{
				if (DK_CLAG_pedDriver) exitWith
				{
					_rd = 10;
				};

				_rd = 2;
			};

			if ((round random _rd) isEqualTo 1) then
			{
				_foot = [_civ, _foot] call DK_fnc_CLAG_CivGetParkVeh;
			};

			if (_foot) then
			{
				_civ call DK_fnc_CLAG_doWalkPed;

				if ( (CNTDOGCHECK) && { (round (random probDog) isEqualTo probDog) } ) then
				{
					[getDir _civ, _civ modelToWorldVisual [0,0,0], _civ] spawn DK_fnc_crtDog;
				};

				_civ call DK_fnc_CLAG_slctCivSay;
			};
		};


		[_logic, _mkrPos, _civ] spawn
		{
			params ["_logic", "_mkrPos", "_civ"];

			uiSleep 0.5;

			detach _civ;

			uiSleep 10;

			DK_CLAG_arr_lgcsWtBehaCivPed pushBackUnique [[_logic, (slpPuBa / 1.7), _mkrPos, (_logic getVariable "choiceDis") + 5], _logic, []];
		};

};

DK_fnc_CLAG_CivGetParkVeh = {

	params ["_civ", ["_foot", true]];


	if ( (isNil "_civ") OR (isNull _civ) OR (!alive _civ) ) exitWith
	{
		_foot;
	};

	private _cars = _civ nearEntities ["Car", 35];
	if !(_cars isEqualTo []) then
	{
		private _nearCar = selectRandom _cars;

		if (_nearCar getVariable ["pedsAllow", false]) then
		{
			_civ removeAllEventHandlers "Deleted";
			CNTPED(-1);

			DK_CLAG_pedDriver = true;
			[] spawn
			{
				uiSleep 120;
				DK_CLAG_pedDriver = false;
			};

			_foot = false;

			_civ addRating 500;
			_civ assignAsDriver _nearCar;
			[_civ] orderGetIn true;
			[_civ] allowGetIn true;
			_civ moveTo (getPosATL _nearCar);

			[_civ,_nearCar] spawn
			{
				params ["_civ", "_nearCar"];


				for "_i" from 0 to 45 step 1 do
				{
					uiSleep 1;
					if ( !(_civ isEqualTo (vehicle _civ)) OR (!alive _civ) OR !(_nearCar getVariable ["pedsAllow", false]) OR (_civ distance2D _nearCar < 5) ) exitWith {};
				};

				if (!alive _civ) exitWith {};

				if ( ((_nearCar getVariable ["pedsAllow", false]) && {(_civ distance2D _nearCar >= 5)}) OR !(canMove _nearCar) ) exitWith
				{
					if (_civ getVariable ["DK_behaviour", ""] isEqualTo "walk") then
					{
						_civ call DK_fnc_CLAG_doWalkPed;
					};
				};

				if !(_nearCar getVariable ["pedsAllow", false]) exitWith
				{
					if ([_civ,"IFIRE",_nearCar] checkVisibility [eyePos _civ, _nearCar modelToWorldVisualWorld [0,0,0]] > 0) exitWith
					{
						[_civ,_nearCar] call DK_fnc_CLAG_carJackedAnim;
					};

					if (_civ getVariable ["DK_behaviour", ""] isEqualTo "walk") then
					{
						_civ call DK_fnc_CLAG_doWalkPed;
					};
				};

//				_civ triggerDynamicSimulation true;
				_civ setVariable ["DK_behaviour", "drive"];
				_nearCar enableSimulationGlobal true;
				_civ call DK_fnc_addEH_getInMan_dynSim;
				_civ moveInDriver _nearCar;
				_civ setVariable ["hisCar", _nearCar];
				_nearCar setVariable ["hisDriver", _civ];
				_nearCar call DK_CLAG_addEH_traffic;
				_civ call DK_CLAG_addEH_trafficDriver;
				uiSleep 0.5 + (random 2);

				vehicle _civ engineOn true;

				uiSleep 0.5 + (random 2);

//				_civ triggerDynamicSimulation false;
				if (alive _civ) then
				{
					_nearCar limitSpeed 80;

					[_civ,1000] call DK_fnc_CLAG_wpDriver;
				};
			};
		};
	};

	_foot
};

DK_fnc_CLAG_crtCivHut = {

	params ["_mkrPos","_logic"];


///	// Check if spawn is ok
	if ((damage (_logic getVariable "house")) isEqualTo 1) exitWith
	{
//		_nul = DK_CLAG_Logics deleteAt (DK_CLAG_Logics find _logic);
		logicPedDel(_logic);
		deleteVehicle _logic;
	};

	if (DK_CLAG_HutAlive) exitWith {};



	if !( PlaceOK(_mkrPos,3,3) ) exitWith
	{
/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPedPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
	};

///	// OK for spawn civilian
	DK_CLAG_HutAlive = true;

	private	_civil = crtHUT;
	_civil attachTo [_logic, [0,0,0]];


	_grpAry = [_civil];
	_civil allowDamage true;
	_civil setVariable ["DK_behaviour", "walk"];
	_civil setVariable ["DK_logic", _logic];
	_civil setVariable ["DK_sittingBench", false];
	_civil setVariable ["DK_inChurch", false];

	_logic setVariable ["DK_behaviour", "walk"];
	_logic setVariable ["DK_group", _grpAry];

	private _dis = _logic getVariable ["choiceDis", 100];

///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civil, _dis] call DK_fnc_addEH_CivPed;

/// // WAITING
	detach _civil;

	[getDir _civil, _civil getPos [1, (getDir _civil) + 90], _civil, _dis] spawn DK_fnc_crtDog;

	[_civil, _logic] spawn
	{
		params ["_civil", "_logic"];


		private _loopOn = true;
		private ["_pos", "_time"];
		while { (_loopOn) && { (!isNil "_civil") && { (!isNull _civil) && { (alive _civil) } } } } do
		{
			_pos = [[[_civil getPos [500, random 360],250]], ["water"]] call BIS_fnc_randomPos;
			uiSleep 1;

			if ( !(_pos isEqualTo [0,0]) && { ((nearestLocations [_pos, ["NameVillage","NameCity","NameCityCapital"], 600]) isEqualTo []) && { !(([_pos, 100] call BIS_fnc_nearestRoad) isEqualTo objNull) } } ) then
			{
				_civil moveTo _pos;

				_time = time + 180;
				waitUntil { uiSleep 5; (time > _time) OR (isNil "_civil") OR (isNull _civil) OR (!alive _civil) OR (_civil distance2D _pos < 10) OR !((_civil getVariable ["DK_behaviour", ""]) isEqualTo "walk") };

				if (([getPosATL _civil, 12] call BIS_fnc_nearestRoad) isEqualTo objNull) exitWith
				{
					_loopOn = false;
				};

				uiSleep 1;
			};
		};

		if ( (isNil "_civil") OR (isNull _civil) OR (!alive _civil) OR !((_civil getVariable ["DK_behaviour", ""]) isEqualTo "walk") ) exitWith {};

		_civil setVariable ["DK_behaviour", "simpleAnim"];
		_logic setVariable ["DK_behaviour", "simpleAnim"];

		_civil disableAI "ANIM";
		_civil playMove "AmovPercMstpSoptWbinDnon";
	};

	[_logic, _mkrPos] spawn
	{
		params ["_logic", "_mkrPos"];


		uiSleep 10;

		DK_CLAG_arr_lgcsWtBehaCivPed pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _logic, []];

/*		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPedPuBa(_logic);
*/	};
};

DK_fnc_CLAG_crtCivHikerWalker = {

	params ["_mkrPos", "_logic"];


	_logicLink = _logic getVariable "logicLink";
	if (!isNil "_logicLink") then
	{
		logicPedDel(_logicLink);
	};

///	// Check if spawn is ok
	if ((damage (_logic getVariable "house")) isEqualTo 1) exitWith
	{
		logicPedDel(_logic);
		deleteVehicle _logic;

		if (!isNil "_logicLink") then
		{
			deleteVehicle _logicLink;
		};
	};


	if !( PlaceOK(_mkrPos,2,3) ) exitWith
	{
		if (!isNil "_logicLink") exitWith
		{
/*			[_logic,_logicLink] spawn
			{
				sleep slpPlacTake;

				logicPedPuBa(_this # 0);
				logicPedPuBa(_this # 1);
			};
*/
			DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
			DK_CLAG_arr_lgcsWtPed pushBackUnique [_logicLink, (time + slpPlacTake)];
		};

/*		_logic spawn
		{
			sleep slpPlacTake;

			logicPedPuBa(_this);
		};
*/
		DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];
	};


///	// OK for spawn civilian
	private _civ = crtHW;
	_civ attachTo [_logic, [0,0,0]];

	[_civ,_logic getVariable "choiceDis"] call DK_fnc_addEH_CivPed;
	detach _civ;
	_civ setVariable ["DK_behaviour", "walk"];
	_logic setVariable ["DK_behaviour", "walk"];

	if (CNTDOGCHECK) then
	{
		if (round (random probDog) isEqualTo probDog) then
		{
			[0, _civ modelToWorldVisual [0,0,0],_civ] spawn DK_fnc_crtDog;
		};
	};

	_grpAry = [_civ];
	_civ allowDamage true;
	_civ setVariable ["DK_logic", _logic];
	_civ setVariable ["DK_sittingBench", false];
	_civ setVariable ["DK_inChurch", false];

	_logic setVariable ["DK_group", _grpAry];

/// // WAITING
	[_logic, _mkrPos, _civ] spawn
	{
		params ["_logic", "_mkrPos", "_civ"];


		private "_pos";
		private _out = false;
		while { alive _civ } do
		{
			_pos = [[[_civ getPos [700, random 360],120]], ["water"]] call BIS_fnc_randomPos;

			if not (_pos isEqualTo [0,0]) then
			{
				if ((nearestLocations [_pos, ["NameVillage","NameCity","NameCityCapital"], 600]) isEqualTo []) then
				{
					_out = true;
				};
			};

			if (_out) exitWith
			{
				_civ moveTo _pos;
			};

			sleep 0.1;
		};

		uiSleep 10;

		DK_CLAG_arr_lgcsWtBehaCivPed pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _logic, []];

/*		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicPedPuBa(_logic);

		_logicLink = _logic getVariable "logicLink";
		if (!isNil "_logicLink") then
		{
			logicPedPuBa(_logicLink);
		};
*/	};
};


DK_fnc_CLAG_crtFaun = {

	params ["_mkrPos","_logic","_rd"];


	private _grpFaun = [];
	private _dis = (_logic getVariable "choiceDis") + 30;
	private _dir = (_logic getVariable "dir") + (selectRandom [0,180]);
	private _faun = classFaun;

	call
	{
/*		if (isDedicated) then
		{
			_rd = 2;
		}
		else
		{
			_rd = selectRandom [1,2,2,2,2];
		};
*/
		_rd = selectRandom [1,2,2,2,2];

		if (_rd isEqualTo 1) exitWith
		{
			_civ01 = call DK_fnc_crtCivHerdsmanAgent;
			_civ01 setPos (_mkrPos vectorAdd [((random 10)-5),((random 10)-5),0]);
			private _grpAry = [_civ01];

			_civ01 allowDamage true;
			_civ01 setVariable ["DK_behaviour", "walk"];
			_civ01 setVariable ["DK_logic", _logic];
			_civ01 setVariable ["DK_sittingBench", false];
			_civ01 setVariable ["DK_inChurch", false];
			[_civ01,_dis] call DK_fnc_addEH_CivPed;

			_logic setVariable ["DK_behaviour", "walk"];
			_logic setVariable ["DK_group", _grpAry];

			private "_nbFaun";
			call
			{
				_nbAliveFaun = CNTFAUNCHECK;

				if (_nbAliveFaun < 6) exitWith
				{
					_nbFaun = 6;
				};
				if (_nbAliveFaun > 16) exitWith
				{
					_nbFaun = 16;
				};

				_nbFaun = _nbAliveFaun;
			};

			for "_i" from 0 to _nbFaun step 1 do
			{
				private _sheep = createAgent [_faun, _mkrPos, [], 50, "NONE"];
				_sheep setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_sheep disableAI "FSM";
				_sheep setBehaviour "STEALTH";
				[_sheep,25,_dis,true] spawn DK_fnc_addAllTo_CUM;
				_sheep setDir (random 360);

				_sheep addEventHandler ["Killed",
				{
					[_this # 0,25,70,true] spawn DK_fnc_addAllTo_CUM;
				}];
			
				_sheep addEventHandler ["Deleted",
				{
					CNTFAUN(-1);
				}];


				CNTFAUN(1);
				_grpFaun pushBackUnique _sheep;
			};

			[_civ01, _dir, _grpFaun, _mkrPos, _dis, _faun] spawn
			{
				params ["_civ01", "_dir", "_grpFaun", "_mkrPos", "_dis", "_faun"];


				private _scdSearch = true;
				private _loop = true;
				private "_pos";

				_pos = [[[_civ01 getPos [500,  _dir],120]], ["water"]] call BIS_fnc_randomPos;
				if !(_pos isEqualTo [0,0]) then
				{
					if ((nearestLocations [_pos, ["NameCity","NameCityCapital"], 450]) isEqualTo []) then
					{
						_scdSearch = false;
						_loop = false;
					};
				};

				uiSleep 1;

				if (_scdSearch) then
				{
					_pos = [[[_civ01 getPos [500,  _dir - 180],120]], ["water"]] call BIS_fnc_randomPos;
					if !(_pos isEqualTo [0,0]) then
					{
						if ((nearestLocations [_pos, ["NameCity","NameCityCapital"], 450]) isEqualTo []) then
						{
							_loop = false;
						};
					};
				};

				private _out = false;
				if (_loop) then
				{
					while { alive _civ01 } do
					{
						_pos = [[[_civ01 getPos [500, random 360],120]], ["water"]] call BIS_fnc_randomPos;

						if !(_pos isEqualTo [0,0]) then
						{
							if ((nearestLocations [_pos, ["NameCity","NameCityCapital"], 450]) isEqualTo []) then
							{
								_out = true;
							};
						};

						if (_out) exitWith {};

						sleep 1;
					};
				};

				private _grpDogs = createGroup civilian;

				private _dog1 = _grpDogs createUnit [classDogs, _mkrPos, [], 40, "NONE"];
				private _dog2 = _grpDogs createUnit [classDogs, _mkrPos, [], 40, "NONE"];
				[_dog1,25,_dis,true] spawn DK_fnc_addAllTo_CUM;
				[_dog2,25,_dis,true] spawn DK_fnc_addAllTo_CUM;
				_dog1 setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_dog2 setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_dog1 setBehaviour "STEALTH";
				_dog2 setBehaviour "STEALTH";

				_grpDogs deleteGroupWhenEmpty true;

				private "_animStp";
				private "_animWalk";
				private "_animRun";
				call
				{
					if (_faun isEqualTo "Sheep_random_F") exitWith
					{
						_animStp = "Sheep_Idle_Stop";
						_animWalk = "Sheep_Walk";
						_animRun = "Sheep_Run";
					};

					_animStp = "Goat_Idle_Stop";
					_animWalk = "Goat_Walk";
					_animRun = "Goat_Run";
				};

				while { (_civ01 getVariable "DK_behaviour") isEqualTo "walk" } do
				{
					{
						call
						{
							private _dis = _x distance2D _civ01;

							if (_dis >= 60) exitWith
							{
								_x playMoveNow _animRun;
							};
							if (_dis <= 8) exitWith
							{
								_x playMoveNow _animStp;
							};
							if ((_dis >= 20) && (_dis < 60)) exitWith
							{
								_x playMoveNow selectRandom [_animWalk,_animRun,_animRun];
							};
							if ((_dis > 8) && (_dis < 20)) then
							{
								_x playMoveNow selectRandom [_animWalk,_animStp];
							};
						};

						uiSleep 0.5;

					} count _grpFaun;

					call
					{
						if ( (_grpFaun findIf { (_civ01 distance2D _x) > 60 }) isEqualTo -1 ) exitWith
						{
							_civ01 moveTo _pos;
						};

						_civ01 moveTo (getPosATL _civ01) vectorAdd [((random 10)-5),((random 10)-5),0];
						uiSleep 2;

						doStop _civ01;
						_civ01 lookAt (selectRandom _grpFaun);
					};

					if (alive _dog1) then
					{
						_dog1 doMove getPosATL (selectRandom _grpFaun);
						_dog1 playMoveNow selectRandom ["Dog_Run","Dog_Walk"];
					};
					if (alive _dog2) then
					{
						_dog2 doMove getPosATL (selectRandom _grpFaun);
						_dog2 playMoveNow selectRandom ["Dog_Idle_Stop","Dog_Run","Dog_Run","Dog_Walk"];
					};

					_civ01 setUnitPos "UP";

					{
						_x moveTo getPosATL _civ01;
						uiSleep 0.15;

					} count _grpFaun;

					uiSleep 1;
				};

				{
					if (alive _x) then
					{
						_x setVariable ["BIS_fnc_animalBehaviour_disable", false];
					};

				} count _grpFaun;

				if (alive _dog1) then
				{
					_dog1 setVariable ["BIS_fnc_animalBehaviour_disable", false];
				};

				if (alive _dog2) then
				{
					_dog2 setVariable ["BIS_fnc_animalBehaviour_disable", false];
				};
			};
		};

		if (_rd isEqualTo 2) exitWith
		{

			private "_nbFaun";
			call
			{
				_nbAliveFaun = CNTFAUNCHECK;

				if (_nbAliveFaun < 3) exitWith
				{
					_nbFaun = 3;
				};
				if (_nbAliveFaun > 16) exitWith
				{
					_nbFaun = 16;
				};

				_nbFaun = _nbAliveFaun;
			};

			private _rad = 50 + (random 50);
			for "_i" from 0 to _nbFaun step 1 do
			{
				private _sheep = createAgent [_faun, _mkrPos, [], _rad, "NONE"];
				[_sheep,25,_dis + 30,true] spawn DK_fnc_addAllTo_CUM;
				_sheep setDir (random 360);

				_sheep addEventHandler ["Killed",
				{
					[_this # 0,25,70,true] spawn DK_fnc_addAllTo_CUM;
				}];
			
				_sheep addEventHandler ["Deleted",
				{
					CNTFAUN(-1);
				}];

				CNTFAUN(1);
				_grpFaun pushBackUnique _sheep;
			};
		};
	};


/// // WAITING
	[_logic,_mkrPos,_grpFaun] spawn
	{
		params ["_logic", "_mkrPos", "_grpFaun"];


		while { !((_grpFaun findIf { alive _x }) isEqualTo -1) } do
		{
			sleep 10;
		};

		private _dis = (_logic getVariable "choiceDis") + 30;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicFaunPuBa(_logic);
	};
};

DK_fnc_CLAG_crtFaunRoad = {

	params ["_mkrPos","_logic","_rd"];


	private _grpFaun = [];
	private _dis = (_logic getVariable "choiceDis") + 30;
	private _dir = (_logic getVariable "dir") + (selectRandom [0,180]);
	private _faun = classFaun;

	call
	{
/*		if (isDedicated) then
		{
			_rd = 2;
		}
		else
		{
			_rd = selectRandom [1,1,1,1,2];
		};
*/
		_rd = selectRandom [1,1,1,1,2];

		if (_rd isEqualTo 1) exitWith
		{
			_civ01 = call DK_fnc_crtCivHerdsmanAgent;
			_civ01 setPos (_mkrPos vectorAdd [((random 10)-5),((random 10)-5),0]);
			private _grpAry = [_civ01];

			_civ01 allowDamage true;
			_civ01 setVariable ["DK_behaviour", "walk"];
			_civ01 setVariable ["DK_logic", _logic];
			_civ01 setVariable ["DK_sittingBench", false];
			_civ01 setVariable ["DK_inChurch", false];
			[_civ01,_dis] call DK_fnc_addEH_CivPed;

			_logic setVariable ["DK_behaviour", "walk"];
			_logic setVariable ["DK_group", _grpAry];

			private "_nbFaun";
			call
			{
				_nbAliveFaun = CNTFAUNCHECK;

				if (_nbAliveFaun < 6) exitWith
				{
					_nbFaun = 6;
				};
				if (_nbAliveFaun > 16) exitWith
				{
					_nbFaun = 16;
				};

				_nbFaun = _nbAliveFaun;
			};


			for "_i" from 0 to _nbFaun step 1 do
			{
				private _sheep = createAgent [_faun, _mkrPos, [], 5, "NONE"];

				_sheep setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_sheep disableAI "FSM";
				_sheep setBehaviour "STEALTH";
				[_sheep,25,_dis,true] spawn DK_fnc_addAllTo_CUM;
				_sheep setDir (random 360);

				_sheep addEventHandler ["Killed",
				{
					[_this # 0,25,70,true] spawn DK_fnc_addAllTo_CUM;
				}];
			
				_sheep addEventHandler ["Deleted",
				{
					CNTFAUN(-1);
				}];


				CNTFAUN(1);
				_grpFaun pushBackUnique _sheep;
			};

			[_civ01,_dir,_grpFaun,_mkrPos,_dis,_faun] spawn
			{
				params ["_civ01", "_dir", "_grpFaun", "_mkrPos", "_dis", "_faun"];


				private _scdSearch = true;
				private _loop = true;
				private "_pos";

				_pos = [[[_civ01 getPos [500,  _dir],120]], ["water"]] call BIS_fnc_randomPos;
				if !(_pos isEqualTo [0,0]) then
				{
					if ((nearestLocations [_pos, ["NameCity","NameCityCapital"], 450]) isEqualTo []) then
					{
						_scdSearch = false;
						_loop = false;
					};
				};

				if (_scdSearch) then
				{
					_pos = [[[_civ01 getPos [500,  _dir - 180],120]], ["water"]] call BIS_fnc_randomPos;
					if !(_pos isEqualTo [0,0]) then
					{
						if ((nearestLocations [_pos, ["NameCity","NameCityCapital"], 450]) isEqualTo []) then
						{
							_loop = false;
						};
					};
				};

				private _out = false;
				if (_loop) then
				{
					while { alive _civ01 } do
					{
						_pos = [[[_civ01 getPos [500, random 360],120]], ["water"]] call BIS_fnc_randomPos;

						if !(_pos isEqualTo [0,0]) then
						{
							if ((nearestLocations [_pos, ["NameCity","NameCityCapital"], 450]) isEqualTo []) then
							{
								_out = true;
							};
						};

						if (_out) exitWith {};

						sleep 1;
					};
				};


				private _grpDogs = createGroup civilian;

				private _dog1 = _grpDogs createUnit [classDogs, _mkrPos, [], 40, "NONE"];
				private _dog2 = _grpDogs createUnit [classDogs, _mkrPos, [], 40, "NONE"];
				[_dog1,25,_dis,true] spawn DK_fnc_addAllTo_CUM;
				[_dog2,25,_dis,true] spawn DK_fnc_addAllTo_CUM;
				_dog1 setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_dog2 setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_dog1 setBehaviour "STEALTH";
				_dog2 setBehaviour "STEALTH";

				_grpDogs deleteGroupWhenEmpty true;

				private "_animStp";
				private "_animWalk";
				private "_animRun";
				call
				{
					if (_faun isEqualTo "Sheep_random_F") exitWith
					{
						_animStp = "Sheep_Idle_Stop";
						_animWalk = "Sheep_Walk";
						_animRun = "Sheep_Run";
					};

					_animStp = "Goat_Idle_Stop";
					_animWalk = "Goat_Walk";
					_animRun = "Goat_Run";
				};

				while { (_civ01 getVariable "DK_behaviour") isEqualTo "walk" } do
				{
					{
						call
						{
							private _dis = _x distance2D _civ01;

							if (_dis >= 60) exitWith
							{
								_x playMoveNow _animRun;
							};
							if (_dis <= 8) exitWith
							{
								_x playMoveNow _animStp;
							};
							if ((_dis >= 20) && (_dis < 60)) exitWith
							{
								_x playMoveNow selectRandom [_animWalk,_animRun,_animRun];
							};
							if ((_dis > 8) && (_dis < 20)) then
							{
								_x playMoveNow selectRandom [_animWalk,_animStp];
							};
						};

						uiSleep 0.5;

					} count _grpFaun;

					call
					{
						if ( (_grpFaun findIf { (_civ01 distance2D _x) > 60 }) isEqualTo -1 ) exitWith
						{
							_civ01 moveTo _pos;
						};

						_civ01 moveTo (getPosATL _civ01) vectorAdd [((random 10)-5),((random 10)-5),0];
						uiSleep 2;

						doStop _civ01;
						_civ01 lookAt (selectRandom _grpFaun);
					};

					if (alive _dog1) then
					{
						_dog1 doMove getPosATL (selectRandom _grpFaun);
						_dog1 playMoveNow selectRandom ["Dog_Run","Dog_Walk"];
					};
					if (alive _dog2) then
					{
						_dog2 doMove getPosATL (selectRandom _grpFaun);
						_dog2 playMoveNow selectRandom ["Dog_Idle_Stop","Dog_Run","Dog_Run","Dog_Walk"];
					};

					_civ01 setUnitPos "UP";

					{
						_x moveTo getPosATL _civ01;
						uiSleep 0.15;

					} count _grpFaun;

					if ( (_grpFaun findIf { alive _x }) isEqualTo -1 ) exitWith
					{
						if ( (_civ01 getVariable "DK_behaviour") isEqualTo "walk" ) then
						{
							_civ01 moveTo _pos;
							_civ01 setBehaviour "CARELESS";
							[_civ01,1,100,true] spawn DK_fnc_addAllTo_CUM;

							if (alive _dog1) then
							{
								[_dog1,1,200,true] spawn DK_fnc_addAllTo_CUM;
							};

							if (alive _dog2) then
							{
								[_dog2,1,200,true] spawn DK_fnc_addAllTo_CUM;
							};
						};
					};

					uiSleep 1;
				};

				{
					if (alive _x) then
					{
						_x setVariable ["BIS_fnc_animalBehaviour_disable", false];
					};

				} count _grpFaun;

				if (alive _dog1) then
				{
					_dog1 setVariable ["BIS_fnc_animalBehaviour_disable", false];
				};

				if (alive _dog2) then
				{
					_dog2 setVariable ["BIS_fnc_animalBehaviour_disable", false];
				};
			};
		};

		if (_rd isEqualTo 2) exitWith
		{

			private "_nbFaun";
			call
			{
				_nbAliveFaun = CNTFAUNCHECK;

				if (_nbAliveFaun < 3) exitWith
				{
					_nbFaun = 3;
				};
				if (_nbAliveFaun > 16) exitWith
				{
					_nbFaun = 16;
				};

				_nbFaun = _nbAliveFaun;
			};

			for "_i" from 0 to _nbFaun step 1 do
			{
				private _sheep = createAgent [_faun, _mkrPos, [], 5, "NONE"];
				[_sheep,25,_dis + 30,true] spawn DK_fnc_addAllTo_CUM;
				_sheep setDir (random 360);

				_sheep addEventHandler ["Killed",
				{
					[_this # 0,25,70,true] spawn DK_fnc_addAllTo_CUM;
				}];
			
				_sheep addEventHandler ["Deleted",
				{
					CNTFAUN(-1);
				}];

				CNTFAUN(1);
				_grpFaun pushBackUnique _sheep;
			};
		};
	};


/// // WAITING
	[_logic, _mkrPos, _grpFaun] spawn
	{
		params ["_logic", "_mkrPos", "_grpFaun"];


		while { !((_grpFaun findIf { alive _x }) isEqualTo -1) } do
		{
			sleep 10;
		};

		private _dis = (_logic getVariable "choiceDis") + 30;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicFaunPuBa(_logic);
	};
};


DK_fnc_CLAG_crtCivPedBandit = {

	params ["_mkrPos","_logic","_continue","_civil","_grpAry"];


	if ((damage (_logic getVariable "house")) > 0.49) exitWith
	{
		logicPedDel(_logic);
		deleteVehicle _logic;
		DK_CLAG_noBandit = true;
	};


	_continue = false;

		if !( PlaceOK(_mkrPos,6,1.5) ) exitWith
		{
			DK_CLAG_arr_lgcsWtPed pushBackUnique [_logic, (time + slpPlacTake)];

			DK_CLAG_noBandit = true;
		};

		_civil = crtPEDBDT;

		_logic setDir (_logic getVariable "dir");
		_civil attachTo [_logic, [0,0,-0.6]];

		_grpAry = [_civil];
		_civil allowDamage true;
		_civil setVariable ["DK_behaviour", "walk"];
		_civil setVariable ["DK_logic", _logic];
		_civil setVariable ["DK_sittingBench", false];
		_civil setVariable ["DK_inChurch", false];

		_logic setVariable ["DK_behaviour", "walk"];
		_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
		[_civil,_logic getVariable "choiceDis"] call DK_fnc_addEH_CivPedBandit;


	/// // MOVE
		detach _civil;

		private "_nearestRoad";
		call
		{
			_nearestRoad = [_civil getPos [70, getDir _civil], 70] call BIS_fnc_nearestRoad;
			if !(_nearestRoad isEqualTo objNull) exitWith
			{
				_civil doMove (getPosWorld _nearestRoad);
			};

			call
			{
				_nearestRoad = [getPosATL _civil, 200] call BIS_fnc_nearestRoad;
				if !(_nearestRoad isEqualTo objNull) exitWith
				{
					_civil doMove  (getPosWorld _nearestRoad);
				};

				_nearestRoad = [(selectRandom DK_CLAG_normalHouses_Ary) getVariable "mkrPos", 300] call BIS_fnc_nearestRoad;
				_civil doMove  (getPosWorld _nearestRoad);
			};
		};

		[_civil,_nearestRoad] spawn
		{
			params ["_civil", "_nearestRoad"];


			uiSleep ((_nearestRoad distance2D _civil) / 2);

			if (alive _civil) then
			{
				private "_pos";
				private _roadsConnect = roadsConnectedTo _nearestRoad;
				if !(_roadsConnect isEqualTo []) then
				{
					_pos = getPosATL (selectRandom _roadsConnect);
				}
				else
				{
					_pos = getPosATL (selectRandom DK_CLAG_normalHouses_Ary);
				};

				_civil doMove _pos;
					
				uiSleep ((_pos distance2D _civil) / 2);

				if (alive _civil) then
				{
					private _pos2 = [[[(_civil getPos [500, ((_civil getDir _pos) + ((random 60) - 30))]),100]], ["water"]] call BIS_fnc_randomPos;
					if (_pos2 isEqualTo [0,0]) then
					{
						_pos2 = getPosATL (selectRandom DK_CLAG_normalHouses_Ary);
					};

					_civil doMove _pos2;
				};
			};
		};


	/// // BANDIT ACTION
		_civil spawn DK_fnc_CLAG_pedBanditAction;


	/// // WAITING
		[_logic,_mkrPos] spawn
		{
			params ["_logic", "_mkrPos"];


			uiSleep 10;

			_behaLogic = _logic getVariable "DK_behaviour";
			if (_behaLogic isEqualTo "flee") then
			{
				uiSleep slpFlee;
			};
			if (_behaLogic isEqualTo "dead") then
			{
				uiSleep slpDead;
			};

			private _dis = (_logic getVariable "choiceDis") + 5;
			for "_y" from 0 to slpPuBa step 12 do
			{
				private _bool = true;
				{
					if ((_x distance2D _mkrPos) < _dis) exitWith
					{
						_bool = false;
					};
					uiSleep 0.02;

				} count playableUnits;

				if (_bool) exitWith {};
				uiSleep 6;
			};

			logicPedPuBa(_logic);
		};
};

DK_fnc_CLAG_pedBanditAction = {

	private "_nearCiv";

	while { (!isNil "_this") && { (!isNull _this) && { (alive _this) && { ((_this getVariable ["DK_behaviour", ""]) isEqualTo "walk") } } } } do
	{
		uiSleep 2;

		private _nearests = (_this nearEntities ["Man", 17]) - [_this];
		if !(_nearests isEqualTo []) then
		{
			_nearCiv = _nearests # 0;

			if ( (_nearCiv getVariable ["DK_side", ""] isEqualTo "civ") && { !(lineIntersects [eyePos _this, eyePos _nearCiv,_this, _nearCiv]) } ) then
			{
				_this setVariable ["DK_behaviour", "bandit", true];
				_this setVariable ["onFire", true];
				_this removeAllEventHandlers "firedNear";
				_this removeAllEventHandlers "Hit";
 
				_this lookAt _nearCiv;
				_nearCiv lookAt _this;
				_this glanceAt _nearCiv;
				_nearCiv glanceAt _this;

				private _sound = selectRandom vocsBandit;
				[_this,_sound,100,1,true] call DK_fnc_say3D;

				[_this, 2] spawn DK_fnc_randomLip;

				[_this,selectRandom ["hgun_ACPC2_F","hgun_Pistol_heavy_02_F","hgun_P07_F","hgun_Rook40_F"],1] call BIS_fnc_addWeapon;
				_this enableAI "FSM";
				_this setBehaviour "COMBAT";
				_this setSkill 1;
				_this doFollow (leader (group _this));
				_this commandTarget _nearCiv;
				_this doTarget _nearCiv;
				_this reveal [_nearCiv, 4];

				_this setSpeedMode "FULL";
				_this forceWalk false;
				[_this] allowGetIn true;

				_this addEventHandler ["Hit",
				{
					_this call DK_fnc_CLAG_pedBanditEhHit;

				}];

				uiSleep (0.5 + (random 2));

				if ( (alive _nearCiv) && { (selectRandom [true,false]) && { ([vehicle _nearCiv, "IFIRE", vehicle _this] checkVisibility [eyePos _nearCiv, eyePos _this] > 0) } } ) then
				{
					if (selectRandom [true,false]) then
					{
						[_nearCiv,"A_civSay04",100,1,true] call DK_fnc_say3D;
					};

					_nearCiv action ["Surrender", _nearCiv];
					_nearCiv setVariable ["DK_surrender",true];

					uiSleep (1 + (random 3));
				};


				if (alive _this) then
				{
					_this setCombatMode "YELLOW";
					_this commandTarget _nearCiv;
					_this doTarget _nearCiv;
					_this doFire (vehicle _nearCiv);
					_this doMove (getPosWorld _nearCiv);
					_this setCaptive false;

					if (alive _nearCiv) then
					{
						if (_nearCiv getVariable ["DK_surrender",false]) then
						{
							_nearCiv playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
						};
					};

					_this spawn
					{
						uiSleep 6;
						if (alive _this) then
						{
							_this setVariable ["onFire", false];
						};
					};
				};
			};
		};
	};

	if ((_this getVariable ["DK_behaviour", ""]) isEqualTo "bandit") then
	{
		waitUntil { uiSleep 0.5; (isNil "_nearCiv") OR (isNull _nearCiv) OR (!alive _nearCiv) OR !(_this getVariable ["onFire", false]) };

		if (alive _this) then
		{
			_this removeAllEventHandlers "Deleted";
			CNTPED(-1);

			_this doFollow (leader (group _this));

			_this setCombatMode "BLUE";
			_this setBehaviour "CARELESS";

			_this addEventHandler ["GetInMan",
			{
				_this call DK_fnc_CLAG_pedBanditEhGetin;
			}];

			_waypoint = [(group _this), _this, "[this, 1000] spawn DK_fnc_CLAG_wpBanditDriver; ", "(alive this)", "GETIN NEAREST", nil, "FULL", "CARELESS"] call DK_fnc_AddWaypointState;

			_this call DK_fnc_addEH_getInMan_dynSim;
		};
	};
};

DK_fnc_CLAG_pedBanditEhHit = {

	params ["_unit", "_killer", "", "_shooter"];


	if (isNull _shooter) then
	{
		_shooter = _killer;
	};

	if (behaviour _units isEqualTo "COMBAT") exitWith {};

	_unit setBehaviour "COMBAT";
	_unit setCombatMode "YELLOW";
	_unit commandTarget _shooter;
	_unit doTarget _shooter;
	_unit doFire (vehicle _shooter);

	_unit spawn
	{
		uiSleep 5;
		_this setCombatMode "BLUE";
		_this setBehaviour "CARELESS";
		_this doFollow (leader (group _this));
	};
};

DK_fnc_CLAG_pedBanditEhGetin = {

	params ["_unit", "_role", "_vehicle"];



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

	if ((_vehicle getVariable ["notForCiv", false]) OR (isPlayer (driver _vehicle)) OR (side group (driver _vehicle) isEqualTo west)) exitWith
	{
		moveOut _unit;
	};

	if !(_role isEqualTo "driver") then
	{
		[_unit, _vehicle] spawn
		{
			params ["_unit", "_vehicle"];


			_unit assignAsDriver _vehicle;
			[_unit] orderGetIn true;

			uiSleep 1.5;
			_unit moveInDriver _vehicle;
		};
	};

	_vehicle forceSpeed 300;
};


/// -- VEHICLE AT GAS STATION & REPAIR GARAGE -- \\\

DK_fnc_crtVPK_CLV = {

	private _class = classVeh;

	_veh = crtV(_class);

	[_veh, _class] call DK_fnc_CLAG_vehColor;

/*	call
	{
		if (_class isEqualTo "C_SUV_01_F") exitWith
		{
			[
				_veh,
				[selectRandom ["Black","Grey","Orange","Red"],1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_class isEqualTo "B_G_Offroad_01_F") exitWith
		{
			private _bumper = selectRandom [[1,0], [0,1]];
			[
				_veh,
				["Guerilla_06", 1], 
				[
					"HideDoor1", 0,
					"HideDoor2", 0,
					"HideDoor3", 0,
					"HideBackpacks", 1,
					"HideBumper1", _bumper # 0,
					"HideBumper2", _bumper # 1,
					"HideConstruction", selectRandom [0,1],
					"hidePolice", 1,
					"HideServices", 1,
					"BeaconsStart", 0,
					"BeaconsServicesStart", 0
				]

			] call BIS_fnc_initVehicle;

			_veh setObjectTextureGlobal [0, selectRandom txtrOffR01];
		};

		if (_class isEqualTo "C_Offroad_01_F") exitWith
		{
			private _bumper = selectRandom [[1,0], [0,1]];
			[
				_veh,
				[selectRandom ["Beige","Blue","Darkred","Red","White","Green"],1], 
				[
					"HideDoor1", 0,
					"HideDoor2", 0,
					"HideDoor3", 0,
					"HideBackpacks", 1,
					"HideBumper1", _bumper # 0,
					"HideBumper2", _bumper # 1,
					"HideConstruction", selectRandom [0,1],
					"hidePolice", 1,
					"HideServices", 1,
					"BeaconsStart", 0,
					"BeaconsServicesStart",0
			]

			] call BIS_fnc_initVehicle;

			_trgPos = [0,9.65,-0.94];
		};

		if (_class isEqualTo "C_Offroad_01_covered_F") exitWith
		{
			_bumper = selectRandom [[1,0], [0,1]];
			[
				_veh,
				[selectRandom ["Green", "Black"], 1], 
				[
					"hidePolice", 1,
					"HideServices", 1,
					"HideCover", 0,
					"StartBeaconLight", 0,
					"HideRoofRack", selectRandom [1,0],
					"HideLoudSpeakers", 1,
					"HideAntennas", 1,
					"HideBeacon", 1,
					"HideSpotlight", 1,
					"HideDoor3", 0,
					"OpenDoor3", 0,
					"HideDoor1", 0,
					"HideDoor2", 0,
					"HideBackpacks", 1,
					"HideBumper1", _bumper # 0,
					"HideBumper2", _bumper # 1,
					"HideConstruction", 0,
					"BeaconsStart", 0
				]

			] call BIS_fnc_initVehicle;

			_trgPos = [0,9.65,-0.94];
		};

		if (_class isEqualTo "C_Hatchback_01_F") exitWith
		{
			[
				_veh,
				[selectRandom ["Beige","Dark","Blue","Black","Grey","Green","Yellow"],1], 
				true

			] call BIS_fnc_initVehicle;
		};
		if (_class isEqualTo "C_Hatchback_01_sport_F") exitWith
		{
			[
				_veh,
				[selectRandom ["Beige","Blue","Red","White","Green"],1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_veh,
			[selectRandom ["Black","White","Orange","Green","Blue","Brown"],1], 
			[
				"hideBullbar",selectRandom [0,1],
				"hideFenders",selectRandom [0,1],
				"hideHeadSupportRear",selectRandom [0,1],
				"hideHeadSupportFront",selectRandom [0,1],
				"hideRollcage",selectRandom [0,1],
				"hideSeatsRear",selectRandom [0,1],
				"hideSpareWheel",selectRandom [0,1]
			]

		] call BIS_fnc_initVehicle;
	};
*/

	if !(_this isEqualTo 0) then
	{
		[_veh,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	};
	_veh call DK_fnc_init_veh;

	CNTVEH(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTVEH(-1);

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

		CNTVEH(-1);
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
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_crtVPK_VANT = {

	_veh = crtV(classVT);

	private _tire = selectRandom [0,1,1];
	[
		_veh,
		[selectRandom ["Orange","Masked","White","Red","Syndikat","Blue","Green"],1], 
		[
			"side_protective_frame_hide",selectRandom [0,1],
			"front_protective_frame_hide",selectRandom [0,1],
			"spare_tyre_holder_hide",_tire,
			"spare_tyre_hide",_tire
		]

	] call BIS_fnc_initVehicle;

	[_veh,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_init_veh;

	CNTVEH(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTVEH(-1);

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

		CNTVEH(-1);
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
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_crtVPK_LT = {

	private _class = classLT;

	_veh = crtV(_class);

	call
	{
		if (_class isEqualTo "C_Van_01_transport_F") exitWith
		{
			[
				_veh,
				[selectRandom ["Black","Red","White"],1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_veh,
			[selectRandom ["Black","White","Red"],1], 
			true

		] call BIS_fnc_initVehicle;
	};

	[_veh,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_init_veh;

	CNTVEH(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTVEH(-1);

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

		CNTVEH(-1);
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
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_crtVPK_REPAIR = {

	_veh = crtV(classREP);

	[_veh,7,(_this # 1) + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_init_veh;

	CNTVEH(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTVEH(-1);

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

		CNTVEH(-1);
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
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};

DK_fnc_crtVPK_FUELT = {

	_veh = crtV(classFUELT);

	[_veh,7,(_this # 1) + 25,true] spawn DK_fnc_addVehTo_CUM;
	_veh call DK_fnc_initTruckFuelTank;

	[
		_veh,
		["Red_v2",1], 
		true

	] call BIS_fnc_initVehicle;

	CNTVEH(1);

	_id1 = _veh addEventHandler ["deleted",
	{
		CNTVEH(-1);

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

		CNTVEH(-1);
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
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_veh
};


DK_fnc_CLAG_crtCivGS = {

	params ["_mkrPos", "_logic"];


	if ( (damage (_logic getVariable "pump")) isEqualTo 1 OR (damage (_logic getVariable "roof")) isEqualTo 1 ) exitWith
	{
		logicGasDel(_logic);
		deleteVehicle _logic;
	};	


	if !( PlaceOK(_mkrPos,4,3) ) exitWith
	{
		DK_CLAG_arr_lgcsWtGas pushBackUnique [_logic, (time + slpPlacTake)];
	};

	_dis = _logic getVariable "choiceDis";

	_civ01 = crtCIV;
	private "_veh";
	call
	{
		if (selectRandom [0,0,0,0,1] isEqualTo 1) exitWith
		{
			_veh = crtVPKLT(_dis);
		};

		_veh = crtVPKCLV(_dis);
	};

	_veh setDir	((_logic getVariable "dir") + (selectRandom [90,-90]));
	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;

	[_civ01,slctAnimsBC] remoteExecCall ["DK_fnc_AnimSwitch", 0];
	_civ01 setPos (_logic getVariable "mkrPos2");
	_civ01 setDir (_civ01 getRelDir _veh);

	[_veh,_civ01] call DK_fnc_CLAG_EH_vehicleGS;

	_grpAry = [_civ01];

	_civ01 allowDamage true;
	_civ01 setVariable ["DK_behaviour", "chat"];
	_civ01 setVariable ["DK_logic", _logic];
	_civ01 setVariable ["DK_sittingBench", false];
	_civ01 setVariable ["DK_inChurch", false];


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civ01,_dis] call DK_fnc_addEH_CivFoot;


	/// // WAITING
	[_civ01,_logic,_mkrPos] spawn
	{
		params ["_civ01","_logic","_mkrPos"];


		uiSleep 2;
		_civ01 enableDynamicSimulation true;

		if (isDedicated) then
		{
			[0.3,[_civ01],_civ01] spawn DK_fnc_CLAG_trgHurtCiv;
		};

		DK_CLAG_arr_lgcsWtBehaGas pushBackUnique [[_logic, (slpPuBa / 2), _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];
	};
};

DK_fnc_CLAG_crtCivGarageCar =  {

	params ["_mkrPos","_logic"];


	if (damage (_logic getVariable "garage") isEqualTo 1) exitWith
	{
		logicGasDel(_logic);
		deleteVehicle _logic;
	};	


//	if !( PlaceOK(_mkrPos,6.5,5) ) exitWith
	if !( PlaceOK(_mkrPos,8,5) ) exitWith
	{
		DK_CLAG_arr_lgcsWtGas pushBackUnique [_logic, (time + slpPlacTake)];
	};

	private "_veh";

	private _dis = _logic getVariable "choiceDis";

	call
	{
		if (selectRandom [true, false]) exitWith
		{
			_veh = crtVPKFUELT(_mkrPos,_dis);
		};

		_veh = crtVPKREP(_mkrPos,_dis);
	};

	_veh setDir	((_logic getVariable "dir") - 25 + (random 50));
//	_veh setDir	(_logic getVariable "dir") + (selectRandom [70 + (random 50),-70 - (random 50)]);
//	_veh setVehiclePosition [_mkrPos, [], 0, "NONE"];

	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;


	/// // WAITING
	[_logic, _mkrPos] spawn
	{
		params ["_logic", "_mkrPos"];


		uiSleep 7;

		DK_CLAG_arr_lgcsWtBehaGas pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _logic, "no"];
	};
};

DK_fnc_CLAG_crtCivGarageRep = {

	params ["_mkrPos","_logic"];


	if (damage (_logic getVariable "garage") isEqualTo 1) exitWith
	{
		logicGasDel(_logic);
		deleteVehicle _logic;
	};	


	if !( PlaceOK(_mkrPos,4,3) ) exitWith
	{
		DK_CLAG_arr_lgcsWtGas pushBackUnique [_logic, (time + slpPlacTake)];
	};

	_dis = _logic getVariable "choiceDis";
	_dir = _logic getVariable "dir";

	_civ01 = crtREP;
	_veh = crtVPKCLV(_dis);

	_veh disableCollisionWith _civ01;
	_civ01 disableCollisionWith _veh;

	_veh setDir	(_dir + (selectRandom [0,180]));
	_veh setPos (_logic getVariable "mkrPos2");

	[_civ01,"HubFixingVehicleProne_idle1"] remoteExecCall ["DK_fnc_AnimSwitch", 0];
	_civ01 setDir _dir + 180;
	_civ01 setPos _mkrPos;

	[_veh,_civ01] call DK_fnc_CLAG_EH_vehicleGS;
	_veh setHitPointDamage ["hitengine", 0.2 + (random 0.7)];

	_grpAry = [_civ01];

	_civ01 setVariable ["DK_behaviour", "chat"];
	_civ01 setVariable ["DK_logic", _logic];
	_civ01 setVariable ["DK_sittingBench", false];
	_civ01 setVariable ["DK_inChurch", false];


	_logic setVariable ["DK_behaviour", "chat"];
	_logic setVariable ["DK_group", _grpAry];

	///	// ADD EVENT HANDLER & IN CLEAN UP MANAGER
	[_civ01,_dis] call DK_fnc_addEH_CivFoot;


	/// // WAITING
	[_civ01,_logic,_mkrPos, _veh] spawn
	{
		_civ01 = _this # 0;
		_logic = _this # 1;
		_mkrPos = _this # 2;


		uiSleep 2;

		_this # 3 enableCollisionWith _civ01;
		_civ01 enableCollisionWith _this # 3;
		_civ01 enableDynamicSimulation true;
		_civ01 allowDamage true;

		DK_CLAG_arr_lgcsWtBehaGas pushBackUnique [[_logic, slpPuBa, _mkrPos, (_logic getVariable "choiceDis") + 5], _civ01, "chat"];

/*		while { ((_civ01 getVariable "DK_behaviour") isEqualTo "chat") } do
		{
			sleep 5;
		};

		_behaLogic = _logic getVariable "DK_behaviour";
		if (_behaLogic isEqualTo "flee") then
		{
			uiSleep slpFlee;
		};
		if (_behaLogic isEqualTo "dead") then
		{
			uiSleep slpDead;
		};

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 6 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.02;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 6;
		};

		logicGasPuBa(_logic);
*/	};
};



/// -- EVENT HANDLERS -- \\\

// Add Event Handler
DK_fnc_addEH_CivFoot = {

	params ["_unit", "_dis"];


	_unit addEventHandler ["firedNear",
	{
		params ["_unit", "_shooter", "_dis"];

		[_unit,_shooter,_dis] spawn
		{
			params ["_unit","_shooter","_dis"];

			if (_dis < 45) exitWith
			{
				_unit removeAllEventHandlers "firedNear";
				_unit removeAllEventHandlers "Hit";
				uiSleep 0.2;

				[_unit,_shooter,false] call DK_fnc_EH_Flee_CivFoot;
			};
			if ([vehicle _unit, "IFIRE", vehicle _shooter] checkVisibility [eyePos _unit, eyePos _shooter] > 0) then
			{
				_unit removeAllEventHandlers "firedNear";
				_unit removeAllEventHandlers "Hit";
				uiSleep 0.2;

				[_unit,_shooter,false] call DK_fnc_EH_Flee_CivFoot;
			};
		};
	}];

	_unit addEventHandler ["Hit",
	{
		params ["_unit", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		[_unit, _instigator, true] call DK_fnc_EH_Flee_CivFoot;
	}];

	_unit addEventHandler ["Killed",
	{
		params ["_unit", "_killer"];

		_unit removeEventHandler ["Killed", _thisEventHandler];

		[_unit,_killer,true] call DK_fnc_EH_Flee_CivFoot;

		[_unit, 20, 10, true] spawn DK_fnc_addAllTo_CUM;
	}];


	[_unit, 7, _dis + 25,true] spawn DK_fnc_addAllTo_CUM;
};

DK_fnc_addEH_CivPed = {

	params ["_unit", "_dis"];


	_unit addEventHandler ["firedNear",
	{
		params ["_unit", "_shooter", "_dis"];

		[_unit, _shooter, _dis] spawn
		{
			params ["_unit", "_shooter", "_dis"];


			if (_dis < 45) exitWith
			{
				_unit removeAllEventHandlers "firedNear";
				_unit removeAllEventHandlers "Hit";
				uiSleep 0.2;

				[_unit,_shooter,false] call DK_fnc_EH_Flee_CivPed;
			};
			if ([vehicle _unit, "IFIRE", vehicle _shooter] checkVisibility [eyePos _unit, eyePos _shooter] > 0) then
			{
				_unit removeAllEventHandlers "firedNear";
				_unit removeAllEventHandlers "Hit";
				uiSleep 0.2;

				[_unit,_shooter,false] call DK_fnc_EH_Flee_CivPed;
			};
		};
	}];

	_unit addEventHandler ["Hit",
	{
		params ["_unit", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		[_unit, _instigator, true] call DK_fnc_EH_Flee_CivPed;
	}];

	_unit addEventHandler ["Killed",
	{
		params ["_unit", "_shooter"];


		_unit removeEventHandler ["Killed", _thisEventHandler];

		[_unit, _shooter, true] call DK_fnc_EH_Flee_CivPed;

		[_unit, 20, 10, true] spawn DK_fnc_addAllTo_CUM;
	}];


	[_unit, 7, _dis + 25, true] spawn DK_fnc_addAllTo_CUM;
};

DK_fnc_addEH_CivPedBandit = {

	params ["_unit", "_dis"];


	_unit addEventHandler ["firedNear",
	{
		params ["_unit", "_shooter", "_dis"];


		[_unit, _shooter, _dis] spawn
		{
			params ["_unit", "_shooter", "_dis"];


			if (_dis < 45) exitWith
			{
				_unit removeAllEventHandlers "firedNear";
				_unit removeAllEventHandlers "Hit";
				uiSleep 0.2;

				[_unit,_shooter,false] call DK_fnc_EH_Flee_CivPedBandit;
			};
			if ([vehicle _unit, "IFIRE", vehicle _shooter] checkVisibility [eyePos _unit, eyePos _shooter] > 0) then
			{
				_unit removeAllEventHandlers "firedNear";
				_unit removeAllEventHandlers "Hit";
				uiSleep 0.2;

				[_unit,_shooter,false] call DK_fnc_EH_Flee_CivPedBandit;
			};
		};
	}];

	_unit addEventHandler ["Hit",
	{
		params ["_unit", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		[_unit, _instigator, true] call DK_fnc_EH_Flee_CivPedBandit;
	}];

	_unit addEventHandler ["Killed",
	{
		params ["_unit", "_shooter"];


		_unit removeEventHandler ["Killed", _thisEventHandler];

		[_unit, _shooter, true] call DK_fnc_EH_Flee_CivPedBandit;

		[_unit, 25, 16, true] spawn DK_fnc_addAllTo_CUM;
	}];


	[_unit, 7, _dis * 1.7, true] spawn DK_fnc_addAllTo_CUM;
};

DK_fnc_addEH_animeState_Flee = {

	_this removeAllEventHandlers "AnimStateChanged";
	_this addEventHandler ["AnimStateChanged",
	{
		params ["_unit","_curAnim"];


		if ( (_curAnim isEqualTo "apanpercmwlksnonwnondf") OR (_curAnim isEqualTo "amovpercmwlksnonwnondf") OR (_curAnim isEqualTo "amovpercmstpsnonwnonDnon") ) exitWith
		{
			_unit playmovenow "ApanPercMstpSnonWnonDnon_ApanPknlMstpSnonWnonDnon";
		};
		if (_curAnim isEqualTo "apanpknlmstpsnonwnondnon") exitWith 
		{
			_unit playmovenow "apanpknlmstpsnonwnondnon";
			_unit removeAllEventHandlers "AnimStateChanged";
		};
		if (_curAnim isEqualTo "amovppnemstpsnonwnondnon") exitWith 
		{
			_unit playmovenow "ApanPpneMstpSnonWnonDnon";
			_unit removeAllEventHandlers "AnimStateChanged";
		};
	}];

	uiSleep (1 + (random 1));
	if ((animationState _this) isEqualTo "amovpercmstpsnonwnonDnon") then
	{
		_this playmovenow "ApanPercMstpSnonWnonDnon";
	};

	uiSleep 1;
	if ((animationState _this) isEqualTo "amovpercmstpsnonwnonDnon") then
	{
		_this playmovenow "ApanPercMstpSnonWnonDnon";
	};
};

DK_fnc_CLAG_EH_vehicleGS = {

	params ["_veh"];


	_veh setVariable ["DK_CLAG_civLinked", _this # 1];

	_veh addEventHandler ["deleted",
	{
		params ["_entity"];


		private _civLinked = _entity getVariable "DK_CLAG_civLinked";

		if (_civLinked getVariable "DK_behaviour" isEqualTo "chat") then
		{
			_civLinked enableDynamicSimulation false;
			_civLinked setVariable ["DK_behaviour", "walk"];

			_civLinked spawn
			{
				sleep (random 0.7);
				if (alive _this) then
				{
					[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};
			};

			_civLinked enableAI "MOVE";
			_civLinked setUnitPos "UP";
			_civLinked forceWalk true;
			_civLinked setSpeedMode "NORMAL";
			_civLinked allowFleeing 0;

			[_civLinked,_civLinked,500] spawn DK_fnc_rdm_civPanic_MoveTo;

			_civLinked forceSpeed (_civLinked getSpeed "SLOW");
		};
	}];

	_id = _veh addEventHandler ["GetIn",
	{
		params ["_veh"];


		_veh removeEventHandler ["GetIn", _thisEventHandler];
		_veh removeAllEventHandlers "Hit";
		_veh removeAllEventHandlers "EpeContactStart";
		_veh removeAllEventHandlers "Deleted";

		[_veh getVariable "DK_CLAG_civLinked",_veh,false] call DK_fnc_EH_Flee_CivFoot;
	}];

	_veh setVariable ["DK_CLAG_idEHgetIn", _id];

	_veh addEventHandler ["Hit",
	{
		params ["_veh", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		_veh removeAllEventHandlers "Hit";
		_veh removeAllEventHandlers "EpeContactStart";
		_veh removeEventHandler ["GetIn", _veh getVariable "DK_CLAG_idEHgetIn"];
		_veh removeAllEventHandlers "Deleted";

		[_veh getVariable "DK_CLAG_civLinked", _instigator, false] call DK_fnc_EH_Flee_CivFoot;
	}];

	_veh addEventHandler ["EpeContactStart",
	{
		params ["_veh", "_shooter"];

		_veh removeAllEventHandlers "EpeContactStart";
		_veh removeAllEventHandlers "Hit";
		_veh removeEventHandler ["GetIn", _veh getVariable "DK_CLAG_idEHgetIn"];
		_veh removeAllEventHandlers "Deleted";

		[_veh getVariable "DK_CLAG_civLinked", _shooter, true] call DK_fnc_EH_Flee_CivFoot;
	}];
};


// Scripts inside EH
DK_fnc_EH_Flee_CivFoot = {

	params ["_unit","_shooter","_checkNrst"];


	private _logic = _unit getVariable "DK_logic";

	if (_unit getVariable "DK_behaviour" isEqualTo "dead") exitWith {};

	_unit removeAllEventHandlers "firedNear";
	_unit removeAllEventHandlers "Hit";

	_unit enableDynamicSimulation false;

	private _trgHurt = _unit getVariable ["trgHurtCiv", "empty"];
	if !(_trgHurt isEqualTo "empty") then
	{
		deleteVehicle _trgHurt;
	};


	call
	{
	/// // IF CIV's Is DEAD
		if (!alive _unit) exitWith
		{
			_unit setVariable ["DK_behaviour", "dead"];
			
			if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
			{
				_logic setVariable ["DK_behaviour", "dead"];
			};

			_unit playMoveNow "AidlPercMstpSrasWrflDnon_AI";

			_unit spawn
			{
				uiSleep 0.5;

				if ((toLower (animationState _this)) call DK_fnc_CLAG_schAnim) then
				{
					[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};
			};
		};
	/// // IF CIV's Is CHATING
		if (_unit getVariable ["DK_behaviour", ""] isEqualTo "chat") exitWith
		{
			if (alive _unit) exitWith
			{
				[_unit,_shooter] call DK_fnc_EH_commonFlee_CivFoot;

				if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
				{
					_logic setVariable ["DK_behaviour", "flee"];
				};
			};
		};

	///	// IF CIV's Is WALKING
		if (_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") exitWith
		{
			if (alive _unit) exitWith
			{
				[_unit,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
				if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
				{
					_logic setVariable ["DK_behaviour", "flee"];
				};
			};
		};
	};



	// EXEC To CIV's GROUP & NEAREST Other CIV
	private _grpAry = _logic getVariable "DK_group";
	private _nil = _grpAry deleteAt (_grpAry find _unit);

	if (isNil "_grpAry") exitWith {};

	[_grpAry,_shooter,_checkNrst,_unit] spawn
	{
		params ["_grpAry","_shooter","_checkNrst","_unit"];

		sleep (random 0.5);
		{
			call
			{
				if (_x getVariable ["DK_behaviour", ""] isEqualTo "chat") exitWith
				{
					_x removeAllEventHandlers "firedNear";
					[_x,_shooter] call DK_fnc_EH_commonFlee_CivFoot;
				};
				if (_x getVariable ["DK_behaviour", ""] isEqualTo "simpleAnim") then
				{
					_x enableAI "ANIM";
					_x removeAllEventHandlers "firedNear";
					[_x,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
				};
			};

			sleep 0.25;

		} count _grpAry;

		if _checkNrst then
		{
			private _nearestS = (_unit nearEntities ["Man", 12]) - _grpAry - [_unit];
			{
				private _nearUnit = _x;

				if (_nearUnit getVariable ["DK_side", ""] isEqualTo "civ") then
				{
					{
						call
						{
							if (_x getVariable ["DK_behaviour", ""] isEqualTo "chat") exitWith
							{
								_x removeAllEventHandlers "firedNear";
								_nil = [_x,_shooter] call DK_fnc_EH_commonFlee_CivFoot;
							};
							if (_x getVariable ["DK_behaviour", ""] isEqualTo "simpleAnim") then
							{
								_x enableAI "ANIM";
								_x removeAllEventHandlers "firedNear";
								_nil = [_x,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
							};
						};

					} count ((_nearUnit getVariable "DK_logic") getVariable ["DK_group", []]);


					if (_nearUnit getVariable ["DK_behaviour", ""] isEqualTo "chat") exitWith
					{
						_nearUnit removeAllEventHandlers "firedNear";
						[_nearUnit,_shooter] call DK_fnc_EH_commonFlee_CivFoot;
						sleep 0.2;
					};
					if (_nearUnit getVariable ["DK_behaviour", ""] isEqualTo "simpleAnim") then
					{
						_nearUnit enableAI "ANIM";
						_nearUnit removeAllEventHandlers "firedNear";
						[_nearUnit,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
						sleep 0.2;
					};
				};

			} count _nearestS;
		};
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		deleteMarker (_unit getVariable "mkr_DEBUG");
	};
/// // DEBUG MOD END

};

DK_fnc_EH_Flee_CivPed = {

	params ["_unit","_shooter","_bool"];


	private _logic = _unit getVariable "DK_logic";

	if (_unit getVariable ["DK_behaviour", ""] isEqualTo "dead") exitWith {};

	_unit removeAllEventHandlers "firedNear";
	_unit removeAllEventHandlers "Hit";

	_unit enableDynamicSimulation false;

	call
	{
		if (hasInterface) exitWith
		{
			_unit remoteExecCall ["removeAllActions", 0];
		};

		_unit remoteExecCall ["removeAllActions", -2];
	};


	call
	{
	///	// IF CIV's Is WALKING
		if (_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") exitWith
		{
			if (alive _unit) exitWith
			{
				[_unit,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
				if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
				{
					_logic setVariable ["DK_behaviour", "flee"];
				};
			};
		};

	/// // IF CIV's Is DEAD
		if (!alive _unit) exitWith
		{
			_unit setVariable ["DK_behaviour", "dead"];
			
			if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
			{
				_logic setVariable ["DK_behaviour", "dead"];
			};

			_unit playMoveNow "AidlPercMstpSrasWrflDnon_AI";

			_unit spawn
			{
				uiSleep 0.5;

				if ((toLower (animationState _this)) call DK_fnc_CLAG_schAnim) then
				{
					[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};
			};
		};

	///	// IF CIV's use BINOC or SITTING GROUND
		if (_unit getVariable ["DK_behaviour", ""] isEqualTo "simpleAnim") exitWith
		{
			if (alive _unit) exitWith
			{
				_unit enableAI "ANIM";
				[_unit,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
				if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
				{
					_logic setVariable ["DK_behaviour", "flee"];
				};
			};
		};

	/// // IF CIV's Is CHATING
		if (_unit getVariable "DK_behaviour" isEqualTo "chat") exitWith
		{
			if (alive _unit) exitWith
			{
				[_unit,_shooter] call DK_fnc_EH_commonFlee_CivFoot;

				if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
				{
					_logic setVariable ["DK_behaviour", "flee"];
				};
			};
		};
	};



	// EXEC To CIV's GROUP & NEAREST Other CIV
	[_shooter,_bool,_unit] spawn
	{
		_shooter = _this # 0;

		sleep (random 0.5);

		if (_this # 1) then
		{
			_unit = _this # 2;

			private _nearestS = (_unit nearEntities ["Man", 12]) - [_unit];
			{
				if (_x getVariable "DK_side" isEqualTo "civ") then
				{
/*					if not (_x getVariable "DK_behaviour" isEqualTo "flee") then
					{
						[_x,_shooter,true] call DK_fnc_EH_Flee_CivFoot;
						sleep 0.25;
					};
*/
					if (_x getVariable ["DK_behaviour", ""] isEqualTo "chat") exitWith
					{
						_x removeAllEventHandlers "firedNear";
						[_x,_shooter] call DK_fnc_EH_commonFlee_CivFoot;
						sleep 0.2;
					};
					if (_x getVariable ["DK_behaviour", ""] isEqualTo "simpleAnim") then
					{
						_x enableAI "ANIM";
						_x removeAllEventHandlers "firedNear";
						[_x,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
						sleep 0.2;
					};
				};

			} count _nearestS;
		};
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		deleteMarker (_unit getVariable "mkr_DEBUG");
	};
/// // DEBUG MOD END

};

DK_fnc_EH_Flee_CivPedBandit = {

	params ["_unit","_shooter","_bool"];
//	_unit = _this # 0;
//	_shooter = _this # 1;


	private _logic = _unit getVariable "DK_logic";

	if (_unit getVariable ["DK_behaviour", ""] isEqualTo "dead") exitWith {};

	_unit removeAllEventHandlers "firedNear";
	_unit removeAllEventHandlers "Hit";


	call
	{
	///	// IF CIV's Is WALKING
		if (_unit getVariable ["DK_behaviour", ""] isEqualTo "walk") exitWith
		{
			if (alive _unit) exitWith
			{
				[_unit,_shooter] call DK_fnc_EH_commonFlee_CivBanditWalking;
				if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
				{
					_logic setVariable ["DK_behaviour", "flee"];
				};
			};
		};

	/// // IF CIV's Is DEAD
		if (!alive _unit) exitWith
		{
			_unit setVariable ["DK_behaviour", "dead"];
			
			if !(_logic getVariable ["DK_behaviour", ""] isEqualTo "dead") then
			{
				_logic setVariable ["DK_behaviour", "dead"];
			};

			_unit playMoveNow "AidlPercMstpSrasWrflDnon_AI";

			_unit spawn
			{
				uiSleep 0.5;

				if ((toLower (animationState _this)) call DK_fnc_CLAG_schAnim) then
				{
					[_this,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
				};
			};
		};
	};


	// EXEC To CIV's GROUP & NEAREST Other CIV
	[_shooter,_bool,_unit] spawn
	{
		_shooter = _this # 0;

		sleep (random 0.5);

		if (_this # 1) then
		{
			_unit = _this # 2;

			private _nearestS = (_unit nearEntities ["Man", 12]) - [_unit];
			{
				if (_x getVariable "DK_side" isEqualTo "civ") then
				{
					if (_x getVariable ["DK_behaviour", ""] isEqualTo "chat") exitWith
					{
						_x removeAllEventHandlers "firedNear";
						[_x,_shooter] call DK_fnc_EH_commonFlee_CivFoot;
						sleep 0.2;
					};
					if (_x getVariable ["DK_behaviour", ""] isEqualTo "simpleAnim") then
					{
						_x enableAI "ANIM";
						_x removeAllEventHandlers "firedNear";
						[_x,_shooter] call DK_fnc_EH_commonFlee_CivFootWalking;
						sleep 0.2;
					};
				};

			} count _nearestS;
		};
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		deleteMarker (_unit getVariable "mkr_DEBUG");
	};
/// // DEBUG MOD END

};


DK_fnc_EH_commonFlee_CivFootWalking = {

	params ["_unit","_shooter"];
//	_unit = _this # 0;
//	_shooter = _this # 1;


	_unit setVariable ["DK_behaviour", "flee"];
	_unit enableDynamicSimulation false;
	[_unit,7,disDelFlee,true] spawn DK_fnc_addAllTo_CUM;
	doStop _unit;
//	_unit setBehaviour "AWARE";

	private "_styleFlee";
	call
	{
		if (_shooter getVariable "DK_side" isEqualTo "cops") exitWith
		{
			_styleFlee = selectRandom [1,2,3];
		};

		_styleFlee = selectRandom [1,2,3,4,5];
	};

	if (selectRandom [0,1,0] isEqualTo 1) then
	{
		_unit doWatch _shooter;
		_unit spawn
		{
			uiSleep 2;
			_this doWatch objNull;
		};
	};

	_unit spawn DK_fnc_vocCiv_Panic;
	_unit enableAI "MOVE";
	_unit forceWalk false;
	_unit setSpeedMode "FULL";
	_unit allowFleeing 1;


	call
	{
		if (_styleFlee > 1) exitWith
		{
			[_unit,(_this # 1),500] spawn DK_fnc_rdm_civPanic_MoveTo;

			_unit forceSpeed (_unit getSpeed "FAST");

			call
			{
				if (selectRandom [true,false]) exitWith
				{
					_unit spawn DK_fnc_addEH_animeState_Flee;
				};

				_unit setUnitPos "UP";
			};
		};

		[_unit,_shooter] spawn
		{
			_unit = _this # 0;

			uiSleep (random 1.1);
			if (alive _unit) then
			{
				[_unit,_this # 1] call DK_fnc_copsShooting_CivFoot;
			};
		};
	};
};

DK_fnc_EH_commonFlee_CivFoot = {

	params ["_unit","_shooter"];
//	_unit = _this # 0;
//	_shooter = _this # 1;


	private _sit = _unit getVariable "DK_sittingBench";

	_unit setVariable ["DK_behaviour", "flee"];
	_unit enableDynamicSimulation false;
	[_unit,7,disDelFlee,true] spawn DK_fnc_addAllTo_CUM;
	doStop _unit;

	if (selectRandom [true,false]) then
	{
		_unit doWatch _shooter;
		_unit spawn
		{
			uiSleep 2;
			_this doWatch objNull;
		};
	};

	_unit spawn DK_fnc_vocCiv_Panic;
	_unit forceWalk false;
	_unit setSpeedMode "FULL";
	_unit allowFleeing 1;

	private "_styleFlee";
	call
	{
		if !(_sit) exitWith
		{
			_unit enableAI "MOVE";

			call
			{
				if (_shooter getVariable "DK_side" isEqualTo "cops") exitWith
				{
					_styleFlee = selectRandom [1,2,3];
				};

				_styleFlee = selectRandom [1,2,3,4,5];
			};
		};

		_styleFlee = 2;
		_unit setUnitPos "UP";
		_unit setPos (_unit modelToWorldVisual [0,0.4 + (random 0.2),0]);
	};

	if ( !(_styleFlee isEqualTo 1) OR (_unit getVariable "DK_inChurch")) then
	{
		_unit setUnitPos "UP";

		[_unit,_shooter,500] spawn DK_fnc_rdm_civPanic_MoveTo;

		_unit forceSpeed (_unit getSpeed "FAST");

		if ((_unit getVariable "DK_inChurch") OR (selectRandom [1,2] isEqualTo 1)) then
		{
			_unit spawn DK_fnc_addEH_animeState_Flee;
		};
	};

	[_unit,_shooter,_styleFlee,_sit] spawn
	{
		_unit = _this # 0;
		_shooter = _this # 1;
		_sit = _this # 3;

		if !(_sit) then
		{
			sleep (random 0.9);
		};

		if ((toLower (animationState _unit)) call DK_fnc_CLAG_schAnim) then
		{
			[_unit,""] remoteExecCall ["DK_fnc_AnimSwitch", 0];
		};

		if (alive _unit) then
		{
			if (_sit) then
			{
				_unit enableAI "MOVE";
			};

			if ((_this # 2) isEqualTo 1) then
			{
				[_unit,_shooter] call DK_fnc_copsShooting_CivFoot;
			};
		};
	};
};

DK_fnc_EH_commonFlee_CivBanditWalking = {

	params ["_unit","_shooter"];
//	_unit = _this # 0;
//	_shooter = _this # 1;


	_unit setVariable ["DK_behaviour", "flee"];
	[_unit,7,disDelFlee,true] spawn DK_fnc_addAllTo_CUM;

	private "_styleFlee";
	call
	{
		if (_shooter getVariable "DK_side" isEqualTo "cops") exitWith
		{
			_styleFlee = selectRandom [1,2,3];
		};

		_styleFlee = selectRandom [1,2,3,4,5];
	};

	if (selectRandom [false,false,true]) then
	{
		_unit lookAt _shooter;
		_unit doWatch _shooter;
		_unit glanceAt _shooter;
	};

	_unit spawn DK_fnc_vocCiv_Panic;
	_unit forceWalk false;
	_unit setSpeedMode "FULL";
	_unit allowFleeing 1;


	call
	{
		if (_styleFlee > 1) exitWith
		{
			[_unit,_shooter,250] spawn DK_fnc_rdm_civBanditPanic_DoMove;

			_unit forceSpeed (_unit getSpeed "FAST");

			call
			{
				if (selectRandom [true,false]) exitWith
				{
					_unit spawn DK_fnc_addEH_animeState_Flee;
				};

				_unit setUnitPos "UP";
			};
		};

		[_unit,_shooter] spawn
		{
			_unit = _this # 0;

			sleep (random 1.1);
			if (alive _unit) then
			{
				[_unit,_this # 1] call DK_fnc_copsShooting_CivFoot;
			};
		};
	};
};


DK_fnc_copsShooting_CivFoot = {

	params ["_unit","_shooter"];


	sleep 0.1;

	_unit setUnitPos "DOWN";
	_unit playMove (selectRandom ["ApanPpneMstpSnonWnonDnon_G01","ApanPpneMstpSnonWnonDnon_G02","ApanPpneMstpSnonWnonDnon_G03"]);
	sleep 0.1;

	_unit disableAI "PATH";
	sleep 3 + (random 120);

	if (alive _unit) then
	{
		_unit enableAI "PATH";
		_unit setUnitPos (selectRandom ["DOWN","MIDDLE","UP"]);
		sleep 5 + (random 20);

		if (alive _unit) then
		{
			_unit setUnitPos (selectRandom ["MIDDLE","UP","UP"]);
			[_unit,_shooter,500] spawn DK_fnc_rdm_civPanic_MoveTo;
		};
	};
};

/*
DK_fnc_CLAG_schAnim = {

	if ( not ((anmsChat_A find _this) isEqualTo -1) OR not ((anmsChat_B find _this) isEqualTo -1) OR not ((anmsChat_C find _this) isEqualTo -1) OR
		 not ((anmsBench_A find _this) isEqualTo -1) OR not ((anmsBench_B find _this) isEqualTo -1) OR not ((anmsBench_C find _this) isEqualTo -1) OR not ((anmsBnchChurch find _this) isEqualTo -1) OR ("amovpsitmstpsnonwnondnon_ground" isEqualTo _this) OR
		 not ((anmsBoss find _this) isEqualTo -1) OR ("hubfixingvehicleprone_idle1" isEqualTo _this) OR ("acts_carfixingwheel" isEqualTo _this)

	   ) exitWith
	{
		true
	};
	false
};
*/
DK_fnc_CLAG_schAnim = {

	if ( (_this in anmsChat_A ) OR (_this in anmsChat_B) OR (_this in anmsChat_C) OR (_this in anmsBench_A) OR (_this in anmsBench_B) OR (_this in anmsBench_C) OR (_this in anmsBnchChurch) OR ("amovpsitmstpsnonwnondnon_ground" isEqualTo _this) OR
		 (_this in anmsBoss) OR ("hubfixingvehicleprone_idle1" isEqualTo _this) OR ("acts_carfixingwheel" isEqualTo _this)

	   ) exitWith
	{
		true
	};
	false
};

if (isNil "DK_fnc_4_chatting") then
{
	DK_fnc_4_chatting = {

		params ["_unit01","_unit02","_unit03","_unit04"];

		_unit02 attachTo [_unit01, [1.4 + (random 0.8) - 0.4,0,0]];
		_unit03 attachTo [_unit01, [0 + (random 0.8) - 0.4,1.4,0]];
		_unit04 attachTo [_unit01, [1.4 + (random 0.8) - 0.4,1.4,0]];

		_unit01 setDir ((_unit01 getRelDir _unit03) + (random 20));
		_unit02 setDir ((_unit02 getRelDir _unit04) - (random 20));
		_unit03 setDir ((_unit03 getRelDir _unit01) - (random 20));
		_unit04 setDir ((_unit04 getRelDir _unit02) + (random 20));
	};
};
