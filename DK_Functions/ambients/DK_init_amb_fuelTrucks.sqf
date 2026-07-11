if !(isServer) exitWith {};


uiSleep (30 + (random 120));


private ["_posDir","_pos"];

private _exit = false;

while { true } do
{
	_posDir = call DK_fnc_slctSpawnCit;
	_pos = _posDir # 0;

	if ( (((nearestObjects [_pos,["AllVehicles"],30]) + (_pos nearEntities [["Man"], 5])) isEqualTo []) && { (playableUnits findIf { _x distance2D _pos < 300 } isEqualTo -1) && { (playableUnits findIf { [vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _pos] > 0 } isEqualTo -1) } } ) then
	{
		_exit = true;
	};

	if _exit exitWith {};

	uiSleep 5;
};

_truck = createVehicle ["C_Van_01_fuel_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"];
_truck allowDamage false;

[
	_truck,
	["Red_v2",1], 
	true

] call BIS_fnc_initVehicle;

_driver = createAgent [selectRandom ["C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_asia"], [0,0,100], [], 0, "CAN_COLLIDE"];
_driver allowDamage false;
_driver setDamage 0;
_driver disableAI "FSM";
_driver setBehaviour "CARELESS";
_driver allowFleeing 0.05;
_driver setSpeedMode "NORMAL";
_driver setVariable ["DK_behaviour", "drive"];
_driver assignAsDriver _truck;
[_driver] orderGetIn true;
[_driver] allowGetIn true;
_driver moveInDriver _truck;
_driver call DK_fnc_LO_lightTT;

_truck setDir (_posDir # 1);
_truck setPosATL _pos;
_truck setVectorUp surfaceNormal _pos;

_truck engineOn true;

_truck call DK_fnc_initTruckFuelTank;
_truck call DK_CLAG_addEH_traffic;
_driver call DK_CLAG_addEH_trafficDriver;
_driver call DK_fnc_addEH_driverCit;
[_truck, [0,9.05,-1.2], _driver] call DK_CLAG_addTrgTraffic;
_truck limitSpeed 100;

_driver setVariable ["hisCar", _truck];
_truck setVariable ["hisDriver", _driver];

_truck allowDamage true;
_driver allowDamage true;

call
{
	if (_posDir # 2 isEqualTo "N") exitWith
	{
		[_driver,_truck] spawn DK_fnc_moveCiternN;
	};

	[_driver,_truck] spawn DK_fnc_moveCiternS;
};

// _truck enableDynamicSimulation true;

/*
/// // DEBUG MARKER
private _mkrNzme = "mkr_truckCiternDbg";
_markerstr = createMarker [_mkrNzme,getPos _truck];
_markerstr setMarkerShape "ICON";
_markerstr setMarkerType "c_car";
_mkrNzme setMarkerColor "ColorOrange";
_mkrNzme setMarkerSize [0.6, 0.6];

while { alive _truck } do
{
	uiSleep 0.33;

	_mkrNzme setMarkerPos (getPos _truck);
};

deleteMarker _mkrNzme;


