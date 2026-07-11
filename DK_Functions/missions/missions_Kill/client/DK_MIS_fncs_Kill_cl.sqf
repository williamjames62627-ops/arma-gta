if !(hasInterface) exitWith {};


// Mission KILL 01 / 02 / 03
DK_MIS_fnc_K01_initClient_cl = {

	_this spawn
	{
		params ["_idMission", "_allUnits", "_insult", "_classGuy", "_victorySnd"];


		DK_MIS_allUnits = +_allUnits;

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
		};

		// get text for Hint
		DK_vTxt_MIS_hintStructured = DK_vTxt_MIS_hint_Kill + "all " + _insult + " " + _classGuy + "<br/><br/>";

		uiSleep 2.5;

		if !(isServer) then
		{
			_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission_cl;
		};

	///	// Hint loop
		_idMission spawn DK_MIS_fnc_Kill_showHint_cl;

	///	// 3d icons & markers
		private _idEhResp = [_idMission] call DK_MIS_add_3dIcone_Kill_cl;

	///	// Petrovic Speech


	///	// Waiting end of current mission 
		[_idMission, _victorySnd, _idEhResp] call DK_MIS_fnc_Kill_WaitEnd_cl;
	};

};

// Mission KILL 04
DK_MIS_fnc_K04_initClient_cl = {

	_this spawn
	{
		params ["_idMission", "_allUnits", "_classGuys", "_victorySnd"];


		DK_MIS_allUnits = +_allUnits;

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
		};

		// get text for Hint
		DK_vTxt_MIS_hintStructured = DK_vTxt_MIS_hint_Kill + "leaders of " + (_classGuys # 0) + " and " + (_classGuys # 1) + "<br/><br/>";

		uiSleep 2.5;

		if !(isServer) then
		{
			_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission_cl;
		};

	///	// Hint loop
		_idMission spawn DK_MIS_fnc_Kill_showHint_cl;

	///	// 3d icons & markers
		private _idEhResp = [_idMission, _allUnits] call DK_MIS_add_3dIcone_Kill_cl;

	///	// Petrovic Speech


	///	// Waiting end of current mission 
		[_idMission, _victorySnd, _idEhResp] call DK_MIS_fnc_Kill_WaitEnd_cl;
	};

};

// Mission KILL 05
DK_MIS_fnc_K05_initClient_cl = {

	_this spawn
	{
		params ["_idMission", "_allUnits", "_classGuy", "_victorySnd"];


		DK_MIS_allUnits = +_allUnits;

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
		};

		// get text for Hint
		DK_vTxt_MIS_hintStructured = DK_vTxt_MIS_hint_Kill + " " + _classGuy + DK_vTxt_MIS_hint_AA_gp;

		uiSleep 2.5;

		if !(isServer) then
		{
			_idMission spawn DK_MIS_fnc_cntdwnMaxTimeMission_cl;
		};

	///	// Hint loop
		_idMission spawn DK_MIS_fnc_Kill_showHint_cl;

	///	// 3d icons & markers
		private _idEhResp = [_idMission] call DK_MIS_add_3dIcone_Kill_cl;

	///	// Petrovic Speech


	///	// Waiting end of current mission 
		[_idMission, _victorySnd, _idEhResp] call DK_MIS_fnc_Kill_WaitEnd_cl;
	};

};



// Missions KILL commun
DK_MIS_fnc_Kill_WaitEnd_cl = {

	params ["_idMission", "_victorySnd", "_idEhResp"];


	// Waiting end
	waitUntil { uiSleep 0.3; !(_idMission isEqualTo DK_idMission) };

	if (!isNil "_idEhResp") then
	{
		player removeEventHandler ["Respawn", _idEhResp];
	};

	// Show last hint
	if (!isNil "DK_nbTargets_Cnt") then
	{
		if (DK_nbTargets_Cnt isEqualTo DK_nbTargets_Goal) then
		{
			hintSilent parseText DK_vTxt_MIS_hint_Cplt;
			playSound [_victorySnd, true];
		}
		else
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

	} count DK_MIS_tgMarkers;

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


	// Delete variables
	DK_nbTargets_Cnt = nil;
	DK_nbTargets_Goal = nil;
	DK_MIS_allUnits = nil;
	DK_vTxt_MIS_hintStructured = nil;
	DK_cntdwnTime = 0;
};

DK_MIS_fnc_Kill_showHint_cl = {

	while { _this isEqualTo DK_idMission } do
	{
		true call DK_MIS_fnc_Kill_Hint_cl;

		uiSleep 25;
	};
};


