if (!isServer) exitWith {};

#define dis2(O,D) playableUnits findIf { _x distance2D O < D } isEqualTo -1
#define	eye(O) (playableUnits findIf { ([vehicle _x, "IFIRE", vehicle O] checkVisibility [eyePos _x, O call DK_corpsPlace] > 0.1) } ) isEqualTo -1


DK_fnc_checkAllWpHolderSim = {

	if ( !(_this getVariable ["isObjectif", false]) && { !(_this getVariable ["cleanUpOn",false]) } ) then
	{
		[_this, 1, 160] spawn DK_fnc_addAllTo_CUM;
	};
}; 


DK_fnc_checkCleanUpMap = {

	if ( (!alive _this) && { (time > (_this getVariable ["DK_hardTm", (time + 9)])) } ) then
	{
		_this setVariable ["distance", 3];
		_this setVariable ["doHiden", false];
	};

	private _dis = _this getVariable ["distance", 20];

	if (playableUnits findIf {_x distance2D _this < _dis} isEqualTo -1) then
	{
		private _canDel = true;

		if (_this getVariable ["doHiden",false]) then
		{
//			_disMax = _dis + 300;

//			if ( !( dis2(_this,_disMax)) && { !( eye(_this) ) } ) then

			if !( (playableUnits findIf { (_x distance2D _this < (_dis + 300)) && { ([vehicle _x, "IFIRE", vehicle _this] checkVisibility [eyePos _x, _this call DK_corpsPlace] > 0.1) } }) isEqualTo -1 ) then
			{
				_canDel = false;
			};
		};

		if (_canDel) then
		{
			call
			{
				private _vehLink = objectParent _this;

				if (!isNull _vehLink) exitWith
				{
					_this call DK_fnc_delInCUM;

					private _checkCar = false;
					call
					{
						if (alive _this) exitWith
						{
							_checkCar = true;
							deleteVehicle _this;
						};

						[_vehLink, _this] remoteExecCall ["deleteVehicleCrew", _vehLink];
					};

					if ( !(_checkCar) OR { ({alive _x} count (crew _vehLink) > 1) } ) exitWith {};


					_vehLink spawn
					{
						waitUntil { (isNil "_this") OR (isNull _this) OR (!alive _this) OR ((crew _this) isEqualTo []) OR !((crew _this) findIf { (side (group _x) isEqualTo west) } isEqualTo -1) };

						if ( (isNil "_this") OR (isNull _this) OR (!alive _this) OR !((crew _this) findIf {  (side (group _x) isEqualTo west) } isEqualTo -1) ) exitWith {};

						_this call DK_fnc_delInCUM;
						deleteVehicle _this;
					};
				};

				_this call DK_fnc_delInCUM;
				deleteVehicle _this;
			};
		};
	};
};


DK_fnc_delInCUM = {

	private _nil = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find _this);
};
