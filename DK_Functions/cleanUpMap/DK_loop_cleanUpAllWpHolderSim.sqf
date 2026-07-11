if (!isServer) exitWith {};


while { true } do
{
	uiSleep 60;

	{
		_x call DK_fnc_checkAllWpHolderSim;

		uiSleep 0.1;

	} count (allMissionObjects "GroundWeaponHolder");

	uiSleep 60;

	{
		_x call DK_fnc_checkAllWpHolderSim;

		uiSleep 0.1;

	} count (allMissionObjects "WeaponHolderSimulated");

	uiSleep 10;

	{
		if (west in [(side (group _x)), side _x]) then
		{
			_x setDamage 1;
			deleteVehicle _x;
		};

	} count (allUnits - allPlayers);
};
