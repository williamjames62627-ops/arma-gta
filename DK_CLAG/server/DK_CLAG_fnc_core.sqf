if (!isServer) exitWith {};

#define vocsJacked ["jackedCar01","jackedCar02"]

#define spdC 45
#define spdS 60
#define spdM 110

#define txtrOffR01 ["a3\soft_f\offroad_01\data\offroad_01_ext_base01_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base04_co.paa","a3\soft_f_enoch\offroad_01\data\offroad_01_ext_grn_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base02_co.paa"]


DK_wheels = ["wheel_1_1_steering","wheel_2_1_steering","wheel_1_2_steering","wheel_2_2_steering"];


DK_fnc_shuffleWalkSide_CIV_Town = {

    {
		private _cnt = (count _x) - 1;
		call
		{
			if (_cnt > 4000) exitWith
			{
				_cnt = _cnt / 9;
			};
			if ( (_cnt > 3000) && { (_cnt < 4001) } ) exitWith
			{
				_cnt = _cnt / 8;
			};
			if ( (_cnt > 2000) && { (_cnt < 3001) } ) exitWith
			{
				_cnt = _cnt / 7;
			};
			if ( (_cnt > 1500) && { (_cnt < 2001) } ) exitWith
			{
				_cnt = _cnt / 6;
			};
			if ( (_cnt > 1000) && { (_cnt < 1501) } ) exitWith
			{
				_cnt = _cnt / 5;
			};
			if ( (_cnt > 500) && { (_cnt < 1001) } ) exitWith
			{
				_cnt = _cnt / 4;
			};
			if ( (_cnt > 200) && { (_cnt < 501) } ) exitWith
			{
				_cnt = _cnt / 3;
			};
			if ( (_cnt > 50) && { (_cnt < 201) } ) exitWith
			{
				_cnt = _cnt / 2.5;
			};
			if ( (_cnt > 8) && { (_cnt < 51) } ) exitWith
			{
				_cnt = _cnt / 1.8;
			};
		};

		private _newArray = _x;
		for "_i" from 0 to _cnt do
		{
			private _pos = selectRandom _newArray;
			DK_CLAG_mkr_customPlace pushBackUnique _pos;
			_nul = _newArray deleteAt (_newArray find _pos);
		};

	} forEach DK_CLAG_CIV_sidewalks_generateArray;
};

DK_fnc_shuffleWalkSide_VPK_Town = {

	DK_CLAG_VPK_sidewalks_finalArray = [];

	{
		private _newArray = _x;

		private _cnt = (count _newArray) - 1;
		call
		{
			if (_cnt > 200) exitWith
			{
//				_cnt = _cnt / 1.7;
				_cnt = _cnt / 3;
			};
			if ( (_cnt > 150) && { (_cnt < 201) } ) exitWith
			{
//				_cnt = _cnt / 1.65;
				_cnt = _cnt / 2.1;
			};
			if ( (_cnt > 115) && { (_cnt < 154) } ) exitWith
			{
//				_cnt = _cnt / 1.6;
				_cnt = _cnt / 2;
			};
			if ( (_cnt > 90) && { (_cnt < 116) } ) exitWith
			{
//				_cnt = _cnt / 1.55;
				_cnt = _cnt / 1.9;
			};
			if ( (_cnt > 50) && { (_cnt < 91) } ) exitWith
			{
//				_cnt = _cnt / 1.45;
				_cnt = _cnt / 1.85;
			};
			if ( (_cnt > 30) && { (_cnt < 51) } ) exitWith
			{
//				_cnt = _cnt / 1.35;
				_cnt = _cnt / 1.75;
			};
			if ( (_cnt > 15) && { (_cnt < 31) } ) exitWith
			{
//				_cnt = _cnt / 1.2;
				_cnt = _cnt / 1.4;
			};
		};

		for "_i" from 0 to _cnt do
		{
			private _pos = selectRandom _newArray;
			DK_CLAG_VPK_sidewalks_finalArray pushBackUnique _pos;
			_nul = _newArray deleteAt (_newArray find _pos);
		};

	} forEach DK_CLAG_VPK_sidewalks_generateArray;
};

