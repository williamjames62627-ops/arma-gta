if !(hasInterface) exitWith {};

DK_init_policeOffroad_siren_cl = {

	_this addEventHandler ["Deleted",
	{
		params ["_entity"];

		private _sndSrc = _entity getVariable "DK_carSndScr";

		if (!isNull _sndSrc) then
		{
			deleteVehicle _sndSrc;
			_veh setVariable ["DK_carSndScr", nil];
		};
	}];


	_this call DK_addAction_policeOffroad_siren_cl;
};

DK_addAction_policeOffroad_siren_cl = {

	_this addAction ["<t color='#FFEF0F'>On/Off siren</t>",
	{
		params ["_vehicle"];

		[_vehicle] remoteExecCall ["DK_fnc_police_siren_OnOff", 2];

	} ,nil,-4,true,true,"","player isEqualTo driver _target"];
};


DK_fnc_police_siren_OnOff_cl = {

	params ["_veh", "_isOn"];


	if (_isOn) exitWith
	{
		private _sndSrc = _veh getVariable "DK_carSndScr";

		if (!isNull _sndSrc) then
		{
			deleteVehicle _sndSrc;
			_veh setVariable ["DK_carSndScr", nil];
		};
	};

	_veh spawn DK_fnc_police_siren_start_cl;
};

DK_fnc_police_siren_start_cl = {

	private _cubeSndSrc = _this getVariable "DK_carSndScr";

	if (!isNil "_cubeSndSrc") exitWith {};

	_cubeSndSrc = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
	hideObject _cubeSndSrc;
	_cubeSndSrc attachTo [_this, [0, 0.5, 0]];
	_this setVariable ["DK_carSndScr", _cubeSndSrc];

	while { !(isNull _cubeSndSrc) && { !(isNull _this) && { (alive _this) } } } do
	{
		call
		{
			// Long sound
			for "_i" from 1 to 4 do
			{
				if (player distance2D _this < 710) then
				{
					_cubeSndSrc say3D [ "police_siren01", 580, 1, true];
				};

				uiSleep 5.17;
				if ( (isNull _cubeSndSrc) OR (isNull _this) OR (!alive _this) ) exitWith {};
			};

			if ( (isNull _cubeSndSrc) OR (isNull _this) OR (!alive _this) ) exitWith {};

			// Short sound
			for "_i" from 1 to 14 do
			{
				if (player distance2D _this < 710) then
				{
					_cubeSndSrc say3D [ "police_siren02", 580, 1, true];
				};

				uiSleep 0.343;
				if ( (isNull _cubeSndSrc) OR (isNull _this) OR (!alive _this) ) exitWith {};
			};
		};
	};

	if !(isNull _cubeSndSrc) then
	{
		deleteVehicle _cubeSndSrc;
		_this setVariable ["DK_carSndScr", nil];
	};
};
