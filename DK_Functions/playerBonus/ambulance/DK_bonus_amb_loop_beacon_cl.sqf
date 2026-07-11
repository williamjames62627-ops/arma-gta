if !(hasInterface) exitWith {};

_this spawn
{
	private _light = "#lightpoint" createVehicle [0,0,0]; 

	_light setLightColor [0.03,0.14,0.44];
	_light setLightAmbient [0,0,0];
	_light setLightDayLight false;
	_light setLightAttenuation [1,1.5,0,0.2,0.1,150];


	// FLARE
	private _flare1 = "#lightpoint" createVehicle [0,0,0];  
	_flare1 setLightColor [0.03,0.14,0.44]; 
	_flare1 setLightAttenuation [0, 0, 0, 0,0.01,0.1];
	_flare1 setLightUseFlare true;
	_flare1 setLightFlareSize 1.2;
	_flare1 setLightFlareMaxDistance 600;

	private _flare2 = "#lightpoint" createVehicle [0,0,0];  
	_flare2 setLightColor [0.03,0.14,0.44]; 
	_flare2 setLightAttenuation [0, 0, 0, 0,0.01,0.1];
	_flare2 setLightUseFlare true;
	_flare2 setLightFlareSize 1.2;
	_flare2 setLightFlareMaxDistance 250;

	private _flare3 = "#lightpoint" createVehicle [0,0,0];  
	_flare3 setLightColor [0.03,0.14,0.44]; 
	_flare3 setLightAttenuation [0, 0, 0, 0,0.01,0.1];
	_flare3 setLightUseFlare true;
	_flare3 setLightFlareSize 1.2;
	_flare3 setLightFlareMaxDistance 600;

	private _flare4 = "#lightpoint" createVehicle [0,0,0];  
	_flare4 setLightColor [0.03,0.14,0.44]; 
	_flare4 setLightAttenuation [0, 0, 0, 0,0.01,0.1];
	_flare4 setLightUseFlare true;
	_flare4 setLightFlareSize 1.2;
	_flare4 setLightFlareMaxDistance 250;

	private _left = true; 
	while { !(isNull _this) && { (alive _this) && { (call DK_fnc_checkIfNight_cl) } } } do
	{
		// Wait & turn off lights if beacons is Off
		waitUntil
		{
			uiSleep 0.3;

			if (_this animationSourcePhase "lights_em_hide" isEqualTo 0) then
			{
				_light setLightIntensity 0;
				_flare1 setLightBrightness 0;
				_flare2 setLightBrightness 0;
				_flare3 setLightBrightness 0;
				_flare4 setLightBrightness 0;
			};

			(_this animationSourcePhase "lights_em_hide" isEqualTo 1) OR (isNull _this) OR !(alive _this) OR !(call DK_fnc_checkIfNight_cl)
		};

		if ( !(alive _this) OR (isNull _this) OR !(call DK_fnc_checkIfNight_cl) ) exitWith {};

		// Activate lights
		call
		{
			if (_this animationSourcePhase "lights_em_hide" isEqualTo 0) exitWith {};

			call
			{
				_light setLightIntensity 4000;
				_flare1 setLightBrightness 1;
				_flare2 setLightBrightness 1;
				_flare3 setLightBrightness 1;
				_flare4 setLightBrightness 1;

				if (_left) exitWith 
				{
					_left = false; 

					_light lightAttachObject [_this, [0,1.6,1.4]];

					_flare1 lightAttachObject [_this, [0.525,1.6,1.125]];
					_flare2 lightAttachObject [_this, [0.3,1.6,1.125]];
					_flare3 lightAttachObject [_this, [-0.525,1.6,1.125]];
					_flare4 lightAttachObject [_this, [-0.3,1.6,1.125]];
				};

				_left = true; 

				_light lightAttachObject [_this, [0,-3.2,1.4]];

				_flare1 lightAttachObject [_this, [0.525,-2.95,1.125]];
				_flare2 lightAttachObject [_this, [0.3,-2.95,1.125]];
				_flare3 lightAttachObject [_this, [-0.525,-2.95,1.125]];
				_flare4 lightAttachObject [_this, [-0.3,-2.95,1.125]];
			};
		};

		uiSleep 0.9;
	};

	deleteVehicle _light;
	deleteVehicle _flare1;
	deleteVehicle _flare2;
	deleteVehicle _flare3;
	deleteVehicle _flare4;
};