DK_fnc_CLAG_trgHurtCiv = {

	params ["_time", "_grpAry", "_civ01", ["_width", "no"]];


	uiSleep _time;

	if ((_civ01 getVariable "DK_behaviour" isEqualTo "chat") OR (_civ01 getVariable "DK_behaviour" isEqualTo "walk")) then
	{
		private ["_rad","_pos"];

		_count = count _grpAry;

		if (_count > 1) then
		{
		///	// get all postions
			private _civsPos = [];
			{
				private _posX = _x modelToWorldVisual [0,0,1];
				_civsPos pushBackUnique _posX;

			} forEach _grpAry;

		///	// find center
			private _vectors = _civsPos # 0;
			for '_i' from 1 to (_count - 1) step 1 do
			{
				_vectors = _vectors vectorAdd (_civsPos # _i);
			};

			_pos = _vectors vectorMultiply (1 / _count);

		///	// choose radius
			private _distances = [];
			{
				_distances pushBack (_pos distance2D _x);

			} forEach _civsPos;
			_rad = (selectMax _distances) + 0.2;
		}
		else
		{
			_pos = _civ01 modelToWorldVisual [0,0,1];
			_rad = 0.6;
		};

	///	// create trigger
		private _trg = createTrigger ["EmptyDetector", [0,0,0], false];
		_trg setPos _pos;

		if (_width isEqualTo "no") then
		{
			_trg setTriggerArea [_rad, _rad, 0, false, 1.2];
		}
		else
		{
			_trg setTriggerArea [_width, _rad, getDir _civ01, true, 1.2];
		};

		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		_trg setTriggerStatements [" !(('Man' countType thisList) isEqualTo 0) ",
		"
			[thisTrigger getVariable 'leader',thisList # 0,false] call DK_fnc_EH_Flee_CivFoot;

			deleteVehicle thisTrigger;
		",
		"
		"];

		_civ01 setVariable ["trgHurtCiv", _trg];
		_trg setVariable ["leader", _civ01];
	};
};


DK_fnc_createMoneyUnit = {

	params ["_unit", "_gain"];


	private _money = createVehicle ["Land_Money_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	call
	{
		if ((stance _unit) isEqualTo "CROUCH") exitWith
		{
			_money setPos (_unit modelToWorld [0,0,0.44]);
		};
		if ((stance _unit) isEqualTo "PRONE") exitWith
		{
			_money setPos (_unit modelToWorld [0,0,0]);
		};

		_money setPos (_unit modelToWorld [0,0,0.88]);
	};

	_money setVelocity [(random 4) - 2, (random 4) - 2, 2];
	[_money,45,60,true] spawn DK_fnc_addAllTo_CUM;

	_money setVariable ["gain", _gain, true];

///	// ADD Action to all player's
	if (hasInterface) exitWith
	{
		_money remoteExecCall ["DK_fnc_moneyAddAct", 0];
	};

	_money remoteExecCall ["DK_fnc_moneyAddAct", -2];
};

DK_fnc_CLAG_slctCivSay = {

	switch (selectRandom [1,2,3]) do
	{
		case 1:
		{
			if (hasInterface) exitWith
			{
				_this remoteExecCall ["DK_fnc_pedsAddAct_A", 0];
			};

			_this remoteExecCall ["DK_fnc_pedsAddAct_A", -2];
		};

		case 2:
		{
			if (hasInterface) exitWith
			{
				_this remoteExecCall ["DK_fnc_pedsAddAct_B", 0];
			};

			_this remoteExecCall ["DK_fnc_pedsAddAct_B", -2];
		};

		case 3:
		{
			if (hasInterface) exitWith
			{
				_this remoteExecCall ["DK_fnc_pedsAddAct_C", 0];
			};

			_this remoteExecCall ["DK_fnc_pedsAddAct_C", -2];
		};
	};
};


// Waypoints
DK_fnc_CLAG_doWalkPed = {

	private "_nearestRoad";
	call
	{
		_nearestRoad = [_this getPos [70, getDir _this], 70] call BIS_fnc_nearestRoad;
		if !(_nearestRoad isEqualTo objNull) exitWith
		{
			_this moveTo (getPosATL _nearestRoad);
		};

		call
		{
			_nearestRoad = [getPosATL _this, 250] call BIS_fnc_nearestRoad;
			if !(_nearestRoad isEqualTo objNull) exitWith
			{
				_this moveTo (getPosATL _nearestRoad);
			};

			_nearestRoad = [(selectRandom DK_CLAG_normalHouses_Ary) getVariable ["mkrPos", [worldSize / 2, worldSize / 2, 0]], 400] call BIS_fnc_nearestRoad;
			_this moveTo (getPosATL _nearestRoad);
		};
	};

	[_this, _nearestRoad] spawn
	{
		params ["_walker", "_nearestRoad"];


	//	uiSleep ((_nearestRoad distance2D _walker) / 2);
		private _time = time + (_nearestRoad distance2D _walker);
		waitUntil { uiSleep 4; (time > _time) OR (_nearestRoad distance2D _walker < 7) };

		if ( (!isNil "_walker") && { (!isNull _walker) && { (alive _walker) && { (_walker getVariable ["DK_behaviour", ""] isEqualTo "walk") } } } ) then
		{
			_nearestRoad = getPosATL (selectRandom (roadsConnectedTo _nearestRoad));

			if (isNil "_nearestRoad") then
			{
				_nearestRoad = [["DK_mkr_gameZone"], ["water"]] call BIS_fnc_randomPos;
			};

			_walker moveTo _nearestRoad;

			DK_CLAG_WalkingPeds pushBackUnique [_walker, time + (_nearestRoad distance2D _walker), _nearestRoad];
		};
	};
};

DK_fnc_CLAG_wpDriver = {

	params ["_unit", "_distance", "_rdmPos", "_nil", "_pos"];


	private _exit = false;
	private _veh = vehicle _unit;
	private _blackArea = +DK_mkrs_spawnProtect + ["DK_MTW_mkr_limitMap_1"];

	private _allRoads = (_unit getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) - 20) + (random 40) ]) nearRoads (_distance /2);

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
//			hint ("allRoads : " + (str _cnt) + " : " + (str _i));

			_rdmPos = selectRandom _allRoads;

			if ( (!isNil "_rdmPos") && { (_blackArea findIf { (getMarkerPos  _x) distance2D _rdmPos < 2000 } isEqualTo -1) && { (DK_blackListWP findIf { _rdmPos inArea _x } isEqualTo -1) && { ((nearestTerrainObjects [_rdmPos, [], 20, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) } } } ) exitWith
			{
				_exit = true;
			};

			_nil = _allRoads deleteAt (_allRoads find _rdmPos);
			_rdmPos = nil;
		}
		else
		{
//			hint ("Angle : " + (str _cnt) + " : " + (str _i));

			call
			{
				if (_angleLaps < 2) exitWith
				{
					if (_angle isEqualTo 1) exitWith
					{
						_allRoads = (_veh getPos [_distance, (getDir _veh) + 75]) nearRoads (_distance /2);

						if (count _allRoads > 60) then
						{
							_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
						};

						_angle = 2;
						_angleLaps = _angleLaps + 1;
					};

					if (_angle isEqualTo 2) exitWith
					{
						_allRoads = (_veh getPos [_distance, (getDir _veh) - 75]) nearRoads (_distance /2);

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

				_allRoads = (_veh getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) + _angle) ]) nearRoads (_distance /2);

				if (count _allRoads > 60) then
				{
					_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
				};

				_angle = _angle + 10;
				_angleLaps = _angleLaps + 1;
			};
		};

		if ( (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_exit) OR (time > _time) OR (_angleLaps > 38) ) exitWith {};

		uiSleep 0.05;
	};


	if (!isNil "_rdmPos") then
	{
		_rdmPos = getPosATL _rdmPos;
	}
	else
	{
		_rdmPos = DK_centerPostionMap;
	};

	if (alive _unit) then
	{
		_unit moveTo _rdmPos;

/*		// DEBUG
		private _mkrNzme = str (random 1000);
		private _markerstr = createMarker [_mkrNzme, _rdmPos];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [50, 50];
		// DEBUG
*/
		uiSleep 3;

		if ( (isNil "_unit") OR (isNull _unit) OR (!alive _unit) ) exitWith {};


		_veh = vehicle _unit;
		_time = time + ((_unit distance2D _rdmPos) / 2.2);
		_veh setVariable ["wpPos", getPosATL _veh];

		DK_CLAG_arr_manageWp pushBack [_unit, _veh, _time, _distance, _rdmPos];
	};
};

