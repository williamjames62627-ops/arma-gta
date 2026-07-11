if !(hasInterface) exitWith {};


if !(isServer) then
{
	DK_MIS_fnc_cntdwnMaxTimeMission_cl = {

		if (DK_cntdwnTime < 1) then
		{
			DK_cntdwnTime = DK_MIS_maxTimeMission;
		};

		if (DK_cntdwnTime < 1) exitWith {};

		while { _this isEqualTo DK_idMission } do
		{
			_time = time + 59;

			uiSleep 50;

			waitUntil { uiSleep 0.4; (time > _time) OR !(_this isEqualTo DK_idMission) };

			if !(_this isEqualTo DK_idMission) exitWith {};

			DK_cntdwnTime = DK_cntdwnTime - 60;

			if (DK_cntdwnTime < 1) exitWith {};
		};
	};
};

// Rewards Box
DK_MIS_rewardsBoxList = [];

DK_MIS_fnc_rewards3dIcone_cl = {

	DK_MIS_rewardsBoxList pushBackUnique _this;

	// Create marker Reward box
	private _mkr = createMarkerLocal [str (random 1000), _this];
	call
	{
		if (_this isKindOf "LandVehicle") exitWith
		{
			_mkr setMarkerTypeLocal "mil_box";
		};

		_mkr setMarkerTypeLocal "mil_triangle";
	};
	_mkr setMarkerColorLocal "ColorGUER";
	_mkr setMarkerSizeLocal [1.1,1.1];

	_this setVariable ["hisMkr", _mkr];

	// Add 3d icone
	if (!isNil "DK_rewards_EF") then
	{
		removeMissionEventHandler ["EachFrame", DK_rewards_EF];
		DK_rewards_EF = nil;
	};

	DK_rewards_EF = addMissionEventHandler ["EachFrame",
	{
		call DK_MIS_fnc_3dIcone_Rewards_cl;
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_reward"];


		[_reward, _reward getVariable "hisMkr"] call DK_MIS_fnc_delete3dIconeMarker_Rewards_cl;
	}];

	_this addEventHandler ["Killed",
	{
		params ["_reward"];


		[_reward, _reward getVariable "hisMkr"] call DK_MIS_fnc_delete3dIconeMarker_Rewards_cl;
	}];


	// Delete Marker & EachFrame after a while 
	[_this,_mkr] spawn
	{
		params ["_reward", "_mkr"];


		uiSleep 180;

		[_reward, _mkr] call DK_MIS_fnc_delete3dIconeMarker_Rewards_cl;
	};
};

DK_MIS_fnc_3dIcone_Rewards_cl = {

	private ["_opak", "_dis"];

	{
		if ( !(isNil "_x") && { (alive _x) } ) then
		{
			(_x getVariable "hisMkr") setMarkerPosLocal (getPosWorld _x);

			_dis = player distance _x;

			call
			{
				if (cameraView isEqualTo "GUNNER") exitWith
				{
					_opak = 0.4;
				};

				_opak = 1;
			};

			call
			{
				if (_x isKindOf "Car") exitWith
				{
					if (_dis < 25) exitWith
					{
						drawIcon3D [DK_vImg3d_rewards, [0,0.55,0.1,_opak], (getPosATL _x) vectorAdd [0,0,2.2], 1.1, 1.1, 35, "", 2, 0, "TahomaB", "center", true];
					};

					if (_dis < 61) exitWith
					{
						drawIcon3D [DK_vImg3d_rewards, [0,0.55,0.1,_opak], (getPosATL _x) vectorAdd [0,0,2.7], 1, 1, 35, "", 2, 0, "TahomaB", "center", true];
					};

					if (_dis < 301) then
					{
						drawIcon3D [DK_vImg3d_rewards, [0,0.55,0.1,_opak], (getPosATL _x) vectorAdd [0,0,2.7], 0.7, 0.7, 35, "", 2, 0, "TahomaB", "center", true];
					};
				};

				if (_dis < 25) exitWith
				{
					drawIcon3D [DK_vImg3d_rewards, [0,0.55,0.1,_opak], (getPosATL _x) vectorAdd [0,0,0.9], 1.1, 1.1, 35, "", 2, 0, "TahomaB", "center", true];
				};

				if (_dis < 61) exitWith
				{
					drawIcon3D [DK_vImg3d_rewards, [0,0.55,0.1,_opak], (getPosATL _x) vectorAdd [0,0,1.4], 1, 1, 35, "", 2, 0, "TahomaB", "center", true];
				};

				if (_dis < 301) then
				{
					drawIcon3D [DK_vImg3d_rewards, [0,0.55,0.1,_opak], (getPosATL _x) vectorAdd [0,0,1.4], 0.7, 0.7, 35, "", 2, 0, "TahomaB", "center", true];
				};
			};
		};

	} count DK_MIS_rewardsBoxList;
};

DK_MIS_fnc_delete3dIconeMarker_Rewards_cl = {

	params ["_rewardBox", "_mkr"];


	private _nil = DK_MIS_rewardsBoxList deleteAt (DK_MIS_rewardsBoxList find _rewardBox);

	if ( (!isNil "DK_rewards_EF") && { (DK_MIS_rewardsBoxList isEqualTo []) } ) then
	{
		removeMissionEventHandler ["EachFrame", DK_rewards_EF];
		DK_rewards_EF = nil;
	};

	if (!isNil "_mkr") then
	{
		deleteMarkerLocal _mkr;
	};
};


