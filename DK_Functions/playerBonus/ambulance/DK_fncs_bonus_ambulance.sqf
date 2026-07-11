if !(isServer) exitWith {};



#define isFlip(V) ((vectorUp V) select 0 > 0.5) OR ((vectorUp V) select 1 > 0.5)

#define CNTWALK(NB) DK_countNb_civ_CLAG = DK_countNb_civ_CLAG + NB
#define CNTPED(NB) DK_countNb_ped_CLAG = DK_countNb_ped_CLAG + NB


DK_fnc_bonus_amb_manageMedics = {

	params ["_player","_ambulance","_allMedics"];

	uiSleep 8;

	private ["_disAll","_posPlayer","_medicSlc","_dis01","_dis02","_dis03","_dis04","_medic01","_medic02","_medic03","_medic04"];
	private	_nbMedics = count _allMedics;

	while { lifeState _player isEqualTo "INCAPACITATED" } do
	{
		_posPlayer = _player modelToWorldVisual [0,2,0];
		_posPlayer set [2,0];
		_disAll = [];

		_medic01 = _allMedics # 0;
		if ( (!isNil "_medic01") && { (!isNull _medic01) && { (alive _medic01) } } ) then
		{
			_dis01 = _posPlayer distance _medic01;
			_disAll pushBack _dis01;
		};
		_medic02 = _allMedics # 1;
		if ( (!isNil "_medic02") && { (!isNull _medic02) && { (alive _medic02) } } ) then
		{
			_dis02 = _posPlayer distance _medic02;
			_disAll pushBack _dis02;
		};
		if (_nbMedics > 2) then
		{
			_medic03 = _allMedics # 2;
			if ( (!isNil "_medic03") && { (!isNull _medic03) && { (alive _medic03) } } ) then
			{
				_dis03 = _posPlayer distance _medic03;
				_disAll pushBack _dis03;
			};
		};
		if (_nbMedics > 3) then
		{
			_medic04 = _allMedics # 3;
			if ( (!isNil "_medic04") && { (!isNull _medic04) && { (alive _medic04) } } ) then
			{
				_dis04 = _posPlayer distance _medic04;
				_disAll pushBack _dis04;
			};
		};

		private _nrstDisMed = selectMin _disAll;
		call
		{
			if (!isNil "_nrstDisMed") then
			{
				if (_nrstDisMed isEqualTo _dis01) exitWith
				{
					_medicSlc = _medic01;
				};
				if (_nrstDisMed isEqualTo _dis02) exitWith
				{
					_medicSlc = _medic02;
				};
				if (_nrstDisMed isEqualTo _dis03) exitWith
				{
					_medicSlc = _medic03;
				};
				if (_nrstDisMed isEqualTo _dis04) exitWith
				{
					_medicSlc = _medic04;
				};
			};
			if (isNil "_nrstDisMed") then
			{
				_medicSlc = [0,0,0];
			};
		};

		uiSleep 0.7;

		if ( (((_player modelToWorldVisual [0,0,0]) distance _medicSlc) < 60) OR (_allMedics findIf {alive _x} isEqualTo -1) OR !(_allMedics findIf { moveToCompleted _x } isEqualTo -1) ) exitWith {};
	};

	if (_allMedics findIf {alive _x} isEqualTo -1) exitWith {};

	if !(lifeState _player isEqualTo "INCAPACITATED") exitWith
	{
		[_ambulance, _allMedics] call DK_fnc_bonus_amb_finish;
	};

	uiSleep 5;

	if (_allMedics findIf {alive _x} isEqualTo -1) exitWith {};

	if !(lifeState _player isEqualTo "INCAPACITATED") exitWith
	{
		[_ambulance, _allMedics] call DK_fnc_bonus_amb_finish;
	};

	if !(_ambulance getVariable ["LeaderMedicIsOut", false]) then
	{
		[_ambulance, _allMedics] call DK_fnc_bonus_amb_getOut;
	};
};