DK_fnc_CLAG_wpDriver_2 = {

	params ["_unit", "_roadPos", "_dis"];


	_unit moveTo _roadPos;

	private "_pos";

	uiSleep 1;
	if ( (isNil "_unit") OR (isNull _unit) OR (!alive _unit) ) exitWith {};


	private _veh = vehicle _unit;
	private _time = time + 60;
	_veh setVariable ["wpPos", getPosATL _veh];

	DK_CLAG_arr_manageWp pushBack [_unit, _veh, _time, _dis, _roadPos];
};

DK_fnc_manageSpdTraff = {

	params ["_unit", "_vehicle"];


	if ((rating _unit < 0) OR (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (isNil "_vehicle") OR (isNull _vehicle) OR (!canMove _vehicle) ) exitWith {};

	if !((DK_CLAG_Traffic_mkr_mainRoads findIf {_unit inArea _x}) isEqualTo -1) exitWith
	{
		_vehicle limitSpeed spdM;
	};

	if !((DK_mkrs_centerCity findIf {_unit inArea _x}) isEqualTo -1) exitWith
	{
		_vehicle limitSpeed spdC;
	};

	_vehicle limitSpeed spdS;
};

DK_fnc_manageFrcRoadTraff = {

	params ["_vehicle", "_pos"];


	if ( (isNil "_vehicle") OR (isNull _vehicle) OR (!canMove _vehicle) ) exitWith {};

	if ( (_vehicle getVariable ["isForceRoad", true]) && { (_pos distance2D _vehicle < 3) && { ( (isNil {_vehicle getVariable ["DK_CLAG_trgAtch", nil]}) OR !(triggerActivated (_vehicle getVariable ["DK_CLAG_trgAtch", t_covermap_1])) ) } } ) then
	{
		_vehicle setVariable ["isForceRoad", false];
		_vehicle forceFollowRoad false;

		_vehicle spawn
		{
			uiSleep 10;

			if ( (isNil "_this") OR (isNull _this) OR (!canMove _this) OR (!alive _this) OR (_this getVariable ["inAlert", false]) ) exitWith {};

			_this setVariable ["isForceRoad", true];
			_this forceFollowRoad true;
		};
	};
};


DK_fnc_CLAG_wpBanditDriver = {

	if (!isServer) exitWith {};

	params ["_unit", "_distance", "_rdmPos", "_nil"];


	private _exit = false;
	private _veh = vehicle _unit;
	private _blackArea = +DK_mkrs_spawnProtect + ["DK_MTW_mkr_limitMap_1"];

//	vehtest = _veh;

	private _allRoads = (_unit getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) - 20) + (random 40) ]) nearRoads (_distance /2);

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

			if ( (!isNil "_rdmPos") && { (_blackArea findIf { (getMarkerPos  _x) distance2D _rdmPos < 2000 } isEqualTo -1) && { (DK_blackListWP findIf { _rdmPos inArea _x } isEqualTo -1) } } ) exitWith
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
						_allRoads = (_veh getPos [_distance, (getDir _veh) + 75]) nearRoads (_distance /2);

						if (count _allRoads > 60) then
						{
							_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
						};

						_angle = 2;
						_angleLaps = _angleLaps + 1;
					};

					if (_angle isEqualTo 2) exitWith
					{
						_allRoads = (_veh getPos [_distance, (getDir _veh) - 75]) nearRoads (_distance /2);

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

				_allRoads = (_veh getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) + _angle) ]) nearRoads (_distance /2);

				if (count _allRoads > 60) then
				{
					_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
				};

				_angle = _angle + 10;
				_angleLaps = _angleLaps + 1;
			};
		};

		if ((_exit) OR (time > _time) OR (_angleLaps > 38) OR (!alive _unit)) exitWith {};