// Polygone rescue place
DK_MIS_fnc_crtPolygonsRescue = {

	DK_MIS_polygonsRescue = [];

	private ["_nil", "_polyg"];

///	// First Line Up

	// Pink
	{
		for "_i" from 0 to 359 step 30 do
		{
		//	_polyg = createVehicle ["Sign_Pointer_Pink_F", [0,0,0], [], 0, "CAN_COLLIDE"];
			_polyg = "Sign_Pointer_Pink_F" createVehicleLocal [0,0,0];

			hideObject _polyg;

			_polyg setpos ((_x getPos [4.5, _i]) vectorAdd [0,0,1]);
			_polyg setDir (random 360);
			_polyg setVariable ["dir", getDir _polyg];
			_nil = DK_MIS_polygonsRescue pushBackUnique _polyg;
		};

	} count _this;

	// Yellow
	{
		for "_i" from 15 to 359 step 30 do
		{
		//	_polyg = createVehicle ["Sign_Pointer_Yellow_F", [0,0,0], [], 0, "CAN_COLLIDE"];
			_polyg = "Sign_Pointer_Yellow_F" createVehicleLocal [0,0,0];

			hideObject _polyg;

			_polyg setpos ((_x getPos [4.5, _i]) vectorAdd [0,0,1]);
			_polyg setDir (random 360);
			_polyg setVariable ["dir", getDir _polyg];
			_nil = DK_MIS_polygonsRescue pushBackUnique _polyg;
		};

	} count _this;


///	// Second Line Down

	// Pink
	{
		for "_i" from 7.5 to 359 step 30 do
		{
		//	_polyg = createVehicle ["Sign_Pointer_Pink_F", [0,0,0], [], 0, "CAN_COLLIDE"];
			_polyg = "Sign_Pointer_Pink_F" createVehicleLocal [0,0,0];
			hideObject _polyg;

			_polyg setpos ((_x getPos [4.5, _i]) vectorAdd [0,0,0.5]);
			_polyg setDir (random 360);
			_polyg setVariable ["dir", getDir _polyg];
			_nil = DK_MIS_polygonsRescue pushBackUnique _polyg;
		};

	} forEach _this;

	// Yellow
	{
		for "_i" from 22.5 to 359 step 30 do
		{
		//	_polyg = createVehicle ["Sign_Pointer_Yellow_F", [0,0,0], [], 0, "CAN_COLLIDE"];
			_polyg = "Sign_Pointer_Yellow_F" createVehicleLocal [0,0,0];
			hideObject _polyg;

			_polyg setpos ((_x getPos [4.5, _i]) vectorAdd [0,0,0.5]);
			_polyg setDir (random 360);
			_polyg setVariable ["dir", getDir _polyg];
			_nil = DK_MIS_polygonsRescue pushBackUnique _polyg;
		};

	} forEach _this;

};


// Divers
DK_MIS_addAction_liftFlipVeh = {


	private _idFlip = _this addAction  [DK_vTxt_colorTake + "Flip vehicle",
	{
		private _veh = _this # 0;

		_veh remoteExecCall ["DK_MIS_fnc_flipVeh", _veh];

	} ,nil,2,true,true,"","_target call DK_MIS_fnc_condActionFlipVeh", 7];


	private _idLiftFlip = _this addAction  [DK_vTxt_colorTake + "Lift and Flip vehicle",
	{
		private _veh = _this # 0;

		_veh remoteExecCall ["DK_MIS_fnc_liftFlipVeh", _veh];

	} ,nil,2,true,true,"","_target call DK_MIS_fnc_condActionFlipVeh", 7];


	_this setVariable ["idActsFlip", [_idFlip, _idLiftFlip]];
};

DK_MIS_fnc_condActionFlipVeh = {

	(isNull (objectParent player)) && { (crew _this findIf {alive _x} isEqualTo -1) && { (cursortarget isEqualTo _this) } }
};

DK_MIS_limitSpeedPlayer_cl = {

	params ["_vehicle", "_idMission"];


	private ["_curspeed", "_vel"];


	while { (!isNull _vehicle) && { (alive _vehicle) && { (_idMission isEqualTo DK_idMission) } } } do
	{
		if ( ((driver _vehicle) isEqualTo player) && { (isTouchingGround _vehicle) } ) then
		{
			_curspeed = speed _vehicle;
			if (_curspeed > 60) then
			{
				_vel = velocityModelSpace _vehicle;
				_vehicle setVelocityModelSpace [(_vel # 0)/_curspeed * 60, (_vel # 1)/_curspeed * 60, (_vel # 2)/_curspeed * 60];

				uiSleep 0.5;
			};
		}
		else
		{
			uiSleep 5;
		};
	};
};


// Ending
DK_fnc_thisIsTheEnd = {

	if ((roleDescription player) isEqualTo ((_this # 0) # 1)) then
	{
		["endWin", true, true, false, false] call BIS_fnc_endMission;
	}
	else
	{
		["endLose", true, true, false, false] call BIS_fnc_endMission;
	};
};