DK_fnc_bonus_amb_moveAmbToInj = {

	params ["_player","_allMedics","_ambulance","_posPlayer","_oldPos"];

	uiSleep 8;

	private "_mkrNzme"; // DEBUG
	while { (lifeState _player isEqualTo "INCAPACITATED") && { !(_allMedics findIf { alive _x } isEqualTo -1) && { !(_ambulance getVariable ["LeaderMedicIsOut", false]) } } } do
	{
		if ( (speed _ambulance < 5) && { (_ambulance getVariable ["outDebugStag", true]) } ) then
		{
			_ambulance setVariable ["outDebugStag", false];

			[_ambulance,_player,_allMedics] spawn
			{
				params ["_ambulance","_player","_allMedics","_stagPos","_time"];

				_stagPos = _ambulance modelToWorldVisual [0,0,0];

				_time = time + 15;
				while { (lifeState _player isEqualTo "INCAPACITATED") && !(_ambulance getVariable ["LeaderMedicIsOut", false]) && !(_allMedics findIf { alive _x } isEqualTo -1) } do
				{
					if (_stagPos distance2D (_ambulance modelToWorldVisual [0,0,0]) > 15) exitWith
					{
						_ambulance setVariable ["outDebugStag", true];
					};

					if (time > _time) exitWith {};

					uiSleep 2;
				};

				if ( (_stagPos distance2D (_ambulance modelToWorldVisual [0,0,0]) <= 15) && { (lifeState _player isEqualTo "INCAPACITATED") && { !(_ambulance getVariable ["LeaderMedicIsOut", false]) && { !(_allMedics findIf { alive _x } isEqualTo -1) } } } ) then
				{

					[_ambulance,_ambulance getVariable "medicsSquad"] call DK_fnc_bonus_amb_getOut;
				};
			};
		};

		_oldPos = _posPlayer;
		_posPlayer = _player modelToWorldVisual [0,0,0];
		_posPlayer set [2,0];

		if (_oldPos distance2D _posPlayer > 4) then
		{
			_allMedics apply
			{
				_x moveTo _posPlayer;
			};
		};

		uiSleep 5;
	};
};

DK_fnc_bonus_amb_moveMedicsToInj = {

	params ["_player","_allMedics"];

	uiSleep 4;

	private "_posPlayer";
	while { (lifeState _player isEqualTo "INCAPACITATED") && { !(_allMedics findIf { alive _x } isEqualTo -1) } } do
	{
		_posPlayer = _player modelToWorldVisual [0,0,0];
		_allMedics apply
		{
			_x moveTo _posPlayer;
		};

		uiSleep 4;
	};
};

