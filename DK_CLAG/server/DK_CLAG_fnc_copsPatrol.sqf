if (!isServer) exitWith {};

#define DelInCUM(TODEL) _nul = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find TODEL)

#define crtV(C) createVehicle [C, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]
#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]

// Max distance for deleting Driver & Vehicle
#define dis DK_CLAG_Default_DisMaxTraffic + 75
//#define eye(X,A) [vehicle X, "IFIRE", A] checkVisibility [eyePos X, getPosASL A] > 0.3
#define eye(X,A) [vehicle A, "IFIRE",vehicle A] checkVisibility [X call DK_fnc_eyePlace, getPosASLVisual A] > 0.3

// Speed limit for Vehicle Driver
#define spdS 55
#define spdM 105

// Count vehicles number

#define CNT(NB) DK_countNb_traffic_CLAG = DK_countNb_traffic_CLAG + NB

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []

// Apply Pushback
#define LogicTraffMainPuBa(LGC) DK_CLAG_LogicsTrafficMain pushBackUnique LGC
#define LogicTraffSecPuBa(LGC) DK_CLAG_LogicsTrafficSec pushBackUnique LGC


// Sleep
#define slpPlacTake 6
#define slpEnd1 5
#define slpEnd2 3.5
#define slpPatrol (90 + (random 120))