//		uiSleep 0.02;
		uiSleep 0.05;
	};

	if (!isNil "_rdmPos") then
	{
		_rdmPos = getPos _rdmPos;
	}
	else
	{
		_rdmPos = DK_centerPostionMap;
	};

	if (alive _unit) then
	{
		_unit doMove _rdmPos;

		uiSleep 3;

//		_time = time + (_unit distance2D _rdmPos) / 2;
		_time = time + (_unit distance2D _rdmPos) / 2.2;
		waitUntil
		{
			uiSleep 1;
			(isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_unit distance2D _rdmPos < 95) OR !(_unit getVariable ["DK_behaviour", ""] isEqualTo "bandit") OR (time > _time)
		};

		if ( (alive _unit) && { (_unit getVariable ["DK_behaviour", ""] isEqualTo "bandit") } )then
		{
			[_unit,_distance] call DK_fnc_CLAG_wpBanditDriver;

			if !(canMove _veh) then
			{
				uiSleep 3;
				if (alive _unit) then
				{
					_unit selectWeapon (secondaryWeapon  _unit);
				};
			};
		};
	};
};


DK_fnc_rdm_civPanic_MoveTo = {

	params ["_runner", "_tracker", "_dis", "_rdmPos"];


	private _continue = true;

	uiSleep (random 1.5);

	if (!alive _runner) exitWith
	{
		_continue = false;
	};

	_rdmPos = [[[(_runner getPos [_dis, _tracker getDir _runner]),150]], [[getPosASL _tracker,100],"water"]] call BIS_fnc_randomPos;

	if (_rdmPos isEqualTo [0,0]) then
	{
		sleep 0.5;

		if (!alive _runner) exitWith
		{
			_continue = false;
		};

		_rdmPos = [[[(_runner getPos [(_dis), _tracker getDir _runner]),250]], [[getPosASL _tracker,80],"water"]] call BIS_fnc_randomPos;

		if (_rdmPos isEqualTo [0,0]) then
		{
			sleep 0.5;

			for "_y" from 0 to 15 step 1.5 do
			{
				if (!alive _runner) exitWith
				{
					_continue = false;
				};

				_rdmPos = [[[(_runner getPos [(_dis) - (_y*10), random 360]),250]], [[getPosASL _tracker,80],"water"]] call BIS_fnc_randomPos;

				if !(_rdmPos isEqualTo [0,0]) exitWith {};
				uiSleep 0.5;

				if (_y > 14) then
				{
					_continue = false;
				};
			};
		};
	};

	if ( (_continue) && { (alive _runner) } ) then
	{
		_rdmPos set [2,0];
		_runner moveTo _rdmPos;

		uiSleep 1;
		for "_y" from 0 to 60 step 4 do
		{
			uiSleep 5;
			if ((!alive _runner) OR (_runner distance2D _rdmPos < 50)) exitWith {};
		};

		if (alive _runner) then
		{
			[_runner, _runner findNearestEnemy _runner, 500] spawn DK_fnc_rdm_civPanic_MoveTo;
		};
	};
};

