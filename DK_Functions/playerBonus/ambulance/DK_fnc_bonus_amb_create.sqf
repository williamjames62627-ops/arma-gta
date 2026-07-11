	#define CNTV(NB) DK_countNb_traffic_CLAG = DK_countNb_traffic_CLAG + NB

	#define isFlip(V) ((vectorUp V) select 0 > 0.5) OR ((vectorUp V) select 1 > 0.5)

	#define classH ["C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_asia"]

	#define crtU createAgent [selectRandom classH, [0,0,100], [], 0, "CAN_COLLIDE"]
	#define crtV createVehicle ["C_Van_02_medevac_F", [random 500,random 500,3000], [], 0, "CAN_COLLIDE"]

	#define CNTWALK(NB) DK_countNb_civ_CLAG = DK_countNb_civ_CLAG + NB
	#define CNTPED(NB) DK_countNb_ped_CLAG = DK_countNb_ped_CLAG + NB


	params ["_player","_nbMedics"];


	[_player,_nbMedics] spawn
	{
		params ["_player","_nbMedics","_result","_pos","_ambulance","_allMedics","_nbForCnt","_posPlayer"];

		_result = [_player, 230, 900, 12, 2,true] call DK_fnc_MTW_searchSpawnVeh_OnRoad;
		_pos = _result # 0;

		if !(lifeState _player isEqualTo "INCAPACITATED") exitWith
		{
			DK_nbSearchSpawnRoad_inProg = false;
		};

		if (_pos isEqualTo 0) exitWith
		{
			DK_nbSearchSpawnRoad_inProg = false;

			_id = owner _player;

			remoteExecCall ["DK_fnc_areaNotSecureNotif_altis", _id];
			uiSleep 1;

			if ( (lifeState _player isEqualTo "INCAPACITATED") && { ((getPlayerScores _player # 5) > call DK_AMB_SCORE_MINI) } ) then
			{
				remoteExecCall ["DK_fnc_chckAllowedAmb", _id];
			};
		};

		DK_nbAmb = DK_nbAmb + 1;
		publicVariable "DK_nbAmb";

		_ambulance = crtV;
		_ambulance allowDamage false;

		CNTV(1);

		_ambulance call DK_fnc_LO_ambulance;
		_ambulance call DK_fnc_init_veh;
		_ambulance engineOn true;

		_ambulance setDir (_result # 1);

		_ambulance setPosATL _pos;
		_ambulance setVectorUp surfaceNormal _pos;

		DK_nbSearchSpawnRoad_inProg = false;

		_ambulance addEventHandler ["deleted",
		{
			CNTV(-1);
		}];

		private _medic01 = crtU;
		_medic01 allowDamage false;
		private _medic02 = crtU;
		_medic02 allowDamage false;

		_allMedics = [_medic01,_medic02];

		private ["_medic03", "_medic04"];
		if (_nbMedics > 2) then
		{
			_medic03 = crtU;
			_medic03 allowDamage false;
			_allMedics pushBack _medic03;
		};
		if (_nbMedics > 3) then
		{
			_medic04 = crtU;
			_medic04 allowDamage false;
			_allMedics pushBack _medic04;
		};

		_nbForCnt = (count _allMedics) / 2;
		CNTWALK(_nbForCnt);
		CNTPED(_nbForCnt);

		{
			_x setDamage 0;
			_x disableAI "FSM";
			_x setBehaviour "CARELESS";
			_x allowFleeing 0.05;
			_x setSpeedMode "FULL";
			[_x] orderGetIn true;
			[_x] allowGetIn true;
			_x call DK_fnc_LO_Medic;
			_x setVariable ["isMedic", true];
			_x setVariable ["linkedAmb", _ambulance];

			uiSleep 0.02;

		} count _allMedics;

		_ambulance setVariable ["medicsSquad", _allMedics];

		_medic01 assignAsDriver _ambulance;
		_medic01 moveInDriver _ambulance;
		_medic02 moveInCargo [_ambulance, 1];

		if (!isNil "_medic03") then
		{
			_medic03 moveInCargo [_ambulance, 0];
		};
		if (!isNil "_medic04") then
		{
			_medic04 moveInCargo [_ambulance, 2];
		};

		_ambulance setVariable ["caller",_player];
		_ambulance setVehicleLock "LOCKEDPLAYER";


		_posPlayer = _player modelToWorldVisual [0,0,0];
		_posPlayer set [2,0];
		_medic01 moveTo _posPlayer;
		_ambulance forceSpeed 200;

		_allMedics apply
 		{
			[_x,160,200,true] spawn DK_fnc_addAllTo_CUM;
			_x call DK_fnc_bonus_amb_addEH_medics;
		};

	///	// Move ambulance
		[_player,_allMedics,_ambulance,_posPlayer] spawn DK_fnc_bonus_amb_moveAmbToInj;

	///	// Manage when medics can get out
		[_player,_ambulance,_allMedics] spawn DK_fnc_bonus_amb_manageMedics;

	///	// Apply last paramaters when ambulance is really starting
		for "_i" from 0 to 15 step 1 do
		{
			if ((speed _ambulance > 7) OR (_allMedics findIf {alive _x} isEqualTo -1)) exitWith {};

			uiSleep 1;
		};

		if !(_allMedics findIf {alive _x} isEqualTo -1) then
		{
			[_ambulance,_player,_allMedics] spawn
			{
				params ["_ambulance","_player","_allMedics"];

				_ambulance forceSpeed -1;

				uiSleep 6;

				if ( !(_allMedics findIf { alive _x } isEqualTo -1) && { (alive _ambulance) && { (lifeState _player isEqualTo "INCAPACITATED") } } ) then
				{
					waitUntil { uiSleep 0.1; (_ambulance distance2D (getPosWorld _player) < 70) OR !(lifeState _player isEqualTo "INCAPACITATED") OR (_allMedics findIf { alive _x } isEqualTo -1) OR !(canMove _ambulance) OR (isFlip(_ambulance)) };

					if (alive _ambulance) then
					{
						_ambulance forceSpeed 85;
					};
				};
			};

			_allMedics remoteExecCall ["DK_add_hudAmbulance", _player];
			[_ambulance, true] call DK_fnc_bonus_amb_beacon_init;
//			[_ambulance] call DK_fnc_bonus_amb_siren;

/*			if (call DK_fnc_checkIfNight) then
			{
				_ambulance setVariable ["beacon_ON", true, true];
				private _NetIdBeacon = _ambulance remoteExecCall ["DK_loop_amb_beacon", DK_isDedi, true];
				_ambulance setVariable ["NetIdBeacon",_NetIdBeacon];
			};
*/
			uiSleep 5;

			if ( (isNil "_ambulance") OR (isNull _ambulance) OR (!alive _ambulance) ) exitWith {};

			_ambulance call DK_fnc_bonus_amb_addEH_ambulance;

			_ambulance allowDamage true;
			{
				_x allowDamage true;

			} count _allMedics;
		};
	};
