if !(isServer) exitWith {};

#define DelInCUM(TODEL) _nul = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find TODEL)
#define DelInEmpV(TODEL) _nul = DK_emptyVeh deleteAt (DK_emptyVeh find TODEL)

#define DK_posStartCiternInit [ [[26879.4,23814.7,0],75,"N"],[[26685.8,24612.2,0],180,"N"],[[27403,24461.7,0],160,"N"],[[27029.5,22739.3,0],308,"N"],[[20715.2,7201.65,0],171,"S"],[[20855.4,6553.39,-0.0517311],0,"S"],[[20440.5,6118.25,-0.0199738],25,"S"] ]

DK_posStartCitern = DK_posStartCiternInit;


DK_fnc_initTruckFuelTank = {

	addToRemainsCollector [_this];
	clearItemCargoGlobal _this;

	DK_emptyVeh pushBackUnique _this;

	_this addEventHandler ["GetIn",
	{
		params ["_veh"];


		if !( (crew _veh) findIf {alive _x} isEqualTo -1 ) then
		{
			DelInCUM(_veh);
			_veh setVariable ["cleanUpOn",false];
			DK_emptyVeh pushBackUnique _veh;
		};
/*
/*		if !(dynamicSimulationEnabled _veh) then
		{
			_veh enableDynamicSimulation true;
		};
*/
/*		if (dynamicSimulationEnabled _veh) then
		{
			_veh enableDynamicSimulation false;
		};
*/	}];

	_this addEventHandler ["Dammaged",
	{
		params ["_veh","_selection","_damage","_hitIndex","_hitPoint"];


		// Check for spawn fired fuel tank & make big explosion after 10sec
		if (_hitIndex isEqualTo 4) then
		{
			if (_damage isEqualTo 1) then
			{
				_veh call DK_fnc_check_exploseTruckFuelTank;
			};
		};

		// Check for spawn fired engine & explose this
		if ( (_hitIndex isEqualTo 6) && { (_damage > 0.89) } ) then
		{
			_veh call DK_fnc_check_smokeTruckEngineFuelTank;
		};

		// Check for spawn smoked engine if veh is dead
		if (_hitPoint isEqualTo "hithull") then
		{
			_veh spawn DK_fnc_check_smokeAloneTruckEngineFuelTank;
		};
	}];

	_this addEventHandler ["Killed",
	{
		params ["_veh"];


		if ( !(_veh getVariable ["smokedTank", false]) && { !(_veh getVariable ["smoked", false]) } ) then
		{
			_veh setVariable ["smoked", true];

			if !(_veh getVariable ["inExpTruckCit", false]) then
			{
				_veh call DK_fnc_expTruckFuelTank;
			};
		};

//		_veh enableDynamicSimulation false;
//		_veh enableSimulationGlobal true,
		_veh setVariable ["cleanUpOn",true];
		DelInEmpV(_veh);
		DelInCUM(_veh);
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_veh"];


		private _attahcedObjects = attachedObjects _veh;
		if !(_attahcedObjects isEqualTo []) then
		{
			{
				deleteVehicle _x;

			} forEach _attahcedObjects;
		};
	}];

	_this addEventHandler ["EpeContactStart",
	{
		params ["_obj1", "_obj2"];


		if !(_obj1 getVariable ["EpeOk", true]) exitWith {};

		_obj1 setVariable ["EpeOk", false];

		_obj1 spawn
		{
			uiSleep 0.1;

			if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
			{
				_this setVariable ["EpeOk", true];
			};
		};

		_spd1 = speed _obj1;
		_spd2 = speed _obj2;

		if ( !((playableUnits findIf { (_obj1 distance2D _x) < 350 }) isEqualTo -1) && { (_spd1 > 99) OR (_spd2 > 99) OR (_spd1 < -99) OR (_spd2 < -99) } ) then
		{
			_obj1 setDamage 1;
		};
	}];

	_this remoteExecCall ["DK_addEH_handleDmg_fuelTruck", 0, _this];
};


DK_fnc_slctSpawnCit = {

	private _posDir = selectRandom DK_posStartCitern;
	_nul = DK_posStartCitern deleteAt (DK_posStartCitern find _posDir);
	if (DK_posStartCitern isEqualTo []) then
	{
		DK_posStartCitern = DK_posStartCiternInit;
	};

	_posDir
};

DK_fnc_addEH_driverCit = {

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit", "", "_vehicle"];

		_unit removeEventHandler ["GetOutMan", _thisEventHandler];

		if (!alive _unit) exitWith {};

		[_unit,7,250,true] spawn DK_fnc_addAllTo_CUM;
//		_vehicle enableDynamicSimulation true;
	}];

};


DK_fnc_moveCiternWp = {

	params ["_driver", "_truck", "_pos", "_dis"];

	_driver moveTo _pos;

	private _time = time + ((_driver distance2D _pos) / 9);
	while { (driver _truck) isEqualTo _driver }  do
	{
		if ((_driver distance2D _pos < _dis) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (time > _time)) exitWith {};

		uiSleep 3;
	};
};

