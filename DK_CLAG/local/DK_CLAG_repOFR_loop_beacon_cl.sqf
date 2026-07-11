if !(hasInterface) exitWith {};

_this spawn
{
///	// Lights
	private _lightL = "#lightpoint" createVehicle [0,0,0]; 
	private _lightR = "#lightpoint" createVehicle [0,0,0];
	_lightL lightAttachObject [_this, [-2.3, 0, 0.55]]; 
	_lightR lightAttachObject [_this, [2.3, 0, 0.55]];

	private _lights = [_lightL,_lightR];

	{
		_x setLightColor [0.9, 0.55, 0];
		_x setLightAmbient [0,0,0];
		_x setLightDayLight false;
		_x setLightAttenuation [6, 2, 0, 0.01,1,100]; 
		_x setLightBrightness 0.4; 

	} count _lights;


///	// Flares
	private _flare1 = "#lightpoint" createVehicle [0,0,0];  
	private _flare2 = "#lightpoint" createVehicle [0,0,0];  

	private _flares = [_flare1,_flare2];

	{
		_x setLightColor [0.9, 0.55, 0]; 
		_x setLightBrightness 0.7;  
		_x setLightAttenuation [0, 0, 0, 0,0.01,0.1];
		_x setLightUseFlare true;
		_x setLightFlareSize 1.2;
		_x setLightFlareMaxDistance 600;

	} count _flares;


	private _left = true; 
	while { !(isNull _this) && { (alive _this) && { (call DK_fnc_checkIfNight_cl) } } } do
	{
		waitUntil
		{
			uiSleep 0.3;

			if (_this animationSourcePhase "Beacons" isEqualTo 0) then
			{

				_lightL setLightBrightness 0;
				_lightR setLightBrightness 0;
				_flare1 setLightBrightness 0;
				_flare2 setLightBrightness 0;
			};

			(_this animationSourcePhase "Beacons" isEqualTo 1) OR (isNull _this) OR !(alive _this) OR !(call DK_fnc_checkIfNight_cl)
		};

		if ( (isNull _this) OR !(alive _this) OR !(call DK_fnc_checkIfNight_cl) ) exitWith {};

		call
		{
			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightBrightness 0.4;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightBrightness 0;
				_lightR setLightBrightness 0.4;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};
		};

		uiSleep 1.2;
	};

	deleteVehicle _lightL;
	deleteVehicle _lightR;
	deleteVehicle _flare1;
	deleteVehicle _flare2;
};