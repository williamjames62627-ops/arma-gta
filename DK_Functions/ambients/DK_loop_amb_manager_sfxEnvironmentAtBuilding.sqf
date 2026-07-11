if !(isServer) exitWith {};

#define houses [("Land_i_House_Small_01_V" + (str (selectRandom [1,2,3]))) + "_F",("Land_i_House_Small_02_V" + (str (selectRandom [1,2,3]))) + "_F",("Land_i_House_Big_02_V" + (str (selectRandom [1,2,3]))) + "_F",("Land_i_House_Big_01_V" + (str (selectRandom [1,2,3]))) + "_F","Land_i_House_Small_03_V1_F"]
#define indus ["Land_i_Shed_Ind_F","Land_Factory_Main_F","Land_dp_mainFactory_F","Land_dp_smallFactory_F"]
#define construc ["Land_WIP_F","Land_Unfinished_Building_02_F","Land_Unfinished_Building_01_F"]

#define listsHsInit ["Flush","FlushBefore","ambSpeech01","ambSpeech02","ambSpeech03","ambSpeech04","ambSpeech05","ambSpeech06","ambSpeech07","ambSpeech08","ambSpeech09","ambSpeech10","ambSpeech11","ambSpeech12","ambSpeech13","ambSpeech14","ambSpeech15","ambSpeech16","ambSpeech17","ambSpeech18","ambSpeech19","ambSpeech20","ambSpeech21","ambSpeech22","ambSpeech23","ambSpeech24","ambSpeech25","ambSpeech26","ambSpeech27","cats01","cats02","cats03","dogs01","dogs02","dogs03","dogs04"]
listsHs = +listsHsInit;

#define listsIndInit ["Indus01", "Indus02", ["Indus03", 3.88, 300], "Indus04", "Indus05", "Indus14", "Indus15", "Indus17", "Indus19", "Indus21", "Indus22", "Indus23", "can01", "can02", ["Indus06", 1.47, 300], ["Indus07", 0.759, 250], ["Indus08", 1.258, 300], ["Indus09", 0.606, 300], ["Indus10", 0.606, 300], ["Indus11", 0.282, 300], ["Indus12", 7.284, 150], ["Indus13", 7.265, 150], ["Indus16", 5.661, 150], ["Indus18", 4.954, 150], ["Indus20", 6.995, 150], ["Indus24", 0.357, 300], ["Indus26", 1.096, 300], ["Indus27", 0.615, 300]]
listsInd = +listsIndInit;

#define listsConstruInit [["Const01", 0.347], ["Const02", 0.418], ["Const03", 0.433], ["Indus12", 7.284], ["Indus13", 7.265], ["Indus18", 4.954], ["Indus20", 6.995]]
listsConstru = +listsConstruInit;

#define slp1 1
#define slp2 1
#define slp3 2
#define slp0 0.1


///	// Industries
[] spawn
{
	while { true } do
	{
		_player = nil;
		private _player = selectRandom playableUnits;

		if !(isNil "_player") then
		{
			private _nearestIndus = (nearestObjects [_player, indus, 150]) - (nearestObjects [_player, indus, 65]);

			if !(_nearestIndus isEqualTo []) then
			{
				_exit = false;

				for "_i" from 0 to (count _nearestIndus) - 1 step 1 do
				{
					private _warehouse = selectRandom _nearestIndus;

					if !(isObjectHidden _warehouse) then
					{
						if ( playableUnits findIf { _x distance2D _warehouse < 65 } isEqualTo -1 ) exitWith
						{
							_exit = true;

							private _sound = selectRandom listsInd;
							_nul = listsInd deleteAt (listsInd find _sound);

					//		hint ((str (player distance2D _warehouse)) + "  :  " + (str _sound));

							[_warehouse,_sound] call DK_fnc_amb_slctSoundIndus;

							if (listsInd isEqualTo []) then
							{
								listsInd = +listsIndInit;
								_nil = listsInd deleteAt (listsInd find _sound);
							};
						};

						_nil = _nearestIndus deleteAt (_nearestIndus find _warehouse);
					};

					if _exit exitWith {};

					uiSleep slp0;
				};

				uiSleep (2 + (random 30));
			};
		};

		uiSleep slp2;
	};
};

///	// Construction sites
[] spawn
{
	while { true } do
	{
		_player = nil;
		private _player = selectRandom playableUnits;

		if !(isNil "_player") then
		{
			private _nearestConstru = (nearestObjects [_player, construc, 165]) - (nearestObjects [_player, construc, 75]);

			if !(_nearestConstru isEqualTo []) then
			{
				_exit = false;

				for "_i" from 0 to (count _nearestConstru) - 1 step 1 do
				{
					private _construc = selectRandom _nearestConstru;

					if !(isObjectHidden _construc) then
					{
						if ( playableUnits findIf { _x distance2D _construc < 65 } isEqualTo -1 ) exitWith
						{
							_exit = true;

							private _sound = selectRandom listsConstru;
							_nul = listsConstru deleteAt (listsConstru find _sound);

					//		hint ((str (player distance2D _construc)) + "  :  " + (str _sound));

							[_construc,_sound] call DK_fnc_amb_slctSoundConstru;

							if (listsConstru isEqualTo []) then
							{
								listsConstru = +listsConstruInit;
								_nil = listsConstru deleteAt (listsConstru find _sound);
							};
						};

						_nil = _nearestConstru deleteAt (_nearestConstru find _construc);
					};

					if _exit exitWith
					{
						uiSleep (10 + (random 30));
					};

					uiSleep slp0;
				};
			};
		};

		uiSleep slp3;
	};
};


///	// Houses
while { true } do
{
	private _time = 1;
	private _player = selectRandom playableUnits;

	if !(isNil "_player") then
	{
		private _nearestHouses = (nearestObjects [_player, houses, 100]) - (nearestObjects [_player, houses, 20]);

		if !(_nearestHouses isEqualTo []) then
		{
			_exit = false;

			for "_i" from 0 to (count _nearestHouses) - 1 step 1 do
			{
				private _house = selectRandom _nearestHouses;

				if !(isObjectHidden _house) then
				{
					if ( playableUnits findIf { _x distance2D _house < 16 } isEqualTo -1 ) exitWith
					{
						_exit = true;

						private _sound = selectRandom listsHs;
						_nul = listsHs deleteAt (listsHs find _sound);

		//				hint ((str (player distance2D _house)) + "  :  " + (str _sound));

						if (listsHs isEqualTo []) then
						{
							listsHs = +listsHsInit;
							_nil = listsHs deleteAt (listsHs find _sound);
						};

						_time = [_house,_sound] call DK_fnc_amb_slctSoundHouse;
					};

					_nil = _nearestHouses deleteAt (_nearestHouses find _house);
				};
				
				if _exit exitWith {};

				uiSleep slp0;
			};

			uiSleep (_time + (random 20));
		};
	};

	uiSleep slp1;
};
















