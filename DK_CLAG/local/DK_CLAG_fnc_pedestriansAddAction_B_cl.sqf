
_this addAction ["<t color='#640aeb'>Hey man</t>  (E)",
{

		params ["_unit"];


		_unit setVariable ["DK_canSay", false];

		[_unit, 1.5] spawn DK_fnc_randomLip;


		switch (selectRandom [1,2,3,4]) do
		{
			case 1 :
			{
				[_unit,"B_civSay01",100,1,true] call DK_fnc_say3D;
			};	

			case 2 :
			{
				[_unit,"B_civSay02",100,1,true] call DK_fnc_say3D;
			};	

			case 3 :
			{
				[_unit,"B_civSay03",100,1,true] call DK_fnc_say3D;
			};	

			case 4 :
			{
				[_unit,"B_civSay04",100,1,true] call DK_fnc_say3D;
			};
		};

		_unit playActionNow (selectRandom ["gestureHi","gestureHiB","gestureHiC"]);

		_unit spawn
		{
			uiSleep 4;
			if ( !(isNil "_this") && { (!isNull _this) && { (alive _this) } } ) then
			{
				_this setVariable ["DK_canSay", true];
			};
		};

} ,nil,1.5,true,true,"LeanRight","_target getVariable ['DK_canSay', true]",7,false ];