// All missions with target Units to kill
DK_MIS_fnc_Kill_Hint_cl = {

	if _this then
	{
		hintSilent parseText ( DK_vTxt_MIS_hintStructured + (str DK_nbTargets_Cnt) + " / " + (str DK_nbTargets_Goal) + "<br/><br/>" + (str round (DK_cntdwnTime / 60)) + " min left" );
	}
	else
	{
		hint parseText ( DK_vTxt_MIS_hintStructured + (str DK_nbTargets_Cnt) + " / " + (str DK_nbTargets_Goal) + "<br/><br/>" + (str round (DK_cntdwnTime / 60)) + " min left" );
	};
};

DK_MIS_add_3dIcone_Kill_cl = {

	params ["_idMission", "_allUnits"];


/*	// Create markers targets
	private ["_mkr", "_nil"];

	{
		if (!isNil "_x") then
		{
			deleteMarkerLocal _x;
		};

	} count DK_MIS_tgMarkers;

	DK_MIS_tgMarkers = [];
	private _mkrNb = 0;
	{
		_mkrNb = _mkrNb + 1;

		_mkr = createMarkerLocal  [("DK_mkr" + _idMission + (str _mkrNb)), _x];
		_mkr setMarkerTypeLocal "hd_dot";
		_mkr setMarkerColorLocal "ColorRed";
		_mkr setMarkerSizeLocal [0.8,0.8];

		_x setVariable ["hisMkr", _mkr];

		_nil = DK_MIS_tgMarkers pushBackUnique _mkr;

	} count DK_MIS_allUnits;
*/

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


/*	// Added icon 3d Eachframe
	switch (["Par_icon3dMis", 1] call BIS_fnc_getParamValue) do
	{
		case 1 :
		{
			DK_MIS_fnc_3dIcone_Kill_cl = DK_MIS_fnc_All3dIcone_Kill_cl;
		};

		case 2 :
		{
			DK_MIS_fnc_3dIcone_Kill_cl = DK_MIS_fnc_Far3dIcone_Kill_cl;
		};
	};
*/

	DK_mateNtargets_EF = addMissionEventHandler ["EachFrame",
	{
		call DK_MIS_fnc_3dIcone_Kill_cl;
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
			call DK_MIS_fnc_3dIcone_Kill_cl;
			call DK_fnc_3dIcone_Mate;
		}];
	}];

	if (!isNil "_allUnits") then
	{
		_allUnits apply
		{
			_x addEventHandler ["Deleted",
			{
				params ["_unit"];

				if (!isNil {_unit getVariable "hisMkr"}) then
				{
					deleteMarkerLocal (_unit getVariable "hisMkr");
				};
			}];
		};
	};


	_idEhResp
};



DK_MIS_fnc_All3dIcone_Kill_cl = {

	private ["_opak", "_icon", "_pos", "_dis", "_stance"];

	{
		if (alive _x) then
		{
	//		(_x getVariable "hisMkr") setMarkerPosLocal (getPosATLVisual _x);

			_dis = player distance _x;

			if (_dis >= 301) exitWith
			{
				call
				{
					if (cameraView isEqualTo "GUNNER") exitWith
					{
						_opak = 0.2;
					};

					_opak = 0.75;
				};

				call
				{
					if (isNull objectParent _x) exitWith
					{
						_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.5];
					};

					_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.2];
				};


				drawIcon3D [DK_vImg3d_arwMateFar, [0.96,0,0,_opak], _pos, 3.7, 3.7, 0, "", 0, 0.022, "TahomaB", "center", true];
			};


			call
			{
				if (cameraView isEqualTo "GUNNER") exitWith
				{
					_opak = 0.4;
				};

				_opak = 1;
			};


			if ( _x call DK_fnc_checkIfVisUnit ) then
			{
				call
				{
					if (_dis < 15) exitWith
					{
						call
						{
							if (isNull objectParent _x) exitWith
							{
								call
								{
									_stance = stance _x;

									if (_stance isEqualTo "PRONE") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1];
									};
									if (_stance isEqualTo "CROUCH") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.5];
									};

									_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2];
								};
							};

							_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.75];
