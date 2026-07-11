
DK_fnc_crt_trgJump_cl = {

	_this spawn
	{
		params ["_veh", "_type", "_padG", "_pos"];

		if ((isNil "_veh") OR (isNull _veh) OR !(_veh getVariable ["jumpOn", false])) exitWith {};


		switch _type do
		{
			case 2 :
			{
				while { (!isNil "_veh") && { (!isNull _veh) && { (alive _veh) && { (_veh getVariable ["jumpOn", false]) } } } } do
				{
					waitUntil { uiSleep 1; (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR !(_veh getVariable ["jumpOn", false]) OR (player distance _pos <= 120) && { (!isNull objectParent player) && { (driver (objectParent player) isEqualTo player) } } };

					waitUntil { (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR !(_veh getVariable ["jumpOn", false]) OR (player distance _pos > 120) OR (isNull (objectParent player)) OR !(driver (objectParent player) isEqualTo player) OR ( ((vehicle player) distance _pos < 1.5) && { (speed vehicle player >= 100) } ) };

					if ( (!isNil "_veh") && { (!isNull _veh) && { (_veh getVariable ["jumpOn", false]) && { (speed (vehicle player) >= 100) && { ((vehicle player) distance _pos < 1.56) && { (!isNull (objectParent player)) && { (driver (objectParent player) isEqualTo player) && { ((objectParent player) isKindOf "LandVehicle") } } } } } } } ) exitWith	// exitWith
					{
						private _speed = speed (vehicle player);
						_veh setVariable ["jumpOn", false, true];
						private _gain = round (_speed - 100);

						private _player = player;
						[_player, (40 + _gain)] remoteExecCall ["DK_fnc_addScr", 2];

						playSound ["jump", true];
						["<t shadow='2' color='#FFFFFF' size = '.75'>You scored a stunt jump at " + (_speed toFixed 2) + " km/h!<br/><t color='#00FF11'>$40" + "<t color='#FFFFFF'> + " + "<t color='#00FF11'>$" + (str _gain),-1,safeZoneY + safeZoneH - 1.18,6,0,0,DK_lyDyn_jump] spawn BIS_fnc_dynamicText;
						[(name _player), 40 + _gain, (_speed toFixed 2)] remoteExecCall ["DK_fnc_mateStunt_cl", (units (group _player)) - [_player]];

						[_veh, _padG] remoteExecCall ["DK_fnc_padRjump", 2];
					};
				};
			};

			case 1 :
			{
				while { (!isNil "_veh") && { (!isNull _veh) && { (alive _veh) && { (_veh getVariable ["jumpOn", false]) } } } } do
				{
					waitUntil { uiSleep 1; (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR !(_veh getVariable ["jumpOn", false]) OR (player distance _pos <= 120) && { (!isNull objectParent player) && { (driver (objectParent player) isEqualTo player) } } };

					waitUntil { (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR !(_veh getVariable ["jumpOn", false]) OR (player distance _pos > 120) OR (isNull (objectParent player)) OR !(driver (objectParent player) isEqualTo player) OR ( ((vehicle player) distance _pos < 1.5) && { (speed vehicle player >= 100) } ) };

					if ( (!isNil "_veh") && { (!isNull _veh) && { (_veh getVariable ["jumpOn", false]) && { (speed (vehicle player) >= 100) && { ((vehicle player) distance _pos < 1.56) && { (!isNull (objectParent player)) && { (driver (objectParent player) isEqualTo player) && { ((objectParent player) isKindOf "LandVehicle") } } } } } } } ) exitWith	// exitWith
					{
						private _speed = speed (vehicle player);
						_veh setVariable ["jumpOn", false, true];
						private _gain = round (_speed - 100);

						private _player = player;
						[_player, 65 + _gain] remoteExecCall ["DK_fnc_addScr", 2];

						playSound ["jump", true];
						["<t shadow='2' color='#FFFFFF' size = '.75'>You scored a stunt jump at " + (_speed toFixed 2) + " km/h!<br/><t color='#00FF11'>$65" + "<t color='#FFFFFF'> + " + "<t color='#00FF11'>$" + (str _gain),-1,safeZoneY + safeZoneH - 1.18,6,0,0,DK_lyDyn_jump] spawn BIS_fnc_dynamicText;
						[(name _player), (65 + _gain), (_speed toFixed 2)] remoteExecCall ["DK_fnc_mateStunt_cl", (units (group _player)) - [_player]];

						[_veh, _padG] remoteExecCall ["DK_fnc_padRjump", 2];
					};
				};
			};
		};
	};
};


DK_fnc_mateStunt_cl = {

	params ["_name", "_gain", "_speed"];


	["<t shadow='2' color='#FFFFFF' size = '.65'>"+ _name + " scored a stunt jump at " + _speed + " km/h!<br/><t color='#0095ff'>+" + (str _gain) + " points",-1,safeZoneY + safeZoneH - 1.18,6,0,0,DK_lyDyn_jump] spawn BIS_fnc_dynamicText;
};
