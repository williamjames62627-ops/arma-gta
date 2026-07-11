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
		_x setLightColor [0.0, 0.04, 0.7];
		_x setLightAmbient [0, 0, 0];
		_x setLightDayLight false;
		_x setLightAttenuation [1, 1.5, 0, 0.2, 0.1, 150];

	} count _lights;


///	// Flares
	private _flare1 = "#lightpoint" createVehicle [0,0,0];  
	private _flare2 = "#lightpoint" createVehicle [0,0,0];  
	private _flare3 = "#lightpoint" createVehicle [0,0,0];  
	private _flare4 = "#lightpoint" createVehicle [0,0,0];  

	private _flares = [_flare1, _flare2, _flare3, _flare4];

	{
		_x setLightColor [0.0, 0.04, 0.7];
		_x setLightAttenuation [0, 0, 0, 0, 0.01, 0.1];
		_x setLightUseFlare true;
		_x setLightFlareSize 1.2;
		_x setLightFlareMaxDistance 600;

	} count _flares;


	_flare3 lightAttachObject [_this, [0.19, 0, 0.6]]; 
	_flare4 lightAttachObject [_this, [0.44, 0, 0.6]];

	private _left = true; 
	while { !(isNull _this) && { (alive _this) && { (call DK_fnc_checkIfNight_cl) } } } do
	{
		_flare3 setLightBrightness 0;
		_flare4 setLightBrightness 0;

		// Wait & turn off lights if beacons is Off
		waitUntil
		{
			uiSleep 0.3;

			if (_this animationSourcePhase "Beacons" isEqualTo 0) then
			{
				_lightL setLightIntensity 0;
				_lightR setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightBrightness 0;
				_flare1 setLightBrightness 0;
				_flare2 setLightBrightness 0;
			};

			(_this animationSourcePhase "Beacons" isEqualTo 1) OR (isNull _this) OR !(alive _this) OR !(call DK_fnc_checkIfNight_cl)
		};

		if ( (isNull _this) OR !(alive _this) OR !(call DK_fnc_checkIfNight_cl) ) exitWith {};

		// Activate lights
		call
		{
			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};

			_flare1 setLightBrightness 1;
			_flare2 setLightBrightness 1;

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightIntensity 4000;
					_lightL setLightBrightness 1;
					_lightR setLightIntensity 0;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};

			if ( (isNull _this) OR !(alive _this) OR (_this animationSourcePhase "Beacons" isEqualTo 0) ) exitWith {};
			uiSleep (0.45 - (speed _this / 800));

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightIntensity 4000;
					_lightL setLightBrightness 1;
					_lightR setLightIntensity 0;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};

			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};
			uiSleep (0.45 - (speed _this / 800));

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightIntensity 4000;
					_lightL setLightBrightness 1;
					_lightR setLightIntensity 0;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};

			if ( (isNull _this) OR !(alive _this) OR (_this animationSourcePhase "Beacons" isEqualTo 0) ) exitWith {};
			uiSleep (0.45 - (speed _this / 800));

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightIntensity 4000;
					_lightL setLightBrightness 1;
					_lightR setLightIntensity 0;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};

			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};
			uiSleep (0.45 - (speed _this / 800));

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightIntensity 4000;
					_lightL setLightBrightness 1;
					_lightR setLightIntensity 0;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};

			if ( (isNull _this) OR !(alive _this) OR (_this animationSourcePhase "Beacons" isEqualTo 0) ) exitWith {};
			uiSleep (0.45 - (speed _this / 800));

			call
			{
				if (_left) exitWith 
				{
					_left = false; 
					_lightL setLightIntensity 4000;
					_lightL setLightBrightness 1;
					_lightR setLightIntensity 0;
					_lightR setLightBrightness 0;
					_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
					_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 
				};

				_left = true; 
				_lightL setLightIntensity 0;
				_lightL setLightBrightness 0;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [0.19, 0, 0.6]]; 
				_flare2 lightAttachObject [_this, [0.44, 0, 0.6]];
			};

			// Double
			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};
			uiSleep (0.45 - (speed _this / 800));

			call
			{
				_lightL setLightIntensity 1000;
				_lightL setLightBrightness 0.25;
				_lightR setLightIntensity 1000;
				_lightR setLightBrightness 0.25;

				_flare1 setLightBrightness 0;
				_flare2 setLightBrightness 0;
				_flare3 setLightBrightness 0;
				_flare4 setLightBrightness 0;
			};

			if ( (isNull _this) OR !(alive _this) OR (_this animationSourcePhase "Beacons" isEqualTo 0) ) exitWith {};
			uiSleep 0.225;

			call
			{
				_lightL setLightIntensity 4000;
				_lightL setLightBrightness 1;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;
				_flare1 lightAttachObject [_this, [-0.52, 0, 0.6]];
				_flare2 lightAttachObject [_this, [-0.27, 0, 0.6]]; 

				_flare1 setLightBrightness 1;
				_flare2 setLightBrightness 1;
				_flare3 setLightBrightness 1;
				_flare4 setLightBrightness 1;
			};

			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};
			uiSleep 0.225;

			call
			{
				_lightL setLightIntensity 1000;
				_lightL setLightBrightness 0.25;
				_lightR setLightIntensity 1000;
				_lightR setLightBrightness 0.25;

				_flare1 setLightBrightness 0;
				_flare2 setLightBrightness 0;
				_flare3 setLightBrightness 0;
				_flare4 setLightBrightness 0;
			};

			if ( (isNull _this) OR !(alive _this) OR (_this animationSourcePhase "Beacons" isEqualTo 0) ) exitWith {};
			uiSleep 0.225;

			call
			{
				_lightL setLightIntensity 4000;
				_lightL setLightBrightness 1;
				_lightR setLightIntensity 4000;
				_lightR setLightBrightness 1;

				_flare1 setLightBrightness 1;
				_flare2 setLightBrightness 1;
				_flare3 setLightBrightness 1;
				_flare4 setLightBrightness 1;
			};

			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};
			uiSleep 0.225;

			call
			{
				_lightL setLightIntensity 1000;
				_lightL setLightBrightness 0.25;
				_lightR setLightIntensity 1000;
				_lightR setLightBrightness 0.25;

				_flare1 setLightBrightness 0;
				_flare2 setLightBrightness 0;
				_flare3 setLightBrightness 0;
				_flare4 setLightBrightness 0;
			};

			if (_this animationSourcePhase "Beacons" isEqualTo 0) exitWith {};
			uiSleep 0.07;
		};

	};

	deleteVehicle _lightL;
	deleteVehicle _lightR;
	deleteVehicle _flare1;
	deleteVehicle _flare2;
	deleteVehicle _flare3;
	deleteVehicle _flare4;
};