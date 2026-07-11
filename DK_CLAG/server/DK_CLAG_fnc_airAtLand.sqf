if (!isServer) exitWith {};


DK_countNb_air_CLAG = 0;

// Count jet & heli number
#define CNTAIR(NB) DK_countNb_air_CLAG = DK_countNb_air_CLAG + NB

// Check script
#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []

// Apply Pushback
#define logicAIRPuBa(LGC) DK_CLAG_LogicsAirAtLand pushBackUnique LGC

// Create jet & heli
#define crtV(C) createVehicle [C, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]
#define crtAIRJET(DIS) DIS call DK_fnc_crtAIR_JET
#define crtAIRHEL(DIS) DIS call DK_fnc_crtAIR_HELI
#define crtAIRHELL(DIS) DIS call DK_fnc_crtAIR_HELIL

//#define IDAPtxtrs ["a3\air_f_orange\heli_transport_02\data\heli_transport_02_1_idap_co.paa","a3\air_f_orange\heli_transport_02\data\heli_transport_02_2_idap_co.paa","a3\air_f_orange\heli_transport_02\data\heli_transport_02_3_idap_co.paa","a3\air_f_orange\heli_transport_02\data\heli_transport_02_int_02_idap_co.paa"]

// Define Classname
#define classJet "C_Plane_Civil_01_racing_F"
#define classHeliL "B_Heli_Light_01_F"
#define classHeli selectRandom ["O_Heli_Light_02_unarmed_F", classHeliL, "I_Heli_Transport_02_F"]

#define txtrHeliL ["a3\air_f\heli_light_01\data\heli_light_01_ext_blue_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_blueline_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_elliptical_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_furious_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_graywatcher_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_jeans_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_light_co.paa","a3\air_f\heli_light_01\data\heli_light_01_ext_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_shadow_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_sheriff_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_speedy_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_sunset_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_vrana_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa","a3\air_f\heli_light_01\data\skins\heli_light_01_ext_wave_co.paa"]

// Sleep
#define slpPlacTake 60					// Time for OK after they are ALREADY a CIV SPAWNED at this place
#define slpPuBa 360 					// Time for OK if ANY PLAYER HAS LEFT area spawn civ.