DK_fnc_rdm_civBanditPanic_DoMove = {

	params ["_runner","_tracker","_dis","_rdmPos"];


	private _continue = true;

	call
	{
		_rdmPos = [[[(_runner getPos [_dis, _tracker getDir _runner]),150]], [[getPosASL _tracker,100],"water"]] call BIS_fnc_randomPos;
		if !(_rdmPos isEqualTo [0,0]) exitWith {};
		sleep 0.4;

		_rdmPos = [[[(_runner getPos [_dis - 100, _tracker getDir _runner]),100]], [[getPosASL _tracker,80],"water"]] call BIS_fnc_randomPos;
		if !(_rdmPos isEqualTo [0,0]) exitWith {};
		sleep 0.4;

		for "_y" from 0 to 60 step 1 do
		{
			if (!alive _runner) exitWith { _continue = false; };

			_rdmPos = [[[(_runner getPos [_dis - 50, random 360]),150]], [[getPosASL _tracker,80],"water"]] call BIS_fnc_randomPos;
			if !(_rdmPos isEqualTo [0,0]) exitWith {};
			sleep 0.75;

			if (_y isEqualTo 59) then
			{
				_continue = false;
			};
		};
	};



	if ( (_continue) && { (alive _runner) } ) then
	{
		_rdmPos set [2,0];
		_runner doMove _rdmPos;

		sleep 1;
		for "_y" from 0 to 60 step 4 do
		{
			sleep 5;
			if (_runner distance2D _rdmPos < 50) exitWith {};
			sleep 5;
			if (_runner distance2D _rdmPos < 50) exitWith {};
			sleep 5;
			if (!alive _runner) exitWith {};
		};

		if (alive _runner) then
		{
			[_runner, _runner findNearestEnemy _runner, 250] spawn DK_fnc_rdm_civBanditPanic_DoMove;
		};
	};
};


