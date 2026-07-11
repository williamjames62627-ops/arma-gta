#define DelInEmpV(TODEL) _nil = DK_emptyVeh deleteAt (DK_emptyVeh find TODEL)


private "_nil";

DK_emptyVeh = [];

waitUntil { uiSleep 5; (!isNil "DK_fnc_activateDynSim") };

while { true } do
{
	uiSleep 5;

	{
		private _veh = _x;


		_nil = _veh call DK_fnc_activateDynSim;

		if (alive _veh) then
		{
			if ( !(_veh getVariable ["cleanUpOn", false]) && { ((crew _veh) findIf {alive _x} isEqualTo -1) } ) then
			{
				_nil = [_veh, DK_delVeh_time, DK_delVeh_dis, true] spawn DK_fnc_addVehTo_CUM;
			};
		}
		else
		{
			DelInEmpV(_veh);
		};

		uiSleep 0.25;

	} count DK_emptyVeh;
};