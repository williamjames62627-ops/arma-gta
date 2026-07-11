if (!isServer) exitWith {};


DK_CLAG_TraffRoadChs = 1;
DK_countNb_traffic_CLAG = 0;
DK_vehsTrafficsAr = [];

// Max distance for deleting Driver & Vehicle
#define dis DK_CLAG_Default_DisMaxTraffic + 75

// Speed limit for Vehicle Driver
#define spdS 50
#define spdM 80

// Count vehicles number
#define CNT(NB) DK_countNb_traffic_CLAG = DK_countNb_traffic_CLAG + NB

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []

// Apply Pushback
#define LogicTraffMainPuBa(LGC) DK_CLAG_LogicsTrafficMain pushBackUnique LGC
#define LogicTraffSecPuBa(LGC) DK_CLAG_LogicsTrafficSec pushBackUnique LGC

// Create Vehicles
#define chsVehNb  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1, 2, 3, selectRandom [3, 4, 4]]
#define chsVeh selectRandom chsVehNb
#define chsVehMNb [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1, 2, 3, selectRandom [1, 4, 4]]
#define chsVehM selectRandom chsVehMNb

#define crtV(C) createVehicle [C, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]
#define crtTraffCLV call DK_fnc_crtTraff_CLV
#define crtTraffVAN call DK_fnc_crtTraff_VAN
#define crtTraffLT call DK_fnc_crtTraff_LT
#define crtTraffZAM call DK_fnc_crtTraff_ZAM
#define crtTraffFuelT call DK_fnc_crtTraff_fuelT
#define crtTraffServ call DK_fnc_crtTraff_serv

// Create Driver
#define crtU createAgent [slctH, [0,0,100], [], 0, "CAN_COLLIDE"]

// Define Classname
#define classVeh ["C_SUV_01_F", "C_SUV_01_F", "C_SUV_01_F", "B_G_Offroad_01_F", "B_G_Offroad_01_F", selectRandom ["B_G_Offroad_01_F", "C_Offroad_01_covered_F"], "C_Hatchback_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Offroad_02_unarmed_F", "C_Offroad_02_unarmed_F", "C_Offroad_02_unarmed_F"]
#define classV ["C_Van_02_transport_F","C_Van_02_vehicle_F"]
#define classLT ["C_Van_01_transport_F","C_Van_01_box_F"]
#define classZAM ["C_Truck_02_transport_F", "C_Truck_02_covered_F", "C_Truck_02_box_F"]
#define classH ["C_man_polo_1_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_asia"]

#define slctVeh selectRandom classVeh
#define slctV selectRandom classV
#define slctLT selectRandom classLT
#define slctZAM selectRandom classZAM
#define slctH selectRandom classH
#define classFUELT "C_Van_01_fuel_F"
#define classREP selectRandom ["C_Van_02_service_F","C_Offroad_01_repair_F"]

// Colors vehicles
#define vanCol ["Orange", "Masked", "Black", "White", "Red", "Syndikat", "Blue", "Green"]
#define vanBand ["Benzyna", "Astra", "BluePearl", "Daltgreen", "White", "AAN", "Fuel", "Redstone", "Swifd", "Vrana"]
#define LTcol ["Black", "Red", "White"]
#define ZamCcol ["BlueBlue", "BlueOlive", "OrangeBlue", "OrangeOlive"]
#define ZamTcol ["Orange", "Blue"]
#define ZamRcol ["BlueGreen", "BlueOrange", "Orange", "OrangeGreen"]

// Horn if colision
#define horn(V) V action ["useWeapon",V,driver V,0]

//
#define eye(X,A) [vehicle A, "IFIRE",vehicle A] checkVisibility [X call DK_fnc_eyePlace, getPosASLVisual A] > 0.3
//#define eye(X,A) [vehicle X, "IFIRE", A] checkVisibility [eyePos X, getPosASL A] > 0.3

//
#define insults ["insult01","C_civSay02","A_civSay07"]

// Sleep
#define slpPlacTake 6					// Time for OK after they are ALREADY a CIV SPAWNED at this place
#define slpEnd1 2.5
#define slpEnd2 3.5

#define slpSFT 180 + (random 180)
//#define slpSFT 1


execVM "DK_CLAG\server\DK_CLAG_loop_manageWpTraffic.sqf";


