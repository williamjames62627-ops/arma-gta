if !(isServer) exitWith {};

worldSizeP = worldSize;
worldSizeN = - worldSize;

DK_init_amb_civPlane = {

	private "_pos";
	private _height = 70 + (random 130);

	while { true } do
	{
		_pos = [[[[20924.2,16289.1,0], [2734, 10827, 21.1, true]]]] call BIS_fnc_randomPos; // whitelist : [center, [a, b, angle, rect]]

		if ( playableUnits findIf { _x distance2D _pos < 2500 } isEqualTo -1 ) exitWith {};

		uiSleep 2;
	};

	_pos set [2,600];

	private _speed = selectRandom ["NORMAL", "LIMITED", "FULL"];


	private _posWp01 = [[[[20924.2,16289.1,0], [2734, 10827, 21.1, true]]], [[_pos,8000],"water"]] call BIS_fnc_randomPos;
	_posWp01 set [2, _height];


	private _driver = createAgent ["C_man_polo_1_F", [0,0,100], [], 0, "CAN_COLLIDE"];

	private _plane = createVehicle ["C_Plane_Civil_01_racing_F", [random 500,random 500,2000 + (random 100)], [], 0, "FLY"];
	_driver moveInDriver _plane;
	_plane setDir (_pos getDir _posWp01);
	_plane setPosATL _pos;

	_driver disableAi "TARGET";
	_driver disableAi "AUTOTARGET";
	_driver disableAI "AUTOCOMBAT";
	_driver setCaptive true;
	_driver allowFleeing 0;
	_driver setDamage 0;
	_driver setBehaviour "CARELESS";
	_driver disableAI "FSM";
	_driver assignAsDriver _plane;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver setSpeedMode _speed;

	_plane flyInHeight _height;

	_plane call DK_fnc_amb_civPLane_slctSkin;
	_plane call DK_fnc_init_vehFlyAir;

	/*
	/// // DEBUG MARKER WP 01
	[_posWp01, _plane] spawn
	{
		params ["_posWp01", "_plane"];

		private _mkrNzme1 = "mkr_planePlaneDbg_1" + (str (random 1000));
		_markerstr = createMarker [_mkrNzme1,_posWp01];
		_markerstr setMarkerShape "ICON";
		_markerstr setMarkerType "c_plane";
		_mkrNzme1 setMarkerColor "ColorYellow";
		_mkrNzme1 setMarkerSize [0.7, 0.7];

		private _mkrNzme2 = "mkr_planePlaneDbg_2" + (str (random 1000));
		_markerstr = createMarker [_mkrNzme2,getPos _plane];
		_markerstr setMarkerShape "ICON";
		_markerstr setMarkerType "c_plane";
		_mkrNzme2 setMarkerColor "ColorWhite";
		_mkrNzme2 setMarkerSize [0.8, 0.8];

		while { alive _plane } do
		{
			uiSleep 0.1;

			_mkrNzme2 setMarkerPos (getPos _plane);

		/*	private _mkrNzmeB = "mkr_planePlaneDbg_move2" + (str (random 1000));
			_markerstr = createMarker [_mkrNzmeB,getPos _plane];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "c_plane";
			_mkrNzmeB setMarkerColor "ColorWhite";
			_mkrNzmeB setMarkerSize [0.3, 0.3];
	*/
	/*	};

		deleteMarker _mkrNzme1;
		deleteMarker _mkrNzme2;
	};
	/// // DEBUG MARKER PLANE
	*/

	//Add waypoint
	_driver moveTo _posWp01;

	uiSleep 1;

	_driver call DK_fnc_addEH_amb_driverCivPlane;


	private _time = time + 240;

	while { ( !(isNil "_driver") && { !(isNull _driver) && { (alive _driver) && { (_driver distance2D _posWp01 > 550) && { !(isNull objectParent _driver) && { (time < _time) } } } } } ) } do
	{
		uiSleep 5;
	};


	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR (isNil "_plane") OR (isNull _plane) OR (!alive _plane) ) exitWith
	{
		uiSleep 15;
		[] spawn DK_init_amb_civPlane;
	};

	[_driver, _plane, _height] call DK_fnc_amb_civPlane_wp02;
};

DK_fnc_amb_civPLane_slctSkin = {

	call
	{
		_rd = selectRandom [1,2,3,4,5,6,7,8];

		if (_rd isEqualTo 1) exitWith
		{
			[
				_this,
				["Wave_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 2) exitWith
		{
			[
				_this,
				["Wave_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 3) exitWith
		{
			[
				_this,
				["Racer_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 4) exitWith
		{
			[
				_this,
				["Racer_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 5) exitWith
		{
			[
				_this,
				["RedLine_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 6) exitWith
		{
			[
				_this,
				["RedLine_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 7) exitWith
		{
			[
				_this,
				["Tribal_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_this,
			["Tribal_2",1], 
			true

		] call BIS_fnc_initVehicle;
	};
};

DK_fnc_amb_civPlane_wp02 = {

	params ["_driver", "_plane", "_height"];

	_driver moveTo [selectRandom [worldSizeP,worldSizeN], selectRandom [worldSizeP,worldSizeN], _height];

	[_driver, 30, 1250, true] spawn DK_fnc_addVehTo_CUM;
};

DK_fnc_addEH_amb_driverCivPlane = {

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		_unit removeEventHandler ["GetOutMan", _thisEventHandler];

		if (!alive _unit) exitWith {};

		[_unit,7,150,true] spawn DK_fnc_addAllTo_CUM;
	}];

	_this addEventHandler ["Deleted",
	{
		[] spawn
		{
			uiSleep 15;
			[] spawn DK_init_amb_civPlane;
		};
	}];

	_this addEventHandler ["Killed",
	{
		params ["_unit"];

		[_unit,30,50] spawn DK_fnc_addAllTo_CUM;
	}];

};


