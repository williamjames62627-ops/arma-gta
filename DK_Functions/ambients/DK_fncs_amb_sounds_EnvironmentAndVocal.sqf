if (!isServer) exitWith {};

// Vocals
#define DK_panicVoAry_Init ["cry01","cry02","cry03","cry04","cry05","cry01","cry02","cry03","cry04","cry05","seeGun01","seeGun02","seeGun03"]
DK_panicVoAry = +DK_panicVoAry_Init;


#define cats ["cats01","cats02","cats03"]
#define dogs ["dogs01","dogs02","dogs03","dogs04"]



// /// FUNCTIONS

//// Vocals
DK_fnc_vocCiv_Panic = {

	uiSleep (0.1 + (random 1.3));

	if !(alive _this) exitWith {};

	[_this, 0.8] spawn DK_fnc_randomLip;

	private _panic = selectRandom DK_panicVoAry;
	_nul = DK_panicVoAry deleteAt (DK_panicVoAry find _panic);
	if (!isNil "_panic") then
	{
		[_this,_panic,145,(0.9 + (random 0.2)),true] call DK_fnc_say3D;
	};

	if (DK_panicVoAry isEqualTo []) then
	{
		DK_panicVoAry = +DK_panicVoAry_Init;
		_nul = DK_panicVoAry deleteAt (DK_panicVoAry find _panic);
	};
};



///	/// SFX Ambient
DK_fnc_amb_slctSoundIndus = {

	params ["_warehouse","_soundNFO"];


	if (_soundNFO isEqualType []) exitWith
	{
		private _durTime = 5 + (random 11);
		{
			if (_x distance2D _warehouse < 350) then
			{
				[_durTime, _warehouse, _soundNFO # 0, (_soundNFO # 1) - 0.033, _soundNFO # 2] remoteExecCall ["DK_fnc_amb_playSfxSoundInBuilding_cl", DK_isDedi];
			};

		} forEach playableUnits;
	};

	[_warehouse, _soundNFO, 300, 1, true] call DK_fnc_say3D;
};

DK_fnc_amb_slctSoundHouse = {

	params ["_house","_sound"];


	private "_time";

	call
	{
		if (_sound in cats) exitWith
		{
			[_house, _sound, 200, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
			_time = 4;
		};
		if (_sound in dogs) exitWith
		{
			[_house, _sound, 300, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
			_time = 2.5;
		};

		[_house, _sound, 170, (0.9 + (random 0.2)), true] call DK_fnc_say3D;
		_time = 2;
	};

	_time
};

DK_fnc_amb_slctSoundConstru = {

	params ["_construc","_soundNFO"];


	private _durTime = 5 + (random 11);
	{
		if (_x distance2D _construc < 350) then
		{
			[_durTime, _construc, _soundNFO # 0, (_soundNFO # 1) - 0.033, 200] remoteExecCall ["DK_fnc_amb_playSfxSoundInBuilding_cl", DK_isDedi];
		};

	} forEach playableUnits;
};