// Functions
DK_fnc_crtTraff_CLV = {

	private _class = slctVeh;
	_veh = crtV(_class);

	private _trgPos = [_veh, _class] call DK_fnc_CLAG_vehColor;
/*	private "_trgPos";
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

		case "C_Offroad_01_F" :
		{
			_bumper = selectRandom [[1,0], [0,1]];
			[
				_veh,
				[selectRandom ["Beige","Blue","Darkred","Red","White"],1], 
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

		default
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
*/
	_veh call DK_fnc_init_veh;

	private _driver = crtU;
	_driver allowDamage false;
	_driver setDamage 0;
	_driver disableAI "FSM";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0.05;
	_driver setSpeedMode "NORMAL";
	_driver setVariable ["DK_behaviour","drive"];
	_driver assignAsDriver _veh;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver moveInDriver _veh;
	_driver call DK_fnc_LO_Civ;

	[_driver,7,dis,true] spawn DK_fnc_addAllTo_CUM;

	/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh addEventHandler ["deleted",
		{
			params ["_entity"];

			deleteMarker (_entity getVariable "mkr_DEBUG");
		}];
	};
	/// // DEBUG MOD END


	// Added MP3 Player

//	[_veh, true, [["MP3music08", 23.001]]] call DK_fnc_MP3car_init;
	[_veh] call DK_fnc_MP3car_init;


	_driver allowDamage true;


	[_veh,_driver,_trgPos]
};

DK_fnc_crtTraff_VAN = {

	private _class = slctV; 
	private ["_band","_DK_fnc_LO"];

	_veh = crtV(_class);

	call
	{
		if (_class isEqualTo "C_Van_02_transport_F") exitWith
		{
			private _tire = selectRandom [0,1,1];
			[
				_veh,
				[selectRandom vanCol,1], 
				[
					"side_protective_frame_hide",selectRandom [0,1],
					"front_protective_frame_hide",selectRandom [0,1],
					"spare_tyre_holder_hide",_tire,
					"spare_tyre_hide",_tire
				]

			] call BIS_fnc_initVehicle;

			_DK_fnc_LO = DK_fnc_LO_Civ;
		};

		_band = selectRandom vanBand;
		private _tire = selectRandom [0,1,1];
		[
			_veh,
			[_band,1], 
			[
				"ladder_hide",selectRandom [0,1],
				"roof_rack_hide",0,
				"front_protective_frame_hide",selectRandom [0,1]
			]

		] call BIS_fnc_initVehicle;

		if (_band isEqualTo "AAN") exitWith
		{
			_DK_fnc_LO = DK_fnc_LO_press;
		};
		if (_band isEqualTo "Redstone") exitWith
		{
			_DK_fnc_LO = DK_fnc_LO_racerTeamRS;
		};
		if (_band isEqualTo "Vrana") exitWith
		{
			_DK_fnc_LO = DK_fnc_LO_racerTeamVR;
		};
		if (_band isEqualTo "Fuel") exitWith
		{
			_DK_fnc_LO = DK_fnc_LO_racerTeamFL;
		};
		if (_band isEqualTo "Astra") exitWith
		{
			_DK_fnc_LO = DK_fnc_LO_Astra;
		};

		_DK_fnc_LO = DK_fnc_LO_Civ;
	};

	_veh call DK_fnc_init_veh;


	private _driver = crtU;
	_driver allowDamage false;
	_driver setDamage 0;
	_driver disableAI "FSM";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0.05;
	_driver setSpeedMode "NORMAL";
	_driver setVariable ["DK_behaviour","drive"];
	_driver assignAsDriver _veh;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver moveInDriver _veh;

	_driver call _DK_fnc_LO;

	[_driver,7,dis,true] spawn DK_fnc_addAllTo_CUM;


	/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh addEventHandler ["deleted",
		{
			params ["_entity"];

			deleteMarker (_entity getVariable "mkr_DEBUG");
		}];
	};
	/// // DEBUG MOD END

	_driver allowDamage true;

	[_veh,_driver,[0,11,-1.04]]
};

DK_fnc_crtTraff_LT = {

	private _class = slctLT;
	private "_DK_fnc_LO";


	_veh = crtV(_class);

	[
		_veh,
		[selectRandom LTcol,1], 
		true

	] call BIS_fnc_initVehicle;

	call
	{
		if (_class isEqualTo "C_Van_01_transport_F") exitWith
		{
			_DK_fnc_LO = DK_fnc_LO_lightTT;
		};

		_DK_fnc_LO = DK_fnc_LO_Civ;
	};

	_veh call DK_fnc_init_veh;


	private _driver = crtU;
	_driver allowDamage false;
	_driver setDamage 0;
	_driver disableAI "FSM";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0.05;
	_driver setSpeedMode "NORMAL";
	_driver setVariable ["DK_behaviour","drive"];
	_driver assignAsDriver _veh;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver moveInDriver _veh;
	_driver call _DK_fnc_LO;

	[_driver,7,dis,true] spawn DK_fnc_addAllTo_CUM;


	/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh addEventHandler ["deleted",
		{
			params ["_entity"];

			deleteMarker (_entity getVariable "mkr_DEBUG");
		}];
	};
	/// // DEBUG MOD END

	_driver allowDamage true;

	[_veh,_driver,[0,9.05,-1.2]]
};

