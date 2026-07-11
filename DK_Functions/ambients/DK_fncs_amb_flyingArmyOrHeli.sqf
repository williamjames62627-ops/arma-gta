if !(isServer) exitWith {};


#define amb_planes2 ["I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F", "B_Plane_CAS_01_dynamicLoadout_F", "B_Heli_Transport_03_F", "B_T_VTOL_01_vehicle_F", "O_T_VTOL_02_infantry_dynamicLoadout_F", "O_Heli_Light_02_unarmed_F", "C_IDAP_Heli_Transport_02_F"]
#define DK_amb_planes2Del(PLN) private _nul = DK_amb_planes2 deleteAt (DK_amb_planes2 find PLN)
DK_amb_planes2 = +amb_planes2;


worldSizeP = worldSize;
worldSizeN = - worldSize;

//DK_amb_plane_2_expTime = if (DK_cntTmGameStart < 4000) then { time + 1200 } else { time + 1800 };
0 spawn
{
	waitUntil { uiSleep 1; (call BIS_fnc_missionTimeLeft > 0) };

	DK_amb_plane_2_expTime = if (DK_cntTmGameStart < 4000) then { ((call BIS_fnc_missionTimeLeft) - 1200) } else { ((call BIS_fnc_missionTimeLeft) - 1800) };
};