DK_fnc_moveCiternWpGS = {

	params ["_driver", "_truck", "_pos", "_dis"];


	_driver moveTo _pos;

	private _next = true;
	private _time = time + ((_driver distance2D _pos) / 9);
	while { (!isNil "_driver") && { (!isNull _driver) && { (driver _truck) isEqualTo _driver } } }  do
	{
		if ((_driver distance2D _pos < _dis) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

		if (time > _time) exitWith
		{
			_next = false;
		};

		uiSleep 3;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith
	{
		_next = false;
	};


	_next
};

DK_fnc_moveCiternN = {

	params ["_driver", "_truck"];


///	// Gas Station : 1
	// hint "GS : 1";
	
	if ([_driver,_truck,[25698.4,21379.4,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 2
	// hint "GS : 2";

	if ([_driver,_truck,selectRandom [[23376.2,19809.2,0],[23368.5,19791.1,0]],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};



///	// Waypoint 2
	// hint "Waypoint : 2";

	[_driver,_truck,[21244.2,17166,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 3
	// hint "GS : 3";
//	private _pos = selectRandom [[20792.7,16683.5,0],[20777.5,16654.7,0]];
	if ([_driver,_truck,[20798.1,16684.3,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 3
	// hint "Waypoint : 3";

	[_driver,_truck,[18613.2,14987.3,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 4
	// hint "Waypoint : 4";

	[_driver,_truck,[17937.5,14987.9,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 4
	// hint "GS : 4";

	if ([_driver,_truck,[17421.5,13926.4,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 5
	// hint "GS : 5";

	if ([_driver,_truck,[16740.4,12505.6,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 5a
	// hint "Waypoint : 5a";

	[_driver,_truck,[16656.9,12460,0],40] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 5b
	// hint "Waypoint : 5b";

	[_driver,_truck,[16810.2,12373,0],40] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 5c
	// hint "Waypoint : 5c";

	[_driver,_truck,[18998.2,13052.7,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 6
	// hint "GS : 6";

	if ([_driver,_truck,[19973,11424.9,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 6
	// hint "Waypoint : 6";

	[_driver,_truck,[20676.3,10273.7,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 7a
	// hint "Waypoint : 7a";

	[_driver,_truck,[20671.5,9062.84,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 7b
	// hint "Waypoint : 7b";

	[_driver,_truck,[21379.1,8109.48,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 7
	// hint "GS : 7";

	if ([_driver,_truck,[21242.1,7131.32,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

	[_driver,_truck] call DK_fnc_moveCiternS;
};

DK_fnc_moveCiternS = {

	params ["_driver", "_truck"];


///	// Gas Station : 7
	// hint "GS : 7";

	if ([_driver,_truck,[21242.1,7131.32,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 7b
	// hint "Waypoint : 7b";

	[_driver,_truck,[21379.1,8109.48,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 7a
	// hint "Waypoint : 7a";

	[_driver,_truck,[20671.5,9062.84,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 6
	// hint "Waypoint : 6";

	[_driver,_truck,[20676.3,10273.7,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 6
	// hint "GS : 6";

	if ([_driver,_truck,[19973,11424.9,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 5c
	// hint "Waypoint : 5c";

	[_driver,_truck,[18998.2,13052.7,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 5d
	// hint "Waypoint : 5d";

	[_driver,_truck,[16814.7,12701.1,0],55] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 5
	// hint "GS : 5";

	if ([_driver,_truck,[16740.4,12505.6,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 5a
	// hint "Waypoint : 5a";

	[_driver,_truck,[16656.9,12460,0],40] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 5b
	// hint "Waypoint : 5b";

	[_driver,_truck,[16810.2,12373,0],40] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 4
	// hint "GS : 4";

	if ([_driver,_truck,[17421.5,13926.4,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 4
	// hint "Waypoint : 4";

	[_driver,_truck,[17937.5,14987.9,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

///	// Waypoint 3
	// hint "Waypoint : 3";

	[_driver,_truck,[18613.2,14987.3,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 3
	// hint "GS : 3";

	if ([_driver,_truck,[20798.1,16684.3,0],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Waypoint 2
	// hint "Waypoint : 2";

	[_driver,_truck,[21244.2,17166,0],80] call DK_fnc_moveCiternWp;

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};


///	// Gas Station : 2
	// hint "GS : 2";

	if ([_driver,_truck,selectRandom [[23376.2,19809.2,0],[23368.5,19791.1,0]],20] call DK_fnc_moveCiternWpGS) then
	{
		[_truck,_driver] call DK_fnc_driverCitWait;
	};

	if ( (isNil "_driver") OR (isNull _driver) OR (!alive _driver) OR !(_driver getVariable ["DK_behaviour", ""] isEqualTo "drive")) exitWith {};

	[_driver,_truck] call DK_fnc_moveCiternN;
};

DK_fnc_driverCitWait = {

	params ["_truck", "_driver"];


	uiSleep 5;
	if ( (!isNil "_truck") && { (!isNull _truck) && { (alive _truck) && { (!isNil "_driver") && { (!isNull _driver) && { (alive _driver) && { (driver _truck isEqualTo _driver) } } } } } } ) then
	{
		_truck engineOn false;
	};

	uiSleep (60 + (random 120));
};