DK_fnc_CLAG_crtCopsPatrol = {

	params ["_roadCore", "_playerNrst", ["_isMain", false ]];


	_roadPos = _roadCore # 0;

	if !( PlaceOK(_roadPos,35,25) ) exitWith
	{
		call
		{
			if _isMain exitWith
			{
				DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + slpPlacTake)];
			};

			DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + slpPlacTake)];

		};
	};

	DK_copsPatrol = DK_copsPatrol + 1;

	_roadPos set [2,0];
	private _disAry = [];
	for "_i" from 1 to (count _roadCore) - 1 step 1 do
	{
		_disAry pushBack ((_roadCore # _i) # 0 distance2D _playerNrst);
	};

	private _vehCrew = [] call DK_fnc_crtCopsPatrol;

	_vehCrew params ["_vehicle", "_unitsCrew", "_grp", "_trgPos"];

	private _goodDis = _disAry findIf { (selectMin _disAry) isEqualTo _x };
	if !(_goodDis isEqualTo -1) then
	{
		_vehicle setDir	((_roadCore # (_goodDis + 1)) # 1 );
	};

	_vehicle setPosATL _roadPos;
	_vehicle setVectorUp surfaceNormal _roadPos;

	_vehicle engineOn true;


	call
	{
		if ( (missionNamespace getVariable ["wantedMissionVal", 0] > 0) && { (DK_MIS_var_missInProg) && { !(DK_MIS_allTargets isEqualTo []) } } )  exitWith
		{
			[_vehicle, _unitsCrew] spawn
			{
				params ["_vehicle", "_unitsCrew"];


				_idEHs = _vehicle getVariable "DK_CLAG_idEHs";

				_vehicle removeEventHandler ["EpeContactStart", _idEHs # 0];
				_vehicle removeEventHandler ["Hit", _idEHs # 3];
				_vehicle removeEventHandler ["GetIn", _idEHs # 2];
				_vehicle removeEventHandler ["HandleDamage", _idEHs # 1];
				_vehicle removeEventHandler ["FiredNear", _idEHs # 4];

				uiSleep 0.4;

				if (_unitsCrew isEqualTo []) exitWith {};

				_unitsCrew apply
				{
					_x removeAllEventHandlers "Hit";
					_x removeAllEventHandlers "FiredNear";
					_x setVariable ["DK_behaviour", "chase"];
				};

				[_unitsCrew, _vehicle, selectRandom DK_MIS_allTargets, 2, 20] spawn DK_fnc_startChase_CopsPatrol;
			};
		};

		_vehicle setFuel (0.75 + (random 0.25));
		_vehicle forceFollowRoad true;

		if _isMain exitWith
		{
			private "_roadToGo";
			for "_i" from 0 to 10 step 1 do
			{
				_roadToGo = (selectRandom DK_CLAG_trafficMainRoads) # 0;

				if ((_roadToGo distance2D _roadPos) > 500) exitWith {};
			};

			[_unitsCrew, _vehicle, _grp, _roadToGo, 1000] spawn DK_fnc_wpDriver_copsPatrol_2;

			_vehicle limitSpeed spdM;
		};

		_vehicle limitSpeed spdS;

		if (DK_CLAG_TraffRoadChs isEqualTo 1) exitWith
		{
			DK_CLAG_TraffRoadChs = 2;
			[_unitsCrew, _vehicle, _grp, 1000] spawn DK_fnc_wpDriver_copsPatrol;
		};

		private _road = [getPosWorld _playerNrst, 70] call BIS_fnc_nearestRoad;
		if !(_road isEqualTo objNull) exitWith
		{
			DK_CLAG_TraffRoadChs = 1;
			[_unitsCrew, _vehicle, _grp, getPosATL _road, 1000] spawn DK_fnc_wpDriver_copsPatrol_2;
		};

		[_unitsCrew, _vehicle, _grp, 1000] spawn DK_fnc_wpDriver_copsPatrol;

		[_vehicle, _trgPos] call DK_addTrgHorn_PatrolCops;
	};


	[_vehicle, _roadPos, _roadCore, _unitsCrew, _isMain] spawn
	{
		params ["_vehicle", "_roadPos", "_roadCore", "_unitsCrew", "_isMain"];


		uiSleep slpEnd1;

		private _waitSlep = true;

		// Push for help if vehicle stuck
		if (_vehicle distance2D _roadPos < 0.8) then
		{
			_vehicle setVelocityModelSpace [0, 15, 0.1];
		};

		uiSleep 0.8;

		private _pushPos = getPosATL _vehicle;

		uiSleep 1.5;

		// Delete Crew & Veh if vehicle stuck
		if ( (_vehicle distance2D _pushPos < 0.8) && { (playableUnits findIf { eye(_x,_vehicle)} isEqualTo -1) } ) then
//		if ( (_vehicle distance2D _roadPos < 0.8) && { (playableUnits findIf { eye(_x,_vehicle)} isEqualTo -1) } ) then
		{
			_waitSlep = false;

			{
				_vehicle deleteVehicleCrew _x;

			} count _unitsCrew;

			waitUntil { ( ((crew _vehicle) isEqualTo []) && { (_unitsCrew findIf { ( !(isNil "_x") && { !(isNull _x) } ) } isEqualTo -1) } ) };

			deleteVehicle _vehicle;
		};

		call
		{
			if _isMain exitWith
			{
				DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + slpEnd2)];
			};

			DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + slpEnd2)];
		};

		if _waitSlep then
		{
			[_unitsCrew, _vehicle] spawn DK_fnc_checkWntd_copsPatrol;

			uiSleep slpPatrol;
		};

		waitUntil { uiSleep 5; (_unitsCrew findIf {alive _x} isEqualTo -1) };

		DK_copsPatrol = DK_copsPatrol - 1;
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_vehicle spawn
		{
			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorRed";
			_mkrNzme setMarkerSize [0.6, 0.6];
			_this setVariable ["mkr_DEBUG", _mkrNzme];

			while { alive _this } do
			{
				uiSleep 0.33;

				_mkrNzme setMarkerPos (getPos _this);
			};
		};
	};


};

DK_fnc_crtCopsPatrol = {

	params [["_weapon", ""]];


	private "_nil";
	private _vehicle = call DK_MIS_fnc_crtVeh_Police;


	private _grp = createGroup resistance;

	private _unitsCrew = [];

	for "_i" from 1 to (2 + (round (random 1))) do
	{
		_unitsCrew pushBackUnique (crtU(_grp,"I_officer_F"));
		uiSleep 0.02;
	};

	_grp addVehicle _vehicle;
	{
		_x allowDamage false;
		_x setDamage 0;
		_x disableAI "AUTOTARGET";
		_x disableAI "TARGET";
		_x setVariable ["DK_behaviour", "drive"];

		_x call DK_MIS_addEH_selectSeat;
		_x setVariable ["vehLinkRfr", _vehicle];
		_x spawn DK_MIS_addEH_HandleDmg;
		_x spawn DK_MIS_EH_handleAmmoNweapons;
		_x spawn DK_MIS_addEH_secondDead;
		_x call DK_addEH_deadNdel_CopsPatrol;
		uiSleep 0.1;

		_x call DK_addEH_firedHit_CopsPatrol;
		_x call DK_addEH_getInOut_CopsPatrol;
		_x call DK_MIS_fnc_skillTurretVeh;
		_nil = DK_unitsStayUp pushBackUnique _x;

		_x setVariable ["group", _grp];

		uiSleep 0.2;

		_x moveInAny _vehicle;

	} count	_unitsCrew;


	_vehicle setVariable ["unitsCrew", _unitsCrew];

	_grp deleteGroupWhenEmpty true;
	_grp setFormation "DIAMOND";
	_grp setBehaviour "CARELESS";
	_grp setSpeedMode "NORMAL";

	_unitsCrew orderGetIn true;
	_unitsCrew allowGetIn true;

	[_unitsCrew, "uniform_Police", "", "vest_mediumPolice"] spawn DK_MIS_fnc_slctUnitsLO;

	_vehicle call DK_addEH_del_veh_CopsPatrol;
	_vehicle call DK_addEHs_veh_CopsPatrol;

	_unitsCrew apply
	{
		[_x, 7, dis, true] spawn DK_fnc_addAllTo_CUM;
		_x allowDamage true;
	};


	[_vehicle, _unitsCrew, _grp, [0,9.65,-0.94]]
};


DK_fnc_wpDriver_copsPatrol = {

	params ["_unitsCrew", "_vehicle", "_grp", ["_distance", 1000], "_rdmPos", "_nil", "_pos"];


	private _exit = false;
	private _blackArea = +DK_mkrs_spawnProtect + ["DK_MTW_mkr_limitMap_1"];

	private _allRoads = (_vehicle getPos [_distance, ((_vehicle getDir (_vehicle modelToWorldVisual [0,5,0])) - 20) + (random 40) ]) nearRoads (_distance /2);

	if (count _allRoads > 70) then
	{
		_allRoads = [_allRoads, 1.5] call DK_fnc_shuffleDiviseArray;
	};

	private _angle = selectRandom [1,2];
	private _angleLaps = 0;
	private _time = time + 12;
	private _cnt = (count _allRoads) + 15000;

	for "_i" from 0 to _cnt do
	{
		if !(_allRoads isEqualTo []) then
		{
			_rdmPos = selectRandom _allRoads;

			if ( (!isNil "_rdmPos") && { (_blackArea findIf { (getMarkerPos  _x) distance2D _rdmPos < 2000 } isEqualTo -1) && { (DK_blackListWP findIf { _rdmPos inArea _x } isEqualTo -1) && { ((nearestTerrainObjects [_rdmPos, [], 20, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) } } } ) exitWith
			{
				_exit = true;
			};

			_nil = _allRoads deleteAt (_allRoads find _rdmPos);
		}
		else
		{
			call
			{
				if (_angleLaps < 2) exitWith
				{
					if (_angle isEqualTo 1) exitWith
					{
						_allRoads = (_vehicle getPos [_distance, (getDir _vehicle) + 75]) nearRoads (_distance /2);

						if (count _allRoads > 60) then
						{
							_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
						};

						_angle = 2;
						_angleLaps = _angleLaps + 1;
					};

					if (_angle isEqualTo 2) exitWith
					{
						_allRoads = (_vehicle getPos [_distance, (getDir _vehicle) - 75]) nearRoads (_distance /2);

						if (count _allRoads > 60) then
						{
							_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
						};

						_angle = 1;
						_angleLaps = _angleLaps + 1;
					};
				};

				if (_angleLaps isEqualTo 2) then
				{
					_angle = random 360;
				};

				_allRoads = (_vehicle getPos [_distance, ((_vehicle getDir (_vehicle modelToWorldVisual [0,5,0])) + _angle) ]) nearRoads (_distance /2);

				if (count _allRoads > 60) then
				{
					_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
				};

				_angle = _angle + 10;
				_angleLaps = _angleLaps + 1;
			};
		};

		if ( (_unitsCrew findIf {alive _x} isEqualTo -1) OR (_exit) OR (time > _time) OR (_angleLaps > 38) ) exitWith {};

		uiSleep 0.03;
	};

	if (!isNil "_rdmPos") then
	{
		_rdmPos = getPosATL _rdmPos;
	}
	else
	{
		_rdmPos = DK_centerPostionMap;
	};


	if (leader _grp getVariable ["DK_behaviour", ""] isEqualTo "drive") then
	{
		_unitsCrew doMove _rdmPos;

		uiSleep 3;

		if ( !(leader _grp getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_vehicle") OR (isNull _vehicle) ) exitWith {};

		_time = time + ((_vehicle distance2D _rdmPos) / 1.8);
		waitUntil
		{
			_pos = getPosATL _vehicle;

			uiSleep 1.5;

			[leader _grp, _vehicle] call DK_fnc_manageSpdTraff;
			[_vehicle, _pos] call DK_fnc_manageFrcRoadTraff;


			!(leader _grp getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_vehicle") OR (isNull _vehicle) OR (unitReady driver _vehicle) OR (_vehicle distance2D _rdmPos < 120) OR (time > _time)
		};


		if ( !(leader _grp getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_vehicle") OR (isNull _vehicle) ) exitWith {};

		[_unitsCrew, _vehicle, _grp, _distance] call DK_fnc_wpDriver_copsPatrol;
	};
};

DK_fnc_wpDriver_copsPatrol_2 = {

	params ["_unitsCrew", "_vehicle", "_grp", "_roadPos", ["_distance", 1000]];


	doStop _unitsCrew;
	_unitsCrew doMove _roadPos;

	private "_pos";

	uiSleep 1;
	private _time = time + 90;

	waitUntil
	{
		_pos = getPosATL _vehicle;

		uiSleep 1.5;

		[leader _grp, _vehicle] call DK_fnc_manageSpdTraff;
		[_vehicle, _pos] call DK_fnc_manageFrcRoadTraff;

		_pos = getPosATL _vehicle;
		uiSleep 1.5;

		[leader _grp, _vehicle] call DK_fnc_manageSpdTraff;
		[_vehicle, _pos] call DK_fnc_manageFrcRoadTraff;

		!(leader _grp getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_vehicle") OR (isNull _vehicle) OR (_vehicle distance2D _roadPos < 100) OR (time > _time)
	};

	if ( !(leader _grp getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_vehicle") OR (isNull _vehicle) ) exitWith {};

	[_unitsCrew, _vehicle, _grp, _distance] spawn DK_fnc_wpDriver_copsPatrol;
};


DK_addEH_deadNdel_CopsPatrol = {

	_this addEventHandler ["Killed",
	{
		params ["_unit", "_killer", "_instigator"];


		_unit setVariable ["cleanUpOn", false];
		[_unit, 25, 150, true, 180] spawn DK_fnc_addAllTo_CUM;
		addToRemainsCollector [_unit];

		private _grp = group _unit;
		private _unitsCrew = units _grp;

		[_unit, _unitsCrew] call DK_fnc_checkAliveGrpForReInitVeh;

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

		if ((isPlayer _instigator) OR (side (group _instigator) isEqualTo west) OR (side _instigator isEqualTo east) OR (_instigator getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
		{
			if ((!isNil "_veh") && { (alive _veh) }) then
			{
				_idEHs = _veh getVariable "DK_CLAG_idEHs";

				_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
				_veh removeEventHandler ["Hit", _idEHs # 3];
				_veh removeEventHandler ["GetIn", _idEHs # 2];
				_veh removeEventHandler ["HandleDamage", _idEHs # 1];
				_veh removeEventHandler ["FiredNear", _idEHs # 4];
			};


			private _unitsCrew = units _unit;

			if (_unitsCrew isEqualTo []) exitWith {};

			_unitsCrew apply
			{
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "FiredNear";
				_x setVariable ["DK_behaviour", "chase"];
			};

			[_unitsCrew, _veh, _instigator] spawn DK_fnc_startChase_CopsPatrol;
		};

	}];

	_this addEventHandler ["Deleted",
	{
		params ["_unit"];


		_vehicle = _unit getVariable "vehLinkRfr";

		if ( (!isNil "_vehicle") && {(!isNull _vehicle)} ) then
		{
			_trg = _hisCar getVariable "DK_CLAG_trgAtch";

			if !(isNil "_trg") then
			{
				deleteVehicle _trg;
			};

			if (units (_unit getVariable "group") findIf {alive _x} isEqualTo -1) then
			{
				_vehicle setVehicleLock "UNLOCKED";
				_vehicle call DK_MIS_fnc_vehicle_removeAllEH;
				_vehicle call DK_MIS_reInitVehNormal;
				_vehicle call DK_MIS_fnc_initVehWhenEnd;
			};
		};
	}];
};

DK_addEH_firedHit_CopsPatrol = {

	_this addEventHandler ["FiredNear",
	{
		_this call DK_fnc_startChase_CopsPatrol_init;
	}];

	_this addEventHandler ["Hit",
	{
		params ["_unit", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		[_unit, _instigator] call DK_fnc_startChase_CopsPatrol_init;
	}];
};



DK_fnc_checkAliveGrpForReInitVeh = {

	params ["_unit", "_unitsCrew"];


	if ((isNil "_unit") OR (isNull _unit)) exitWith {};

	private _idAlive = _unitsCrew findIf {alive _x};

	if (_idAlive isEqualTo -1) then
	{
		private _vehicle = _unit getVariable "vehLinkRfr";
		if (!isNil "_vehicle") then
		{
			_vehicle setVehicleLock "UNLOCKED";
			_vehicle call DK_MIS_fnc_vehicle_removeAllEH;
			_vehicle call DK_MIS_reInitVehNormal;
			_vehicle call DK_MIS_fnc_initVehWhenEnd;
		};
	}
	else
	{
		private _vehicle = _unit getVariable "vehLinkRfr";
		if ((!isNil "_vehicle") && { (_unit isEqualTo driver _vehicle) } ) then
		{
			_Uslct = _unitsCrew # _idAlive;
			group _Uslct selectLeader _Uslct;
			_Uslct assignAsDriver _vehicle;
		};
	};
};

DK_fnc_checkWntd_copsPatrol = {

	params [["_allUnits", []], ["_veh", objNull]];


//	private ["_leader", "_player"];
	private "_id";

	while { !(_allUnits findIf { (alive _x) } isEqualTo -1) && { (alive _veh) } } do
	{
		waitUntil { uiSleep 1; (_allUnits findIf { (alive _x) } isEqualTo -1) OR !(alive _veh) OR (_allUnits findIf { ((_x getVariable ["DK_behaviour", ""]) isEqualTo "chase") } isEqualTo -1); };

		_id = _allUnits findIf { (alive _x) };

		if ((_id isEqualTo -1) OR !(alive _veh)) exitWith {};

		{
			_unit = driver _x;

			if ( !({alive _x} count ( _unit getVariable ["wantedLvl", []]) isEqualTo 0) && { ((getPosATL _unit) # 2 < 180) } ) exitWith
			{
				{
					_x setVariable ["DK_behaviour", "chase"];

				} count _allUnits;

				[_allUnits, _veh, _unit] call DK_fnc_startChase_CopsPatrol;
			};

			uiSleep 0.05;

		} count (nearestObjects [leader (_allUnits # _id), ["B_Soldier_F", "LandVehicle", "Air", "Ship"], 150, true]);


		uiSleep 1;
	};
};


DK_addEH_del_veh_CopsPatrol = {

	_this addEventHandler ["deleted",
	{
		params ["_entity"];

//		CNT(-1);

		private _trg = _veh getVariable "DK_CLAG_trgAtch";
		if (!isNil "_trg") then
		{
			deleteVehicle _trg;		
		};

	/// // DEBUG MOD
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];
};

DK_addEHs_veh_CopsPatrol = {


	private _idEH_EPS = _this addEventHandler ["EpeContactStart",
	{
		_this call DK_fnc_EpeStart_copsPatrol;
	}];

	private _idEH_HD = _this addEventHandler ["HandleDamage",
	{
		private _nil = _this pushBack _thisEventHandler;
		private _damage = _this call DK_fnc_EhHandleDmg_cops;

		_damage
	}];

	private _idEH_GetIn = _this addEventHandler ["GetIn",
	{
		_this call DK_fnc_EhGetIn_cops;
	}];


	private _idEH_Hit = _this addEventHandler ["Hit",
	{
		_this call DK_fnc_EhHit_cops;
	}];

	private _idEH_FiredN = _this addEventHandler ["FiredNear",
	{
		_this call DK_fnc_EhFiredN_cops;
	}];


	_this setVariable ["DK_CLAG_idEHs", [_idEH_EPS, _idEH_HD, _idEH_GetIn, _idEH_Hit, _idEH_FiredN]];
};


DK_fnc_EpeStart_copsPatrol = {

	params ["_veh", "_object2"];


	if !(_veh getVariable ["EpeOk", true]) exitWith {};

	_veh setVariable ["EpeOk", false];

	_veh spawn
	{
		uiSleep 0.7;

		if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
		{
			_this setVariable ["EpeOk", true];
		};
	};

	if (typeName _object2 isEqualTo "STRING") exitWith {};

	private _shooter = driver (vehicle _object2);

	if ( !(crew _veh isEqualTo []) && { ( (isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (side _shooter isEqualTo east) OR (_shooter getVariable ["DK_side", ""] isEqualTo "civ") && { !(_shooter getVariable ["DK_side", ""] in ["cops", "fbi", "army"]) } ) } ) exitWith
	{
		private _speed1 = speed _veh;
		private _speed2 = speed _object2;
		if (_speed2 < 0) then
		{
			_speed2 = _speed2 * -1;
		};
		if (_speed1 < 0) then
		{
			_speed1 = _speed1 * -1;
		};

		if ( (_speed2 > 70) OR ( (_speed2 > 15) && { (_speed2 > _speed1) } ) ) exitWith
		{
			_idEHs = _veh getVariable "DK_CLAG_idEHs";

			_veh removeEventHandler ["Hit", _idEHs # 3];
			_veh removeEventHandler ["EpeContactStart", _thisEventHandler];
			_veh removeEventHandler ["GetIn", _idEHs # 2];
			_veh removeEventHandler ["HandleDamage", _idEHs # 1];
			_veh removeEventHandler ["FiredNear", _idEHs # 4];


			private _unitsCrew = _veh getVariable ["unitsCrew", []];

			if (_unitsCrew isEqualTo []) exitWith {};

			_unitsCrew apply
			{
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "FiredNear";
				_x setVariable ["DK_behaviour", "chase"];
			};

			[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;
		};

		if !(isPlayer (driver (vehicle _veh))) then
		{
			[_veh, vehicle _object2] call DK_fnc_EpConHorn_CopsPatrol;
		};
	};
};

DK_fnc_EhHit_cops = {

		params ["_veh", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};


		if ( !(crew _veh isEqualTo []) && { ((isPlayer _instigator) OR (side (group _instigator) isEqualTo west) OR (side _instigator isEqualTo east) OR (_instigator getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) } ) then
		{
			_idEHs = _veh getVariable "DK_CLAG_idEHs";

			_veh removeEventHandler ["Hit", _thisEventHandler];
			_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
			_veh removeEventHandler ["GetIn", _idEHs # 2];
			_veh removeEventHandler ["HandleDamage", _idEHs # 1];
			_veh removeEventHandler ["FiredNear", _idEHs # 4];


			private _unitsCrew = _veh getVariable ["unitsCrew", []];

			if (_unitsCrew isEqualTo []) exitWith {};

			_unitsCrew apply
			{
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "FiredNear";
				_x setVariable ["DK_behaviour", "chase"];
			};

			[_unitsCrew, _veh, _instigator] spawn DK_fnc_startChase_CopsPatrol;
		};
};

DK_fnc_EhHandleDmg_cops = {

	params ["_vehicle", "", "_damage", "_source", "_projectile", "", "_instigator", "", "_thisEventHandler"];


	if ( ((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && { !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } } ) then
	{
		_instigator = _source;
	};


	// Normal damage if shooter is player
	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) OR ( !(_projectile isEqualTo "") && { !(_instigator getVariable  ["DK_side", ""] in ["civ", "cops", "fbi", "army"]) } ) ) exitWith
	{
		_vehicle removeEventHandler ["HandleDamage", _thisEventHandler];

		_damage
	};

	if (typeName _projectile isEqualTo "OBJECT") then
	{
		(getShotParents _projectile) params ["", "_instigatorBis"];
	};

	if ( (!isNil "_instigatorBis") && { (isPlayer _instigatorBis) OR (side (group _instigatorBis) isEqualTo west) } ) exitWith
	{
		_vehicle removeEventHandler ["HandleDamage", _thisEventHandler];

		_damage
	};

	(crew _vehicle) apply
	{
		_x setDamage 0;
	};

	_damage = 0;


	_damage
};

DK_fnc_EhGetIn_cops = {

	params ["_veh", "", "_getIner"];


	if ( (isPlayer _getIner) OR (side (group _getIner) isEqualTo west) && { ((typeName _getIner) isEqualTo "OBJECT") } ) then
	{
		_idEHs = _veh getVariable ["DK_CLAG_idEHs", []];
		_idEHs params [["_id1", -1], ["_id2", -1], ["_id3", -1], ["_id4", -1], ["_id5", -1]];

		_veh removeEventHandler ["GetIn", _id3];
		_veh removeEventHandler ["EpeContactStart", _id1];
		_veh removeEventHandler ["Hit", _id4];
		_veh removeEventHandler ["HandleDamage", _id2];
		_veh removeEventHandler ["FiredNear", _id5];

		_veh getVariable "DK_CLAG_trgAtch";
		if (!isNil "_trg") then
		{
			deleteVehicle _trg;
		};
	};
};

DK_fnc_EhFiredN_cops = {

	params ["_veh", "_shooter"];
		

	if ( !(crew _veh isEqualTo []) && { ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (side _shooter isEqualTo east) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) } ) then
	{
		_idEHs = _veh getVariable ["DK_CLAG_idEHs", []];
		_idEHs params [["_id1", -1], ["_id2", -1], ["_id3", -1], ["_id4", -1], ["_id5", -1]];

		_veh removeEventHandler ["Hit", _idEHs # 3];
		_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
		_veh removeEventHandler ["GetIn", _idEHs # 2];
		_veh removeEventHandler ["HandleDamage", _idEHs # 1];
		_veh removeEventHandler ["FiredNear", _id5];


		private _unitsCrew = _veh getVariable ["unitsCrew", []];

		if (_unitsCrew isEqualTo []) exitWith {};

		_unitsCrew apply
		{
			_x removeAllEventHandlers "Hit";
			_x removeAllEventHandlers "FiredNear";
			_x setVariable ["DK_behaviour", "chase"];
		};

		[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;
	};
};



DK_fnc_startChase_CopsPatrol_init = {

	params ["_unit", "_shooter"];
		

	if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west) OR (side _shooter isEqualTo east) OR (_shooter getVariable ["DK_side", ""] in ["civ", "cops", "fbi", "army"])) then
	{
		private _veh = _unit getVariable "vehLinkRfr";

		if ((!isNil "_veh") && { (alive _veh) }) then
		{
			_idEHs = _veh getVariable ["DK_CLAG_idEHs", []];
			_idEHs params [["_id1", -1], ["_id2", -1], ["_id3", -1], ["_id4", -1], ["_id5", -1]];

			_veh removeEventHandler ["EpeContactStart", _id1];
			_veh removeEventHandler ["Hit", _id4];
			_veh removeEventHandler ["GetIn", _id3];
			_veh removeEventHandler ["HandleDamage", _id2];
			_veh removeEventHandler ["FiredNear", _id5];
		};


		private _unitsCrew = units _unit;

		if (_unitsCrew isEqualTo []) exitWith {};

		_unitsCrew apply
		{
			_x removeAllEventHandlers "Hit";
			_x removeAllEventHandlers "FiredNear";
			_x setVariable ["DK_behaviour", "chase"];
		};

		[_unitsCrew, _veh, _shooter] spawn DK_fnc_startChase_CopsPatrol;
	};
};

DK_fnc_startChase_CopsPatrol = {

	params ["_unitsCrew", ["_vehicle", objNull], "_objTarget", ["_condLoop", 1], ["_timeToDel", 12]];


	if ( !(_unitsCrew findIf { _x getVariable ["DK_behaviour", ""] isEqualTo "drive" } isEqualTo -1) OR (_unitsCrew findIf {alive _x} isEqualTo -1) ) exitWith {};

	if !(isNil "_vehicle") then
	{
		private _trg = _vehicle getVariable "DK_CLAG_trgAtch";
		if (!isNil "_trg") then
		{
			deleteVehicle _trg;
		};

		_vehicle forceFollowRoad false;
	};

	private "_nil";
	{
		if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
		{
			_x setVariable ["DK_behaviour", "chase"];

			uiSleep (random 0.4);

			_x enableAI "TARGET";
			_x enableAI "AUTOTARGET";

			if !(someAmmo _x) then
			{
				_nil = _x spawn DK_fnc_add_handGun_cops;
			};

			DelInCUM(_x);
			_x setVariable ["cleanUpOn",false];
		};

	} count _unitsCrew;

	if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};

	private _grp = group (_unitsCrew # 0);
	_grp spawn DK_loop_voicePoliceLand;
	private _combatMode = "YELLOW";
	private _directionToMove = _objTarget;
	private _idMission = "-1";

	if (isNull (objectParent leader _grp)) then
	{
		{
			_x enableAI "MOVE";

		} count _unitsCrew;

		_grp setBehaviour "COMBAT";
	};

	call
	{
		if ( (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) ) exitWith
		{
			[_objTarget, _unitsCrew] spawn DK_fnc_manageWantedLvlPly;

			[_unitsCrew, _objTarget, _grp] spawn DK_fnc_countdown_2sRfr;
		};

		if (_objTarget getVariable ["DK_isObjectif", false]) exitWith
		{
			_combatMode = "RED";
			_directionToMove = (_objTarget getVariable ["MIS_nfo", [[0,0,0]]]) # 0;
			_idMission = DK_idMission;
		};


		if (_objTarget getVariable ["DK_side", ""] isEqualTo "civ") then
		{
			{
				_x disableAI "AUTOTARGET";

			} count _unitsCrew;

			if !(side _objTarget isEqualTo east) then
			{
				private _grpEast = createGroup [east, true];
				[_objTarget] join _grpEast;

				_objTarget addRating -10000;
				_objTarget setSpeedMode "FULL";
				vehicle _objTarget limitSpeed 200;
				vehicle _objTarget forceSpeed 200;
			};


			[driver _objTarget, _grp, _unitsCrew] spawn DK_fnc_copsVsCiv;
		};

//		private _exit = false;
		if (_objTarget getVariable ["DK_side", ""] in ["cops", "fbi", "army"]) then
		{
			_objTarget = assignedTarget _objTarget;

			if ((_objTarget isEqualTo objNull) OR (_objTarget getVariable ["DK_side", ""] in ["cops", "fbi", "army"])) exitWith
			{
//				_exit = true;

				[_unitsCrew, _vehicle, _grp] spawn DK_fnc_finishChase_CopsPatrol;
			};

			if ( (!isPlayer _objTarget) && { !(side (group _objTarget) isEqualTo west) } ) then
			{
		//		_combatMode = "WHITE";
				[driver _objTarget, _grp, _unitsCrew] spawn DK_fnc_copsVsCiv;
			};

			if ( !(side _objTarget isEqualTo east) && { (!isPlayer _objTarget) OR !(side (group _objTarget) isEqualTo west) } ) then
			{
				{
					_x disableAI "AUTOTARGET";

				} count _unitsCrew;
			};

			_grp setCombatMode _combatMode;
		};

//		if _exit exitWith {};

//		_grp setCombatMode _combatMode;
	};

	if ( (!isNil "_vehicle") && { (!isNull _vehicle) && { (canMove _vehicle) && { (alive _vehicle) && { (DK_wheels findIf {(_vehicle getHit _x) isEqualTo 1} isEqualTo -1) } } } } ) then
	{
		if (alive driver _vehicle) then
		{
			[_vehicle, false] call DK_fnc_police_siren_OnOff;
			_vehicle animateSource ["Beacons", 1];
		};

		[_unitsCrew, _grp, _vehicle, _objTarget, _idMission, _condLoop, _directionToMove, _combatMode, _timeToDel] call DK_fnc_AiFollow_rfr;
	}
	else
	{
		[_unitsCrew, _objTarget, _grp] spawn DK_loop_AiFollow_rfrFoot;
	};
};

DK_fnc_finishChase_CopsPatrol = {

	params ["_unitsCrew", "_vehicleRfr", "_grp", ["_objTarget", objNull]];


	uiSleep 2;

	if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith
	{
		if ( (!isNil "_vehicleRfr") && { (!isNull _vehicleRfr) && { (alive _vehicleRfr) } } ) then
		{
			_vehicleRfr call DK_MIS_fnc_vehicle_removeAllEH;
			_vehicleRfr call DK_MIS_reInitVehNormal;
			_vehicleRfr call DK_MIS_fnc_initVehWhenEnd;
			_vehicleRfr forceSpeed -1;
			_vehicleRfr limitSpeed 250;
		};
	};

	private _idSHooter = _unitsCrew findIf { !(assignedTarget _x isEqualTo objNull) };
	if !(_idSHooter isEqualTo -1) exitWith
	{
		private _shooter = assignedTarget (_unitsCrew # _idSHooter);

		if ( (!isNil "_vehicleRfr") && { (!isNull _vehicleRfr) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) && { (alive _vehicleRfr) } } } } ) then
		{
			[_unitsCrew, _grp, _vehicleRfr, _shooter, [], 1, _shooter, if ((isPlayer _shooter) OR (side (group _shooter) isEqualTo west)) then {"YELLOW"} else {"WHITE"}] call DK_fnc_AiFollow_rfr;
		}
		else
		{
			[_unitsCrew, _shooter, _grp] spawn DK_loop_AiFollow_rfrFoot;
		};
	};

	_grp call DK_fnc_delAllWp;

	private ["_nil", "_fnc_condSSVOR"];
	if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
	{
		_fnc_condSSVOR = {

			(isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget) OR ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) && { (side (group _objTarget) isEqualTo west) && { (lifeState _objTarget isEqualTo "INCAPACITATED") } } } )
		};
	}
	else
	{
		_fnc_condSSVOR = {

			(isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget)
		};
	};


	// Target Down, return to normal patrol
	if (call _fnc_condSSVOR) exitWith
	{
		_grp setBehaviour "CARELESS";
		_grp setSpeedMode "LIMITED";

		// With car
		if ( (!isNil "_vehicleRfr") && { (!isNull _vehicleRfr) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) } } } ) exitWith
		{
			{
				if (alive _x) then
				{
					_x disableAI "AUTOTARGET";
					_x disableAI "TARGET";
					uiSleep 0.3;

					if (someAmmo _x) then
					{
						removeAllWeapons _x;
					};

					[_x, 10, 400, true] spawn DK_fnc_addAllTo_CUM;

					_x setVariable ["DK_behaviour", "drive"];
					_nil = _x call DK_addEH_firedHit_CopsPatrol;
					_x forceSpeed -1;
				};

			} count _unitsCrew;

			if (alive driver _vehicleRfr) then
			{
				_vehicleRfr animateSource ["Beacons", 0];

				if (_vehicleRfr getVariable ["DK_sirenIsON", true]) then
				{
					[_vehicleRfr, true] call DK_fnc_police_siren_OnOff;
				};
			};

			_vehicleRfr call DK_addEHs_veh_CopsPatrol;
			_vehicleRfr forceSpeed -1;
			_vehicleRfr limitSpeed 60;

			_grp addVehicle _vehicleRfr;
			_unitsCrew allowGetIn true;
			_unitsCrew orderGetIn true;

			private _waypoint = [_grp, _vehicleRfr, " this spawn DK_fnc_wpGetInFinal_CopsPatrol; ", "true", "GETIN", nil, "LIMITED", "CARELESS"] call DK_fnc_AddWaypointState;
		};

		// On foot
		if ( (!isNil "_vehicleRfr") && (!isNull _vehicleRfr) && { (alive _vehicleRfr) } ) then
		{
			if (alive driver _vehicleRfr) then
			{
				_vehicleRfr animateSource ["Beacons", 0];

				if (_vehicleRfr getVariable ["DK_sirenIsON", true]) then
				{
					[_vehicleRfr, true] call DK_fnc_police_siren_OnOff;
				};
			};

			_vehicleRfr call DK_MIS_fnc_vehicle_removeAllEH;
			_vehicleRfr call DK_MIS_reInitVehNormal;
			_vehicleRfr call DK_MIS_fnc_initVehWhenEnd;
			_vehicleRfr forceSpeed -1;
			_vehicleRfr limitSpeed 60;
		};

		{
			if (alive _x) then
			{
				_x disableAI "AUTOTARGET";
				_x disableAI "TARGET";
				uiSleep 0.3;

				if (someAmmo _x) then
				{
					removeAllWeapons _x;
				};

				[_x, 10, 150, true] spawn DK_fnc_addAllTo_CUM;

				_x setVariable ["DK_behaviour", "drive"];
				_x call DK_addEH_firedHit_CopsPatrol;
			};

		} forEach _unitsCrew;

		[_unitsCrew, leader _grp, _grp, 800] call DK_fnc_wpDriver_copsPatrol;
	};

	// Vehicle cops down
	if ( (!isNil "_vehicleRfr") && (!isNull _vehicleRfr) && { (alive _vehicleRfr) } ) then
	{
		_vehicleRfr call DK_MIS_fnc_vehicle_removeAllEH;
		_vehicleRfr call DK_MIS_reInitVehNormal;
		_vehicleRfr call DK_MIS_fnc_initVehWhenEnd;
		_vehicleRfr forceSpeed -1;
		_vehicleRfr limitSpeed 250;
	};

	if !(_unitsCrew findIf { !(isNull objectParent _x) } isEqualTo -1) then
	{
		doStop _unitsCrew;
		private _waypoint = [_grp, _vehicleRfr, "GETOUT", nil, "NORMAL", "COMBAT"] call DK_fnc_AddWaypoint;
	};


	[_unitsCrew, _objTarget, _grp] spawn DK_loop_AiFollow_rfrFoot;
};

DK_fnc_wpGetInFinal_CopsPatrol = {

	if (!isServer) exitWith {};

	private _unitsCrew = units _this;
	private _grp = group _this;

	[_unitsCrew, if (alive (_this getVariable ["vehLinkRfr", vehicle _this])) then { _this getVariable ["vehLinkRfr", vehicle _this] } else { _this }, _grp, 1000] spawn DK_fnc_wpDriver_copsPatrol;
	_grp setSpeedMode "LIMITED";

	_unitsCrew apply
	{
		if (someAmmo _x) then
		{
			removeAllWeapons _x;
		};
	};
};

DK_fnc_copsVsCiv = {

	params ["_objTarget", "_grp", "_unitsCrew"];


	_grp reveal [_objTarget, 4];
	_grp setCombatMode "YELLOW";
	_unitsCrew apply
	{
		_x doTarget _objTarget;
		_x commandTarget _objTarget;
		_x doFire _objTarget;
	};

	waitUntil { uiSleep 0.3; (isNil "_objTarget") OR (_grp isEqualTo grpNull) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR !(alive _objTarget) };

	if ( (_grp isEqualTo grpNull) OR (_unitsCrew findIf {alive _x} isEqualTo -1) ) exitWith {};

	_grp setCombatMode "WHITE";
};


DK_loop_AiFollow_rfrFoot = {

	params ["_unitsCrew", "_objTarget", "_grp"];


	if ( !(_unitsCrew findIf { _x getVariable ["DK_behaviour", ""] isEqualTo "drive" } isEqualTo -1) OR (_unitsCrew findIf {alive _x} isEqualTo -1) ) exitWith {};

	{
		if (alive _x) then
		{
			[_x, 7, 150, true] spawn DK_fnc_addAllTo_CUM;
		};

	} forEach _unitsCrew;


	private _combatMode = "YELLOW";
	private ["_fnc_condSSVOR", "_waypoint", "_time", "_targetPos"];

	if ( !(isPlayer _objTarget) OR !(side (group _objTarget) isEqualTo west) ) then
	{
//		_combatMode = "YELLOW";
		_combatMode = "WHITE";		// WHITE for civilians
	};


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


	_grp setSpeedMode "FULL";


	private _timeCheck = 0;
	while { (call _fnc_condSSVOR) } do
	{
		_unitsCrew = units _grp;

		_grp call DK_fnc_delAllWp;

		call
		{
			if ((time < _timeCheck) OR (leader _grp distance2D _objTarget > 80)) exitWith
			{
				_unitsCrew doMove (getPosATL _objTarget);
			};

			_waypoint = [_grp, _objTarget, "SAD", nil,  "FULL", "COMBAT"] call DK_fnc_AddWaypoint;
		};

		_targetPos = getPosATL _objTarget;

		_unitsCrew apply
		{
			_x commandTarget _objTarget;
			_x doTarget _objTarget;
		};

		_grp setCombatMode _combatMode;


		_time = time + 20;
		_timeCheck = time + 7;

		waitUntil { uiSleep 3; (time > _time) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget) OR (_objTarget distance _targetPos > 35) };

		if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith {};
	};
};


DK_addEH_getInOut_CopsPatrol = {


	_this addEventHandler ["GetInMan",
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

		if (_role isEqualTo "driver") then
		{
			_unit disableAI "FSM";

			if (_unit getVariable ["DK_behaviour", "drive"] isEqualTo "chase") then
			{
				_vehicle animateSource ["Beacons", 1];

				if !(_vehicle getVariable ["DK_sirenIsON", true]) then
				{
					[_vehicle, false] call DK_fnc_police_siren_OnOff;
				};
			}
			else
			{
				_vehicle animateSource ["Beacons", 0];

				if (_vehicle getVariable ["DK_sirenIsON", true]) then
				{
					[_vehicle, true] call DK_fnc_police_siren_OnOff;
				};
			};
		};
	}];

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit", "_role", "_vehicle"];


		if (!alive _unit) exitWith {};

//		_unit call (_unit getVariable "DK_skill");

		if (_role isEqualTo "driver") then
		{		
			_unit enableAI "FSM";

			if (_vehicle getVariable ["DK_sirenIsON", false]) then
			{
				[_vehicle, true] call DK_fnc_police_siren_OnOff;
			};
		};
	}];
};

DK_fnc_EpConHorn_CopsPatrol = {

	params ["_veh", "_vehCol", ["_byPass", false]];


	if ( (_byPass) OR ((_vehCol isKindOf "LandVehicle") && { !(driver _vehCol isEqualTo objNull) && { (_veh getVariable ["hornAllow", true]) && { !(driver _veh isEqualTo objNull) } } }) ) then
	{
		_veh setVariable ["hornAllow", false];

		private "_settings";
		switch ( selectRandom [1,2,3] ) do
		{
			case 1 :
			{
				_settings = [ _veh, [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)], [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)]];
			};

			case 2 :
			{
				_settings = [ _veh, [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)], [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)], [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)]];
			};

			case 3 :
			{
				_settings = [ _veh, [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)], [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)], [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)], [selectRandom ["police_siren01", "police_siren02"], 0.1 + (random 0.275)]];
			};
		};

		playableUnits apply
		{
			if (_x distance2D _veh < 530) then
			{
				_settings remoteExecCall ["DK_fnc_Horn_CopsPatrol_cl", _x];
			};

		};

		_veh spawn
		{
			uiSleep 2;

			if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) && { (canMove _this) && { (alive (driver _this)) } } } } ) then
			{
				_this setVariable ["hornAllow", true];
			};
		};
	};
};


DK_addTrgHorn_PatrolCops = {

	params ["_veh", "_pos"];


	private _trg = createTrigger ["EmptyDetector", [0,0,0], false];
	_trg setTriggerArea [2.8, 2.8, 0, false, 3];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [" !(('Man' countType thisList) isEqualTo 0) ",
	"
		(vehicle (attachedTo thisTrigger)) call DK_fnc_TrgHorn_PatrolCopsAct;
	",
	"
		(driver (vehicle (attachedTo thisTrigger))) enableAI 'MOVE';
	"];

	_trg attachTo [_veh,_pos];
	_veh setVariable ["DK_CLAG_trgAtch", _trg];
};

DK_fnc_TrgHorn_PatrolCopsAct = {

	if (((speed _this) > 4) && { (alive driver _this) } ) then
	{
		[_this, "", true] call DK_fnc_EpConHorn_CopsPatrol;
		(driver _this) disableAI "MOVE";

		(driver _this) spawn
		{
			uiSleep 3;

			if ((!isNil "_this") && { (!isNull _this) && { (alive _this) } }) then
			{
				_this enableAI "MOVE";
			};
		};
	};
};


DK_fnc_crtCopsPatrol_2sRfr = {

	params [["_weapon", ""]];


	private _vehicle = [true, true, true] call DK_MIS_fnc_crtVeh_Police;
	

	private _grp = createGroup resistance;

	_unit01 = crtU(_grp,"I_officer_F");
	_unit02 = crtU(_grp,"I_officer_F");
	_unit03 = crtU(_grp,"I_officer_F");

	_unitsCrew = [_unit02, _unit01, _unit03];

	_grp addVehicle _vehicle;

	private "_nil";
	{
		_x allowDamage false;
		_x setDamage 0;
		_x setVariable ["DK_behaviour", "chase"];
		_x setVariable ["DK_side", "cops"];

		_x call DK_MIS_addEH_selectSeat;
		_x setVariable ["vehLinkRfr", _vehicle];
		_x spawn DK_MIS_addEH_HandleDmg;
		_x spawn DK_MIS_EH_handleAmmoNweapons;
		_x spawn DK_MIS_addEH_secondDead;

		uiSleep 0.03;

		_x call DK_addEH_deadNdel_rfr;
		_x call DK_addEH_getInOut_CopsPatrol;
		_x call DK_MIS_fnc_skillTurretVeh;
		DK_unitsStayUp pushBackUnique _x;

		_nil = _x moveInAny _vehicle;

		uiSleep 0.07;

	} count _unitsCrew;

	_vehicle setVariable ["unitsCrew", _unitsCrew];

	_grp deleteGroupWhenEmpty true;
	_grp setFormation "DIAMOND";
	_grp setBehaviour "CARELESS";
	_grp setCombatMode "YELLOW";
	_grp setSpeedMode "FULL";

	_unitsCrew orderGetIn true;
	_unitsCrew allowGetIn true;

	[_unitsCrew, "uniform_Police", _weapon, "vest_mediumPolice"] spawn DK_MIS_fnc_slctUnitsLO;


	_unitsCrew apply
	{
		[_x, 7, dis, true] spawn DK_fnc_addAllTo_CUM;
		_x allowDamage true;
	};



	private _idEH_HD = _vehicle addEventHandler ["HandleDamage",
	{
		private _nil = _this pushBack _thisEventHandler;
		private _damage = _this call DK_fnc_EhHandleDmg_cops;

		_damage
	}];

	private _idEH_GetIn = _vehicle addEventHandler ["GetIn",
	{
		params ["_veh", "", "_getIner"];

		if ( (isPlayer _getIner) OR (side (group _getIner) isEqualTo west) && { ((typeName _getIner) isEqualTo "OBJECT") } ) then
		{
			_idEHs = _veh getVariable ["DK_CLAG_idEHs", []];

			if (_idEHs isEqualTo []) exitWith {};

			_veh removeEventHandler ["GetIn", _thisEventHandler];
			_veh removeEventHandler ["HandleDamage", _idEHs # 1];
		};
	}];

	_vehicle setVariable ["DK_CLAG_idEHs", [ _idEH_HD, _idEH_GetIn]];

	waitUntil { uiSleep 0.1; ({alive _x} count (crew _vehicle)) isEqualTo ({alive _x} count _unitsCrew) };


	[_vehicle, _unitsCrew, _grp]
};

DK_fnc_initCopsPatrol_2sRfr = {

	// Search position safe for spawn Reinforcement
	private "_resultSrchSpwn";

	call
	{
		if ( !(vehicle _this isEqualTo _this) && { (speed _this > 15) } ) exitWith
		{
			_resultSrchSpwn = [_this, 200, 500, nil, 1, true, "-1"] call DK_fnc_searchSpawn_rfr;
		};

		_resultSrchSpwn = [_this, 200, 500, 20, 3, true] call DK_fnc_MTW_searchSpawnVeh_OnRoad;
	};

	_resultSrchSpwn params ["_spawnPos", "_dir"];

	if (_spawnPos isEqualTo 0) exitWith
	{
		DK_nbSearchSpawnRoad_inProg = false;
	};

	// Create Reinforcement Vehicle & Crew 
	private _vehCrew = ["wpns_smgs"] call DK_fnc_crtCopsPatrol_2sRfr;
	_vehCrew params ["_vehicle", "_unitsCrew", "_grp"];

	_vehicle engineOn true;
	_vehicle setDir _dir;
	_vehicle setPosATL _spawnPos;
	_vehicle setVectorUp surfaceNormal _spawnPos;

	_vehicle enableSimulationGlobal true;
	_vehicle allowDamage true;
	_vehicle setVehicleLock "LOCKEDPLAYER";

	// Start Voice if order forces
	_grp spawn DK_fnc_selectLoopVoice;

	DK_nbSearchSpawnRoad_inProg = false;

	// Stars manager Stars for player
	[_this, _unitsCrew] spawn DK_fnc_manageWantedLvlPly;


	// Start AI Follow Objectif
	[_unitsCrew, _grp, _vehicle, _this, "-1", 1, nil, combatMode (leader _grp), 40] call DK_fnc_AiFollow_rfr;
};

DK_fnc_countdown_2sRfr = {

	params ["_unitsCrew", "_objTarget", "_grp", ["_slpTm", 0]];


	// Waiting if player havent kill every cops
	private "_time";
	private _nbPlyNr = 0;
	private _leader = leader _grp;

	{
		if ( !(lifeState _x isEqualTo "INCAPACITATED") && { ((_x distance2D _objTarget < 50) OR (_x distance2D _leader < 50)) } ) then
		{
			_nbPlyNr = _nbPlyNr + 1;
		};

		uiSleep 0.02;

	} forEach playableUnits;

	call
	{
		if (_nbPlyNr > 9) exitWith
		{
			_time = time + 1 + _slpTm;
		};

		_time = (time + 10) - _nbPlyNr + _slpTm;
	};


	if (_objTarget isKindOf "Man") then
	{
		waitUntil { (time > _time) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget) OR (lifeState _objTarget isEqualTo "INCAPACITATED") };
	}
	else
	{
		waitUntil { (time > _time) OR (_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget) };
	};

	if ((_unitsCrew findIf {alive _x} isEqualTo -1) OR (isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget)) exitWith {};


	// Rfr 2s can be call if player have less than 7 cops chasing ( less than 3 stars)
	if ( {alive _x} count (_objTarget getVariable ["wantedLvl", []]) < 8 ) then
	{
		_objTarget spawn DK_fnc_initCopsPatrol_2sRfr;
	};

};