DK_fnc_crtAIR_JET = {

	_jet = crtV(classJet);

	clearBackpackCargoGlobal _jet;
	_jet addBackpackCargoGlobal ["B_Parachute",2];

	_jet call DK_fnc_textureCivJet;
/*	call
	{
		_rd = selectRandom [1,2,3,4,5,6,7,8];

		if (_rd isEqualTo 1) exitWith
		{
			[
				_jet,
				["Wave_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 2) exitWith
		{
			[
				_jet,
				["Wave_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 3) exitWith
		{
			[
				_jet,
				["Racer_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 4) exitWith
		{
			[
				_jet,
				["Racer_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 5) exitWith
		{
			[
				_jet,
				["RedLine_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 6) exitWith
		{
			[
				_jet,
				["RedLine_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 7) exitWith
		{
			[
				_jet,
				["Tribal_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_jet,
			["Tribal_2",1], 
			true

		] call BIS_fnc_initVehicle;
	};
*/
	[_jet,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_jet call DK_fnc_init_vehAir;

	CNTAIR(1);

	_id1 = _jet addEventHandler ["deleted",
	{
		CNTAIR(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

/*	_id2 = _jet addEventHandler ["Engine",
	{
		params ["_jet"];


		_EHs = _jet getVariable "DK_CLAG_EHs";

		_jet removeEventHandler ["Engine", _EHs # 1];
		_jet removeEventHandler ["deleted", _EHs # 0];

//		CNTAIR(-1);
	}];

	_jet setVariable ["DK_CLAG_EHs", [_id1,_id2]];
*/
	if (DK_CLAG_debugModMarkers_units) then
	{
		_jet spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "n_air";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_jet
};

DK_fnc_crtAIR_HELI = {

	private _class = classHeli;
	private _heli = crtV(_class);

	switch (_class) do
	{
		case "B_Heli_Light_01_F" :
		{
			_heli setObjectTextureGlobal [0, selectRandom txtrHeliL];

			[
				_heli,
				nil,
				[
					"AddTread", 0,
					"AddTread_Short", 0
				]

			] call BIS_fnc_initVehicle;
		};


		case "I_Heli_Transport_02_F" :
		{
			clearBackpackCargoGlobal _heli;
			clearMagazineCargoGlobal _heli;
			clearWeaponCargoGlobal _heli;
			clearItemCargoGlobal _heli;
			_heli addBackpackCargoGlobal ["B_Parachute",8];

			[
				_heli,
				[selectRandom ["Dahoman", "ION"], 1], 
				true

			] call BIS_fnc_initVehicle;
		};

/*		case "C_Heli_Light_01_civil_F" :
		{
			_heli addBackpackCargoGlobal ["B_Parachute",4];

			call
			{
				_rd = round (random 15);

				if (_rd isEqualTo 1) exitWith
				{
					[
						_heli,
						["Blue",1], 
						["AddTread",0,"AddTread_Short",0]

					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 2) exitWith
				{
					[
						_heli,
						["BlueLine",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 3) exitWith
				{
					[
						_heli,
						["Elliptical",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 4) exitWith
				{
					[
						_heli,
						["Furious",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 5) exitWith
				{
					[
						_heli,
						["Graywatcher",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 6) exitWith
				{
					[
						_heli,
						["Jeans",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 7) exitWith
				{
					[
						_heli,
						["Light",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 8) exitWith
				{
					[
						_heli,
						["Red",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 9) exitWith
				{
					[
						_heli,
						["Shadow",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 10) exitWith
				{
					[
						_heli,
						["Sheriff",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 11) exitWith
				{
					[
						_heli,
						["Speedy",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 12) exitWith
				{
					[
						_heli,
						["Sunset",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 13) exitWith
				{
					[
						_heli,
						["Vrana",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 14) exitWith
				{
					[
						_heli,
						["Wasp",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				[
					_heli,
					["Wave",1], 
					["AddTread",0,"AddTread_Short",0]


				] call BIS_fnc_initVehicle;
			};
		};
*/

		case "O_Heli_Light_02_unarmed_F" :
		{
			clearMagazineCargoGlobal _heli;
			clearWeaponCargoGlobal _heli;
			clearItemCargoGlobal _heli;

			[
				_heli,
				["Blue", 1], 
				true

			] call BIS_fnc_initVehicle;
		};

	};

	[_heli,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_heli call DK_fnc_init_vehAir;

	CNTAIR(1);

	_id1 = _heli addEventHandler ["deleted",
	{
		CNTAIR(-1);

	/// // DEBUG MOD
		params ["_entity"];
		if (DK_CLAG_debugModMarkers_units) then
		{
			deleteMarker (_entity getVariable "mkr_DEBUG");
		};
	/// // DEBUG MOD END
	}];

/*	_id2 = _heli addEventHandler ["Engine",
	{
		params ["_heli"];


		_EHs = _heli getVariable "DK_CLAG_EHs";

		_heli removeEventHandler ["Engine", _EHs # 1];
		_heli removeEventHandler ["deleted", _EHs # 0];

//		CNTAIR(-1);
	}];

	_heli setVariable ["DK_CLAG_EHs", [_id1,_id2]];
*/
	if (DK_CLAG_debugModMarkers_units) then
	{
		_heli spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "n_air";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_heli
};

DK_fnc_crtAIR_HELIL = {

	private _class = classHeliL;
	_heli = crtV(_class);

	_heli setObjectTextureGlobal [0, selectRandom txtrHeliL];

	[
		_heli,
		nil,
		[
			"AddTread", 0,
			"AddTread_Short", 0
		]

	] call BIS_fnc_initVehicle;


/*	call
	{
		if (_class isEqualTo "C_Heli_Light_01_civil_F") exitWith
		{
			_heli addBackpackCargoGlobal ["B_Parachute",4];

			call
			{
				_rd = round (random 15);

				if (_rd isEqualTo 1) exitWith
				{
					[
						_heli,
						["Blue",1], 
						["AddTread",0,"AddTread_Short",0]

					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 2) exitWith
				{
					[
						_heli,
						["BlueLine",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 3) exitWith
				{
					[
						_heli,
						["Elliptical",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 4) exitWith
				{
					[
						_heli,
						["Furious",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 5) exitWith
				{
					[
						_heli,
						["Graywatcher",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 6) exitWith
				{
					[
						_heli,
						["Jeans",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 7) exitWith
				{
					[
						_heli,
						["Light",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 8) exitWith
				{
					[
						_heli,
						["Red",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 9) exitWith
				{
					[
						_heli,
						["Shadow",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 10) exitWith
				{
					[
						_heli,
						["Sheriff",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 11) exitWith
				{
					[
						_heli,
						["Speedy",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 12) exitWith
				{
					[
						_heli,
						["Sunset",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 13) exitWith
				{
					[
						_heli,
						["Vrana",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				if (_rd isEqualTo 14) exitWith
				{
					[
						_heli,
						["Wasp",1], 
						["AddTread",0,"AddTread_Short",0]


					] call BIS_fnc_initVehicle;
				};

				[
					_heli,
					["Wave",1], 
					["AddTread",0,"AddTread_Short",0]


				] call BIS_fnc_initVehicle;
			};
		};

		_heli setObjectTextureGlobal [0, "a3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa"];
	};
*/

	[_heli,7,_this + 25,true] spawn DK_fnc_addVehTo_CUM;
	_heli call DK_fnc_init_vehAir;

	CNTAIR(1);

	_id1 = _heli addEventHandler ["deleted",
	{
		CNTAIR(-1);

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
		_heli spawn
		{
			uiSleep 1;

			private _mkrNzme = str (random 1000);
			_markerstr = createMarker [_mkrNzme,getPos _this];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "n_air";
			_mkrNzme setMarkerColor "ColorYellow";
			_mkrNzme setMarkerSize [0.8, 0.8];
			_this setVariable ["mkr_DEBUG", _mkrNzme];
		};
	};


	_heli
};


DK_fnc_CLAG_crtJET =  {

	params ["_mkrPos","_logic"];


	if !( PlaceOK(_mkrPos,12,8) ) exitWith
	{
		DK_CLAG_arr_lgcsWtAir pushBackUnique [_lgcSrc, (time + slpPlacTake)];
	};


	_dis = _logic getVariable "choiceDis";

	private _jet = crtAIRJET(_dis);		

	_jet setDir (_logic getVariable "dir");
	_jet setPosATL _mkrPos;
	_jet setVectorUp surfaceNormal _mkrPos;

	_jet setFuel (0.3 + (random 0.7));

	/// // WAITING
	[_logic,_mkrPos,_jet] spawn
	{
		params ["_logic","_mkrPos","_jet"];


		private _nTime = time + 30;
		DK_CLAG_arr_lgcsWtEndAir pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime];
	};
};

DK_fnc_CLAG_crtHELI =  {

	params ["_mkrPos","_logic"];


	if !( PlaceOK(_mkrPos,12,8) ) exitWith
	{
		DK_CLAG_arr_lgcsWtAir pushBackUnique [_lgcSrc, (time + slpPlacTake)];

/*		_logic spawn
		{
			uiSleep slpPlacTake;
			logicAIRPuBa(_this);
		};
*/	};


	_dis = _logic getVariable "choiceDis";

	private _heli = crtAIRHEL(_dis);		

	_heli setDir (_logic getVariable "dir");
	_heli setPosATL _mkrPos;
	_heli setVectorUp surfaceNormal _mkrPos;

	_heli setFuel (0.1 + (random 0.4));

	/// // WAITING
	[_logic,_mkrPos,_heli] spawn
	{
		params ["_logic","_mkrPos","_heli"];


		private _nTime = time + 30;
		DK_CLAG_arr_lgcsWtEndAir pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime];

/*		uiSleep 30;

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 10 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.04;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 10;
		};

		logicAIRPuBa(_logic);
*/	};
};

DK_fnc_CLAG_crtHELIL =  {

	params ["_mkrPos","_logic"];


	if !( PlaceOK(_mkrPos,12,8) ) exitWith
	{
		DK_CLAG_arr_lgcsWtAir pushBackUnique [_lgcSrc, (time + slpPlacTake)];

/*		_logic spawn
		{
			uiSleep slpPlacTake;
			logicAIRPuBa(_this);
		};
*/	};

	_dis = _logic getVariable "choiceDis";

	private _heli = crtAIRHELL(_dis);

	_heli setDir (_logic getVariable "dir");
	_heli setPosATL _mkrPos;
	_heli setVectorUp surfaceNormal _mkrPos;

	_heli setFuel (0.1 + (random 0.4));

	/// // WAITING
	[_logic,_mkrPos,_heli] spawn
	{
		params ["_logic","_mkrPos","_heli"];


		private _nTime = time + 30;
		DK_CLAG_arr_lgcsWtEndAir pushBackUnique [_logic, (_nTime + slpPuBa), _mkrPos, (_logic getVariable "choiceDis") + 5, _nTime];

/*		uiSleep 30;

		private _dis = (_logic getVariable "choiceDis") + 5;
		for "_y" from 0 to slpPuBa step 10 do
		{
			private _bool = true;
			{
				if ((_x distance2D _mkrPos) < _dis) exitWith
				{
					_bool = false;
				};
				uiSleep 0.04;

			} count playableUnits;

			if (_bool) exitWith {};
			uiSleep 10;
		};

		logicAIRPuBa(_logic);
*/	};
};


DK_fnc_textureCivJet = {

	switch (selectRandom [1,2,3,4,5,6,7,8]) do
	{
		case 1 :
		{
			[
				_this,
				["Wave_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 2 :
		{
			[
				_this,
				["Wave_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 3 :
		{
			[
				_this,
				["Racer_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 4 :
		{
			[
				_this,
				["Racer_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 5 :
		{
			[
				_this,
				["RedLine_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 6 :
		{
			[
				_this,
				["RedLine_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 7 :
		{
			[
				_this,
				["Tribal_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		case 8 :
		{
			[
				_this,
				["Tribal_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};
	};
};

DK_fnc_textureCivHeliL = {

	switch (round (random 15)) do
	{
		case  1 :
		{
			[
				_this,
				["Blue",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  2 :
		{
			[
				_this,
				["BlueLine",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  3 :
		{
			[
				_this,
				["Elliptical",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  4 :
		{
			[
				_this,
				["Furious",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  5 :
		{
			[
				_this,
				["Graywatcher",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  6 :
		{
			[
				_this,
				["Jeans",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  7 :
		{
			[
				_this,
				["Light",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  8 :
		{
			[
				_this,
				["Red",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  9 :
		{
			[
				_this,
				["Shadow",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  10 :
		{
			[
				_this,
				["Sheriff",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  11 :
		{
			[
				_this,
				["Speedy",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  12 :
		{
			[
				_this,
				["Sunset",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  13 :
		{
			[
				_this,
				["Vrana",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  14 :
		{
			[
				_this,
				["Wasp",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};

		case  15 :
		{
			[
				_this,
				["Wave",1], 
				["AddTread",0,"AddTread_Short",0]

			] call BIS_fnc_initVehicle;
		};
	};
};

DK_fnc_textureMedHeli = {

	[
		_this,
		["Black",1], 
		true
	] call BIS_fnc_initVehicle;
};



