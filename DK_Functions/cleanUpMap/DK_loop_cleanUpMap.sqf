if (!isServer) exitWith {};

#define start (DK_cleanUpMap_Array isEqualTo [])
//#define exist(O) (!isNil O)
#define exist(O,S) (!isNil O) && {(!isNull S)}


DK_cleanUpMap_Array = [];

private ["_toDel"];

while { true } do
{
	while { start } do
	{
		uiSleep 5;
	};

	{
		_toDel = _x;

		_toDel call ( if (exist("_toDel",_toDel)) then [{DK_fnc_checkCleanUpMap}, {DK_fnc_delInCUM}] );

		uiSleep 0.05;

	} count DK_cleanUpMap_Array;
};