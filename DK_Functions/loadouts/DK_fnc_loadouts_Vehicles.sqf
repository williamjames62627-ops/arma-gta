if !(isServer) exitWith {};

DK_fnc_LO_ambulance = {

	[
		_this,

		["CivAmbulance",1], 
		[
			"Door_1_source",0,"Door_2_source",0,"Door_3_source",0,"Door_4_source",0,"Hide_Door_1_source",0,"Hide_Door_2_source",0,"Hide_Door_3_source",0,"Hide_Door_4_source",0,"lights_em_hide",1,"ladder_hide",1,"spare_tyre_holder_hide",1,
			"spare_tyre_hide",1,"reflective_tape_hide",0,"roof_rack_hide",1,"LED_lights_hide",0,"sidesteps_hide",0,"rearsteps_hide",1,"side_protective_frame_hide",1,"front_protective_frame_hide",1,"beacon_front_hide",0,"beacon_rear_hide",0,
			"animationSource1", 1, "animationSource2", 1
		]
	] call BIS_fnc_initVehicle;

	[_this, "CustomSoundController1", 1, 0.2] remoteExecCall ["BIS_fnc_setCustomSoundController"];
};
