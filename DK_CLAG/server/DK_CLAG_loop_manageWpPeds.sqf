if (!isServer) exitWith {};


private ["_nil", "_DK_CLAG_WalkingPeds"];


DK_CLAG_WalkingPeds = [];

while { uiSleep 3; true } do
{
	_DK_CLAG_WalkingPeds = +DK_CLAG_WalkingPeds;

	{
		_x params ["_walker", "_time", "_pos"];


		if ( (isNil "_walker") OR (isNull _walker) OR (!alive _walker) OR !(_walker getVariable ["DK_behaviour", ""] isEqualTo "walk") ) exitWith
		{
			_nil = DK_CLAG_WalkingPeds deleteAt (DK_CLAG_WalkingPeds find _x);
		};

		if ( (time > _time) OR (_pos distance2D _walker < 25) ) then
		{
			_pos = [[[(_walker getPos [500, ((_walker getDir _pos) + ((random 60) - 30))]),100]], ["water"]] call BIS_fnc_randomPos;

			if (_pos isEqualTo [0,0]) then
			{
				_pos = getPosATL (selectRandom DK_CLAG_normalHouses_Ary);
			};

			_walker moveTo _pos;

			_x set [1, time + (_pos distance2D _walker)];
			_x set [2, _pos];
		};

		uiSleep 0.5;

	} count DK_CLAG_WalkingPeds;
};