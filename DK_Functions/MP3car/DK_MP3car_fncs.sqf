if !(isServer) exitWith {};

#define tracks [["MP3music02", 18.125], ["MP3music03", 14.793], ["MP3music04", 24], ["MP3music05", 8], ["MP3music08", 23.001], ["MP3music01", 32], ["MP3music06", 35.559], ["MP3music07", 40.435]]
DK_mp3car_nbOfTracks = (count tracks) - 1;

if (!isServer) exitWith {};



DK_fnc_MP3car_init = {

	if !(DK_MP3car_Zero) exitWith {};

	DK_MP3car_Zero = false;

	params ["_vehicle", ["_MP3carON", true], ["_slctdTrck", []]];

	_vehicle addEventHandler ["Deleted",
	{
		params ["_veh"];


		// Delete MP3car Sound
		private _netIdInitMP3car = _veh getVariable "NetIdInitMP3car";
		if !(isNil "_netIdInitMP3car") then
		{
			remoteExecCall ["", _netIdInitMP3car];
			_veh setVariable ["NetIdInitMP3car", nil];
		};

		private _NetIdMP3car = _veh getVariable "DK_netID_MP3carOnOff";
		if !(isNil "_NetIdMP3car") then
		{
			remoteExecCall ["", _NetIdMP3car];
			_veh setVariable ["DK_netID_MP3carOnOff", nil];
		};

		_veh setVariable ["DK_carSndTracks", nil, true];

		DK_MP3car_Zero = true;

	}];

	_vehicle addMPEventHandler ["mpKilled",
	{
		params ["_veh"];

		if (isServer) then
		{
			// Delete MP3car sound
			private _netIdInitMP3car = _veh getVariable "NetIdInitMP3car";
			if !(isNil "_netIdInitMP3car") then
			{
				remoteExecCall ["", _netIdInitMP3car];
				_veh setVariable ["NetIdInitMP3car", nil];
			};

			private _NetIdMP3car = _veh getVariable "DK_netID_MP3carOnOff";
			if !(isNil "_NetIdMP3car") then
			{
				remoteExecCall ["", _NetIdMP3car];
				_veh setVariable ["DK_netID_MP3carOnOff", nil];
			};

			_veh setVariable ["DK_carSndTracks", nil, true];
		};

		if (hasInterface) then
		{
			removeAllActions _veh;

			// Delete MP3car sound source
			private _sndSrc = _veh getVariable "DK_carSndScr";

			if (!isNull _sndSrc) then
			{
				deleteVehicle _sndSrc;
				_veh setVariable ["DK_carSndScr", nil];
			};
		};

	}];


	// MP3car sound
	private _netIdInitMP3car = _vehicle remoteExecCall ["DK_init_MP3car_cl", DK_isDedi, true];
	_vehicle setVariable ["NetIdInitMP3car", _netIdInitMP3car];

	if _MP3carON then
	{
		_vehicle setVariable ["DK_MP3carIsON", true];
		[_vehicle, false, _slctdTrck] call DK_fnc_MP3car_OnOff;
	}
	else
	{
		_vehicle setVariable ["DK_MP3carIsON", false];
	};
};

DK_fnc_MP3car_OnOff = {

	params ["_vehicle", ["_isOn", nil], ["_slctdTrck", []]];


	if (isNil "_isOn") then
	{
		_isOn = _vehicle getVariable ["DK_MP3carIsON", false];
	};

	private _trackNFO = _vehicle getVariable ["DK_MP3carTrackNFO", []];
	if (_trackNFO isEqualTo []) then
	{
		if (_slctdTrck isEqualTo []) then
		{
			_trackNFO = selectRandom tracks;
		}
		else
		{
			_trackNFO = selectRandom _slctdTrck;
		};


		_vehicle setVariable ["DK_MP3carTrackNFO", _trackNFO, true];
	};

	// Delete JIP
	private _NetIdMP3car = _vehicle getVariable "DK_netID_MP3carOnOff";
	if !(isNil "_NetIdMP3car") then
	{
		remoteExecCall ["", _NetIdMP3car];
	};

	// Send On/Off
	call
	{
		if (_isOn) exitWith
		{
			_vehicle setVariable ["DK_MP3carIsON", false];

			private _netID_MP3carOnOff = [_vehicle, true] remoteExecCall ["DK_fnc_MP3car_OnOff_cl", DK_isDedi, true];
			_vehicle setVariable ["DK_netID_MP3carOnOff", _netID_MP3carOnOff];
		};

		_vehicle setVariable ["DK_MP3carIsON", true];

		private _netID_MP3carOnOff = [_vehicle, false] remoteExecCall ["DK_fnc_MP3car_OnOff_cl", DK_isDedi, true];
		_vehicle setVariable ["DK_netID_MP3carOnOff", _netID_MP3carOnOff];
	};
};



//////// A FAIRE //////
DK_fnc_MP3car_NextTracks = {

	private "_trackNFO";

	private _trackId = tracks find (_this getVariable ["DK_MP3carTrackNFO", selectRandom tracks]);

	if (_trackId < DK_mp3car_nbOfTracks) then
	{
		_trackNFO = tracks # (_trackId + 1);
	}
	else
	{
		_trackNFO = tracks # 0;
	};
	
	_this setVariable ["DK_MP3carTrackNFO", _trackNFO, true];


	if (_this getVariable ["DK_MP3carIsON", false]) then
	{
		[_this, false] call DK_fnc_MP3car_OnOff;
	}
	else
	{
		[_this, true] call DK_fnc_MP3car_OnOff;
	};
};


