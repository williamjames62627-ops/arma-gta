params ["_type","_wpHold"];


// Weapon drop or created
if ( (_type isEqualTo "GroundWeaponHolder") && { !(_wpHold getVariable ["isObjectif", false]) && { !(_wpHold getVariable ["cleanUpOn",false]) } } ) exitWith
{
	[_wpHold,1,150] spawn DK_fnc_addAllTo_CUM;
};


// Weapon drop with corps
if (_type isEqualTo "WeaponHolderSimulated") then
{
	_wpHold spawn
	{
		private _wpHold = _this;

		_wpHold setVariable ["cleanUpOn", true];
		uiSleep 235;

		if !(_wpHold isEqualTo objNull) then
		{
			[_wpHold,1,45,true] spawn DK_fnc_addAllTo_CUM;
		};
	};
};