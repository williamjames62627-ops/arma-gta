if !(hasInterface) exitWith {};


// Mission TAKE CAR 01
DK_MIS_fnc_TC01_initClient_cl = {

	_this spawn
	{
		params ["_idMission", "_tg_TakeCar", "_rescuePlace", "_contain", "_configName", "_classGuy", "_victorySnd"];


		DK_MIS_TakeCar01 = _tg_TakeCar;
		DK_MIS_allVehicles = [_tg_TakeCar];
		DK_MIS_RescuePlace = _rescuePlace;
		DK_MIS_typeGuys_cl = _classGuy;


		private _time = time + 20;

		waitUntil { (!isNil "DK_cntdwnTime") OR (time > _time) };

		if ((isNil "DK_cntdwnTime") OR (DK_cntdwnTime < 1)) then
		{
			DK_cntdwnTime = DK_MIS_maxTimeMission;
		};


		if (time > 3) then
		{
			hintSilent "";

			playSound ["GSM", true];
			uiSleep 3.15;
			playSound ["GSM", true];
		};

		// Added capacity to flip obejctif
		_tg_TakeCar call DK_MIS_addAction_liftFlipVeh;

		// get text for Hint
		DK_vTxt_MIS_hintStructured = DK_vTxt_MIS_hint_Take + "the " + _configName + " containing " + _contain + " and<br/>" + DK_vTxt_MIS_hint_nBringIt + "to Petrovic" + "<br/><br/>";

		uiSleep 2.5;

		if !(isServer) then
		{
			_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission_cl;
		};

	///	// Hint loop
		[_idMission, _tg_TakeCar] spawn DK_MIS_fnc_TakeCar_showHint_cl;

	///	// 3d icons & markers
		private _idEhResp = [_idMission] call DK_MIS_add_3dIcone_TakeCar_cl;

	///	// Petrovic Speech


	/// // Block speed car
		[_tg_TakeCar, _idMission] spawn DK_MIS_limitSpeedPlayer_cl;

	///	// Waiting end of current mission 
		[_idMission, _victorySnd, _tg_TakeCar, _idEhResp] call DK_MIS_fnc_TakeCar_WaitEnd_cl;
	};

};


DK_MIS_fnc_TakeCar_WaitEnd_cl = {

	params ["_idMission", "_victorySnd", "_tg_TakeCar", "_idEhResp"];


	// Waiting end
	waitUntil { uiSleep 0.3; !(_idMission isEqualTo DK_idMission) OR (!alive _tg_TakeCar) };

	if (!isNil "_idEhResp") then
	{
		player removeEventHandler ["Respawn", _idEhResp];
	};

	// Show last hint
	if ( (!isNil "DK_MIS_TakeCarIsSafe") && { (DK_MIS_TakeCarIsSafe) } ) then
	{
		hintSilent parseText DK_vTxt_MIS_hint_Cplt;
		playSound [_victorySnd, true];
	}
	else
	{
		if (alive _tg_TakeCar) then
		{
			hintSilent parseText DK_vTxt_MIS_hint_Fail;
			playSound ["fail", true];
		};
	};

	// Delete Markers
	{
		if (!isNil "_x") then
		{
			deleteMarkerLocal _x;
		};

	} count (DK_MIS_tgMarkers + DK_MIS_tgMarkersRescue);

	// Delete Eachframe mission 3d Icon & Markers, re-added 3d icones Mate
	if (!isNil "DK_mateNtargets_EF") then
	{
		removeMissionEventHandler ["EachFrame", DK_mateNtargets_EF];
		DK_mateNtargets_EF = nil;
	};
		
	if (isNil "DK_mate_EF") then
	{
		call DK_addEH_3dIcone_Mate;
	};

	// Delete polygon rescue
	DK_MIS_polygonsRescue apply
	{
		deleteVehicle _x;
	};

	// Delete Action Flip
	DK_MIS_TakeCar01 getVariable ["idActsFlip", []] apply
	{
		DK_MIS_TakeCar01 removeAction _x;
	};


	// Delete variables
	DK_MIS_TakeCar01 = nil;
	DK_MIS_RescuePlace = nil;
	DK_MIS_allVehicles = nil;
//	DK_MIS_tgMarkers = nil;
//	DK_MIS_tgMarkersRescue = nil;
	DK_vTxt_MIS_hintStructured = nil;
	DK_cntdwnTime = 0;
	DK_MIS_polygonsRescue = nil;
	DK_MIS_fncTemp_HUD_rfr = nil;
	DK_MIS_typeGuys_cl = nil;
	if !(isServer) then
	{
		DK_MIS_TakeCarIsSafe = nil;
	};
};

