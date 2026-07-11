if (!isServer) exitWith {};


DK_countNb_boats_CLAG = 0;

// Count vehicles number
#define CNTBOAT(NB) DK_countNb_boats_CLAG = DK_countNb_boats_CLAG + NB

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["Ship","AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []
#define eye(X) (playableUnits findIf { [vehicle X, "IFIRE", vehicle _x] checkVisibility [eyePos X, eyePos _x] > 0.96 } ) isEqualTo -1
#define dis(X) (playableUnits findIf { _x distance2D X < (60 + (random 170)) } ) isEqualTo -1

// Create unit
#define crtU createAgent [classH, [0,0,100], [], 0, "CAN_COLLIDE"]

// Apply Pushback
#define logicBoatPuBa(LGC) DK_CLAG_LogicsBoats pushBackUnique LGC

// Create Vehicles
#define crtV(C) createVehicle [C, [random 500, random 500, 9], [], 0, "CAN_COLLIDE"]
#define crtBOAT(CLS,DIS) [CLS,DIS] call DK_fnc_crtStasBOAT
#define crtMvBOAT(CLS) CLS call DK_fnc_crtMoveBOAT

// Define Classname
#define classBoat selectRandom ["C_Boat_Civil_01_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F","I_Boat_Transport_01_F"]
#define lightBoats ["C_Scooter_Transport_01_F","I_Boat_Transport_01_F"]
#define classH selectRandom ["C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_asia"]

// Sleep
#define slpPlacTake 60					// Time for OK after they are ALREADY a CIV SPAWNED at this place



// Functions

DK_fnc_crtStasBOAT = {

	params ["_class", "_dis"];


	_boat = crtV(_class);

	[_boat, 7, _dis + 25,true] spawn DK_fnc_addVehTo_CUM;
	_boat call DK_fnc_init_boat;

	CNTBOAT(1);

	_id1 = _boat addEventHandler ["deleted",
	{
		CNTBOAT(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

	_id2 = _boat addEventHandler ["Engine",
	{
		params ["_boat"];


		_EHs = _boat getVariable "DK_CLAG_EHs";

		_boat removeEventHandler ["Engine", _EHs # 1];
		_boat removeEventHandler ["deleted", _EHs # 0];

		CNTBOAT(-1);
	}];

	_boat setVariable ["DK_CLAG_EHs", [_id1,_id2]];

	if (DK_CLAG_debugModMarkers_units) then
	{
		_boat spawn
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


	_boat
};

DK_fnc_crtMoveBOAT = {

	_boat = crtV(_this);

	_boat call DK_fnc_init_boat;

	CNTBOAT(1);

	_id1 = _boat addEventHandler ["deleted",
	{
		CNTBOAT(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

	if (DK_CLAG_debugModMarkers_units) then
	{
		_boat spawn
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


	_boat
};


DK_fnc_CLAG_crtStasBoat =  {

	params ["_mkrPos", "_logic"];


	private "_rad";
	private _class = classBoat;

	call
	{
		if (_class in lightBoats) exitWith
		{
			_rad = 3.8;
		};

		_rad = 8;		
	};

	if !( PlaceOK(_mkrPos,_rad,1) ) exitWith
	{
		DK_CLAG_arr_lgcsWtBoat pushBackUnique [_logic, (time + slpPlacTake)];

/*		_logic spawn
		{
			sleep slpPlacTake;

			logicBoatPuBa(_this);
		};
*/	};

	_dis = _logic getVariable "choiceDis";

	private _boat = crtBOAT(_class,_dis);		

	_boat setDir ((_logic getVariable "dir") + (selectRandom [0,180]));
	_boat setPosASL _mkrPos;

	/// // WAITING
	[_logic, _mkrPos, _boat, _dis] spawn
	{
		params ["_logic", "_mkrPos", "_boat", "_dis"];


//		uiSleep 7;

		DK_CLAG_arr_lgcsWtEndBoats pushBackUnique [_logic, (time + 28), _mkrPos, _dis, (time + 7)];

/*		for "_y" from 0 to 6 step 1 do
		{
			if (playableUnits findIf { (_x distance2D _mkrPos) < _dis } isEqualTo -1) exitWith {};
			uiSleep 3;
		};

		logicBoatPuBa(_logic);
*/	};
};

DK_fnc_CLAG_crtMoveBoat = {

	params ["_mkrPos", "_logic"];


	private "_rad";
	private _class = classBoat;

	call
	{
		if (_class in lightBoats) exitWith
		{
			_rad = 3.8;
		};

		_rad = 8;		
	};

	if !( PlaceOK(_mkrPos,_rad,1) ) exitWith
	{
		DK_CLAG_arr_lgcsWtBoat pushBackUnique [_logic, (time + slpPlacTake)];

/*		_logic spawn
		{
			sleep slpPlacTake;

			logicBoatPuBa(_this);
		};
*/	};

	_dis = (_logic getVariable "choiceDis") * 2;

	private _boat = crtMvBOAT(_class);		

	private _dir = _logic getVariable "dir";
	_boat setDir _dir;

	private _civ01 = _boat call DK_fnc_CLAG_crtDriverBoat;

	_boat setPosASL _mkrPos;
	_boat engineOn true;
	_civ01 allowDamage true;

	[_civ01,7,_dis,true] spawn DK_fnc_addAllTo_CUM; 

	///	// ADDED MATE IF SCOOTER
	call
	{
		if (_class isEqualTo "C_Scooter_Transport_01_F") exitWith
		{
			private _rdm = selectRandom [2,3];

			if (_rdm isEqualTo 2) then
			{
				uiSleep 0.2;

				private _boat02 = crtBOAT("C_Scooter_Transport_01_F",_dis);		
				private _civ02 = _boat02 call DK_fnc_CLAG_crtDriverBoat;
				_boat02 setDir _dir;
				_boat02 setPosASL (_civ01 modelToWorldVisualWorld [2.5,1,0.2]);
				[_civ01,_civ02] spawn DK_fnc_CLAG_followBoat;
				[_civ02,7,_dis,true] spawn DK_fnc_addAllTo_CUM; 
				_civ02 setSpeedMode "FULL";
				_boat02 limitSpeed 200;
				_civ02 forceSpeed  200;
				_civ02 call DK_fnc_LO_DriverScoot;
				_boat02 engineOn true;
				_civ02 allowDamage true;
			};

			if (_rdm isEqualTo 3) then
			{
				uiSleep 0.2;

				private _boat02 = crtBOAT("C_Scooter_Transport_01_F",_dis);		
				private _civ02 = _boat02 call DK_fnc_CLAG_crtDriverBoat;
				_boat02 setDir _dir;
				_boat02 setPosASL (_civ01 modelToWorldVisualWorld [2.5,1,0.2]);
				[_civ01,_civ02] spawn DK_fnc_CLAG_followBoat;
				[_civ02,7,_dis,true] spawn DK_fnc_addAllTo_CUM; 
				_civ02 setSpeedMode "FULL";
				_boat02 limitSpeed 200;
				_civ02 forceSpeed  200;
				_civ02 call DK_fnc_LO_DriverScoot;
				_boat02 engineOn true;
				_civ02 allowDamage true;

				uiSleep 0.3;

				private _boat03 = crtBOAT("C_Scooter_Transport_01_F",_dis);		
				private _civ03 = _boat03 call DK_fnc_CLAG_crtDriverBoat;
				_boat03 setDir _dir;
				_boat03 setPosASL (_civ01 modelToWorldVisualWorld [-2.5,1,0.2]);
				[_civ01,_civ03] spawn DK_fnc_CLAG_followBoat;
				[_civ03,7,_dis,true] spawn DK_fnc_addAllTo_CUM; 
				_civ03 setSpeedMode "FULL";
				_boat03 limitSpeed 200;
				_civ03 forceSpeed  200;
				_civ03 call DK_fnc_LO_DriverScoot;
				_boat03 engineOn true;
				_civ03 allowDamage true;
			};

			_civ01 call DK_fnc_LO_DriverScoot;
		};

		[_civ01] call DK_fnc_LO_DriverBoat;
	};

	/// // CHANGE SPEED
	[_civ01, _boat, _class] spawn
	{
		params ["_civ01", "_boat", "_class"];


		private _exit = false;

		while { (!isNil "_civ01") && { (!isNull _civ01) && { (alive _civ01) && { !(_civ01 isEqualTo vehicle _civ01) } } } } do
		{
			if !(eye(_civ01)) exitWith {};
			uiSleep 1;

			if !(dis(_civ01)) exitWith {};
			uiSleep 1;
		};
	
		if (alive _civ01) then
		{
			call
			{
				if (_class isEqualTo "C_Scooter_Transport_01_F") exitWith
				{
					_civ01 setSpeedMode "FULL";
					_boat limitSpeed 200;
					_civ01 forceSpeed  200;
				};

				_civ01 setSpeedMode (selectRandom ["NORMAL","FULL"]);
				_boat limitSpeed (35 + (random 150));
			};

			[_civ01] call DK_fnc_CLAG_doMoveBoat;
		};
	};

	/// // WAITING
	[_logic, _mkrPos, _boat, _dis / 2] spawn
	{
		params ["_logic", "_mkrPos", "_boat", "_dis"];


//		uiSleep 30;

		DK_CLAG_arr_lgcsWtEndBoats pushBackUnique [_logic, (time + 50), _mkrPos, _dis, (time + 30)];

/*		for "_y" from 0 to 6 step 1 do
		{
			if (playableUnits findIf { (_x distance2D _mkrPos) < _dis } isEqualTo -1) exitWith {};
			uiSleep 3;
		};

		logicBoatPuBa(_logic);
*/	};
};

DK_fnc_CLAG_crtDriverBoat = {

	private _civ01 = crtU;
	_civ01 allowDamage false;
	_civ01 setDamage 0;
	_civ01 disableAI "FSM";
	_civ01 setBehaviour "CARELESS";
	_civ01 allowFleeing 0.05;

	_civ01 assignAsDriver _this;
	[_civ01] orderGetIn true;
	[_civ01] allowGetIn true;
	_civ01 moveInDriver _this;

	_civ01
};