//							_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.4];
						};

						drawIcon3D [DK_vImg3d_arwMateDown,[0.96,0,0,_opak],_pos,0.5,0.5,0, "",0,0.032,"TahomaB","center",true];
					};

					if ( (_dis >= 15) && { (_dis <= 40) } ) exitWith
					{
						call
						{
							if (isNull objectParent _x) exitWith
							{
								call
								{
									_stance = stance _x;

									if (_stance isEqualTo "PRONE") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.4];
									};
									if (_stance isEqualTo "CROUCH") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.95];
									};

									_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.2];
								};

								drawIcon3D [DK_vImg3d_arwMateDown,[0.96,0,0,_opak],_pos,0.4,0.4,0, "",0,0.027,"TahomaB","center",true];
							};

							drawIcon3D [DK_vImg3d_arwMateDown,[0.96,0,0,_opak],ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.8],0.4,0.4,0, "",0,0.027,"TahomaB","center",true];
						};
					};

					if ( (_dis > 40) && { (_dis <= 75) } ) exitWith
					{
						call
						{
							if (isNull objectParent _x) exitWith
							{
								call
								{
									_stance = stance _x;

									if (_stance isEqualTo "PRONE") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.55];
									};
									if (_stance isEqualTo "CROUCH") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.225];
									};

									_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.5];
								};
							};

							_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.85];
						};

						drawIcon3D [DK_vImg3d_arwMateDown,[0.96,0,0,_opak],_pos,0.32,0.32,0, "",0,0.024,"TahomaB","center",true];
					};
				};
			};


			call
			{
				if ( (_dis > 75) && { (_dis < 140) } ) exitWith
				{
						call
						{
							if ( _x call DK_fnc_checkIfVisUnit ) exitWith
							{
								_icon = DK_vImg3d_arwMateDown;
							};
							
							_icon = DK_vImg3d_arwMateUp;
						};

						call
						{
							if (isNull objectParent _x) exitWith
							{
								call
								{
									_stance = stance _x;

									if (_stance isEqualTo "PRONE") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.5];
									};
									if (_stance isEqualTo "CROUCH") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.115];
									};

									_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.3];
								};
							};

							_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.6];
						};

					drawIcon3D [_icon, [0.96,0,0,_opak], _pos, 0.32, 0.32, 0, "", 0, 0.022, "TahomaB", "center", true];
				};

				if ( (_dis >= 140) && { (_dis < 301) } ) exitWith
				{
						call
						{
							if ( _x call DK_fnc_checkIfVisUnit ) exitWith
							{
								_icon = DK_vImg3d_arwMateDown;
							};
							
							_icon = DK_vImg3d_arwMateUp;
						};

						call
						{
							if (isNull objectParent _x) exitWith
							{
								call
								{
									_stance = stance _x;

									if (_stance isEqualTo "PRONE") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.15];
									};
									if (_stance isEqualTo "CROUCH") exitWith
									{
										_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.125];
									};

									_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.5];
								};
							};

							_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,1.95];
						};

					drawIcon3D [_icon,[0.96,0,0,_opak],_pos,0.4,0.4,0, "",0,0.022,"TahomaB","center",true];
				};
			};
		};

	} count DK_MIS_allUnits;

};

DK_MIS_fnc_Far3dIcone_Kill_cl = {

	private ["_opak", "_pos"];

	{
		if ( (alive _x) && { (player distance _x > 300) } ) then
		{
			call
			{
				if (cameraView isEqualTo "GUNNER") exitWith
				{
					_opak = 0.2;
				};

				_opak = 0.75;
			};

			call
			{
				if (isNull objectParent _x) exitWith
				{
					_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.5];
				};

				_pos = ASLToAGL (getPosASLVisual _x) vectorAdd [0,0,2.2];
			};


			drawIcon3D [DK_vImg3d_arwMateFar, [0.96,0,0,_opak], _pos, 3.7, 3.7, 0, "", 0, 0.022, "TahomaB", "center", true];
		};

	} count DK_MIS_allUnits;
};

// Mission Kill with reinforcement
DK_fnc_hudKillRfr = {

	_this spawn
	{
		private _time = time + 15;
			
		while { time < _time } do
		{
			["<t shadow='2' color='#FFFFFF' size = '.5'>" + _this + " called backup", -1,  safeZoneY + safeZoneH - 0.33, 0.25, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;

			uiSleep 1;
		};

		["<t shadow='2' color='#FFFFFF' size = '.5'>" + _this + " called backup", -1,  safeZoneY + safeZoneH - 0.33, 30, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;
	};
};


// Added icon 3d Eachframe
switch (["Par_icon3dMis", 1] call BIS_fnc_getParamValue) do
{
	case 1 :
	{
		DK_MIS_fnc_3dIcone_Kill_cl = DK_MIS_fnc_All3dIcone_Kill_cl;
	};

	case 2 :
	{
		DK_MIS_fnc_3dIcone_Kill_cl = DK_MIS_fnc_Far3dIcone_Kill_cl;
	};
};


