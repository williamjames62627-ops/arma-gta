
private _idEH = addMissionEventHandler ["Ended",{ "EveryoneWon" call BIS_fnc_endMissionServer; }];


/// INIT Spawn Position for Player's
DK_spwnPos =
[
	[185.592,90],[0,0],
	[123.728,90],[61.864,-90],
	[61.864,90],[123.728,-90],
	[0,0],[185.592,-90]		
];

///  CIVIL SIDE SETUP
CIVILIAN setfriend [WEST,0];
CIVILIAN setfriend [EAST,1];
CIVILIAN setfriend [independent,1];

/// Order Force (cops fbi army)
independent setfriend [WEST,0];
independent setfriend [EAST,0];

/// Enemie for all (Bandits)
EAST setfriend [WEST,0];
EAST setfriend [independent,0];
EAST setfriend [civilian,1];

/// Players Team
WEST setfriend [EAST,0];
WEST setfriend [independent,0];



/// DELETE CORPS when player disconnect
addMissionEventHandler ["HandleDisconnect",
{
	params ["_unit"];


	if ( (alive _unit) OR { !((DK_mkrs_spawnProtect findIf { _unit inArea _x; }) isEqualTo -1) } ) then
	{
		deleteVehicle _unit;
	}
	else
	{
		if (!isNil "_unit") then
		{
			[_unit, 60, 150, true] spawn DK_fnc_addAllTo_CUM;
		};
	};


	false
}];

/*
addMissionEventHandler ["PlayerDisconnected",
{
	params ["", "_uid", "_name"]


	if !(_uid isEqualTo "") exitWith
	{
		missionNamespace setVariable [("DK_" + _uid), ];
	};
}];
*/





DK_durationTmGame = "Par_durationTimeGame" call BIS_fnc_getParamValue;
DK_dayTime = "Par_dayTime" call BIS_fnc_getParamValue;
DK_rainLvl = "Par_rainLevel" call BIS_fnc_getParamValue;



// === DURATION GAME
switch (DK_durationTmGame) do
{
	case -1 : { DK_cntTmGameStart = 2700; }; // 45min
	case 0 : { DK_cntTmGameStart = 3600; }; // 1h00
	case 1 : { DK_cntTmGameStart = 4800; }; // 1h20 
	case 2 : { DK_cntTmGameStart = 6000; }; // 1h40 
	case 3 : { DK_cntTmGameStart = 7200; }; // 2h00 
	case 4 : { DK_cntTmGameStart = 8400; }; // 2h20 
	case 5 : { DK_cntTmGameStart = 9600; }; // 2h40 
	case 6 : { DK_cntTmGameStart = 10800; }; // 3h00
};

DK_middleTime = round (DK_cntTmGameStart / 2);


