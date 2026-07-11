if (!isServer) exitWith {};


DK_countNb_veh_CLAG = 0;

// Count vehicles number
#define CNTVEH(NB) DK_countNb_veh_CLAG = DK_countNb_veh_CLAG + NB

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []
#define PlaceOKhey(P) (nearestObjects [P, [], 6]) findIf { typeOf _x isEqualTo "Land_HayBale_01_stack_F"} isEqualTo -1


// Apply Delete
#define logicVPKDel(LGC) _nul = DK_CLAG_logicsGlobVPK deleteAt (DK_CLAG_logicsGlobVPK find LGC)
#define logicVPKCTRYDel(LGC) _nul = DK_CLAG_logicsCtryRoadsVPK deleteAt (DK_CLAG_logicsCtryRoadsVPK find LGC)
#define logicVPKCTRYBDel(LGC) _nul = DK_CLAG_logicsCtryBuildVPK deleteAt (DK_CLAG_logicsCtryBuildVPK find LGC)

// Apply Pushback
#define logicVPKPuBa(LGC) DK_CLAG_logicsGlobVPK pushBackUnique LGC
#define logicVPKCTRYPuBa(LGC) DK_CLAG_logicsCtryRoadsVPK pushBackUnique LGC
#define logicVPKCTRYBPuBa(LGC) DK_CLAG_logicsCtryBuildVPK pushBackUnique LGC

// Create Vehicles
#define crtV(C) createVehicle [C, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]
#define crtVPKCLV(DIS) DIS call DK_fnc_crtVPK_CLV
#define crtVPKOFR(DIS) DIS call DK_fnc_crtVPK_OFR
#define crtVPKVANT(DIS) DIS call DK_fnc_crtVPK_VANT
#define crtVPKVANC(DIS) DIS call DK_fnc_crtVPK_VANC
#define crtVPKVAN(DIS) DIS call DK_fnc_crtVPK_VAN
#define crtVPKLT(DIS) DIS call DK_fnc_crtVPK_LT
#define crtVPKLTB(DIS) DIS call DK_fnc_crtVPK_LTB
#define crtVPKLTT(DIS) DIS call DK_fnc_crtVPK_LTT
#define crtVPKZAM(DIS) DIS call DK_fnc_crtVPK_ZAM

// Define Classname
#define classVeh selectRandom ["C_SUV_01_F", "C_SUV_01_F", "C_SUV_01_F", "B_G_Offroad_01_F", "B_G_Offroad_01_F", selectRandom ["B_G_Offroad_01_F", "C_Offroad_01_covered_F"], "C_Hatchback_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Offroad_02_unarmed_F", "C_Offroad_02_unarmed_F", "C_Offroad_02_unarmed_F"]
#define classOfr selectRandom ["B_G_Offroad_01_F","C_Offroad_02_unarmed_F"]
#define classVT "C_Van_02_transport_F"
#define classVC "C_Van_02_vehicle_F"
#define classV selectRandom ["C_Van_02_transport_F","C_Van_02_vehicle_F"]
#define classLT selectRandom ["C_Van_01_transport_F","C_Van_01_box_F"]
#define classLTT "C_Van_01_transport_F"
#define classLTB "C_Van_01_box_F"
#define classZAM "C_Truck_02_transport_F"

// Sleep
#define slpPlacTake 60					// Time for OK after they are ALREADY a CIV SPAWNED at this place
#define slpPuBa 360 					// Time for OK if ANY PLAYER HAS LEFT area spawn civ.

//#define txtrOffR01 ["a3\soft_f\offroad_01\data\offroad_01_ext_base01_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base04_co.paa","a3\soft_f_enoch\offroad_01\data\offroad_01_ext_grn_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base02_co.paa"]


