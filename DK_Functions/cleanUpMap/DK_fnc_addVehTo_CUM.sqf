params ["_vehToDel", "_slpTime", "_dis", "_vis"];


if (!isNull _vehToDel) then
{
	_vehToDel setVariable ["cleanUpOn", true];
	private _nul01 = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find _vehToDel);
	private _nul02 = DK_emptyVeh deleteAt (DK_emptyVeh find _vehToDel);

	_vehToDel setVariable ["cleanUpTimer", false];

	[_vehToDel,_slpTime] spawn
	{
		params ["_vehToDel","_slpTime"];


		for "_i" from 0 to _slpTime step 0.5 do
		{
			uiSleep 0.5;

			if !(_vehToDel getVariable ["cleanUpOn", true]) exitWith
			{
				_nul01 = DK_emptyVeh pushBackUnique _vehToDel;
			};

			if (!alive _vehToDel) exitWith {};
		};

		if (_vehToDel getVariable ["cleanUpOn", true]) then
		{
			_vehToDel setVariable ["cleanUpTimer", true];
		};
	};

	waitUntil
	{
		uiSleep 0.5;

		(isNil "_vehToDel")
		OR
		(isNull _vehToDel)
		OR
		(!alive _vehToDel)
		OR
		!(_vehToDel getVariable ["cleanUpOn", false])
		OR
		(_vehToDel getVariable ["cleanUpTimer", true])
	};

	if (_vehToDel getVariable ["cleanUpOn", true]) then
	{
		if (alive _vehToDel) then
		{
			private _finish = true;
			if (!isNil "_dis") then
			{
				_vehToDel setVariable ["distance",_dis];
				_finish = false;

				if (!isNil "_vis") then
				{
					_vehToDel setVariable ["doHiden",_vis];
				};
			};

			if (_finish) exitWith
			{
				deleteVehicle _vehToDel;
			};

/*			_vehToDel setVariable ["DK_hardTmInit", _hardTm];
			_vehToDel addEventHandler ["Killed",
			{
				params ["_unit"];

				_unit setVariable ["DK_hardTm", (time + (_unit getVariable ["DK_hardTmInit", 0]))];
				_unit setVariable ["DK_hardTmInit", nil];
			}];
*/

			_nul02 = DK_cleanUpMap_Array pushBackUnique _vehToDel;
		};
	};
};