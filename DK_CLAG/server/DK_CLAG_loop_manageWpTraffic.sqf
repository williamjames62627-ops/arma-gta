if (!isServer) exitWith {};


private ["_nil", "_pos", "_DK_CLAG_arr_manageWp"];

DK_CLAG_arr_manageWp = [];

While { uiSleep 2; true } do
{
		_DK_CLAG_arr_manageWp = +DK_CLAG_arr_manageWp;
		{
			_x params ["_unit", "_veh", "_time", "_distance", "_rdmPos"];


			call
			{
				if ((isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_unit distance2D _rdmPos < 99) OR !(_unit getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (time > _time) OR !(DK_wheels findIf {(_veh getHit _x) isEqualTo 1} isEqualTo -1)) exitWith
				{
					_nil = DK_CLAG_arr_manageWp deleteAt (DK_CLAG_arr_manageWp find _x);

					if ( (!isNil "_unit") && { (!isNull _unit) && { (alive _unit) && { (_unit getVariable ["DK_behaviour", ""] isEqualTo "drive") && { (DK_wheels findIf {(_veh getHit _x) isEqualTo 1} isEqualTo -1) } } } } ) then
					{
						_nil = [_unit, _distance] spawn DK_fnc_CLAG_wpDriver;
					};
				};

				_pos = _veh getVariable ["wpPos", [worldSize / 2, worldSize / 2, 0]];

				_nil = [_unit, _veh] call DK_fnc_manageSpdTraff;

				uiSleep 0.05;

				_nil = [_veh, _pos] call DK_fnc_manageFrcRoadTraff;

				_veh setVariable ["wpPos", getPosATL _veh];
			};

			uiSleep 0.2;

		} count _DK_CLAG_arr_manageWp;
};