DK_fnc_CLAG_carJackedAnim = {

	params ["_civ","_jack"];


	_civ removeAllEventHandlers "firedNear";
	_civ removeAllEventHandlers "Hit";

	private _pos = getPosATL _jack;

	_civ setDir (_civ getDir _pos);

	uiSleep 0.15;

	unassignVehicle _civ;
	[_civ] orderGetIn false;
	[_civ] allowGetIn false;

	private _sound = selectRandom vocsJacked;
	[_this, _sound, 95, 1, true] call DK_fnc_say3D;
	[_civ, 2] spawn DK_fnc_randomLip;

	_civ forceWalk false;
	_civ setBehaviour "AWARE";
	_civ forceSpeed 50;
	_civ allowFleeing 1;
	_civ setspeedmode "FULL";

	private _rdmWP = [nil, [[_pos,1000],"water"]] call BIS_fnc_randomPos;
	_civ moveTo _rdmWP; 
};


DK_fnc_CLAG_eventCBD_smokeEngine = {

	[_this, "hitengine", 0.8] remoteExecCall ["DK_fnc_setHitPoint", _this];

	while { alive _this } do
	{
		sleep (1 + (random 14));

		if (isNull _this) exitWith {};

		private _crateSmk = createVehicle ["Box_NATO_Grenades_F", [0,0,200], [], 0, "CAN_COLLIDE"];
		_crateSmk hideObjectGlobal true;
		_crateSmk disableCollisionWith _this;
		_crateSmk attachTo [_this,[0,1.5,-0.7]];
		_crateSmk setDamage 1;
		[_this, "hitengine", 0.8] remoteExecCall ["DK_fnc_setHitPoint", _this];

		sleep (1 + (random 14));

		deleteVehicle _crateSmk;
	};
};


DK_fnc_CLAG_doMoveBoat = {

	params ["_units", ["_dis", 650]];


	private "_pos";

	private _angle = 0;
	private _isPosi = selectRandom [true,false];
	private _dir = getDir (vehicle _units);

	while { !(isNil "_units") && { !(isNull _units) && { (alive _units) && { !(isNull (objectParent _units)) } } } } do
	{
		_pos = [[[_units getPos [_dis, _dir + _angle], 200]], ["ground"]] call BIS_fnc_randomPos;

		if ( !(_pos isEqualTo [0,0]) && { (_pos isEqualType []) } ) exitWith {};

		if ((_angle > 359) OR (_angle < -359)) exitWith
		{
			_pos = [0,0];
		};

		call
		{
			if _isPosi exitWith
			{
				_angle = _angle + 20;
			};

			_angle = _angle - 20;
		};

		uiSleep 0.8;
	};

	if ((isNil "_pos") OR (isNil "_units") OR (isNull _units) OR (!alive _units)) exitWith {};

	call
	{
		if (isAgent teamMember _units) exitWith
		{
			_units moveTo _pos;
		};

		_units doMove _pos;
	};

	private _time = time + ((_pos distance2D _units) / 2.3);

	while { !(isNil "_units") && { !(isNull _units) && { (alive _units) && { !(isNull (objectParent _units)) && { (time < _time) && { (_pos distance2D _units > 70) } } } } } } do
	{
		uiSleep 2;
	};

	if ((isNil "_units") OR (isNull _units) OR (!alive _units)) exitWith {};

	_units call DK_fnc_CLAG_doMoveBoatNext;
};