DK_fnc_crtTraff_ZAM = {

	private _class = slctZAM;

	_veh = crtV(_class);

	call
	{
		if (_class isEqualTo "C_Truck_02_transport_F") exitWith
		{
			[
				_veh,
				[selectRandom ZamTcol,1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_class isEqualTo "C_Truck_02_box_F") exitWith
		{
			[
				_veh,
				[selectRandom ZamRcol,1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_veh,
			[selectRandom ZamCcol,1], 
			true

		] call BIS_fnc_initVehicle;
	};

	_veh call DK_fnc_init_veh;


	private _driver = crtU;
	_driver allowDamage false;
	_driver setDamage 0;
	_driver disableAI "FSM";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0.05;
	_driver setSpeedMode "NORMAL";
	_driver setVariable ["DK_behaviour","drive"];
	_driver assignAsDriver _veh;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver moveInDriver _veh;
	_driver call DK_fnc_LO_zamack;

	[_driver,7,dis,true] spawn DK_fnc_addAllTo_CUM;

	/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh addEventHandler ["deleted",
		{
			params ["_entity"];

			deleteMarker (_entity getVariable "mkr_DEBUG");
		}];
	};
	/// // DEBUG MOD END

	_driver allowDamage true;

	[_veh,_driver,[0,10.85,-1.7]]
};

DK_fnc_crtTraff_fuelT = {

	private _veh = crtV(classFUELT);

	[
		_veh,
		["Red_v2", 1], 
		true

	] call BIS_fnc_initVehicle;

	_veh call DK_fnc_initTruckFuelTank;


	private _driver = crtU;
	_driver allowDamage false;
	_driver setDamage 0;
	_driver disableAI "FSM";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0.05;
	_driver setSpeedMode "NORMAL";
	_driver setVariable ["DK_behaviour","drive"];
	_driver assignAsDriver _veh;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver moveInDriver _veh;
	_driver call DK_fnc_LO_lightTT;

	[_driver,7,dis,true] spawn DK_fnc_addAllTo_CUM;


	/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh addEventHandler ["deleted",
		{
			params ["_entity"];

			deleteMarker (_entity getVariable "mkr_DEBUG");
		}];
	};
	/// // DEBUG MOD END

	_driver allowDamage true;

	[_veh,_driver,[0,9.05,-1.2]]
};

DK_fnc_crtTraff_serv = {

	_veh = crtV(classREP);

	_veh call DK_fnc_init_veh;


	private _driver = crtU;
	_driver allowDamage false;
	_driver setDamage 0;
	_driver disableAI "FSM";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0.05;
	_driver setSpeedMode "NORMAL";
	_driver setVariable ["DK_behaviour","drive"];
	_driver assignAsDriver _veh;
	[_driver] orderGetIn true;
	[_driver] allowGetIn true;
	_driver moveInDriver _veh;
	_driver call DK_fnc_LO_RepairSafe;

	[_driver,7,dis,true] spawn DK_fnc_addAllTo_CUM;


	/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh addEventHandler ["deleted",
		{
			params ["_entity"];

			deleteMarker (_entity getVariable "mkr_DEBUG");
		}];
	};
	/// // DEBUG MOD END

	_driver allowDamage true;

	[_veh, _driver, [0,9.65,-0.94]]
};


DK_fnc_CLAG_crtTRAFFIC =  {

	params ["_roadCore", "_playerNrst"];


	_roadPos = _roadCore # 0;

	if !( PlaceOK(_roadPos,35,25) ) exitWith
	{
		DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + slpPlacTake)];
	};

	_roadPos set [2,0];
	private _disAry = [];
	for "_i" from 1 to (count _roadCore) - 1 step 1 do
	{
		_disAry pushBack ((_roadCore # _i) # 0 distance2D _playerNrst);
	};

	private "_vehCrew";

	call
	{
		_type = chsVeh;
		if (_type isEqualTo 1) exitWith
		{
			_vehCrew = crtTraffCLV;

		};
		if (_type isEqualTo 2) exitWith
		{
			_vehCrew = crtTraffVAN;

		};
		if (_type isEqualTo 3) exitWith
		{
			_vehCrew = crtTraffLT;

		};

		_vehCrew = crtTraffZAM;
	};


	_vehCrew params ["_veh", "_civil", "_trgPos"];

	private _goodDis = _disAry findIf { (selectMin _disAry) isEqualTo _x };
	if !(_goodDis isEqualTo -1) then
	{
		_veh setDir	((_roadCore # (_goodDis + 1)) # 1 );
	};

	_veh setPosATL _roadPos;
	_veh setVectorUp surfaceNormal _roadPos;

	_veh setFuel (0.5 + (random 0.5));

	_veh forceFollowRoad true;
	_veh engineOn true;

	call
	{
		if (DK_CLAG_TraffRoadChs isEqualTo 1) exitWith
		{
			DK_CLAG_TraffRoadChs = 2;
			[_civil, 1000] spawn DK_fnc_CLAG_wpDriver;
		};

		private _road = [getPosWorld _playerNrst, 70] call BIS_fnc_nearestRoad;
		if ( !(_road isEqualTo objNull) && { ((nearestTerrainObjects [_road, [], 20, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) } ) exitWith
		{
			DK_CLAG_TraffRoadChs = 1;
			[_civil, getPosATL _road, 1000] spawn DK_fnc_CLAG_wpDriver_2;
		};

		[_civil, 1000] spawn DK_fnc_CLAG_wpDriver;		
	};

	_veh call DK_CLAG_addEH_traffic;
	_civil call DK_CLAG_addEH_trafficDriver;
	[_veh, _trgPos, _civil] call DK_CLAG_addTrgTraffic;
	_veh limitSpeed spdS;
	_civil setFormation "COLUMN";

	_civil setVariable ["hisCar", _veh];
	_veh setVariable ["hisDriver", _civil];

	_civil addRating 500;
	CNT(1);
	DK_vehsTrafficsAr pushBackUnique [_veh, _civil];


	[_veh, _roadPos, _roadCore, _civil] spawn
	{
		params ["_veh", "_roadPos", "_roadCore", "_civil"];


		uiSleep slpEnd1;

		if ( (_veh distance2D _roadPos < 0.8) && { (playableUnits findIf { eye(_x,_veh)} isEqualTo -1) } ) then
		{
			_veh deleteVehicleCrew _civil;

			waitUntil { ( ((crew _veh) isEqualTo []) && { (isNil "_civil") OR (isNull _civil) } ) };

			deleteVehicle _veh;
		};

		DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + slpEnd2)];
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorOrange";
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

DK_fnc_CLAG_crtTRAFFICm =  {

	params ["_roadCore","_playerNrst"];


	_roadPos = _roadCore # 0;

	if !( PlaceOK(_roadPos,40,25) ) exitWith
	{
		DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + slpPlacTake)];
	};

	private "_roadToGo";
	for "_i" from 0 to 10 step 1 do
	{
		_roadToGo = (selectRandom DK_CLAG_trafficMainRoads) # 0;

		if ((_roadToGo distance2D _roadPos) > 500) exitWith {};
	};

	_roadPos set [2,0];
	private _disAry = [];
	for "_i" from 1 to (count _roadCore) - 1 step 1 do
	{
		_disAry pushBack ((_roadCore # _i) # 0 distance2D _roadToGo);
	};

	private "_vehCrew";

	call
	{
		_type = chsVehM;
		if (_type isEqualTo 1) exitWith
		{
			_vehCrew = crtTraffCLV;

		};
		if (_type isEqualTo 2) exitWith
		{
			_vehCrew = crtTraffVAN;

		};
		if (_type isEqualTo 3) exitWith
		{
			_vehCrew = crtTraffLT;

		};

		_vehCrew = crtTraffZAM;
	};


	_vehCrew params ["_veh", "_civil", "_trgPos"];

	private _goodDis = _disAry findIf { (selectMin _disAry) isEqualTo _x };
	if !(_goodDis isEqualTo -1) then
	{
		_veh setDir	((_roadCore # (_goodDis + 1)) # 1 );
	};

	_veh setPosATL _roadPos;
	_veh setVectorUp surfaceNormal _roadPos;

	_veh setFuel (0.5 + (random 0.5));

	_veh forceFollowRoad true;
	_veh engineOn true;

	[_civil, _roadToGo, 1000] spawn DK_fnc_CLAG_wpDriver_2;

	_veh call DK_CLAG_addEH_traffic;
	_civil call DK_CLAG_addEH_trafficDriver;
	[_veh, _trgPos, _civil] call DK_CLAG_addTrgTraffic;
	_veh limitSpeed spdM;
	_civil setFormation "COLUMN";

	_civil setVariable ["hisCar", _veh];
	_veh setVariable ["hisDriver", _civil];

	_civil addRating 500;
	CNT(1);
	DK_vehsTrafficsAr pushBackUnique [_veh, _civil];


	[_veh, _roadPos, _roadCore, _civil] spawn
	{
		params ["_veh", "_roadPos", "_roadCore", "_civil"];


		uiSleep slpEnd1;

		if ( (_veh distance2D _roadPos < 0.8) && { (playableUnits findIf { eye(_x,_veh)} isEqualTo -1) } ) then
		{
			_veh deleteVehicleCrew _civil;

			waitUntil { ( ((crew _veh) isEqualTo []) && { (isNil "_civil") OR (isNull _civil) } ) };

			deleteVehicle _veh;
		};

		DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + slpEnd2)];
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorOrange";
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

DK_fnc_CLAG_crtTRAFFICm_SFT =  {

	params ["_roadCore", "_playerNrst"];


	_roadPos = _roadCore # 0;

	if !( PlaceOK(_roadPos,45,25) ) exitWith
	{
		DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + slpPlacTake)];
	};

	DK_SFTnb = DK_SFTnb + 1;

	private "_roadToGo";
	for "_i" from 0 to 10 step 1 do
	{
		_roadToGo = (selectRandom DK_CLAG_trafficMainRoads) # 0;

		if ((_roadToGo distance2D _roadPos) > 500) exitWith {};
	};

	_roadPos set [2,0];
	private _disAry = [];
	for "_i" from 1 to (count _roadCore) - 1 step 1 do
	{
		_disAry pushBack ((_roadCore # _i) # 0 distance2D _roadToGo);
	};

	private "_vehCrew";

	call
	{
		if (selectRandom [true, false]) exitWith
		{
			_vehCrew = crtTraffServ;

		};

		_vehCrew = crtTraffFuelT;
	};


	_vehCrew params ["_veh", "_civil", "_trgPos"];

	private _goodDis = _disAry findIf { (selectMin _disAry) isEqualTo _x };
	if !(_goodDis isEqualTo -1) then
	{
		_veh setDir	((_roadCore # (_goodDis + 1)) # 1 );
	};

	_veh setPosATL _roadPos;
	_veh setVectorUp surfaceNormal _roadPos;

	_veh setFuel (0.5 + (random 0.5));

	_veh forceFollowRoad true;
	_veh engineOn true;

	[_civil, _roadToGo, 1000] spawn DK_fnc_CLAG_wpDriver_2;

	_veh call DK_CLAG_addEH_traffic;
	_civil call DK_CLAG_addEH_trafficDriver;
	[_veh, _trgPos, _civil] call DK_CLAG_addTrgTraffic;
	_veh limitSpeed spdM;
	_civil setFormation "COLUMN";

	_civil setVariable ["hisCar", _veh];
	_veh setVariable ["hisDriver", _civil];

	_civil addRating 500;
	CNT(1);
	DK_vehsTrafficsAr pushBackUnique [_veh, _civil];


	[_veh, _roadPos, _roadCore, _civil] spawn
	{
		params ["_veh", "_roadPos", "_roadCore", "_civil"];


		uiSleep slpEnd1;

		private _waitSlep = true;

		if ( (_veh distance2D _roadPos < 0.8) && { (playableUnits findIf { eye(_x,_veh)} isEqualTo -1) } ) then
		{
			_waitSlep = false;

			_veh deleteVehicleCrew _civil;

			waitUntil { ( ((crew _veh) isEqualTo []) && { (isNil "_civil") OR (isNull _civil) } ) };

			deleteVehicle _veh;
		};

		DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + slpEnd2)];

		waitUntil { uiSleep 5; (isNil "_civil") OR (isNull _civil) OR (!alive _civil) };

		if _waitSlep then
		{
			uiSleep slpSFT;
		};

		DK_SFTnb = DK_SFTnb - 1;
	};


/// // DEBUG MOD
	if (DK_CLAG_debugModMarkers_units) then
	{
		_veh spawn
		{
			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "c_car";
			_mkrNzme setMarkerColor "ColorOrange";
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



// Event Handlers
DK_CLAG_addEH_traffic = {

	private _idEH_EPS = _this addEventHandler ["EpeContactStart",
	{
		_this call DK_CLAG_EH_traffEpConStart;
	}];

	private _idEH_HD = _this addEventHandler ["HandleDamage",
	{
		private _nil = _this pushBack _thisEventHandler;
		private _damage = _this call DK_CLAG_EH_traffHandleDmg;

		_damage
	}];

	private _idEH_DMGD = _this addEventHandler ["Dammaged",
	{
		params ["_veh", "_hitSlct", "_damage"];


		[_veh,_hitSlct,_damage] call DK_CLAG_EH_traffDmgd;
	}];

	private _idEH_GetIn1 = _this addEventHandler ["GetIn",
	{
		params ["_veh", "", "_getIner"];


		if ( (isPlayer _getIner) OR (side (group _getIner) isEqualTo west) && { ((typeName _getIner) isEqualTo "OBJECT") } ) then
		{
			_veh call DK_CLAG_EH_traffGetIn;
		};
	}];

	private _idEH_Hit = _this addEventHandler ["Hit",
	{
		params ["_veh", "_killer", "", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};


		if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
		{
			[_veh, _instigator, _thisEventHandler] call DK_CLAG_EH_hitTraffCivA;
		};
	}];


	_this setVariable ["DK_CLAG_idEHs", [_idEH_EPS, _idEH_GetIn1, _idEH_DMGD, _idEH_HD, _idEH_Hit]];
};

DK_CLAG_addEH_trafficDriver = {

	_this addEventHandler ["Killed",
	{
		params ["_unit"];


		[_unit, 25, 16, true] spawn DK_fnc_addAllTo_CUM;

		private _hisCar = _unit getVariable ["hisCar", ""];

		if (_hisCar isEqualTo "") exitWith {};

		private _idEHs = _hisCar getVariable ["DK_CLAG_idEHs", []];
		if !(_idEHs isEqualTo []) then
		{
			_hisCar removeEventHandler ["EpeContactStart", _idEHs # 0];
			_hisCar removeEventHandler ["HandleDamage", _idEHs # 3];
			_hisCar removeEventHandler ["Dammaged", _idEHs # 2];
			_hisCar removeEventHandler ["Hit", _idEHs # 4];
			_hisCar removeEventHandler ["GetIn", _idEHs # 1];

			_hisCar setVariable ["DK_CLAG_idEHs", []];
		};

		deleteVehicle (_hisCar getVariable "DK_CLAG_trgAtch");
	}];

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit", "_role", "_vehicle"];


		if ( (_role isEqualTo "driver") && { (alive _unit) && { (alive _vehicle) } } ) then
		{
			_vehicle engineOn false;
		};

		_unit removeEventHandler ["GetOutMan", _thisEventHandler];
	}];

	_this call DK_fnc_addEH_getInMan_dynSim;
};


DK_CLAG_EH_traffEpConStart = {

	params ["_veh", "_object2"];


	if (_veh getVariable ["EpeOk", true]) then
	{
		_veh setVariable ["EpeOk", false];

		_veh spawn
		{
			uiSleep 0.5;

			if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
			{
				_this setVariable ["EpeOk", true];
			};
		};

		if !(isPlayer (driver (vehicle _veh))) then
		{
			[_veh, vehicle _object2] call DK_CLAG_EH_traffEpConHorn;
		};
	};
};

DK_CLAG_EH_traffHandleDmg = {

	params ["_veh", "", "_damage", "_source", "_projectile", "", "_instigator", "", "_thisEventHandler"];


	if ( ((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && { !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } } ) then
	{
		_instigator = _source;
	};


	// Normal damage if shooter is player
	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) OR ( !(_projectile isEqualTo "") && { !(_instigator getVariable  ["DK_side", ""] in ["civ", "cops", "fbi", "army"]) } ) ) exitWith
	{
		_veh removeEventHandler ["HandleDamage", _thisEventHandler];

		_damage
	};

	if (typeName _projectile isEqualTo "OBJECT") then
	{
		(getShotParents _projectile) params ["", "_instigatorBis"];
	};

	if ( (!isNil "_instigatorBis") && { (isPlayer _instigatorBis) OR (side (group _instigatorBis) isEqualTo west) } ) exitWith
	{
		_veh removeEventHandler ["HandleDamage", _thisEventHandler];

		_damage
	};

	(driver _veh) setDamage 0;
	_damage = 0;


	_damage
};

DK_CLAG_EH_hitTraffCivA = {

	params ["_car", "_shooter", "_thisEventHandler"];


	private _driver = _car getVariable "hisDriver";

	if ( (!isNil "_driver") && { (_driver getVariable ["DK_behaviour", ""] isEqualTo "drive") } ) then
	{
		if !(canMove _car) exitWith
		{
			_car removeEventHandler ["Hit", _thisEventHandler];
			[_car,_driver] call DK_CLAG_EH_hitTraffCivB;
		};

		_dis = _car distance _shooter;

		if (_dis <= 15) exitWith
		{
			_car removeEventHandler ["Hit", _thisEventHandler];
			[_car,_driver] call DK_CLAG_EH_hitTraffCivB;
		};

		if ( (_dis > 15) && { (_dis <= 220) } ) then
		{
			call
			{
				private _nearCars = (nearestObjects [_shooter, ["Car"], 50]) - [_car];
				if !(_nearCars isEqualTo []) exitWith
				{
					private _carsStop = 0;
					_nbCars = count _nearCars;
					for "_i" from 0 to _nbCars step 1 do
					{
						private _nearCar = _nearCars # _i;
						if ( (!alive (driver _nearCar)) && { (alive _nearCar) } ) then
						{
							_carsStop = _carsStop + 1;
						};
					};

					call
					{
						_car removeEventHandler ["Hit", _thisEventHandler];

						if (_carsStop isEqualTo 0) exitWith
						{
							[_car,_driver] call DK_CLAG_EH_hitTraffCivB;
						};

						if (_carsStop isEqualTo 1) exitWith
						{
							if (selectRandom [true,false]) then
							{
								[_car,_driver] call DK_CLAG_EH_hitTraffCivB;
							};

							_car limitSpeed 120;
							_driver setSpeedMode "FULL";
							_driver allowFleeing 1;

							[_car,_driver,1] spawn DK_CLAG_EH_reAddedHit;
						};

						_car limitSpeed 200;
						_car forceSpeed 200;
						_driver setSpeedMode "FULL";
						_driver allowFleeing 1;

						[_car,_driver,3] spawn DK_CLAG_EH_reAddedHit;
					};
				};

				_car removeEventHandler ["Hit", _thisEventHandler];
				[_car,_driver] call DK_CLAG_EH_hitTraffCivB;
			};

		};
	};
};

DK_CLAG_EH_hitTraffCivB = {

	params ["_car", "_driver"];


	deleteVehicle (_car getVariable "DK_CLAG_trgAtch");
	[_driver] orderGetIn false;
	[_driver] allowGetIn false;
	_driver moveTo (getPosATL _driver);
	_driver disableAI "MOVE";

	[_car, _driver] spawn
	{
		params ["_car", "_driver"];


		waitUntil { uiSleep 0.2; (isNil "_driver") OR (isNull _driver) OR (isNil "_car") OR (isNull _car) OR ( ((speed _car) < 2) && { (isTouchingGround _car) } ) OR (!alive _driver) };

		uiSleep 1;

		if ( (alive _driver) && { ((_driver getVariable ["DK_behaviour", ""]) isEqualTo "drive") } ) then
		{
			_driver setVariable ["DK_behaviour", "flee"];
			moveOut _driver;

			_car engineOn true;
			_driver spawn DK_fnc_vocCiv_Panic;
			_driver forceWalk false;
			_driver allowFleeing 1;
			_driver setSpeedMode "FULL";

			_rdmC = selectRandom [1,2,2,3];
			if (_rdmC isEqualTo 1) exitWith
			{
				[_driver,1,100,true] spawn DK_fnc_addAllTo_CUM;

				_driver enableAI "MOVE";

				uiSleep 0.5;
				[_driver,_car,500] call DK_fnc_rdm_civPanic_MoveTo;
			};

			if (_rdmC isEqualTo 2) exitWith
			{
				_driver setUnitPos "DOWN";
				uiSleep (9 + (random 40));

				if (alive _driver) then
				{
					if (selectRandom [true,false]) exitWith
					{
						[_driver,selectRandom insults,145,1,true] call DK_fnc_say3D;
						_driver enableAI "MOVE";
						[_driver] orderGetIn true;
						[_driver] allowGetIn true;
						_driver setUnitPos "UP";

						uiSleep 1.5;

						private _running = true;
						if ( (canMove _car) && { ((DK_wheels findIf { (_car getHit _x) isEqualTo 1 }) isEqualTo -1) } ) then
						{
							_running = false;

							_driver moveInDriver _car;
							_driver setVariable ["DK_behaviour", "drive"];
							_car limitSpeed 200;
							[_driver,1000] spawn DK_fnc_CLAG_wpDriver;
						};

						if _running then
						{
							[_driver,_car,500] call DK_fnc_rdm_civPanic_MoveTo;							
						};
					};

					[_driver,_car,500] call DK_fnc_rdm_civPanic_MoveTo;							
				};

				if (_rdmC isEqualTo 3) then
				{
					[_driver,1,130,true] spawn DK_fnc_addAllTo_CUM;

					_driver enableAI "MOVE";
					_driver playMoveNow "ApanPpneMstpSnonWnonDnon_G01";

					uiSleep 0.5;
					[_driver,_car,500] call DK_fnc_rdm_civPanic_MoveTo;
				};
			};
		};
	};
};

DK_CLAG_EH_reAddedHit =	{

	params ["_car", "_driver", "_time"];


	uiSleep _time;

	if ( (alive _driver) && { ((driver _car) isEqualTo _driver) } ) then
	{
		private _idEH_Hit = _car addEventHandler ["Hit",
		{
			params ["_veh", "_killer", "", "_instigator"];


			if (isNull _instigator) then
			{
				_instigator = _killer;
			};


			if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
			{
				[_veh, _instigator, _thisEventHandler] call DK_CLAG_EH_hitTraffCivA;
			};
		}];

		private _idEHs = _car getVariable "DK_CLAG_idEHs";
		_idEHs set [4, _idEH_Hit];
		_car setVariable ["DK_CLAG_idEHs", _idEHs];
	};
};

DK_CLAG_EH_traffEpConHorn = {

	params ["_veh", "_vehCol"];


	if ( (_vehCol isKindOf "LandVehicle") && { !(driver _vehCol isEqualTo objNull) && { (_veh getVariable ["hornAllow", true]) && { !(driver _veh isEqualTo objNull) && { (selectRandom [true, true, false]) } } } } ) then
	{
		_veh setVariable ["hornAllow", false];
		horn(_veh);

		_veh spawn
		{
			sleep 5;

			if ( (alive (_this getVariable "hisDriver")) && { (canMove _this) && { (alive (driver _this)) } } ) then
			{
				_this setVariable ["hornAllow", true];
			};
		};
	};

	if !(canMove _veh) then
	{
		_unit = _veh getVariable "hisDriver";

		private _idEHs = _veh getVariable "DK_CLAG_idEHs";
		_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
		_veh removeEventHandler ["Dammaged", _idEHs # 2];
		_veh removeEventHandler ["HandleDamage", _idEHs # 3];
		_veh removeEventHandler ["GetIn", _idEHs # 1];
		if (!isNil {_idEHs # 4}) then
		{
			_veh removeEventHandler ["Hit", _idEHs # 4];
		};
		deleteVehicle (_veh getVariable "DK_CLAG_trgAtch");

		[_unit] orderGetIn false;
		[_unit] allowGetIn false;
		_unit moveTo (getPosATL _unit);
		_unit disableAI "MOVE";

		_unit setVariable ["DK_behaviour", "flee"];
		[_unit,_veh] spawn DK_CLAG_EH_traffPanic_MoveOut;
	};
};

DK_CLAG_EH_traffDmgd = {

	params ["_veh", "_hitSlct", "_dmgLvl"];


	private _unit = driver _veh;

	if ( (_dmgLvl isEqualTo 1) && { !(isPlayer _unit) && { !(side (group _unit) isEqualTo west) && { ((_hitSlct in DK_wheels) OR !(canMove _veh)) } } } ) then
	{
		private _idEHs = _veh getVariable "DK_CLAG_idEHs";

		_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
		_veh removeEventHandler ["Dammaged", _idEHs # 2];
		_veh removeEventHandler ["HandleDamage", _idEHs # 3];
		_veh removeEventHandler ["Hit", _idEHs # 4];
		_veh removeEventHandler ["GetIn", _idEHs # 1];
		deleteVehicle (_veh getVariable "DK_CLAG_trgAtch");

		if ( (isNil "_unit") OR (isNull _unit) OR (!alive _unit) ) exitWith {};

		[_unit] orderGetIn false;
		[_unit] allowGetIn false;
		_unit moveTo (getPosATL _unit);
		_unit disableAI "MOVE";

		_unit setVariable ["DK_behaviour", "flee"];
		[_unit, _veh] spawn DK_CLAG_EH_traffPanic_MoveOut;
	};
};

DK_CLAG_EH_traffPanic_MoveOut = {

	params ["_civil", "_veh"];


//	_civil setVariable ["DK_behaviour", "flee"];

	waitUntil { uiSleep 1; (isNil "_civil") OR (isNull _civil) OR (isNil "_veh") OR (isNull _veh) OR (((speed _civil) < 2) && { (isTouchingGround _veh) }) };

	uiSleep (1 + (random 2));

	if !(alive _civil) exitWith {};

	[_civil,1,100,true] spawn DK_fnc_addAllTo_CUM;
	moveOut _civil;

	_civil enableAI "MOVE";
	_civil forceWalk false;
	_civil setSpeedMode "FULL";
	_civil allowFleeing 1;

	uiSleep 0.5;
	_civil spawn DK_fnc_vocCiv_Panic;
	[_civil,_veh,500] call DK_fnc_rdm_civPanic_MoveTo;
};

DK_CLAG_EH_traffGetIn = {

	private _idEHs = _this getVariable "DK_CLAG_idEHs";
	_this removeEventHandler ["EpeContactStart", _idEHs # 0];
	_this removeEventHandler ["HandleDamage", _idEHs # 3];
	_this removeEventHandler ["Dammaged", _idEHs # 2];
	_this removeEventHandler ["Hit", _idEHs # 4];
	_this removeEventHandler ["GetIn", _idEHs # 1];
	deleteVehicle (_this getVariable "DK_CLAG_trgAtch");
};

// Trigger
DK_CLAG_addTrgTraffic = {

	params ["_veh", "_pos", "_driver"];


	private _trg = createTrigger ["EmptyDetector", [0,0,0], false];
	_trg setTriggerArea [2.8, 2.8, 0, false, 3];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [" !(('Man' countType thisList) isEqualTo 0) ",
	"
		(vehicle (attachedTo thisTrigger)) call DK_CLAG_fnc_trgTrafficAct;
	",
	"
		(vehicle (attachedTo thisTrigger)) call DK_CLAG_fnc_trgTrafficDes;
	"];

	_trg attachTo [_veh,_pos];
	_veh setVariable ["DK_CLAG_trgAtch", _trg];


	_driver addEventHandler ["deleted",
	{
		params ["_unit"];


		private _hisCar = _unit getVariable "hisCar";
		if ( (!isNil "_hisCar") && {(!isNull _hisCar)} ) then
		{
			deleteVehicle (_hisCar getVariable "DK_CLAG_trgAtch");
		};
	}];

};

DK_CLAG_fnc_trgTrafficAct = {

//	_civil = _this getVariable "hisDriver";

	if (((speed _this) > 4) && { (alive driver _this) } ) then
	{
		horn(_this);
		(_this getVariable "hisDriver") disableAI "MOVE";
	};
};

DK_CLAG_fnc_trgTrafficDes = {


	(_this getVariable "hisDriver") enableAI "MOVE";
};

