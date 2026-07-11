
private _distance = "Par_ViewDistance" call BIS_fnc_getParamValue;

if ((_distance isEqualTo "Player setting") OR (viewDistance <= _distance)) exitWith {};

setViewDistance _distance;