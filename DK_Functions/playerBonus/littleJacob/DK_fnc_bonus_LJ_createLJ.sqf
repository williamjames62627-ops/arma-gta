
	#define crtU createAgent ["C_man_p_beggar_F_afro", [0,0,100], [], 0, "CAN_COLLIDE"]
	#define crtV(V) createVehicle [V, [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]


	_this spawn
	{
		params ["_player","_wpSelect","_stuffLvL","_DLCs","_cost","_jacobCar"];


		private _id = owner _player;
		private _unitsPlayerGrp = (units (group _player)) - [_player];
		private _resultMags = [_player] call DK_fnc_bonus_LJ_selectMag;

		private _resultPos = [_player, 400, 1000, 12, 5, true] call DK_fnc_MTW_searchSpawnVeh_OnRoad;

		_resultPos params ["_roadPos", "_dir"];

		if (_roadPos isEqualTo 0) exitWith
		{
			DK_nbSearchSpawnRoad_inProg = false;
			DK_weapon_LJ_InProgress = false;
			publicVariable "DK_weapon_LJ_InProgress";

			remoteExecCall ["DK_fnc_areaNotSecureNotif_LJ", _player];
			uiSleep 2;

			if (alive _player) then
			{
				[_player,true] call DK_fnc_bonus_LJ_handleIfPlyrAlwd;
			};
		};

		_player setVariable ["inCntDownAction_LJ", true];
		[_player,_cost] call DK_fnc_handlePlayerMoney;

		remoteExecCall ["DK_fnc_bonus_LJ_cntDwn",_player];

		private _haveApex = 395180 in _DLCs;
		call
		{
			if _haveApex exitWith
			{
				_jacobCar = crtV("C_Offroad_02_unarmed_F");
			};

			_jacobCar = crtV("C_Hatchback_01_sport_F");
		};

		_jacobCar allowDamage false;

		[
			_jacobCar,
			["Green",1],
			true

		] call BIS_fnc_initVehicle;

		_jacobCar call DK_fnc_init_veh;
		_jacobCar engineOn true;

		_jacobCar setDir _dir;

		_jacobCar setPosATL _roadPos;
		_jacobCar setVectorUp surfaceNormal _roadPos;

		DK_nbSearchSpawnRoad_inProg = false;

		private _littleJ = crtU;
		_littleJ allowDamage false;

		_littleJ setDamage 0;

		DK_littleJ = _littleJ;
		_littleJ call DK_fnc_bonus_LJ_EH_deleted;

		_littleJ disableAI "FSM";
		_littleJ disableAI "TARGET";
		_littleJ disableAI "AUTOTARGET";
		_littleJ setBehaviour "CARELESS";
		_littleJ allowFleeing 0.05;
		_littleJ setSpeedMode "FULL";
		[_littleJ] orderGetIn true;
		[_littleJ] allowGetIn true;
		_littleJ call DK_fnc_LO_LJ;
		_littleJ setCaptive true;

		_littleJ assignAsDriver _jacobCar;
		_littleJ moveInDriver _jacobCar;
		_littleJ setVariable ["isJacob",true];
		_littleJ setVariable ["caller",_player];

		_jacobCar setVehicleLock "LOCKEDPLAYER";

		private _posPlayer = _player modelToWorldVisual [0,0,0];
		_posPlayer set [2,0];
		_littleJ moveTo _posPlayer;
		_jacobCar forceSpeed 200;

		[_littleJ,240,250,true] spawn DK_fnc_addAllTo_CUM;


	///	// Apply last paramaters when LJ car is really starting
		for "_i" from 0 to 15 step 1 do
		{
			if ((speed _jacobCar > 7) OR (!alive _littleJ)) exitWith {};

			uiSleep 1;
		};

		if (alive _littleJ) then
		{
			_jacobCar forceSpeed -1;

			[_littleJ,_jacobCar,_posPlayer] remoteExecCall ["DK_bonus_LJ_addHud_caller", _id];

			if !(_unitsPlayerGrp isEqualTo []) then
			{
				[_littleJ] remoteExecCall ["DK_bonus_LJ_addHud_fam", _unitsPlayerGrp];
			};

			uiSleep 5;

			_jacobCar allowDamage true;

			_jacobCar call DK_fnc_bonus_LJ_addEH_LJcar;

			_littleJ setVariable ["stuffList", [_resultMags # 0, _resultMags # 1, _resultMags # 2, _stuffLvL, _wpSelect, _haveApex]];

	/////// //	Handle arrived LJ
			private _time = time + 100;
			while { uiSleep 0.2; (time < _time) } do
			{
				uiSleep 0.4;
				if ( (_littleJ getVariable ["JacobIsOut", false]) OR (_player distance2D (vehicle _littleJ) < 45) OR (isNil "_littleJ") OR (isNil "_player") OR (!alive _littleJ) OR (!alive _player) OR (!alive _jacobCar) OR (time > _time) ) exitWith {};

				uiSleep 0.4;
				if ( (_littleJ getVariable ["JacobIsOut", false]) OR (_player distance2D (vehicle _littleJ) < 45) OR (isNil "_littleJ") OR (isNil "_player") OR (!alive _littleJ) OR (!alive _player) OR (!alive _jacobCar) OR (time > _time) ) exitWith {};

				uiSleep 0.4;
				if ( (_littleJ getVariable ["JacobIsOut", false]) OR (_player distance2D (vehicle _littleJ) < 45) OR (isNil "_littleJ") OR (isNil "_player") OR (!alive _littleJ) OR (!alive _player) OR (!alive _jacobCar) OR (time > _time) ) exitWith {};

				uiSleep 0.4;
				if ( (_littleJ getVariable ["JacobIsOut", false]) OR (_player distance2D (vehicle _littleJ) < 45) OR (isNil "_littleJ") OR (isNil "_player") OR (!alive _littleJ) OR (!alive _player) OR (!alive _jacobCar) OR (time > _time) ) exitWith {};

				_littleJ moveTo (getPosATL _player);
			};

			if (!alive _littleJ) exitWith {};

			if !(_littleJ getVariable ["JacobIsOut",false]) then
			{
				_littleJ setVariable ["JacobIsOut",true];
				[_littleJ,_jacobCar,_player] call DK_fnc_bonus_LJ_getOut;
			};
		};
	};
