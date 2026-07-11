


DK_fnc_bonus_LJ_addEH_LJcar = {

	params ["_jacobCar","_idEH_HD","_idEH_GI","_idEH_DMGD"];

	
	_idEH_HD = _jacobCar addEventHandler ["HandleDamage",
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
			(driver _veh) setDamage 0;
			_damage = 0;
		};


		_damage
	}];

	_idEH_GI = _jacobCar addEventHandler ["GetIn",
	{
		params ["_veh", "", "_unit"];

		if ( (isPlayer _unit) OR (side (group _unit) isEqualTo west) ) then
		{
			private _idEHs = _veh getVariable "DK_idEh";
			_veh removeEventHandler ["HandleDamage", _idEHs # 0];
			_veh removeEventHandler ["Dammaged", _idEHs # 1];
			_veh removeEventHandler ["GetIn", _thisEventHandler];
			_idEHs = nil;
		};
	}];

	_idEH_DMGD = _jacobCar addEventHandler ["Dammaged",
	{
		params ["_veh", "_hitSlct", "_damage", "_hitIndex", "_hitPoint"];

		[_veh,_hitSlct,_damage,_hitIndex,_hitPoint] call DK_fnc_bonus_LJ_EH_dmgd;
	}];


	_jacobCar setVariable ["DK_idEh",[_idEH_HD,_idEH_DMGD,_idEH_GI]];
};

DK_fnc_bonus_LJ_EH_dmgd = {

	params ["_veh","_hitSlct","_dmgLvl","_hitIndex","_hitPoint"];

	if ( (_dmgLvl isEqualTo 1) OR ((_hitPoint isEqualTo "hitengine") && (_dmgLvl > 0.89)) ) then
	{
		if ( (_hitSlct in DK_wheels) OR !(canMove _veh) OR (_hitPoint isEqualTo "hitengine") ) then
		{
			private _unit = driver _veh;
		
			private _idEHs = _veh getVariable "DK_idEh";
			_veh removeEventHandler ["Dammaged", _idEHs # 1];
			_veh removeEventHandler ["HandleDamage", _idEHs # 0];
			_veh removeEventHandler ["GetIn", _idEHs # 2];

			if (_unit getVariable ["isJacob", false]) then
			{
				if !(_unit getVariable ["JacobIsOut",false]) then
				{
					_unit setVariable ["JacobIsOut",true];

					private _caller = _unit getVariable "caller";
					_veh setVariable ["isDestroy", true, owner _caller];
					[_unit,_veh,_caller] spawn DK_fnc_bonus_LJ_getOut;
				};
			};
		};
	};
};


DK_fnc_bonus_LJ_selectMag = {

	params ["_player","_primarWaypon","_magClass","_magNb","_weaponClass"];


	_weaponClass = "";

	_primarWaypon = primaryWeapon _player;
	if !(_primarWaypon isEqualTo "") then
	{
		_magClass = primaryWeaponMagazine _player;

		if !(_magClass isEqualTo []) then
		{
			call
			{
				_className = _primarWaypon select [0,12];
				if (_className isEqualTo "arifle_MX_SW") exitWith
				{
					_magClass = "100Rnd_65x39_caseless_mag_Tracer";
					_magNb = 2;
				};
				_className = _primarWaypon select [0,14];
				if (_className isEqualTo "arifle_SPAR_02") exitWith
				{
					_magClass = "150Rnd_556x45_Drum_Mag_Tracer_F";
					_magNb = 2;
				};
				_className = _primarWaypon select [0,6];
				if (_className isEqualTo "LMG_03") exitWith
				{
					_magClass = "200Rnd_556x45_Box_Tracer_Red_F";
					_magNb = 2;
				};
				if (_className isEqualTo "MMG_01") exitWith
				{
					_magClass = "150Rnd_93x64_Mag";
					_magNb = 2;
				};
				if (_className isEqualTo "MMG_02") exitWith
				{
					_magClass = "130Rnd_338_Mag";
					_magNb = 2;
				};
				if (_className isEqualTo "SMG_03") exitWith
				{
					_magClass = "50Rnd_570x28_SMG_03";
					_magNb = 4;
				};
				_className = _primarWaypon select [0,9];
				if (_className isEqualTo "LMG_Zafir") exitWith
				{
					_magClass = "150Rnd_762x54_Box_Tracer";
					_magNb = 2;
				};
				if (_className isEqualTo "LMG_Mk200") exitWith
				{
					_magClass = "200Rnd_65x39_cased_Box_Tracer";
					_magNb = 2;
				};

				_magClass = _magClass # 0;
				_magNb = 11;
			};
		}
		else
		{
			call
			{
				_className = _primarWaypon select [0,12];
				if (_className isEqualTo "arifle_MX_SW") exitWith
				{
					_magClass = "100Rnd_65x39_caseless_mag_Tracer";
					_magNb = 2;
				};
				_className = _primarWaypon select [0,14];
				if (_className isEqualTo "arifle_SPAR_02") exitWith
				{
					_magClass = "150Rnd_556x45_Drum_Mag_Tracer_F";
					_magNb = 2;
				};
				_className = _primarWaypon select [0,6];
				if (_className isEqualTo "LMG_03") exitWith
				{
					_magClass = "200Rnd_556x45_Box_Tracer_Red_F";
					_magNb = 2;
				};
				if (_className isEqualTo "MMG_01") exitWith
				{
					_magClass = "150Rnd_93x64_Mag";
					_magNb = 2;
				};
				if (_className isEqualTo "MMG_02") exitWith
				{
					_magClass = "130Rnd_338_Mag";
					_magNb = 2;
				};
				if (_className isEqualTo "SMG_03") exitWith
				{
					_magClass = "50Rnd_570x28_SMG_03";
					_magNb = 4;
				};
				_className = _primarWaypon select [0,9];
				if (_className isEqualTo "LMG_Zafir") exitWith
				{
					_magClass = "150Rnd_762x54_Box_Tracer";
					_magNb = 2;
				};
				if (_className isEqualTo "LMG_Mk200") exitWith
				{
					_magClass = "200Rnd_65x39_cased_Box_Tracer";
					_magNb = 2;
				};

				_supportedMags = getArray (configFile >> "CfgWeapons" >> _primarWaypon >> "magazines");
				_magClass = _supportedMags # 0;
				_magNb = 11;
			};
		};
	}
	else
	{
		call
		{
			private _wpStr = call DK_weaponStart;

			if (_wpStr isEqualTo 0) exitWith
			{
				_magClass = "30Rnd_556x45_Stanag";
				_weaponClass = "arifle_Mk20C_F";
			};

			if (_wpStr isEqualTo 1) exitWith
			{
				_magClass = "30Rnd_45ACP_Mag_SMG_01";
				_weaponClass = "SMG_01_F";
			};

			if (_wpStr isEqualTo 2) exitWith
			{
				_magClass = "9Rnd_45ACP_Mag";
				_weaponClass = "hgun_ACPC2_F";
			};
		};

		_magNb = 11;
	};

	[_magClass,_magNb,_weaponClass]
};

DK_fnc_bonus_LJ_stuffCar = {

	params ["_veh", "_magClass", "_magNb", "_weaponClass", "_stuffLvL", "_wpSelect", "_player"];
 

	clearItemCargoGlobal _veh;

	call
	{
		if (call DK_fnc_checkIfNight) then
		{
			_veh addItemCargoGlobal ["NVGoggles_INDEP", 1];		
			_veh addItemCargoGlobal ["acc_flashlight", 1];
		};

		private _score = (getPlayerScores _player) # 5;
		if (_score >= call DK_LJ_WP_SCORE_MAX_PAL0) then
		{
			private "_nbRqt";
			call
			{
				if (_score < call DK_LJ_WP_SCORE_MAX_PAL1) exitWith
				{
					_nbRqt = 2;
					_veh addBackpackCargoGlobal ["B_FieldPack_blk",1];
					_veh addMagazineCargoGlobal ["MiniGrenade",2];
				};

				if (_score < call DK_LJ_WP_SCORE_MAX_PAL2) exitWith
				{
					_veh addBackpackCargoGlobal ["B_FieldPack_blk",1];
					_veh addBackpackCargoGlobal ["B_Kitbag_rgr", 1];
					_veh addMagazineCargoGlobal ["MiniGrenade",2];
					_veh addMagazineCargoGlobal ["SmokeShell",1];
					_nbRqt = 3;
				};

				if (_score < call DK_LJ_WP_SCORE_MAX_PAL3) exitWith
				{
					_veh addBackpackCargoGlobal ["B_FieldPack_blk",1];
					_veh addBackpackCargoGlobal ["B_Kitbag_rgr", 1];
					_veh addBackpackCargoGlobal ["B_Carryall_khk", 1];
					_veh addMagazineCargoGlobal ["MiniGrenade", 3];
					_veh addMagazineCargoGlobal ["SmokeShell", 2];
					_nbRqt = 4;

					if (call DK_LJ_ALWD_EXPL) then
					{
						_veh addItemCargoGlobal ["DemoCharge_Remote_Mag",1];
					};
				};

				_veh addBackpackCargoGlobal ["B_FieldPack_blk",1];
				_veh addBackpackCargoGlobal ["B_Kitbag_rgr", 1];
				_veh addBackpackCargoGlobal ["B_Carryall_khk", 1];
				_veh addMagazineCargoGlobal ["MiniGrenade", 3];
				_veh addMagazineCargoGlobal ["SmokeShell", 2];
				_nbRqt = 4;

				if (call DK_LJ_ALWD_EXPL) then
				{
					_veh addItemCargoGlobal ["DemoCharge_Remote_Mag",1];
					_veh addItemCargoGlobal ["SatchelCharge_Remote_Mag",1];
				};
			};

			call
			{
				if (call DK_fnc_allPlayersHaveDLC_apex) exitWith
				{
					_veh addWeaponCargoGlobal ["launch_RPG7_F",1];
					_veh addMagazineCargoGlobal ["RPG7_F", _nbRqt];
				};

				_veh addWeaponCargoGlobal ["launch_RPG32_F",1];
				_veh addMagazineCargoGlobal ["RPG32_F", _nbRqt];
			};

		};

		if (_stuffLvL isEqualTo 0) exitWith
		{
			call
			{
				if (_wpSelect isEqualTo 0) exitWith
				{
					if (_weaponClass isEqualTo "") exitWith
					{
						_veh addMagazineCargoGlobal [_magClass, _magNb];
						_veh addItemCargoGlobal ["optic_ACO_grn", 1];
					};

					_veh addWeaponWithAttachmentsCargoGlobal [[_weaponClass, "", "", "optic_ACO_grn", [_magClass, 30], [], ""], 1];
					_veh addMagazineCargoGlobal [_magClass, _magNb - 1];
				};

				if (_wpSelect isEqualTo 1) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["SMG_02_F", "", "", "optic_ACO_grn", ["30Rnd_9x21_Mag_SMG_02", 30], [], ""], 1];
					_veh addMagazineCargoGlobal ["30Rnd_9x21_Mag_SMG_02", 10];
				};

				if (_wpSelect isEqualTo 2) then
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["arifle_TRG20_F", "", "", "optic_ACO_grn", ["30Rnd_556x45_Stanag", 30], [], ""], 1];
					_veh addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 10];
				};
			};
		};

		if (_stuffLvL isEqualTo 1) exitWith
		{
			call
			{
				if (_wpSelect isEqualTo 0) exitWith
				{
					if (_weaponClass isEqualTo "") exitWith
					{
						_veh addMagazineCargoGlobal [_magClass, _magNb];
						_veh addItemCargoGlobal ["optic_ACO_grn", 1];
					};

					_veh addWeaponWithAttachmentsCargoGlobal [[_weaponClass, "", "", "optic_ACO_grn", [_magClass, 30], [], ""], 1];
					_veh addMagazineCargoGlobal [_magClass, _magNb - 1];
				};

				if (_wpSelect isEqualTo 1) exitWith
				{
					_veh addWeaponCargoGlobal ["arifle_AKS_F",1];
					_veh addMagazineCargoGlobal ["30Rnd_545x39_Mag_F",11];
				};

				if (_wpSelect isEqualTo 2) then
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["arifle_Katiba_C_F", "", "", "optic_ACO_grn", ["30Rnd_65x39_caseless_green", 30], [], ""], 1];
					_veh addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 10];
				};
			};

		};

		if (_stuffLvL isEqualTo 2) exitWith
		{
			call
			{
				if (_wpSelect isEqualTo 0) exitWith
				{
					if (_weaponClass isEqualTo "") exitWith
					{
						_veh addMagazineCargoGlobal [_magClass, _magNb];
						_veh addItemCargoGlobal ["optic_ACO_grn", 1];
					};

					_veh addWeaponWithAttachmentsCargoGlobal [[_weaponClass, "", "", "optic_ACO_grn", [_magClass, 30], [], ""], 1];
					_veh addMagazineCargoGlobal [_magClass, _magNb - 1];
				};

				if (_wpSelect isEqualTo 1) exitWith
				{
					_veh addWeaponCargoGlobal ["arifle_AKM_F",1];
					_veh addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",11];	
				};

				if (_wpSelect isEqualTo 2) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["srifle_EBR_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["20Rnd_762x51_Mag", 20], [], "bipod_02_F_tan"], 1];
					_veh addMagazineCargoGlobal ["20Rnd_762x51_Mag", 10];
				};

				if (_wpSelect isEqualTo 3) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["LMG_Mk200_F", "", "", "optic_ACO_grn", ["200Rnd_65x39_cased_Box_Tracer", 100], [], "bipod_02_F_blk"], 1];
					_veh addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer",1];
				};

				if (_wpSelect isEqualTo 4) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_03_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["20Rnd_762x51_Mag", 20], [], "bipod_02_F_blk"], 1];
					_veh addMagazineCargoGlobal ["20Rnd_762x51_Mag", 8];
				};
			};

		};

		if (_stuffLvL isEqualTo 3) exitWith
		{
			call
			{
				if (_wpSelect isEqualTo 0) exitWith
				{
					if (_weaponClass isEqualTo "") exitWith
					{
						_veh addMagazineCargoGlobal [_magClass, _magNb];
						_veh addItemCargoGlobal ["optic_ACO_grn", 1];
					};

					_veh addWeaponWithAttachmentsCargoGlobal [[_weaponClass, "", "", "optic_ACO_grn", [_magClass, 30], [], ""], 1];
					_veh addMagazineCargoGlobal [_magClass, _magNb - 1];
				};
				if (_wpSelect isEqualTo 1) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["arifle_AK12_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["30Rnd_762x39_Mag_F", 30], [], "bipod_02_F_blk"], 1];
					_veh addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 8];	
				};

				if (_wpSelect isEqualTo 2) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["arifle_MXM_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["30Rnd_65x39_caseless_mag", 30], [], "bipod_02_F_tan"], 1];
					_veh addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 10];
				};

				if (_wpSelect isEqualTo 3) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["LMG_Mk200_F", "", "", "optic_ACO_grn", ["200Rnd_65x39_cased_Box_Tracer", 200], [], "bipod_02_F_blk"], 1];
					_veh addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 1];
				};

				if (_wpSelect isEqualTo 4) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["LMG_03_F", "", "", "optic_ACO_grn", ["200Rnd_556x45_Box_Tracer_F", 200], [], ""], 1];
					_veh addMagazineCargoGlobal ["200Rnd_556x45_Box_Tracer_F", 1];
				};

				if (_wpSelect isEqualTo 5) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_05_tan_f", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["10Rnd_93x64_DMR_05_Mag", 10], [], "bipod_01_F_blk"], 1];
					_veh addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 9];
				};
			};

		};

		if (_stuffLvL isEqualTo 4) then
		{
			call
			{
				if (_wpSelect isEqualTo 0) exitWith
				{
					if (_weaponClass isEqualTo "") exitWith
					{
						_veh addMagazineCargoGlobal [_magClass, _magNb];
						_veh addItemCargoGlobal ["optic_ACO_grn", 1];
					};

					_veh addWeaponWithAttachmentsCargoGlobal [[_weaponClass, "", "", "optic_ACO_grn", [_magClass, 30], [], ""], 1];
					_veh addMagazineCargoGlobal [_magClass, _magNb - 1];
				};

				if (_wpSelect isEqualTo 1) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["arifle_AK12_GL_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["30Rnd_762x39_Mag_F", 30], ["1Rnd_HE_Grenade_shell", 1], ""], 1];
					_veh addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 9];	
					_veh addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 2];
				};

				if (_wpSelect isEqualTo 2) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["arifle_MX_GL_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_MRCO"} else {"optic_ACO_grn"}, ["30Rnd_65x39_caseless_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""], 1];
					_veh addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 10];
					_veh addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 3];
				};

				if (_wpSelect isEqualTo 3) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["LMG_Zafir_F", "", "", "optic_ACO_grn", ["150Rnd_762x54_Box_Tracer", 150], [], ""], 1];
					_veh addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer", 2];
				};

				if (_wpSelect isEqualTo 4) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["LMG_03_F", "", "", "optic_ACO_grn", ["200Rnd_556x45_Box_Tracer_F", 100], [], ""], 1];
					_veh addMagazineCargoGlobal ["200Rnd_556x45_Box_Tracer_F", 2];
				};

				if (_wpSelect isEqualTo 5) exitWith
				{
					_veh addWeaponWithAttachmentsCargoGlobal [["srifle_LRR_F", "", "", if (call DK_LJ_ALWD_OPTC) then {"optic_KHS_blk"} else {"optic_ACO_grn"}, ["7Rnd_408_Mag", 7], [], ""], 1];
					_veh addMagazineCargoGlobal ["7Rnd_408_Mag",7];
				};
			};

		};
	};
};