DK_MIS_fnc_TakeCar_showHint_cl = {

	params ["_idMission", "_tg_TakeCar"],


	while { (_idMission isEqualTo DK_idMission) && { (!isNull _tg_TakeCar) && { (alive _tg_TakeCar) } } } do
	{
		call DK_MIS_fnc_TakeCar_Hint_cl;

		uiSleep 25;
	};
};


DK_MIS_fnc_TakeCar_Hint_cl = {

	hintSilent parseText ( DK_vTxt_MIS_hintStructured + (str round (DK_cntdwnTime / 60)) + " min left" );
};

DK_MIS_fnc_Takecar_DestroyByP_Hint_cl = {

	hintSilent parseText (DK_vTxt_MIS_hint_Fail + "<br/>" + (name _this) + DK_vTxt_MIS_hint_FailTgDstrydP);
	playSound ["fail", true];
};

DK_MIS_fnc_Takecar_DestroyUnk_Hint_cl = {

	hintSilent parseText (DK_vTxt_MIS_hint_Fail + "<br/>" + DK_vTxt_MIS_hint_FailTgDstryd);
	playSound ["fail", true];
};

DK_MIS_add_3dIcone_TakeCar_cl = {

	params ["_idMission"];


	[DK_MIS_RescuePlace # 0, DK_MIS_RescuePlace # 1] call DK_MIS_fnc_crtPolygonsRescue;
	
	// Create markers targets
	private ["_mkr", "_place", "_nil"];

	{
		if (!isNil "_x") then
		{
			deleteMarkerLocal _x;
		};

	} count (DK_MIS_tgMarkers + DK_MIS_tgMarkersRescue);

	DK_MIS_tgMarkers = [];
	DK_MIS_tgMarkersRescue = [];

	private _mkrNbA = 0;
	{
		_mkrNbA = _mkrNbA + 1;

		_mkr = createMarkerLocal  [("DK_mkr" + _idMission + (str _mkrNbA)), _x];
		_mkr setMarkerTypeLocal "mil_box";
		_mkr setMarkerColorLocal "Color5_FD_F";
		_mkr setMarkerSizeLocal [0.95,0.95];

		_x setVariable ["hisMkr", _mkr];

		_nil = DK_MIS_tgMarkers pushBackUnique _mkr;

	} forEach DK_MIS_allVehicles;

	// Create markers rescue place
	for "_i" from 0 to 1 step 1 do
	{
//		_mkrNbB = _mkrNbB + 1;

		_mkr = createMarkerLocal  [("DK_mkr" + _idMission + (str _i)), [0,0,0]];
		_mkr setMarkerAlphaLocal 0;
		_mkr setMarkerTypeLocal "mil_box";
		_mkr setMarkerColorLocal "ColorYellow";
		_mkr setMarkerSizeLocal [0.95,0.95];
		_mkr setMarkerDirLocal 45;

		_mkr setMarkerPosLocal (DK_MIS_RescuePlace # _i);

		_nil = DK_MIS_tgMarkersRescue pushBackUnique _mkr;
	};

	// Delete every similare eachFrame for be sure
	if (!isNil "DK_mate_EF") then
	{
		removeMissionEventHandler ["Draw3D", DK_mate_EF];
		DK_mate_EF = nil;
	};

	if (!isNil "DK_mateNtargets_EF") then
	{
		removeMissionEventHandler ["EachFrame", DK_mateNtargets_EF];
		DK_mateNtargets_EF = nil;
	};


	// Added icon 3d Eachframe
	DK_mateNtargets_EF = addMissionEventHandler ["EachFrame",
	{
		call DK_MIS_fnc_3dIcone_TakeCar_cl;
		call DK_fnc_3dIcone_Mate;
	}];

	// Added Respaw EH for re-give EachFrame
	private _idEhResp = player addEventHandler ["Respawn",
	{
	
		if (!isNil "DK_mateNtargets_EF") then
		{
			removeMissionEventHandler ["EachFrame", DK_mateNtargets_EF];
			DK_mateNtargets_EF = nil;
		};

		if (!isNil "DK_mate_EF") then
		{
			removeMissionEventHandler ["Draw3D", DK_mate_EF];
			DK_mate_EF = nil;
		};

		DK_mateNtargets_EF = addMissionEventHandler ["EachFrame",
		{
			call DK_MIS_fnc_3dIcone_TakeCar_cl;
			call DK_fnc_3dIcone_Mate;
		}];
	}];


	_idEhResp
};


DK_MIS_fnc_3dIcone_TakeCar_cl = {

	private ["_disVeh", "_opak", "_icon", "_txt", "_veh", "_mkrAlph0", "_isDriver", "_disRescue", "_disAff"];

	{
		_veh = _x;

		if (alive _veh) then
		{
			_isDriver = (driver _veh) isEqualTo player;

		///	// Vehicle to Rescue
			(_veh getVariable "hisMkr") setMarkerPosLocal (getPosATLVisual _veh);

			if !((driver _veh) isEqualTo player) then
			{
				_disVeh = player distance _veh;

				call
				{
					if ( (alive (driver _veh)) && { ((group (driver _veh)) isEqualTo (group player)) } ) exitWith
					{
						_icon = "\A3\ui_f\data\GUI\Rsc\RscDisplayMain\profile_unit_ca.paa";
						_txt = "PROTECT";
					};

					_icon = "\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa";
					_txt = "STEAL";
				};

				if (_disVeh >= 301) exitWith
				{
					call
					{
						if (cameraView isEqualTo "GUNNER") exitWith
						{
							_opak = 0.3;
						};

						_opak = 0.8;
					};

					drawIcon3D [_icon, [0.76, 0.27, 0.75, _opak], (getPosATLVisual _veh) vectorAdd [0,0,4], 1.02, 1.02, 0, "", 2, 0.022, "TahomaB", "center", true];
				};


				call
				{
					if (cameraView isEqualTo "GUNNER") exitWith
					{
						_opak = 0.4;
					};

					_opak = 0.7;
				};


				call
				{
					if (_disVeh < 15) exitWith
					{
						drawIcon3D [_icon, [0.76, 0.27, 0.75, _opak], (getPosATLVisual _veh) vectorAdd [0,0,2.25], 1.1, 1.1, 0, _txt, 2, 0.03, "RobotoCondensedBold", "center", true];
					};

					if ( (_disVeh >= 15) && { (_disVeh <= 40) } ) exitWith
					{
						drawIcon3D [_icon, [0.76, 0.27, 0.75, _opak], (getPosATLVisual _veh) vectorAdd [0,0,2.4], 1, 1, 0, "", 2, 0.022, "TahomaB", "center", true];
					};

					if ( (_disVeh > 40) && { (_disVeh <= 75) } ) exitWith
					{
						drawIcon3D [_icon, [0.76, 0.27, 0.75, _opak], (getPosATLVisual _veh) vectorAdd [0,0,2.8], 0.85, 0.85, 0, "", 2, 0.022, "TahomaB", "center", true];
					};

					if ( (_disVeh > 75) && { (_disVeh < 140) } ) exitWith
					{
						drawIcon3D [_icon, [0.76, 0.27, 0.75, _opak], (getPosATLVisual _veh) vectorAdd [0,0,3.3], 0.85, 0.85, 0, "", 2, 0.022, "TahomaB", "center", true];
					};

					if ((_disVeh >= 140) && { (_disVeh < 301) } ) exitWith
					{
						drawIcon3D [_icon, [0.76, 0.27, 0.75, _opak], (getPosATLVisual _veh) vectorAdd [0,0,3.7], 0.85, 0.85, 0, "", 2, 0.022, "TahomaB", "center", true];
					};
				};
			};

			///	// Place to rescue vehicle
			{
				call
				{
					_mkrAlph0 = (markerAlpha _x) isEqualTo 0;

					if ( _mkrAlph0 && { _isDriver }) exitWith
					{
						_x setMarkerAlphaLocal 1;
					};

					if ( not _mkrAlph0 && { not _isDriver }) then
					{
						_x setMarkerAlphaLocal 0;
					};
				};

			} forEach DK_MIS_tgMarkersRescue;

			call
			{
				if _isDriver exitWith
				{
					[DK_vTxt_MIS_haveVehRescue, -1, safeZoneY + safeZoneH - 0.20, 0.1, 0, 0, DK_lyDyn_downScrnHaveRescue] spawn BIS_fnc_dynamicText; 

					_disRescue = _veh distance (DK_MIS_RescuePlace # 2);

					if (_disRescue < 100) then
					{
						if (isObjectHidden (DK_MIS_polygonsRescue # 0)) then
						{
							{
								_x hideObject false;

							} forEach DK_MIS_polygonsRescue;
						};
					};

					call
					{
						if (_disRescue >= 1000) exitWith
						{
							drawIcon3D ["\A3\ui_f\data\IGUI\Cfg\simpleTasks\background3_ca.paa", [1,0.9,0,0.83], DK_MIS_RescuePlace # 2, 0.85, 0.85, 0, format ["%1 km", round ((_disRescue / 1000) * (10 ^ 1)) / (10 ^ 1)], 2, 0.032, "RobotoCondensedBold", "center", true];
						};


						if (_disRescue < 100) exitWith
						{
							drawIcon3D ["\A3\ui_f\data\IGUI\Cfg\simpleTasks\background3_ca.paa", [1,0.9,0,0.83], DK_MIS_RescuePlace # 0, 0.85, 0.85, 0, format ["%1 m", round _disRescue], 2, 0.032, "RobotoCondensedBold", "center", true];
							drawIcon3D ["\A3\ui_f\data\IGUI\Cfg\simpleTasks\background3_ca.paa", [1,0.9,0,0.83], DK_MIS_RescuePlace # 1, 0.85, 0.85, 0, format ["%1 m", round _disRescue], 2, 0.032, "RobotoCondensedBold", "center", true];
						};

						drawIcon3D ["\A3\ui_f\data\IGUI\Cfg\simpleTasks\background3_ca.paa", [1,0.9,0,0.83], DK_MIS_RescuePlace # 2, 0.85, 0.85, 0, format ["%1 m", round _disRescue], 2, 0.032, "RobotoCondensedBold", "center", true];
					};
				};

				if !(isObjectHidden (DK_MIS_polygonsRescue # 0)) then
				{
					{
						_x hideObject true;

					} forEach DK_MIS_polygonsRescue;
				};
			};
		};

	} count DK_MIS_allVehicles;


};

DK_MIS_fnc_onlyMkr_TakeCar_cl = {

	private ["_veh", "_mkrAlph0", "_isDriver"];

	{
		_veh = _x;

		if (alive _veh) then
		{
			_isDriver = (driver _veh) isEqualTo player;

			// Vehicle to Rescue
			(_veh getVariable "hisMkr") setMarkerPosLocal (getPosATLVisual _veh);

			// Place to rescue vehicle
			{
				call
				{
					_mkrAlph0 = (markerAlpha _x) isEqualTo 0;

					if ( _mkrAlph0 && { _isDriver }) exitWith
					{
						_x setMarkerAlphaLocal 1;
					};

					if ( !(_mkrAlph0) && { !(_isDriver) }) then
					{
						_x setMarkerAlphaLocal 0;
					};
				};

			} forEach DK_MIS_tgMarkersRescue;

			call
			{
				if _isDriver exitWith
				{
					[DK_vTxt_MIS_haveVehRescue, -1, safeZoneY + safeZoneH - 0.20, 0.1, 0, 0, DK_lyDyn_downScrnHaveRescue] spawn BIS_fnc_dynamicText; 

					if (_veh distance (DK_MIS_RescuePlace # 2) < 100) then
					{
						if (isObjectHidden (DK_MIS_polygonsRescue # 0)) then
						{
							{
								_x hideObject false;

							} forEach DK_MIS_polygonsRescue;
						};
					};
				};

				if !(isObjectHidden (DK_MIS_polygonsRescue # 0)) then
				{
					{
						_x hideObject true;

					} forEach DK_MIS_polygonsRescue;
				};
			};
		};

	} count DK_MIS_allVehicles;
};


DK_MIS_fnc_HUD_RfrCalled_rfr_cl = {

	params ["_typeGuys", "_tg_TakeCar", "_idMission"];


	[_typeGuys, _tg_TakeCar, _idMission] spawn
	{
		params ["_typeGuys", "_tg_TakeCar", "_idMission"];


		private _time = time + 10;
		
		if (time > 3) then
		{
			while { time < _time } do
			{
				["<t shadow='2' color='#FFFFFF' size = '.5'>" + _typeGuys + " called backup", -1,  safeZoneY + safeZoneH - 0.33, 0.25, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;

				uiSleep 1;
			};
		};

		private "_fncTemp_HUD_rfr";
		call
		{
			if (_typeGuys in ["Police forces", "FIB agents", "Military"]) exitWith
			{
				_fncTemp_HUD_rfr = {

					[DK_vTxt_wtd_wtd, -1,  safeZoneY + safeZoneH - 0.33, 15, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;
					[DK_vTxt_wtd_strs + (switch (missionNamespace getVariable ["wantedMissionLvl_cl", 1]) do { case 1 : {"* * *"}; case 2 : {"* * * *"}; case 3 : {"* * * * *"}; default { "" }; }), -1,  safeZoneY + safeZoneH - 0.295, 5, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;
				};
			};

			_fncTemp_HUD_rfr = {

				["<t shadow='2' color='#FFFFFF' size = '.5'>" + DK_MIS_typeGuys_cl + " in alert and patroling", -1,  safeZoneY + safeZoneH - 0.33, 15, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;
			};
		};

		uiSleep 0.9;

		while { (_idMission isEqualTo DK_idMission) && { (!isNull _tg_TakeCar) && { (alive _tg_TakeCar) } } } do
		{
			call _fncTemp_HUD_rfr;

			uiSleep 5;
		};

		["", -1,  0, 0, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;
		["", -1, 0, 0, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;

	};


};




/*
DK_MIS_fnc_HUD_Gangs_rfr_cl = {

	params ["_typeGuys", "_tg_TakeCar", "_idMission"];


	private _time = time + 10;
	
	if (time > 3) then
	{
		while { time < _time } do
		{
			["<t shadow='2' color='#FFFFFF' size = '.5'>" + _typeGuys + " called backup", -1,  safeZoneY + safeZoneH - 0.32, 0.25, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;

			uiSleep 1;
		};
	};

	uiSleep 0.9;

	if ( !(_idMission isEqualTo DK_idMission) OR !(!isNull _tg_TakeCar) OR !(alive _tg_TakeCar) ) exitWith {};

	DK_MIS_fncTemp_HUD_rfr = {

		["<t shadow='2' color='#FFFFFF' size = '.5'>" + DK_MIS_typeGuys_cl + " in alert and patroling", -1,  safeZoneY + safeZoneH - 0.32, 0.1, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;
	};

};



/* MOVE MARKER IF DEAD (DEBUG MOD)

onEachFrame {                                       { 
  if (alive _x) then 
  { 
   (_x getVariable "hisMkr") setMarkerPosLocal          (getPosWorld _x); 
}} forEach dk_mis_allunits }