DK_init_amb_plane_2 = {

	params [["_tmNextAmb", 900]];


	waitUntil { uiSleep 1; (call BIS_fnc_missionTimeLeft > 0) };

	uiSleep _tmNextAmb;


	private _type = selectRandom DK_amb_planes2;
	DK_amb_planes2Del(_type);
	if (DK_amb_planes2 isEqualTo []) then
	{
		DK_amb_planes2 = +amb_planes2;
		DK_amb_planes2Del(_type);
	};

	private ["_radMin1", "_pos", "_driver", "_playableUnits", "_nil", "_oldPosTmp", "_player"];

	call
	{
		if (_type in ["I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]) exitWith
		{
			_radMin1 = 1300;
		};

		if (_type isEqualTo "B_Heli_Transport_03_F") exitWith
		{
			_radMin1 = 1800;
		};

		if (_type isEqualTo "B_T_VTOL_01_vehicle_F") exitWith
		{
			_radMin1 = 1800;
		};

		if (_type isEqualTo "O_T_VTOL_02_infantry_dynamicLoadout_F") exitWith
		{
			_radMin1 = 1650;
		};

		if (_type isEqualTo "B_Plane_CAS_01_dynamicLoadout_F") exitWith
		{
			_radMin1 = 2000;
		};

		if (_type isEqualTo "O_Heli_Light_02_unarmed_F") exitWith
		{
			_radMin1 = 1300;
		};

		if (_type isEqualTo "C_IDAP_Heli_Transport_02_F") then
		{
			_radMin1 = 1400;
		};
	};

	private _radMin2 = _radMin1 + 10;
	private _radMax = _radMin1 + 100; 


	waitUntil { uiSleep 4;  !(DK_MIS_var_missInProg) && { !(playableUnits isEqualTo []) } };

	private _height = 70 + (random 70);
	private _exit = false;
	private _time = time + 3;
	private	_time2 = time + 45;
	private _oldPos = [];

	while { true } do
	{
		uiSleep 2;

		_player = call DK_fnc_slctMinPlayerScr;

		if ((time > _time2) OR ( (!isNil "_player") && { (alive _player) && { (DK_mkrs_spawnProtect findIf { _player distance2D (getMarkerPos _x) < 1000 } isEqualTo -1) } } )) exitWith {};
	};


	while { true } do
	{

		if (time > _time2) then
		{
			waitUntil { uiSleep 0.2; !(playableUnits isEqualTo []) };

			_player = selectRandom playableUnits;
		};


		if ( (!isNil "_player") && { (DK_mkrs_spawnProtect findIf { _player distance2D (getMarkerPos _x) < 900 } isEqualTo -1) } ) then
		{
			_oldPosTmp = [[getPosATL _player, _radMin2]];
			_oldPosTmp append _oldPos;

			_pos = [[[getPosATL _player, _radMax]], _oldPosTmp] call BIS_fnc_randomPos;

			if (playableUnits findIf { _x distance2D _pos < _radMin1 } isEqualTo -1) exitWith
			{
				_exit = true;
			};

			_nil = _oldPos pushBackUnique [_pos, 100];

			if ( (time > _time) && { (_radMax < 4000) } ) then
			{
				_radMax = _radMax + 50;
				_time = time + 1.5;
			};
		};

		if _exit exitWith {};

		_player = nil;
	};

	_pos set [2, 500];


	private "_posWp01";
	if (!isNil "_player") then
	{
		_posWp01 = getPosATL _player;
	}
	else
	{
		_posWp01 = [[[[20924.2,16289.1,0], [2734, 10827, 21.1, true]]], [[_pos,8000],"water"]] call BIS_fnc_randomPos;
	};

	_posWp01 set [2, _height];

	private ["_speed", "_cnt", "_disDel"];
	private _drivers = [];
	private _planes = [];

	private _tmNextAmb = 900;
	call
	{
		if (_type in ["I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]) exitWith
		{
			_cnt = selectRandom [0,1,2];
			for "_i" from 0 to _cnt step 1 do
			{
				_drivers pushBackUnique (createAgent ["I_officer_F", [0,0,100], [], 0, "CAN_COLLIDE"]);
				_planes pushBackUnique (createVehicle [_type, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"]);
				(_drivers # _i) assignAsDriver (_planes # _i);
				(_drivers # _i) moveInDriver (_planes # _i);
				_speed = selectRandom ["NORMAL", "LIMITED", "FULL"];
				_disDel = 4000;
				uiSleep 0.2;

				[(_planes # _i), 4] call DK_amb_planes2_addBonusStuff;

				{
					_nil = _x call DK_fnc_LO_amb_ArmyJet_pilot;

				} count _drivers;
			};
		};

		if (_type isEqualTo "B_Heli_Transport_03_F") exitWith
		{
			_cnt = selectRandom [0,1];
			for "_i" from 0 to _cnt step 1 do
			{
				_drivers pushBackUnique (createAgent ["I_officer_F", [0,0,100], [], 0, "CAN_COLLIDE"]);
				_planes pushBackUnique (createVehicle [_type, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"]);
				(_drivers # _i) assignAsDriver (_planes # _i);
				(_drivers # _i) moveInDriver (_planes # _i);
				_speed = "FULL";
				_disDel = 3000;
				uiSleep 0.2;

				[(_planes # _i), 1] call DK_amb_planes2_addBonusStuff;

				{
					_nil = _x call DK_fnc_LO_amb_ArmyHeli_pilot;

				} count _drivers;
			};
		};

		if (_type in ["O_T_VTOL_02_infantry_dynamicLoadout_F", "B_T_VTOL_01_vehicle_F"]) exitWith
		{
			_cnt = selectRandom [0,1];
			for "_i" from 0 to _cnt step 1 do
			{
				_drivers pushBackUnique (createAgent ["I_officer_F", [0,0,100], [], 0, "CAN_COLLIDE"]);
				_planes pushBackUnique (createVehicle [_type, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"]);
				(_drivers # _i) assignAsDriver (_planes # _i);
				(_drivers # _i) moveInDriver (_planes # _i);
				_speed = selectRandom ["NORMAL", "FULL"];
				_disDel = 3000;
				uiSleep 0.2;

				[(_planes # _i), 2] call DK_amb_planes2_addBonusStuff;
			};

			{
				_nil = _x call DK_fnc_LO_amb_ArmyHeli_pilot;

			} count _drivers;
		};

		if (_type isEqualTo "B_Plane_CAS_01_dynamicLoadout_F") exitWith
		{
			_cnt = selectRandom [0,1,2];
			for "_i" from 0 to _cnt step 1 do
			{
				_drivers pushBackUnique (createAgent ["I_officer_F", [0,0,100], [], 0, "CAN_COLLIDE"]);
				_planes pushBackUnique (createVehicle [_type, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"]);
				(_drivers # _i) assignAsDriver (_planes # _i);
				(_drivers # _i) moveInDriver (_planes # _i);
				_speed = selectRandom ["NORMAL", "LIMITED", "FULL"];
				_disDel = 5500;
				uiSleep 0.2;

				[(_planes # _i), 3] call DK_amb_planes2_addBonusStuff;

				{
					_nil = _x call DK_fnc_LO_amb_ArmyJet_pilot;

				} count _drivers;
			};
		};

		if (_type isEqualTo "O_Heli_Light_02_unarmed_F") exitWith
		{
			_driver = createAgent ["C_man_polo_1_F", [0,0,100], [], 0, "CAN_COLLIDE"];
			_drivers pushBackUnique _driver;

			_plane = createVehicle [_type, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"];
			[
				_plane,
				["Blue", 1], 
				true

			] call BIS_fnc_initVehicle;

			_planes pushBackUnique _plane;

			_driver assignAsDriver _plane;
			_driver moveInDriver _plane;
			_speed = selectRandom ["LIMITED", "NORMAL", "FULL"];

			_tmNextAmb = 600;
			_disDel = 2700;
		};

		if (_type isEqualTo "C_IDAP_Heli_Transport_02_F") then
		{
			_driver = createAgent ["C_IDAP_Pilot_01_F", [0,0,100], [], 0, "CAN_COLLIDE"];
			_drivers pushBackUnique _driver;

			_plane = createVehicle [_type, [random 500,random 500,2000 + (random 100)], [], 0, "FLY"];

			_planes pushBackUnique _plane;

			_driver assignAsDriver _plane;
			_driver moveInDriver _plane;
			_speed = selectRandom ["LIMITED", "NORMAL", "FULL"];

			_tmNextAmb = 600;
			_disDel = 2700;
		};
	};

	private _dir = _pos getDir _posWp01;
	{
		_x setDir _dir;
		if (_forEachIndex isEqualTo 0) then
		{
			_x setPosATL _pos;
		}
		else
		{
			_x setPosATL ((_planes # (_forEachIndex - 1)) modelToWorldVisualWorld [0, -150, 0]);
		};
		_x flyInHeight _height;
		_nil = _x call DK_fnc_init_vehFlyAir;

		_x disableTIEquipment true;
		_x disableNVGEquipment true;

		uiSleep 0.1;

	} forEach _planes;

	{
		_x disableAi "TARGET";
		_x disableAi "AUTOTARGET";
		_x disableAI "AUTOCOMBAT";
		_x setCaptive true;
		_x allowFleeing 0;
		_x setDamage 0;
		_x setBehaviour "CARELESS";
		_x disableAI "FSM";
		[_x] orderGetIn true;
		[_x] allowGetIn true;
		_x setSpeedMode "FULL";
		_x moveTo _posWp01;

		uiSleep 0.1;

	} count _drivers;


	
	/// // DEBUG MARKER WP 01
/*	[_posWp01, _planes # 0] spawn
	{
		params ["_posWp01", "_plane"];

		avion = _plane;
	//	player moveInAny avion;

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
/*		};

		deleteMarker _mkrNzme1;
		deleteMarker _mkrNzme2;
	};
*/	/// // DEBUG MARKER PLANE


	uiSleep 1;

	private "_nil";
	{
		_nil = _x call DK_fnc_addEH_amb_plane_2;
		uiSleep 0.1;

		_x unassignItem "NVGoggles_INDEP";
		_x removeItem "NVGoggles_INDEP";
		removeAllAssignedItems _x;

	} count _drivers;

	_time = time + 240;

	while { !(_drivers findIf { !isNil "_x" } isEqualTo -1) && { !(_drivers findIf { !isNull _x } isEqualTo -1) && {  !(_drivers findIf { alive _x } isEqualTo -1) && { ((selectRandom _drivers) distance2D _posWp01 > 600) && { !(_drivers findIf {!isNull objectParent _x} isEqualTo -1) && { (time < _time) } } } } } } do
	{
		uiSleep 5;
	};


	if ( (_drivers findIf { !isNil "_x" } isEqualTo -1) OR (_drivers findIf { !isNull _x } isEqualTo -1) OR (_drivers findIf { alive _x } isEqualTo -1) OR (_planes findIf { !isNil "_x" } isEqualTo -1) OR (_planes findIf { !isNull _x } isEqualTo -1) OR (_planes findIf { alive _x } isEqualTo -1) ) exitWith
	{
		_tmNextAmb spawn DK_init_amb_plane_2;
	};

	[_drivers, _planes, _height, _speed, _disDel] call DK_fnc_amb_plane_2_wp02;
};

DK_fnc_amb_plane_2_wp02 = {

	params ["_driver", "_planes", "_height", "_speed", ["_disDel", 3000]];


	private "_nil";
	private _move1 = selectRandom [worldSizeP,worldSizeN];
	private _move2 = selectRandom [worldSizeP,worldSizeN];

	{
		if !(_x getVariable ["isPetro", false]) then
		{
			_x moveTo [_move1, _move2, _height];
			_x setSpeedMode _speed;
			_nil = [_x, 7, _disDel, false] spawn DK_fnc_addAllTo_CUM;
		};

		uiSleep 0.1;

	} count _drivers;

	// Bonus at middle time game
	if ( (call BIS_fnc_missionTimeLeft < DK_amb_plane_2_expTime) && { !(_type in ["C_IDAP_Heli_Transport_02_F", "O_Heli_Light_02_unarmed_F"]) } ) then
//	if ( (time > DK_amb_plane_2_expTime) && { !(_type in ["C_IDAP_Heli_Transport_02_F", "O_Heli_Light_02_unarmed_F"]) } ) then
	{
//		DK_amb_plane_2_expTime = if (DK_cntTmGameStart < 4000) then { time + 1200 } else { time + 2100 };
		DK_amb_plane_2_expTime = if (DK_cntTmGameStart < 4000) then { ((call BIS_fnc_missionTimeLeft) - 1200) } else { ((call BIS_fnc_missionTimeLeft) - 2100) };

		selectRandom _planes spawn DK_fnc_amb_planes2_forceExpBonus;
	};

	uiSleep 10;

	while { (_drivers findIf { isNil "_x" } isEqualTo -1) && { (_drivers findIf { isNull _x } isEqualTo -1) && {  (_drivers findIf { !alive _x } isEqualTo -1) && { (_planes findIf { isNil "_x" } isEqualTo -1) && { (_planes findIf { isNull _x } isEqualTo -1) && { (_planes findIf { !alive _x } isEqualTo -1) } } } } } } do
	{
		uiSleep 5;
	};

	_tmNextAmb spawn DK_init_amb_plane_2;
};

DK_fnc_addEH_amb_plane_2 = {

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		_unit removeEventHandler ["GetOutMan", _thisEventHandler];

		if ( (!alive _unit) OR (_unit getVariable ["isPetro", false]) ) exitWith {};

		
		[_unit,7,150,true] spawn DK_fnc_addAllTo_CUM;
	}];

	_this addEventHandler ["Killed",
	{
		params ["_unit"];

		[_unit,30,50] spawn DK_fnc_addAllTo_CUM;
	}];

};

DK_amb_planes2_addBonusStuff = {

	params ["_plane", "_lvlStuff"];


	_plane setVariable ["lvlStuff", _lvlStuff];

	_plane addEventHandler ["HandleDamage",
	{
		params ["_plane", "", "_dmgTotal", "_source", "", "", "_instigator"];


		call
		{
			if (_plane getVariable ["isPetro", false]) exitWith
			{
				_plane removeEventHandler ["HandleDamage", _thisEventHandler];

				_plane spawn DK_fnc_amb_planes2_forceExpBonus2;
			};


			if ( ((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && { !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } } ) then
			{
				_instigator = _source;
			};

			if ( (!isPlayer _instigator) OR !(side (group _instigator) isEqualTo west) OR (_dmgTotal < 0.1) OR (damage _plane < 0.1) ) exitWith {};

			_plane removeEventHandler ["HandleDamage", _thisEventHandler];

			[_plane, _plane getVariable ["lvlStuff", 1], _instigator] spawn DK_fnc_amb_planes2_bonusStuff;
			private _driver = driver _plane;
			_driver hideObjectGlobal true;
			_plane deleteVehicleCrew _driver;

			_plane spawn
			{
				uiSleep 0.5;
				if (damage _this < 0.9) then
				{
					_this setDamage 0.9;
				};
			};
		};


		_dmgTotal
	}];
};

DK_fnc_amb_planes2_bonusStuff = {

	params ["_plane", "_lvlStuff", "_instigator"];


	private _bbr = boundingBoxReal _plane;
	_p1 = _bbr # 0;
	_p2 = _bbr # 1;
	_maxLength = abs ((_p2 # 1) - (_p1 # 1));

	private ["_smokeType", "_Bonus", "_attachpos"];
	switch _lvlStuff do
	{
		case 1 :
		{
			_Bonus = [false] call DK_MIS_fnc_crtVeh_Army_ProwlerHMG;
			_smokeType ="SmokeShellPurple";
			_attachpos = [0,0,0];

			_Bonus addEventHandler ["GetIn",
			{
				params ["_veh"];

				_veh removeEventHandler ["GetIn", _thisEventHandler];
				_veh setVariable ["smokeStop", true];
			}];
		};

		case 2 :
		{
			_Bonus = [false] call DK_MIS_fnc_crtVeh_Army_ProwlerAT;
			_smokeType ="SmokeShellPurple";
			_attachpos = [0,0,0];

			_Bonus addEventHandler ["GetIn",
			{
				params ["_veh"];

				_veh removeEventHandler ["GetIn", _thisEventHandler];
				_veh setVariable ["smokeStop", true];
			}];
		};

		case 3 :
		{
			_Bonus = createVehicle ["C_supplyCrate_F", [0,0,120], [], 0, "CAN_COLLIDE"];
			[_Bonus, 1] spawn DK_fnc_LO_amb_heli_ammoBox;
			_smokeType ="SmokeShellRed";
			_attachpos = [0,0,0.48];
		};

		case 4 :
		{
			_Bonus = createVehicle ["Box_NATO_Equip_F", [0,0,120], [], 0, "CAN_COLLIDE"];
			[_Bonus, 2] spawn DK_fnc_LO_amb_heli_ammoBox;
			_smokeType ="SmokeShellRed";
			_attachpos = [0,0,0.39];
		};
	};

	_Bonus allowDamage false;

	private _condSmoke = {

		params ["_objct"];

		(isTouchingGround _objct) OR (((getPosATL _objct) # 2) < 3.5)
	};

	[_Bonus, _condSmoke, _attachPos, _smokeType] spawn DK_fnc_smokeHeObjct;

	_Bonus setDir (getDir _plane);
	_Bonus setPosATL (_plane modelToWorldVisual [0,0 - _maxLength,0]);


	private _vel = velocityModelSpace _plane;
	_Bonus setVelocityModelSpace [((_vel # 0) / 2), ((_vel # 1) / 2), (_vel # 2)];

	uiSleep 0.5;

	if ( (isNil "_Bonus") OR (isNull _Bonus) ) exitWith {};

	_para = createVehicle ["I_Parachute_02_F", [0,0,150], [], 0, "CAN_COLLIDE"];
	_para attachTo [_Bonus, [0,0,0]];
	uiSleep 1.25;

	if ( (isNil "_Bonus") OR (isNull _Bonus) ) exitWith {};

	detach _para;
	_para setDir (getDir _Bonus);
	_Bonus attachTo [_para, [0,0,0]];

	// Send SMS for player/players
	if (_plane getVariable ["isPetro", false]) then
	{
		_Bonus remoteExecCall ["DK_fnc_event01_cl", DK_isDedi];

		uiSleep 0.5;
		["Kenny Petrovic", "Bonus Plane"] spawn DK_fnc_customChat;
	};

	if (!isNil "_instigator") then
	{
		_Bonus remoteExecCall ["DK_fnc_event01_cl", _instigator];
	};
	

	private _time = time + 180;
	waitUntil { uiSleep 0.2; (isNil "_Bonus") OR (isNull _Bonus) OR (isNil "_para") OR (isNull _para) OR (((getPosATL _Bonus) # 2) < 3.5) OR (time > _time) OR (isTouchingGround _Bonus) };

	if ( !(isNil "_Bonus") && { !(isNull _Bonus) } ) then
	{
		[_Bonus, 180, _attachPos, _smokeType] spawn DK_fnc_smokeHeObjct;
		detach _Bonus;
	};

	if ( !(isNil "_para") && { !(isNull _para) } ) then
	{
		deleteVehicle _para;
	};

	call
	{
		if (_lvlStuff in [1,2]) exitWith
		{
			_Bonus call DK_fnc_init_veh;
		};

		[_Bonus, 480, 600] spawn DK_fnc_addAllTo_CUM;
	};


	_time = time + 120;
	waitUntil { uiSleep 0.5; (time > _time) OR (isNil "_Bonus") OR (isNull _Bonus) OR (isTouchingGround _Bonus) };

	if ((isNil "_Bonus") OR (isNull _Bonus)) exitWith {};

	_Bonus spawn DK_MIS_fnc_debugReward;
	_Bonus allowDamage true;
};


DK_fnc_amb_planes2_forceExpBonus = {

	_this setVariable ["isPetro", true];
	(driver _this) setVariable ["isPetro", true];

	private  _obu = "APERSMine_Range_Ammo" createVehicle [0,0,3];
	uiSleep 0.3;

	_obu setPos (_this modelToWorldVisual [0, -1, 0]);
	_obu setDamage 1;

	private _fire = "test_EmptyObjectForSmoke" createVehicle [0,0,5];

	[_this, _this getVariable ["lvlStuff", 1]] spawn DK_fnc_amb_planes2_bonusStuff;


	switch (typeOF _this) do
	{
		case "B_Heli_Transport_03_F" :
		{
			_fire attachTo [_this, [0, -3, 0.9]];
		};

		case "B_T_VTOL_01_vehicle_F" :
		{
			_fire attachTo [_this, [-11.3, 0, -1]];
		};

		case "O_T_VTOL_02_infantry_dynamicLoadout_F" :
		{
			_fire attachTo [_this, [-1.55, -7.5, 1.2]];
		};

		case "I_Plane_Fighter_03_dynamicLoadout_F" :
		{
			_fire attachTo [_this, [0, -6, -0.75]];
		};

		case "I_Plane_Fighter_04_F" :
		{
			_fire attachTo [_this, [0, -7, -0.75]];
		};

		case "B_Plane_CAS_01_dynamicLoadout_F" :
		{
			_fire attachTo [_this, [-1.35, -5.3, 0.57]];
		};

	};

	waitUntil { uiSleep 1; (isNil "_this") OR (isNull _this) OR (!alive _this) OR (isTouchingGround _this); };

	if ((isNil "_fire") OR (isNull _fire)) exitWith {};

	if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
	{
		private _time = time + 170;

		waitUntil { uiSleep 1; (time > _time) OR (isNil "_this") OR (isNull _this) OR (!alive _this) OR (damage _this isEqualTo 0); };
	};

	if ((isNil "_fire") OR (isNull _fire)) exitWith {};

	deleteVehicle _fire;
};

DK_fnc_amb_planes2_forceExpBonus2 = {

	uiSleep 0.5;
	if (!alive _this) exitWith {};

	private _driver = driver _this;

	doStop _driver;
	_driver disableAI "move";

	private _type = typeOf _this;

	if (_type isEqualTo "B_Heli_Transport_03_F") then
	{
		_this setHitPointDamage ["hitvrotor", 1];
		_this setVehicleAmmoDef  0.5;
	};

	_this setHitPointDamage [ "hitengine", 1];

	uiSleep (4 + (random 5));

	if (alive _driver) then
	{
		_driver enableAI "move";
	};

	if (alive _this) then
	{
		switch (_type) do
		{
			case "B_T_VTOL_01_vehicle_F" :
			{
				_this setHitPointDamage [ "hitengine", 0.1];
			};

			case "O_T_VTOL_02_infantry_dynamicLoadout_F" :
			{
				_this setHitPointDamage [ "hitengine", 0.3];
			};

			case "I_Plane_Fighter_03_dynamicLoadout_F" :
			{
				_this setHitPointDamage [ "hitengine", 0.1];
			};

			case "I_Plane_Fighter_04_F" :
			{
				_this setHitPointDamage [ "hitengine", 0.1];
			};

			case "B_Plane_CAS_01_dynamicLoadout_F" :
			{
				_this setHitPointDamage [ "hitengine", 0.5];
			};
		};
	};


	call
	{
		if ( !(_type in ["B_Plane_CAS_01_dynamicLoadout_F", "I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]) && { (selectRandom [true, false]) && { ((getPosATL _driver) # 2 > 100) } } ) exitWith
		{
			if (alive _driver) then
			{
				unassignVehicle _driver;
				[_driver] ordergetin false;
				moveOut _driver;
				[_driver, _this, 390] spawn DK_fnc_getNopenPara;

				[_driver, 90, 70, true] spawn DK_fnc_addAllTo_CUM;

				_driver spawn
				{
					waitUntil { uiSleep 0.1; (isNil "_this") OR (isNull _this) OR (!alive _this) OR (isTouchingGround _this) };

					if ( (isNil "_this") OR (isNull _this) OR (!alive _this) ) exitWith {};

					detach _this;
					_this playActionNow (selectRandom ["GestureSpasm0", "GestureSpasm1", "GestureSpasm2", "GestureSpasm3", "GestureSpasm4", "GestureSpasm5", "GestureSpasm6"]);
					_this disableAi "MOVE";
				};
			};
		};

		if (alive _this) then
		{
			_this spawn DK_fnc_checkDlcAir;
			_this land "LAND";
		};
	};

	_time = time + 120;

	waitUntil { uiSleep 1; (time > _time) OR (isNil "_this") OR (isNull _this) OR (!alive _this) OR (isTouchingGround _this);  };


	if ( (!isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
	{
		_this setHitPointDamage [ "hitengine", 1];

		[_this, 180, 300, true] spawn DK_fnc_addVehTo_CUM;

		_this setVariable ["DK_actRepOFF", false];
		_this remoteExecCall ["DK_fnc_repairAir", DK_isDedi];

		if (_type isEqualTo "B_T_VTOL_01_vehicle_F") then
		{
/*			private "_veh";
			call
			{
				if (time > (DK_cntTmGameStart / 2)) exitWith
				{
					_veh = [true, true] call DK_MIS_fnc_crtVeh_Army_MRAP;
					_veh setVehicleAmmoDef 0.5;
				};

				_veh = [true] call DK_MIS_fnc_crtVeh_Army_ProwlerAT;


			};
*/
			private _veh = [true] call (selectRandom [DK_MIS_fnc_crtVeh_Army_ProwlerAT, DK_MIS_fnc_crtVeh_Army_ProwlerHMG, DK_MIS_fnc_crtVeh_Army_MRAP]);
			_this setVehicleCargo _veh;
			[_veh, 180, 300, true] spawn DK_fnc_addVehTo_CUM;
		};

		uiSleep 3;
		if ( (alive _driver) && { (_driver isEqualTo driver _this) } ) then
		{
			_driver setDamage 1;
		};
	};
};