DK_fnc_CLAG_doMoveBoatNext = {

	private ["_pos", "_angleEnd"];

	private _rad = 10;

	private _angle = random 360;
	private _isPosi = selectRandom [true,false];

		call
		{
			if _isPosi exitWith
			{
				_angleEnd = _angle + 720;
			};

			_angleEnd = _angle - 720;
		};


	while { !(isNil "_this") && { !(isNull _this) && { (alive _this) && { !(isNull (objectParent _this)) } } } } do
	{
		_pos = [[[_this getPos [(160 + _rad), _angle], (40 + _rad)]], ["ground"]] call BIS_fnc_randomPos;

		if ( !(_pos isEqualTo [0,0]) && { (_pos isEqualType []) } ) exitWith {};

		if ( ((_isPosi) && { (_angle > _angleEnd) }) OR (!(_isPosi) && { (_angle < _angleEnd) }) ) exitWith
		{
			_pos = [0,0];
		};

		call
		{
			if _isPosi exitWith
			{
				_angle = _angle + 20;
			};

			_angle = _angle - 20;
		};


		if (_rad < 150) then
		{
			_rad = _rad + 10;
		};

		uiSleep 0.8;
	};

	if ((isNil "_pos") OR (isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	call
	{
		if (isAgent teamMember _this) exitWith
		{
			_this moveTo _pos;
		};

		_this doMove _pos;
	};

	private _time = time + ((_pos distance2D _this) / 2.3);

	while { !(isNil "_this") && { !(isNull _this) && { (alive _this) && { !(isNull (objectParent _this)) && { (time < _time) && { (_pos distance2D _this > 70) } } } } } } do
	{
		uiSleep 2;
	};

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	_this call DK_fnc_CLAG_doMoveBoatNext
};

DK_fnc_CLAG_followBoat = {

	params ["_master","_follower"];


	while { (alive _follower) && { !(_follower isEqualTo (vehicle _follower)) && { (alive _master) && { !(_master isEqualTo (vehicle _master)) } } } } do
	{
		_follower moveTo (_master modelToWorldVisual [10,0,0]);

		uiSleep 4;
	};

	if ( (alive _follower) && { !(_follower isEqualTo (vehicle _follower)) } ) then
	{
		_follower setSpeedMode "FULL";
		(vehicle _follower) limitSpeed 200;

		[_follower] call DK_fnc_CLAG_doMoveBoat;
	};
};


// Vehicles color
DK_fnc_CLAG_vehColor = {

	params ["_veh", "_class"];


	private "_trgPos";

	switch (_class) do
	{
		case "C_SUV_01_F" :
		{
			[
				_veh,
				[selectRandom ["Black","Grey","Orange","Red"],1], 
				true

			] call BIS_fnc_initVehicle;

			_trgPos = [0,9.35,-0.88];
		};

		case "B_G_Offroad_01_F" :
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

			_trgPos = [0,9.65,-0.94];
		};

		case "C_Offroad_01_F" :
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

		case "C_Offroad_01_covered_F" :
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

		case "C_Hatchback_01_F" :
		{
			[
				_veh,
				[selectRandom ["Beige","Dark","Blue","Black","Grey","Green","Yellow"],1], 
				true

			] call BIS_fnc_initVehicle;

			_trgPos = [0,9.18,-0.73];
		};

		case "C_Hatchback_01_sport_F" :
		{
			[
				_veh,
				[selectRandom ["Beige","Blue","Red","White","Green"],1], 
				true

			] call BIS_fnc_initVehicle;

			_trgPos = [0,9.18,-0.73];
		};

		case "C_Offroad_02_unarmed_F" :
		{
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

			_trgPos = [0,9.3,-0.89];
		};
	};


	_trgPos
};


// THX KillzoneKid
KK_fnc_arrayShuffle = {

    private _cnt = count _this;

    for "_i" from 1 to _cnt do
	{
        _this pushBack (_this deleteAt floor random _cnt);
    };

    _this
};