// Functions
DK_fnc_crtVPK_CLV = {

	private _class = classVeh;

	_veh = crtV(_class);

	[_veh, _class] call DK_fnc_CLAG_vehColor;


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

DK_fnc_crtVPK_OFR = {

	private _class = classOfr;

	_veh = crtV(_class);

	[_veh, _class] call DK_fnc_CLAG_vehColor;


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

DK_fnc_crtVPK_VANC = {

	_veh = crtV(classVC);

	[
		_veh,
		[selectRandom ["BluePearl","Daltgreen","White","AAN","Fuel","Redstone","Swifd","Vrana"],1], 
		[
			"ladder_hide",selectRandom [0,1],
			"roof_rack_hide",0,
			"front_protective_frame_hide",selectRandom [0,1]
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

DK_fnc_crtVPK_VAN = {

	private _class = classV; 

	_veh = crtV(_class);

	call
	{
		if (_class isEqualTo "C_Van_02_transport_F") exitWith
		{
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
		};

		private _tire = selectRandom [0,1,1];
		[
			_veh,
			[selectRandom ["BluePearl","Daltgreen","White","AAN","Fuel","Redstone","Swifd","Vrana"],1], 
			[
				"ladder_hide",selectRandom [0,1],
				"roof_rack_hide",0,
				"front_protective_frame_hide",selectRandom [0,1]
			]

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

DK_fnc_crtVPK_LTB = {

	_veh = crtV(classLTB);

	[
		_veh,
		[selectRandom ["Black","White","Red"],1], 
		true

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

DK_fnc_crtVPK_LTT = {

	_veh = crtV(classLTT);

	[
		_veh,
		[selectRandom ["Black","Red","White"],1], 
		true

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

DK_fnc_crtVPK_ZAM = {

	_veh = crtV(classZAM);

	[
		_veh,
		[selectRandom ["Orange","Blue"],1], 
		true

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



DK_fnc_CLAG_crtVPK_CLV =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos,5.8,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};

	_dis = _logic getVariable "choiceDis";

	private _veh = crtVPKCLV(_dis);	
	_veh allowDamage false;	

	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [175 + (random 10),-5 + (random 10)]));
	};
	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;

	_veh setFuel (0.2 + (random 0.8));

	_veh setVariable ["pedsAllow", true];

	call
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			if (selectRandom [true, false]) then
			{
				_veh call DK_fnc_CLAG_addAlarmCar;
			};
		};

		if (selectRandom [0,0,0,0,0,1] isEqualTo 1) then
		{
			_veh call DK_fnc_CLAG_addAlarmCar;
		};
	};

	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;
		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _logic;
			deleteVehicle _veh;
		};

		_veh enableDynamicSimulation true;

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_LTT =  {

	params ["_mkrPos", "_logic", "_logics", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logics);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logics);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logics);
			};
		};

		call
		{
			if (_logics isEqualType []) exitWith
			{
				{
					deleteVehicle _x;

				} forEach _logics;
			};

			deleteVehicle _logic;
		};
	};	


	if ( !( PlaceOK(_mkrPos,5.8,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logics, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logics, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logics, (time + slpPlacTake)];
		};
	};

	_dis = _logic getVariable "choiceDis";

	_veh = crtVPKLTT(_dis);
	_veh allowDamage false;	

	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [175 + (random 10),-5 + (random 10)]));
	};
	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;
	_veh setFuel (0.2 + (random 0.8));


	/// // WAITING
	[_logic,_mkrPos,_logics,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_logics", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _logic;
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_LT =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos,5.8,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};

	_dis = _logic getVariable "choiceDis";

	private _veh = crtVPKLT(_dis);
	_veh allowDamage false;	


	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [175 + (random 10),-5 + (random 10)]));
	};

	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;
	_veh setFuel (0.2 + (random 0.8));


	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _logic;
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_LTB =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos,5.8,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};


	_dis = _logic getVariable "choiceDis";

	private _veh = crtVPKLT(_dis);
	_veh allowDamage false;	


	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [175 + (random 10),-5 + (random 10)]));
	};

	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;
	_veh setFuel (0.2 + (random 0.8));


	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _logic;
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_OFR =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos,5.8,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};


	_dis = _logic getVariable "choiceDis";

	private _veh = crtVPKOFR(_dis);		
	_veh allowDamage false;	

	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [175 + (random 10),-5 + (random 10)]));
	};
	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;

	_veh setFuel (0.2 + (random 0.8));

	_veh setVariable ["pedsAllow", true];

	call
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			if (selectRandom [true, false]) then
			{
				_veh call DK_fnc_CLAG_addAlarmCar;
			};
		};

		if (selectRandom [0,0,0,0,0,1] isEqualTo 1) then
		{
			_veh call DK_fnc_CLAG_addAlarmCar;
		};
	};

	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _logic;
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_VANT =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos,6,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};


	_dis = _logic getVariable "choiceDis";

	_veh = crtVPKVANT(_dis);		
	_veh allowDamage false;	

	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [177 + (random 6),-3 + (random 6)]));
	};

	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;
	_veh setFuel (0.2 + (random 0.8));

	_veh setVariable ["pedsAllow", true];

	call
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			if (selectRandom [true, false]) then
			{
				_veh call DK_fnc_CLAG_addAlarmCar;
			};
		};

		if (selectRandom [0,0,0,0,0,1] isEqualTo 1) then
		{
			_veh call DK_fnc_CLAG_addAlarmCar;
		};
	};

	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_VANC =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos, 6,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};


	_dis = _logic getVariable "choiceDis";

	_veh = crtVPKVANC(_dis);		
	_veh allowDamage false;	


	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [177 + (random 6),-3 + (random 6)]));
	};

	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;
	_veh setFuel (0.2 + (random 0.8));

	_veh setVariable ["pedsAllow", true];

	call
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			if (selectRandom [true, false]) then
			{
				_veh call DK_fnc_CLAG_addAlarmCar;
			};
		};

		if (selectRandom [0,0,0,0,0,1] isEqualTo 1) then
		{
			_veh call DK_fnc_CLAG_addAlarmCar;
		};
	};

	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_VAN =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos, 6,4) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};


	_dis = _logic getVariable "choiceDis";

	_veh = crtVPKVAN(_dis);		
	_veh allowDamage false;	

	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	(_dir + (selectRandom [177 + (random 6),-3 + (random 6)]));
	};

	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;
	_veh setFuel (0.2 + (random 0.8));

	_veh setVariable ["pedsAllow", true];

	call
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			if (selectRandom [true, false]) then
			{
				_veh call DK_fnc_CLAG_addAlarmCar;
			};
		};

		if (selectRandom [0,0,0,0,0,1] isEqualTo 1) then
		{
			_veh call DK_fnc_CLAG_addAlarmCar;
		};
	};

	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2.5;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};

