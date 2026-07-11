if !(hasInterface) exitWith {};

DK_init_MP3car_cl = {

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


	_this call DK_MP3car_addActions_cl;
};


DK_fnc_MP3car_OnOff_cl = {

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

	_veh spawn DK_fnc_MP3car_start_cl;
};


DK_fnc_MP3car_start_cl = {

	if ((isNil "_this") OR (!alive _this)) exitWith {};

	private _sndSrc = _this getVariable "DK_carSndScr";

	if (!isNil "_sndSrc") then
	{
		deleteVehicle _sndSrc;
	};

	_trackNFO = _this getVariable "DK_MP3carTrackNFO";

	if (isNil "_trackNFO") exitWith {};

	private _track = _trackNFO # 0;
	private _time = (_trackNFO # 1) - 0.033;

	private _sndSrc = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
	hideObject _sndSrc;
	_sndSrc attachTo [_this, [0, 1, 0]];
	_this setVariable ["DK_carSndScr", _sndSrc];

//	systemChat "Before loop mp3";
//	while { !(isNull _sndSrc) && { !(isNull _this) && { (alive _this) } } } do
	while { (alive _this) && { ( !(_sndSrc isEqualTo objNull) OR !(simulationEnabled _this) ) } } do
	{
//		systemChat "in loop mp3";
		if (player distance2D _this < 850) then
		{
			_sndSrc = "Land_VR_Shape_01_cube_1m_F" createVehicleLocal [0,0,0];
			hideObject _sndSrc;
			call
			{
				if !(simulationEnabled _this) exitWith
				{
					_sndSrc setPosATL (getPosATL _this);
				};

				_sndSrc attachTo [_this, [0, 1, 0]];
			};
			_this setVariable ["DK_carSndScr", _sndSrc];

			_sndSrc say3D [ _track, 180, 1, true];
		};

		uiSleep _time;

		if ( !(isNil "_sndSrc") && { !(isNull _sndSrc) } ) then
		{
			deleteVehicle _sndSrc;
			_this setVariable ["DK_carSndScr", nil];
		};

//		waitUntil { (simulationEnabled _this) OR (!alive _this) };
	};
//	systemChat "Out loop mp3";

	if ( !(isNil "_sndSrc") && { !(isNull _sndSrc) } ) then
	{
		deleteVehicle _sndSrc;
		_this setVariable ["DK_carSndScr", nil];
	};
};
