params [["_toDel", objNull], ["_slpTime", 10], "_dis", "_vis", ["_hardTm", 420]];



if (isNull _toDel) exitWith {};

_toDel setVariable ["cleanUpOn",true];

private _nul = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find _toDel);

private _time = time + _slpTime;

waitUntil { uiSleep 0.3; (isNil "_toDel") OR (isNull _toDel) OR (time > _time) OR !(_toDel getVariable ["cleanUpOn",true]) };

if ( ( (isNil "_toDel") && {(isNull _toDel)} ) OR !(_toDel getVariable ["cleanUpOn",true]) ) exitWith {};


private _finish = true;

if ( (!isNil "_dis") && { !(_dis isEqualTo 0) } ) then
{
	_toDel setVariable ["distance" ,_dis];
	_finish = false;

	if (!isNil "_vis") then
	{
		_toDel setVariable ["doHiden", _vis];
	};
};

if _finish exitWith
{
	deleteVehicle _toDel;
};

call
{
	if (alive _toDel) exitWith
	{
		_toDel setVariable ["DK_hardTmInit", _hardTm];
		_toDel addEventHandler ["Killed",
		{
			params ["_unit"];

			_unit setVariable ["DK_hardTm", (time + (_unit getVariable ["DK_hardTmInit", 0]))];
			_unit setVariable ["DK_hardTmInit", nil];
		}];
	};

	_toDel setVariable ["DK_hardTm", (time + _hardTm)];
};


private _nil = DK_cleanUpMap_Array pushBackUnique _toDel;