DK_fnc_bonus_LJ_getOut = {


	params ["_littleJ", "_jacobCar", "_player", "_idEHs", "_time", "_stuffList"];


	_idEHs = _jacobCar getVariable "DK_idEh";
	_jacobCar removeEventHandler ["Dammaged", _idEHs # 1];
	_jacobCar removeEventHandler ["HandleDamage", _idEHs # 0];
	_jacobCar removeEventHandler ["GetIn", _idEHs # 2];

	doStop [_littleJ,_jacobCar];
	_jacobCar limitSpeed 1;
	_jacobCar forceSpeed 0;
	_littleJ moveTo (getPos (vehicle _littleJ));
	_jacobCar engineOn false;

	_time = time + 40;

	waitUntil { uiSleep 0.3; ( (speed _littleJ < 1.5) && { ((_player distance (vehicle _littleJ)) < 8) } ) OR (!alive _littleJ) OR (!alive _jacobCar) OR (time > _time) OR ( (speed _littleJ < 1.5) && { (_jacobCar getVariable ["smoked",false]) } ) };


	if ((alive _jacobCar) && !(_jacobCar getVariable ["smoked",false])) then
	{
		_stuffList = _littleJ getVariable "stuffList";
		[_jacobCar, _stuffList # 0, _stuffList # 1, _stuffList # 2, _stuffList # 3, _stuffList # 4, _player] call DK_fnc_bonus_LJ_stuffCar;

		_jacobCar setVehicleLock "UNLOCKED";
	};

	if (alive _littleJ) then
	{
		uiSleep 0.5;

		[_littleJ, 4, 30, true] spawn DK_fnc_addAllTo_CUM;
		_littleJ spawn
		{
			uiSleep 32;

			if (alive _this) then
			{
				[_this, 1] spawn DK_fnc_addAllTo_CUM;
			};
		};

		moveOut _littleJ;
		[_littleJ] orderGetIn false;
		[_littleJ] allowGetIn false;
		_littleJ leaveVehicle _jacobCar;

		_littleJ disableAI "PATH";

		_littleJ forceWalk true;

		uiSleep 1;
		if (_player distance _littleJ < 30) then
		{
			_littleJ lookAt _player;		
			_littleJ doWatch _player;		
			_littleJ glanceAt _player;		

			uiSleep 0.4;
			_voice = selectRandom ["bonus_jacob01","bonus_jacob02","bonus_jacob02"];
			[_littleJ,_voice,70,1,true] spawn DK_fnc_say3D;

			private _slpLips = 2.2;
			if (_voice isEqualTo "bonus_jacob01") then
			{
				_slpLips = 0.6;
			};

			[_littleJ, _slpLips] spawn DK_fnc_randomLip;

			_littleJ playActionNow (selectRandom ["gestureHi","gestureHiB"]); 

			uiSleep 7;
		};

		_jacobCar forceSpeed -1;
		_littleJ forceSpeed -1;
		_littleJ enableAI "PATH";
		_littleJ setVariable ["DK_behaviour","walk"];
		_littleJ call DK_fnc_CLAG_doWalkPed;
	};
};


DK_fnc_bonus_LJ_debugInProg = {

	private _time = time + 52;

	waitUntil { (time > _time) OR !(DK_weapon_LJ_InProgress) };

	call
	{
		if (isNil "DK_littleJ") exitWith {};

		_time = time + 220;

		waitUntil { (time > _time) OR (isNil "DK_littleJ") OR !(DK_weapon_LJ_InProgress) };
	};

	if DK_weapon_LJ_InProgress then
	{
		DK_weapon_LJ_InProgress = false;
		publicVariable "DK_weapon_LJ_InProgress";
	};
};

DK_fnc_bonus_LJ_EH_deleted = {

	_this addEventHandler ["Deleted",
	{
		DK_weapon_LJ_InProgress = false;
		publicVariable "DK_weapon_LJ_InProgress";

		DK_littleJ = nil;
	}];
};