DK_fnc_bonus_amb_getOut = {

	params ["_ambulance","_allMedics"];


	_ambulance setVariable ["LeaderMedicIsOut",true];
	_ambulance setVariable ["outDebugStag", false];

	private _driver = driver _ambulance;

	(fullCrew _ambulance) apply
	{
		if ((_x # 0) getVariable "isMedic") then
		{
			if (((_x # 2) isEqualTo 1) OR ((_x # 2) isEqualTo 2)) exitWith
			{
				if (_ambulance doorPhase "Door_3_source" isEqualTo 0) then
				{
					_ambulance animateDoor ["Door_3_source", 1, false];
				};
			};
			if ((_x # 2) isEqualTo -1) exitWith
			{
				doStop _x;
			};
		};
	};

	_ambulance limitSpeed 1;
	_ambulance forceSpeed -1;

	private _player = _ambulance getVariable "caller";

	waitUntil { uiSleep 0.3; (speed _ambulance < 6) OR (_allMedics findIf {alive _x} isEqualTo -1) OR (_allMedics findIf {!isNull objectParent _x} isEqualTo -1) };

	[_ambulance,"CustomSoundController1",0,0.2] remoteExecCall ["BIS_fnc_setCustomSoundController"];

	if !(lifeState _player isEqualTo "INCAPACITATED") exitWith
	{
		[_ambulance, _allMedics] call DK_fnc_bonus_amb_finish;
	};

	if (_allMedics findIf {alive _x} isEqualTo -1) exitWith {};

	private	_posPlayer = getPosWorld _player;
	_allMedics apply
	{
		unassignVehicle _x;
	};

	{
		private _medic = _x # 0;
		if (_medic getVariable "isMedic") then
		{
			private _seat = _x # 2;

			if ((_seat isEqualTo 1) OR (_seat isEqualTo 2)) exitWith
			{
				[_ambulance,_medic,_posPlayer] spawn
				{
					params ["_ambulance","_medic","_posPlayer"];

					waitUntil { _ambulance doorPhase "Door_3_source" isEqualTo 1 OR !alive _ambulance};

					moveOut _medic;
					_medic moveTo _posPlayer;
				};
			};
			if (_seat isEqualTo -1) exitWith
			{
				_ambulance animateDoor ["Door_1_source", 1, false];

				[_ambulance,_medic,_posPlayer] spawn
				{
					params ["_ambulance","_medic","_posPlayer"];

					waitUntil { _ambulance doorPhase "Door_1_source" isEqualTo 1 OR !alive _ambulance };

					moveOut _medic;
					_medic moveTo _posPlayer;
				};
			};
			if (_seat isEqualTo 0) exitWith
			{
				_ambulance animateDoor ["Door_2_source", 1, false];

				[_ambulance,_medic,_posPlayer] spawn
				{
					params ["_ambulance","_medic","_posPlayer"];

					waitUntil { _ambulance doorPhase "Door_2_source" isEqualTo 1 OR !alive _ambulance };

					moveOut _medic;
					_medic moveTo _posPlayer;
				};
			};
		};

	} forEach (fullCrew _ambulance);

	_allMedics orderGetIn false;
	_allMedics allowGetIn false;
	_ambulance setVehicleLock "UNLOCKED";

	private ["_disAll","_posPlayer","_medicSlc","_dis01","_dis02","_dis03","_dis04","_medic03","_medic04","_dis"];
	private	_nbMedics = count _allMedics;

	[_player,_allMedics] spawn DK_fnc_bonus_amb_moveMedicsToInj;


	while { lifeState _player isEqualTo "INCAPACITATED" } do
	{
		_posPlayer = getPosWorld _player;
		_disAll = [];

		_medic01 = _allMedics # 0;
		if ( (!isNil "_medic01") && { (!isNull _medic01) && { (alive _medic01) } } ) then
		{
			_dis01 = _posPlayer distance _medic01;
			_disAll pushBack _dis01;
		};
		_medic02 = _allMedics # 1;
		if ( (!isNil "_medic02") && { (!isNull _medic02) && { (alive _medic02) } } ) then
		{
			_dis02 = _posPlayer distance _medic02;
			_disAll pushBack _dis02;
		};
		if (_nbMedics > 2) then
		{
			_medic03 = _allMedics # 2;
			if ( (!isNil "_medic03") && { (!isNull _medic03) && { (alive _medic03) } } ) then
			{
				_dis03 = _posPlayer distance _medic03;
				_disAll pushBack _dis03;
			};
		};
		if (_nbMedics > 3) then
		{
			_medic04 = _allMedics # 3;
			if ( (!isNil "_medic04") && { (!isNull _medic04) && { (alive _medic04) } } ) then
			{
				_dis04 = _posPlayer distance _medic04;
				_disAll pushBack _dis04;
			};
		};

		private _nrstDisMed = selectMin _disAll;
		call
		{
			if (!isNil "_nrstDisMed") then
			{
				if (_nrstDisMed isEqualTo _dis01) exitWith
				{
					_medicSlc = _medic01;
				};
				if (_nrstDisMed isEqualTo _dis02) exitWith
				{
					_medicSlc = _medic02;
				};
				if (_nrstDisMed isEqualTo _dis03) exitWith
				{
					_medicSlc = _medic03;
				};
				if (_nrstDisMed isEqualTo _dis04) then
				{
					_medicSlc = _medic04;
				};
			};
		};

		if (isNil "_nrstDisMed") exitWith {};

		if ( (_medicSlc getVariable ["outDebugStag", true]) && { ((_medicSlc distance _player) < 10) } ) then
		{
			_medicSlc setVariable ["outDebugStag", false];

			[_medicSlc,_player,_allMedics] spawn
			{
				params ["_medicSlc","_player","_allMedics","_stagPos","_time"];

				_stagPos = _medicSlc modelToWorldVisual [0,0,0];

				_time = time + 10;
				while { (lifeState _player isEqualTo "INCAPACITATED") && { (alive _medicSlc) } } do
				{
					if (_stagPos distance (_medicSlc modelToWorldVisual [0,0,0]) > 3) exitWith
					{
						_medicSlc setVariable ["outDebugStag", true];
					};

					if (time > _time) exitWith {};

					uiSleep 2;
				};

				if ( (_stagPos distance2D (_medicSlc modelToWorldVisual [0,0,0]) <= 3) && { (lifeState _player isEqualTo "INCAPACITATED") } ) then
				{
					if !(isNull objectParent _player) then
					{
						moveOut _player;
					};

					_medicSlc disableAI "MOVE";
					_medicSlc attachTo [_player ,[-0.55,0,0]];
					_medicSlc setdir 90;
				};
			};
		};

		call
		{
			if (isNull objectParent _player) exitWith
			{
				_dis = 3.5;
			};

			_dis = 5;
		};

		if (((_medicSlc distance _player) < _dis) OR (_allMedics findIf {alive _x} isEqualTo -1)) exitWith {};

		uiSleep 0.35;
	};

	if (_allMedics findIf {alive _x} isEqualTo -1) exitWith {};
	uiSleep 1.5;

	if !(lifeState _player isEqualTo "INCAPACITATED") exitWith
	{
		[_ambulance, _allMedics] call DK_fnc_bonus_amb_finish;
	};

	if !(isNull objectParent _player) then
	{
		moveOut _player;
	};

	_medicSlc disableAI "MOVE";
	_medicSlc attachTo [ _player ,[-0.55,0,0]];
	_medicSlc setdir 90;
	uiSleep 0.75;

	/// Handle Money
	[_player,call DK_AMB_COST] call DK_fnc_handlePlayerMoney;

	remoteExecCall ["DK_fnc_revivePlayer", owner _player];
	_medicSlc playMoveNow "AinvPknlMstpSnonWrflDnon_medic4";
	uiSleep 4;

	_medicSlc playMoveNow "AmovPercMstpSnonWnonDnon";
	_medicSlc enableAI "MOVE";
	uiSleep 2;

	detach _medicSlc;
	_medicSlc setPosATL (_medicSlc modelToWorldVisual [-0.75,0,0.1]);

	[_ambulance, _allMedics] call DK_fnc_bonus_amb_finish;
};

DK_fnc_bonus_amb_finish = {

	params ["_ambulance", ["_allMedics", []]];


	if ( (!isNil "_ambulance") && { (!isNull _ambulance) && { (alive _ambulance) } } ) then
	{
		private _driver = driver _ambulance;
		_allMedics apply
		{
			if (alive _x) then
			{
				[_x,5,200,true] spawn DK_fnc_addAllTo_CUM;

				if (_driver isEqualTo _x) then
				{
					[_ambulance, "CustomSoundController1", 0, 0.2] remoteExecCall ["BIS_fnc_setCustomSoundController"];
					_ambulance animateSource ["Beacons", 0];
				};
			};
		};
	}
	else
	{
		_allMedics apply
		{
			if (alive _x) then
			{
				[_x,5,200,true] spawn DK_fnc_addAllTo_CUM;
			};
		};
	};

	if ( (!isNil "_ambulance") && { (!isNull _ambulance) && { (alive _ambulance) && { (canMove _ambulance) && { (DK_wheels findIf {(_ambulance getHit _x) isEqualTo 1} isEqualTo -1) && { (_ambulance getVariable ["medicsAllowed", true]) && { !(isFlip(_ambulance)) } } } } } } ) then
	{
		_allMedics orderGetIn true;
		_allMedics allowGetIn true;
		_allMedics apply
		{
			_x moveTo (getPosATL _ambulance);
		};

		private _seatsPlc = [1,0,2];
		waitUntil
		{
			uiSleep 1;

			{
				if ( !(objectParent _x isEqualTo _ambulance) && { (_x distance2D _ambulance < 8) } ) then
				{
					if (alive (driver _ambulance)) then
					{
						if (alive _x) then
						{
							_x assignAsCargo _ambulance;
							_x moveInCargo [_ambulance, _seatsPlc # 0];
							private _nul = _seatsPlc deleteAt 0;
						};
					}
					else
					{
						if (alive _x) then
						{
							_x assignAsDriver _ambulance;
							_x moveInDriver _ambulance;
							_ambulance animateDoor ["Door_1_source", 0, false];
						};
					};
				};

			} count _allMedics;

			!(alive _ambulance) OR (({ alive _x } count crew _ambulance) isEqualTo ({ alive _x } count _allMedics)) OR !(DK_wheels findIf {(_ambulance getHit _x) isEqualTo 1} isEqualTo -1) OR !(canMove _ambulance) OR !(_ambulance getVariable ["medicsAllowed", true])
		};

		if !(_allMedics findIf { alive _x } isEqualTo -1) then
		{
			if ( (DK_wheels findIf {(_ambulance getHit _x) isEqualTo 1} isEqualTo -1) && { (canMove _ambulance) && { (_ambulance getVariable ["medicsAllowed", true]) } } ) then
			{
				fullCrew _ambulance apply
				{
					if ( ((_x # 0) getVariable "isMedic") && { (alive (_x # 0)) } ) then
					{
						if (((_x # 2) isEqualTo 1) OR ((_x # 2) isEqualTo 2)) exitWith
						{
							if (_ambulance doorPhase "Door_3_source" isEqualTo 1) then
							{
								_ambulance animateDoor ["Door_3_source", 0, false];
							};
						};
						if ((_x # 2) isEqualTo 0) exitWith
						{
							_ambulance animateDoor ["Door_2_source", 0, false];
						};
					};
				};

				_allMedics apply
				{
					if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
					{
						_x setVariable ["DK_behaviour","drive"];
					};
				};

				_ambulance setVariable ["bonusTerminate", true];

				_ambulance spawn
				{
					private _time = time + 6;

					waitUntil { ( (_this doorPhase "Door_3_source" isEqualTo 0) && { (_this doorPhase "Door_2_source" isEqualTo 0) && { (_this doorPhase "Door_1_source" isEqualTo 0) } } ) OR (time > _time) };

					if !(time > _time) then
					{
						[
							_this,
							["CivAmbulance",1], 
							["Door_1_source",0,"Door_2_source",0,"Door_3_source",0,"Door_4_source",0,"Hide_Door_1_source",0,"Hide_Door_2_source",0,"Hide_Door_3_source",0,"Hide_Door_4_source",0,"lights_em_hide",0,"ladder_hide",1,"spare_tyre_holder_hide",1,"spare_tyre_hide",1,"reflective_tape_hide",0,"roof_rack_hide",1,"LED_lights_hide",0,"sidesteps_hide",0,"rearsteps_hide",1,"side_protective_frame_hide",1,"front_protective_frame_hide",1,"beacon_front_hide",0,"beacon_rear_hide",0]

						] call BIS_fnc_initVehicle;

						_this setVariable ["beacon_ON", false, true];
					};
				};

				[driver _ambulance,1500] spawn DK_fnc_CLAG_wpDriver;
			}
			else
			{
				_allMedics apply
				{
					if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
					{
						_x setVariable ["DK_behaviour","walk"];
						_x call DK_fnc_CLAG_doWalkPed;
					};
				};
			};
		};
	}
	else
	{
		_allMedics apply
		{
			if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
			{
				_x setVariable ["DK_behaviour","walk"];
				_x call DK_fnc_CLAG_doWalkPed;
			};
		};
	};

	if ( (!isNil "_ambulance") && { (!isNull _ambulance) && { (alive _ambulance) } } ) then
	{
		_ambulance forceSpeed -1;
		_ambulance limitSpeed 80;

		if !(_ambulance getVariable ["medicsAllowed", true]) then
		{
			_allMedics apply
			{
				if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
				{
					_x setVariable ["DK_behaviour","walk"];
					_x call DK_fnc_CLAG_doWalkPed;
				};
			};
		};
	};

	{
		if ( (!isNil "_x") && { (!isNull _x) && { (alive _x) } } ) then
		{
			_x setSpeedMode "NORMAL";
		};

	} count _allMedics;

	DK_nbAmb = DK_nbAmb - 1;
	publicVariable "DK_nbAmb";
};


DK_fnc_bonus_amb_addEH_medics = {

	_this addEventHandler ["Killed",
	{
		params ["_unit","_killer"];


		if ( (isPlayer _killer) OR (side (group _killer) isEqualTo west) ) then
		{
			[_killer, call DK_AMB_COST_KILL] call DK_fnc_addScr;
			[_killer] remoteExecCall ["DK_fnc_wndd_Medic_Kl", _killer];
		};

		_unit spawn
		{
			uiSleep 2;

			private _ambulance = _this getVariable "linkedAmb";
			private _allMedics = _ambulance getVariable "medicsSquad";
			private _nil = _allMedics deleteAt (_allMedics find _this);

			if ( (canMove _ambulance) && { (DK_wheels findIf {(_ambulance getHit _x) isEqualTo 1} isEqualTo -1) && { (!alive (driver _ambulance)) && { (objectParent _this isEqualTo _ambulance) && { !(_allMedics isEqualTo []) } } } } ) then
			{
				private _medic = _allMedics # 0;
				if (alive _medic) then
				{
					moveOut _medic;
					_medic assignAsDriver _ambulance;
					_medic moveInDriver _ambulance;

					if (_medic getVariable ["DK_behaviour", nil] isEqualTo "drive") then
					{
						[_medic,1500] spawn DK_fnc_CLAG_wpDriver;
					};
				};
			};
		};

		[_unit,60,32,true] spawn DK_fnc_addAllTo_CUM;
	}];

	_this spawn
	{
		waitUntil { uiSleep 2; isNull _this; };

		CNTWALK(-0.5);
		CNTPED(-0.5);
	};
};

DK_fnc_bonus_amb_addEH_ambulance = {

	params ["_ambulance","_idEH_HD","_idEH_GI","_idEH_DMGD"];


	_idEH_HD = _ambulance addEventHandler ["HandleDamage",
	{
		params ["_veh", "", "_damage", "_source", "_projectile", "", "_instigator"];


		if ( ((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && { !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } } ) then
		{
			_instigator = _source;
		};

		if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) exitWith
		{
			_veh removeEventHandler ["HandleDamage", _thisEventHandler];
		};

		if (_projectile isEqualTo "") then
		{
			{
				_x setDamage 0;

			} count crew _veh;

			_damage = 0;
		};


		_damage
	}];

	_idEH_GI = _ambulance addEventHandler ["GetIn",
	{
		params ["_veh","","_unit"];

		if ( (isPlayer _unit) OR (side (group _unit) isEqualTo west) ) then
		{
			private _idEHs = _veh getVariable "DK_idEh";
			_veh removeEventHandler ["HandleDamage", _idEHs # 0];
			_veh removeEventHandler ["Dammaged", _idEHs # 1];
			_veh removeEventHandler ["GetIn", _thisEventHandler];
			_veh setVariable ["medicsAllowed", false];
			_idEHs = nil;
		};
	}];

	_idEH_DMGD = _ambulance addEventHandler ["Dammaged",
	{
		params ["_veh", "_hitSlct", "_damage"];

		[_veh,_hitSlct,_damage] call DK_fnc_bonus_amb_EH_dmgd;
	}];


	_ambulance setVariable ["DK_idEh",[_idEH_HD,_idEH_DMGD,_idEH_GI]];
};


DK_fnc_bonus_amb_EH_dmgd = {

	params ["_veh","_hitSlct","_dmgLvl"];


	if (_dmgLvl isEqualTo 1) then
	{
		if ( (_hitSlct in DK_wheels) OR !(canMove _veh) ) then
		{
			private _idEHs = _veh getVariable "DK_idEh";
			_veh removeEventHandler ["HandleDamage", _idEHs # 0];
			_veh removeEventHandler ["Dammaged", _idEHs # 1];
			_veh removeEventHandler ["GetIn", _idEHs # 2];

			if !(_veh getVariable ["LeaderMedicIsOut", false]) exitWith
			{
				[_veh,_veh getVariable "medicsSquad"] spawn DK_fnc_bonus_amb_getOut;
			};

			if (_veh getVariable ["bonusTerminate", false]) then
			{
				fullCrew _veh apply
				{
					if ((_x # 0) getVariable "isMedic") then
					{
						if (alive (_x # 0)) then
						{
							if (((_x # 2) isEqualTo 1) OR ((_x # 2) isEqualTo 2)) exitWith
							{
								if (_veh doorPhase "Door_3_source" isEqualTo 0) then
								{
									_veh animateDoor ["Door_3_source", 1, false];
								};
							};
							if ((_x # 2) isEqualTo -1) exitWith
							{
								_veh animateDoor ["Door_1_source", 1, false];
							};
							if ((_x # 2) isEqualTo 0) exitWith
							{
								_veh animateDoor ["Door_2_source", 1, false];
							};
						};
					};
				};

				_veh limitSpeed 1;
				_veh forceSpeed -1;


				_veh spawn
				{
					params ["_veh","_allMedics","_pos"];

					_allMedics = _veh getVariable "medicsSquad";

					waitUntil { uiSleep 0.3; (speed _veh < 6) OR (_allMedics findIf {alive _x} isEqualTo -1) OR (_allMedics findIf {!isNull objectParent _x} isEqualTo -1) };

					if (_allMedics findIf {alive _x} isEqualTo -1) exitWith {};

					_pos = [[[getPos _veh,1200]], [[getPos _veh,700],"water"]] call BIS_fnc_randomPos;
					_allMedics apply
					{
						unassignVehicle _x;
						moveOut _x;
						_x moveTo _pos;
						uiSleep (0.5 + (random 2));
					};
				};
			};
		};
	};
};


///	// SIREN
DK_fnc_bonus_amb_beacon_init = {

	params ["_ambulance", ["_beaconON", true]];


	_ambulance addEventHandler ["Deleted",
	{
		params ["_veh"];


		private _netIdBeacon = _veh getVariable "NetIdBeacon";
		if !(isNil "_netIdBeacon") then
		{
			remoteExecCall ["", _netIdBeacon];
			_veh setVariable ["NetIdBeacon", nil];
		};
	}];

	_ambulance addMPEventHandler ["mpKilled",
	{
		params ["_veh"];

		if (isServer) then
		{
			private _netIdBeacon = _veh getVariable "NetIdBeacon";
			if !(isNil "_netIdBeacon") then
			{
				remoteExecCall ["", _netIdBeacon];
				_veh setVariable ["NetIdBeacon", nil];
			};
		};

		if (hasInterface) then
		{
			removeAllActions _veh;
		};
	}];

	if (call DK_fnc_checkIfNight) then
	{
		private _NetIdBeacon = _ambulance remoteExecCall ["DK_loop_amb_beacon", DK_isDedi, true];
		_ambulance setVariable ["NetIdBeacon",_NetIdBeacon];

		if !(_beaconON) then
		{
			_ambulance animateSource ["Beacons", 0];
		};
	};
};