// === DATE, WEATHER, RAIN, CLOUDS
	waitUntil { (count allPlayers) > 0 };

	switch (DK_dayTime) do
	{
		case 0 : { setDate [2035, 6, 10, 1, 00]; };
		case 1 : { setDate [2035, 6, 10, 2, 00]; };
		case 2 : { setDate [2035, 6, 10, 3, 00]; };
		case 3 : { setDate [2035, 6, 10, 4, 00]; };
		case 4 : { setDate [2035, 6, 10, 4, 30]; };
		case 5 : { setDate [2035, 6, 10, 5, 00]; };
		case 6 : { setDate [2035, 6, 10, 6, 00]; };
		case 7 : { setDate [2035, 6, 10, 7, 00]; };
		case 8 : { setDate [2035, 6, 10, 8, 00]; };
		case 9 : { setDate [2035, 6, 10, 9, 00]; };
		case 10 : { setDate [2035, 6, 10, 10, 00]; };
		case 11 : { setDate [2035, 6, 10, 11, 00]; };
		case 12 : { setDate [2035, 6, 10, 12, 00]; };
		case 13 : { setDate [2035, 6, 10, 13, 00]; };
		case 14 : { setDate [2035, 6, 10, 14, 00]; };
		case 15 : { setDate [2035, 6, 10, 15, 00]; };
		case 16 : { setDate [2035, 6, 10, 16, 00]; };
		case 17 : { setDate [2035, 6, 10, 17, 00]; };
		case 18 : { setDate [2035, 6, 10, 18, 00]; };
		case 19 : { setDate [2035, 6, 10, 19, 00]; };
		case 20 : { setDate [2035, 6, 10, 20, 00]; };
		case 21 : { setDate [2035, 6, 10, 21, 00]; };
		case 22 : { setDate [2035, 6, 10, 22, 00]; };
		case 23 : { setDate [2035, 6, 10, 23, 00]; };
		case 24 : { setDate [2035, 6, 10, 0, 00]; };
		case 25 : {
					private _dropTime = round (DK_cntTmGameStart / 3600);
					private _hours = (5 + round (random 13)) - _dropTime;
					if (_hours < 5) then
					{
						_hours = 5;
					};
					setDate [2035, 6, 10, _hours, round (random 59)];
				  };
		case 26 : {
					private _dropTime = round (DK_cntTmGameStart / 3600);
//					private _hours = (4 + round (random 15)) - _dropTime;
					private _hours = (4 + round (random 15)) - _dropTime;
					if (_hours < 4) then
					{
						_hours = 4;
					};
//					setDate [2035, 6, 10, _hours, 15 + (round (random 25))];
					setDate [2035, 6, 10, _hours, 15 + (round (random 44))];
				  };
		case 27 : {				
					setDate [2035, 6, 10, round (random 23), round (random 59)];
				  };
	};

	if (time < 10) then
	{
		switch ("Par_weather" call BIS_fnc_getParamValue) do
		{
			case 0 : { 0 setOvercast 0; };
			case 1 : { 0 setOvercast 0.1; };
			case 2 : { 0 setOvercast 0.2; };
			case 3 : { 0 setOvercast 0.3; };
			case 4 : { 0 setOvercast 0.4; };
			case 5 : { 0 setOvercast 0.5; };
			case 6 : { 0 setOvercast 0.6; };
			case 7 : { 0 setOvercast 0.7; };
			case 8 : { 0 setOvercast 0.8; };
			case 9 : { 0 setOvercast 0.9; };
			case 10 : { 0 setOvercast 1; };
			case 11 : { 0 setOvercast ([(random 1), 4] call BIS_fnc_cutDecimals); };
		};
	};

	private _par_fog = ["Par_fog", 1] call BIS_fnc_getParamValue; 
	switch (_par_fog) do
	{
		case 0 : { 0 setFog 0; };
		case 1 : { 0 setFog (selectRandom [[0.2, 0.2, 5], [0.1, 0.2, 20], [0.02, 0.15, 30]]) };					//	Light
		case 2 : { 0 setFog (selectRandom [[0.02, 0.13, 40], [0.006, 0.01, 300], [0.015, 0.01, 300]]) };		//	Medium
		case 3 : { 0 setFog (selectRandom [[0.002, 0.02, 300], [0.006, 0.02, 300], [0.2, 0.01, 10]]) };			//	Heavy

		case 4 :
		{
			switch ( selectRandom [0,1,1] ) do
			{
				case 0 : { 0 setFog 0; };
				case 1 : { 0 setFog (selectRandom [[0.2, 0.2, 5], [0.1, 0.2, 20], [0.02, 0.15, 30]]) };					//	Light
			};
		};

		case 5 :
		{
			switch ( selectRandom [0,1,2] ) do
			{
				case 0 : { 0 setFog 0; };
				case 1 : { 0 setFog (selectRandom [[0.2, 0.2, 5], [0.1, 0.2, 20], [0.02, 0.15, 30]]) };					//	Light
				case 2 : { 0 setFog (selectRandom [[0.02, 0.13, 40], [0.006, 0.01, 300], [0.015, 0.01, 300]]) };		//	Medium
			};
		};

		case 6 :
		{
			switch ( selectRandom [0,1,1] ) do
			{
				case 0 : { 0 setFog 0; };

				case 1 :
				{
					switch ( selectRandom [0,1,2,3] ) do
					{
						case 0 : { 0 setFog [0.02, random 0.15, 40]; };															//  Light Heavy Medium
						case 1 : { 0 setFog (selectRandom [[0.2, 0.2, 5], [0.1, 0.2, 20], [0.02, 0.15, 30]]) };					//	Light
						case 2 : { 0 setFog (selectRandom [[0.02, 0.13, 40], [0.006, 0.01, 300], [0.015, 0.01, 300]]) };		//	Medium
						case 3 : { 0 setFog (selectRandom [[0.002, 0.02, 300], [0.006, 0.02, 300], [0.2, 0.01, 10]]) };			//	Heavy
					};
				};
			};
		};

		case 7 :
		{
			switch ( selectRandom [0,1] ) do
			{
				case 0 : { 0 setFog (selectRandom [[0.2, 0.2, 5], [0.1, 0.2, 20], [0.02, 0.15, 30]]) };					//	Light
				case 1 : { 0 setFog (selectRandom [[0.02, 0.13, 40], [0.006, 0.01, 300], [0.015, 0.01, 300]]) };		//	Medium
			};
		};

		case 8 :
		{
			switch ( selectRandom [0,1] ) do
			{
				case 0 : { 0 setFog (selectRandom [[0.02, 0.13, 40], [0.006, 0.01, 300], [0.015, 0.01, 300]]) };		//	Medium
				case 1 : { 0 setFog (selectRandom [[0.002, 0.02, 300], [0.006, 0.02, 300], [0.2, 0.01, 10]]) };			//	Heavy
			};
		};

		case 9 :
		{
			switch ( selectRandom [1,2,3] ) do
			{
				case 1 : { 0 setFog (selectRandom [[0.2, 0.2, 5], [0.1, 0.2, 20], [0.02, 0.15, 30]]) };					//	Light
				case 2 : { 0 setFog (selectRandom [[0.02, 0.13, 40], [0.006, 0.01, 300], [0.015, 0.01, 300]]) };		//	Medium
				case 3 : { 0 setFog (selectRandom [[0.002, 0.02, 300], [0.006, 0.02, 300], [0.2, 0.01, 10]]) };			//	Heavy
			};
		};
	};

	switch (DK_rainLvl) do
	{
		case 0 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
		case 1 : { 0 setRain 0.05; forceWeatherChange; };
		case 2 : { 0 setRain 0.10; forceWeatherChange; };
		case 3 : { 0 setRain 0.15; forceWeatherChange; };
		case 4 : { 0 setRain 0.20; forceWeatherChange; };
		case 5 : { 0 setRain 0.3; forceWeatherChange; };
		case 6 : { 0 setRain 0.4; forceWeatherChange; };
		case 7 : { 0 setRain 0.5; forceWeatherChange; };
		case 8 : { 0 setRain 0.6; forceWeatherChange; };
		case 9 : { 0 setRain 0.7; forceWeatherChange; };
		case 10 : { 0 setRain 0.8; forceWeatherChange; };
		case 11 : { 0 setRain 0.9; forceWeatherChange; };
		case 12 : { 0 setRain 1; forceWeatherChange; };
		case 13 : 
				{
					_rain = selectRandom [1,2,3,4,5,6,7,8,9,10,11,12];
					switch (_rain) do 
					{
						case 1 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
						case 2 : { 0 setRain 0.05; forceWeatherChange; };
						case 3 : { 0 setRain 0.15; forceWeatherChange; };
						case 4 : { 0 setRain 0.3; forceWeatherChange; };
						case 5 : { 0 setRain 0.5; forceWeatherChange; };
						case 6 : { 0 setRain 0.7; forceWeatherChange; };
						case 7 : { 0 setRain 1; forceWeatherChange; };
						case 8 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
						case 9 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
						case 10 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
						case 11 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
						case 12 : { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
					};

				 };

		default { 0 setRain 0; forceWeatherChange; 999999 setRain 0; };
	};

	uiSleep 1;

	if (_par_fog isEqualTo 0) then
	{
		999999 setFog 0;
	};


/// HIDE FUCKING OBJECT'S ROADKILLS
DK_hideFence = ["Par_hideFence", 0] call BIS_fnc_getParamValue;
DK_hideMound = ["Par_hideMound", 0] call BIS_fnc_getParamValue;
DK_hideRock = ["Par_hideRock", 0] call BIS_fnc_getParamValue;

if (DK_hideFence isEqualTo 0) then
{
	_objs = nearestTerrainObjects [[28685.4,11867.9,195], ["fence"], 14000];
	{
		_str = format ["%1", _x];
		_class = _str select [(count _str) - 20];

		if (_class in ["wired_fence_8m_f.p3d", "wired_fence_4m_f.p3d", "ired_fence_8md_f.p3d", "ired_fence_4md_f.p3d"]) then
		{
			hideObject _x;
		};

	} count _objs;
};

if (0 in [DK_hideMound, DK_hideRock]) then
{
	private _toHide = [];
	if (DK_hideMound isEqualTo 0) then
	{
		_toHide append ["mound01_8m_f.p3d", "mound02_8m_f.p3d"];
	};
	if (DK_hideRock isEqualTo 0) then
	{
		_toHide append ["pstone_03_lc.p3d", "ones_erosion.p3d", "tstone_01_lc.p3d", "luntstone_01.p3d", "luntstone_02.p3d", "luntstone_03.p3d"];
	};

	_objs = nearestTerrainObjects [[28685.4,11867.9,195], ["hide"], 14000];
	{
		_str = format ["%1", _x];
		_class = _str select [(count _str) - 16];

//		if (_class in ["mound01_8m_f.p3d", "mound02_8m_f.p3d", "pstone_03_lc.p3d", "ones_erosion.p3d", "tstone_01_lc.p3d", "luntstone_01.p3d", "luntstone_02.p3d", "luntstone_03.p3d"]) then
		if (_class in _toHide) then
		{
			hideObject _x;
		};

	} count _objs;
};

DK_hideFence = nil;
DK_hideMound = nil;
DK_hideRock = nil;

DK_dayTime = nil;
DK_rainLvl = nil;

// Params MP3 Player
if (["Par_allowMP3car", 0] call BIS_fnc_getParamValue isEqualTo 0) then
{
	DK_MP3car_Zero = true;
}
else
{
	DK_MP3car_Zero = false;
};

/// COMPILE
call compileFinal preprocessFileLineNumbers "DK_Functions\loadouts\DK_fnc_loadouts_Vehicles.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\DK_fncs_MTW_core.sqf";
DK_fnc_handlePlayerMoney = compileFinal preprocessFileLineNumbers "DK_Functions\playerMoney\DK_fnc_handlePlayerMoney.sqf";
DK_fnc_handleFamilyScore = compileFinal preprocessFileLineNumbers "DK_Functions\scores\DK_fnc_handleFamilyScore.sqf";

DK_fnc_checkMoneyRespawn = compileFinal preprocessFileLineNumbers "DK_Functions\forceRespawn\DK_fnc_checkMoneyRespawn.sqf";

/// COMPILE BONUS Player
// Ambulance
call compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fncs_bonus_ambulance.sqf";
DK_fnc_bonus_amb_create = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_bonus_amb_create.sqf";
DK_fnc_bonus_amb_verifMoney = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\ambulance\DK_fnc_bonus_amb_checkIfHaveMoney.sqf";

// Little Jacob Waypons
DK_fnc_bonus_LJ_handleIfPlyrAlwd = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_handleIfPlayerAllowed.sqf";
DK_fnc_bonus_LJ_createLJ = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_createLJ.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fncs_bonus_LJ.sqf";
DK_fnc_bonus_LJ_verifMoney = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\littleJacob\DK_fnc_bonus_LJ_checkIfHaveMoney.sqf";
DK_weapon_LJ_InProgress = false;


/// START COMPILE & MISSION MANAGER
call compileFinal preprocessFileLineNumbers "DK_Functions\reinforcementAndOrderForces\DK_fncs_reinforcementAndOrderForces.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\reinforcementAndOrderForces\siren\DK_fncs_sirens.sqf";
private _waitingMissionInit = 0 execVM "DK_Functions\missions\DK_MIS_init_missionCore.sqf";


/// COMPILE AMBIENTS SCRIPT'S
// Sounds
call compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fncs_amb_sounds_EnvironmentAndVocal.sqf";

// Fuel truck
call compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fncs_amb_fuelTrucks.sqf";

// Ambient air
call compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fncs_amb_flyingPlanes.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fncs_amb_flyingArmyOrHeli.sqf";

// Sounds
call compileFinal preprocessFileLineNumbers "DK_Functions\sounds\DK_fncs_vocalsOrderForces.sqf";


/// START AMBIENTS SCRIPT'S
waitUntil { getClientStateNumber > 9 };
waitUntil { !(playableUnits isEqualTo []) };



waitUntil { scriptDone _waitingMissionInit };

/// Start Missions
if ("Par_missionOn" call BIS_fnc_getParamValue isEqualTo 1) then
{
	0 spawn DK_MIS_fnc_slctDifficultyLevel;
};


// CLAG
0 execVM "DK_CLAG\server\DK_CLAG_coreManagerLoop.sqf";


/// START COUNTER GAME TIME
estimatedTimeLeft DK_cntTmGameStart;


// Killed manager for Patrol & Control cops
addMissionEventHandler ["EntityKilled",
{
	_this call DK_fnc_EH_entityKilled;
}];


// Setup Terrain grid resolution on server for prevent Lag
if (isDedicated) then
{
	setTerrainGrid 35;
};


// Sounds
0 execVM "DK_Functions\ambients\DK_loop_amb_manager_sfxEnvironmentAtBuilding.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fncs_music_house.sqf";
execVM  "DK_Functions\ambients\DK_loop_music_house.sqf";


// Ambient air
0 spawn DK_init_amb_civPlane;
0 spawn DK_init_amb_plane_2;


// Loop check number players in Family
0 execVM "DK_Functions\UI\DK_fnc_checkNbPlayersFam.sqf";


// Create custom channel for Petrovic, LJ etc
private _channelID1 = radioChannelCreate [[0, 0.5647, 1, 1], "Kenny Petrovic", "Kenny Petrovic", [], false];
if (_channelID1 != 0) then
{
	missionNamespace setVariable ["chanPetro", _channelID1];
}
else
{
	diag_log format ["Error : Custom channel '%1' creation failed!", "Kenny Petrovic"];
};

private _channelID2 = radioChannelCreate [[0.2284, 1, 0.4549, 1], "Little Jacob", "Little Jacob", [], false];
if (_channelID2 != 0) then
{
	missionNamespace setVariable ["chanLJ", _channelID2];
}
else
{
	diag_log format ["Error : Custom channel '%1' creation failed!", "Little Jacob"];
};



/*
// Simple shop from HoverGuy
[] execVM "HG\Setup\fn_serverInitialization.sqf";


// Stop creating markers on map by playersNumber
//(findDisplay 46) displayAddEventHandler ["onMouseButtonDown", { hint "onMouseButtonDown"; player sideChat "onMouseButtonDown"; }];