DK_fnc_CLAG_crtVPK_ZAM =  {

	params ["_mkrPos", "_logic", "_parents"];


	if (damage (_logic getVariable "building") isEqualTo 1) exitWith
	{
		call
		{
			if (_parents isEqualTo "logicsVPK") exitWith
			{
				logicVPKDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryVPK") exitWith
			{
				logicVPKCTRYDel(_logic);
			};
			if (_parents isEqualTo "logicsCtryBuildVPK") then
			{
				logicVPKCTRYBDel(_logic);
			};
		};

		deleteVehicle _logic;
	};	


	if ( !( PlaceOK(_mkrPos, 8,6) ) OR !( PlaceOKhey(_mkrPos) ) ) exitWith
	{
		if (_parents isEqualTo "logicsVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPK pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryVPK") exitWith
		{
			DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_logic, (time + slpPlacTake)];
		};

		if (_parents isEqualTo "logicsCtryBuildVPK") then
		{
			DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_logic, (time + slpPlacTake)];
		};
	};


	_dis = _logic getVariable "choiceDis";

	private _veh = crtVPKZAM(_dis);		
	_veh allowDamage false;	

	call
	{
		private _dir = _logic getVariable "dir";

		if (isNil "_dir") exitWith
		{
			_veh setDir (random 360);
		};

		_veh setDir	((_dir - 8) + (random 16));
	};
	_veh setPosATL _mkrPos;
	_veh setVectorUp surfaceNormal _mkrPos;

	_veh setFuel (0.2 + (random 0.8));

	_veh setVariable ["pedsAllow", true];

	/// // WAITING
	[_logic,_mkrPos,_veh,_parents] spawn
	{
		params ["_logic", "_mkrPos", "_veh", "_parents"];


		uiSleep 0.2;
		_veh allowDamage true;	

		uiSleep 2;

		_veh enableDynamicSimulation true;

		if ( (_veh distance2D _mkrPos > 1) OR (!alive _veh) OR (damage _veh > 0.5) OR ((vectorUp _veh) # 0 > 0.5) OR ((vectorUp _veh) # 1) > 0.5 ) exitWith
		{
			deleteVehicle _logic;
			deleteVehicle _veh;
		};

		private _nTime = time + 4.5;
		DK_CLAG_arr_lgcsWtEndVPK pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime, _parents];
	};
};



