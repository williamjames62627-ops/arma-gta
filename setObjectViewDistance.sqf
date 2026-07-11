
private _distance = "Par_ObjectViewDistance" call BIS_fnc_getParamValue;

if ((_distance isEqualTo "Player setting") OR ((getObjectViewDistance # 0) <= _distance)) exitWith {};

setObjectViewDistance _distance;