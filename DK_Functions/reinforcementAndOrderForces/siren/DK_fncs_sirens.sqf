if (!isServer) exitWith {};



DK_fnc_sirenNbeacon_init = {

	params ["_vehicle", "_sirenON", "_beaconON"];

	_vehicle addEventHandler ["Deleted",
	{
		params ["_veh"];


		// Delete Siren Sound
		private _netIdInitSiren = _veh getVariable "NetIdInitSiren";
		if !(isNil "_netIdInitSiren") then
		{
			remoteExecCall ["", _netIdInitSiren];
			_veh setVariable ["NetIdInitSiren", nil];
		};

		private _NetIdSiren = _veh getVariable "DK_netID_sirenOnOff";
		if !(isNil "_NetIdSiren") then
		{
			remoteExecCall ["", _NetIdSiren];
			_veh setVariable ["DK_netID_sirenOnOff", nil];
		};


		// Delete Beacons lights
		private _netIdBeacon = _veh getVariable "NetIdBeacon";
		if !(isNil "_netIdBeacon") then
		{
			remoteExecCall ["", _netIdBeacon];
			_veh setVariable ["NetIdBeacon", nil];
		};
	}];

	_vehicle addMPEventHandler ["mpKilled",
	{
		params ["_veh"];

		if (isServer) then
		{
			// Delete Siren sound
			private _netIdInitSiren = _veh getVariable "NetIdInitSiren";
			if !(isNil "_netIdInitSiren") then
			{
				remoteExecCall ["", _netIdInitSiren];
				_veh setVariable ["NetIdInitSiren", nil];
			};

			private _NetIdSiren = _veh getVariable "DK_netID_sirenOnOff";
			if !(isNil "_NetIdSiren") then
			{
				remoteExecCall ["", _NetIdSiren];
				_veh setVariable ["DK_netID_sirenOnOff", nil];
			};


			// Delete Beacons lights
			private _netIdBeacon = _veh getVariable "NetIdBeacon";
			if !(isNil "_netIdBeacon") then
			{
				remoteExecCall ["", _netIdBeacon];
				_veh setVariable ["NetIdBeacon", nil];
			};
		};

		if (hasInterface) then
		{
			removeAllActions _veh;

			// Delete Siren sound source
			private _sndSrc = _veh getVariable "DK_carSndScr";

			if (!isNull _sndSrc) then
			{
				deleteVehicle _sndSrc;
				_veh setVariable ["DK_carSndScr", nil];
			};
		};

	}];


	// Siren sound
	private _netIdInitSiren = _vehicle remoteExecCall ["DK_init_policeOffroad_siren_cl", DK_isDedi, true];
	_vehicle setVariable ["NetIdInitSiren", _netIdInitSiren];

	if _sirenON then
	{
		_vehicle setVariable ["DK_sirenIsON", true];
		[_vehicle, false] call DK_fnc_police_siren_OnOff;
	}
	else
	{
		_vehicle setVariable ["DK_sirenIsON", false];
	};

	// Beacons Lights
	call
	{
		if (typeOf _vehicle isEqualTo "B_GEN_Van_02_transport_F") exitWith
		{
			if (call DK_fnc_checkIfNight) then
			{
				private _NetIdBeacon = _vehicle remoteExecCall ["DK_loop_policeOffroad_beacon_cl", DK_isDedi, true];
				_vehicle setVariable ["NetIdBeacon", _NetIdBeacon];
			};

			if _beaconON then
			{
				_vehicle animateSource ["lights_em_hide",1]
			};
		};

		if (call DK_fnc_checkIfNight) then
		{
			private _NetIdBeacon = _vehicle remoteExecCall ["DK_loop_policeOffroad_beacon_cl", DK_isDedi, true];
			_vehicle setVariable ["NetIdBeacon", _NetIdBeacon];
		};

		if _beaconON then
		{
			_vehicle animateSource ["Beacons", 1];
		};
	};
};

DK_fnc_police_siren_OnOff = {

	params ["_vehicle", ["_isOn", nil]];


	if (isNil "_isOn") then
	{
		_isOn = _vehicle getVariable ["DK_sirenIsON", false];
	};

	// Delete JIP
	private _NetIdSiren = _vehicle getVariable "DK_netID_sirenOnOff";
	if !(isNil "_NetIdSiren") then
	{
		remoteExecCall ["", _NetIdSiren];
	};

	// Send On/Off
	call
	{
		if (_isOn) exitWith
		{
			_vehicle setVariable ["DK_sirenIsON", false];

			private _netID_sirenOnOff = [_vehicle, true] remoteExecCall ["DK_fnc_police_siren_OnOff_cl", DK_isDedi, true];
			_vehicle setVariable ["DK_netID_sirenOnOff", _netID_sirenOnOff];
		};

		_vehicle setVariable ["DK_sirenIsON", true];

		private _netID_sirenOnOff = [_vehicle, false] remoteExecCall ["DK_fnc_police_siren_OnOff_cl", DK_isDedi, true];
		_vehicle setVariable ["DK_netID_sirenOnOff", _netID_sirenOnOff];
	};
};