DK_fnc_CLAG_addAlarmCar = {

	_id1 = _this addEventHandler ["GetIn",
	{
		params ["_veh","_role","_unit"];


		_veh removeEventHandler ["GetIn", _thisEventHandler];
		_veh removeEventHandler ["Hit",(_veh getVariable "DK_CLAG_idEHAlarm") # 1];

		if ((isPlayer _unit) OR (side (group _unit) isEqualTo west) OR ((_unit getVariable ["DK_behaviour",""]) isEqualTo "bandit")) then
		{
			_veh call DK_fnc_CLAG_playAlarmCar;
		};
	}];


	_id2 = _this addEventHandler ["hit",
	{
		params ["_veh"];


		_veh removeEventHandler ["hit",_thiseventhandler];
		_veh removeEventHandler ["GetIn", (_veh getVariable "DK_CLAG_idEHAlarm") # 0];
	
		_veh setVariable ["pedsAllow", false];
		_veh call DK_fnc_CLAG_playAlarmCar;
	
	}];

	_veh setVariable ["DK_CLAG_idEHAlarm", [_id1,_id2]];

};

DK_fnc_CLAG_playAlarmCar = {


	if (_this getvariable ["DK_vehAlarm_busy",false]) exitwith {};

		_this setvariable ["DK_vehAlarm_busy",true];
		_this setVariable ["pedsAllow", false];

	//--- Sound
		_alarm = selectRandom [1,2,3];

		call
		{
			if (_alarm isEqualTo 1) exitWith
			{
				_this spawn
				{
					for "_i" from 0 to 8 step 1 do
					{
						if (!alive _this OR !simulationenabled _this) exitWith {};

						[_this,"alarmCar01",190,1,true] spawn DK_fnc_say3D;
						[_this,"alarmCar01",190,1,true] spawn DK_fnc_say3D;
						uiSleep 2;
					};
				};
			};

			if (_alarm isEqualTo 2) exitWith
			{
				_this spawn
				{

					for "_i" from 0 to 8 step 1 do
					{
						if (!alive _this OR !simulationenabled _this) exitWith {};

						[_this,"alarmCar02",190,1,true] spawn DK_fnc_say3D;
						[_this,"alarmCar02",190,1,true] spawn DK_fnc_say3D;
						uiSleep 2.12;
					};
				};
			};

			_this spawn
			{
				for "_i" from 0 to 6 step 1 do
				{
					if (!alive _this OR !simulationenabled _this) exitWith {};

					[_this,"alarmCar03",190,1,true] spawn DK_fnc_say3D;
					[_this,"alarmCar03",190,1,true] spawn DK_fnc_say3D;
					uiSleep 2.83;
				};
			};
		};

	//--- Lights
		_this spawn
		{
			private _time = time + 16;
			_timeLight = 0;
			_statusLight = "LightOff";

			waituntil
			{
				if (time > _timeLight) then
				{
					_statusLight = (["LightOn","LightOff"] - [_statusLight]) # 0;
					bis_functions_mainscope action [_statusLight,_this];
					_timeLight = time + 0.35;
				};

				time > _time || {!alive _this || {!simulationenabled _this}}
			};

			bis_functions_mainscope action ["LightOff",_this];
		};
};
