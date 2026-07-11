if (!hasInterface) exitWith {};

DK_BA_allMedics = _this;

DK_BA_mkr = createMarkerLocal ["mkrAmbulance", DK_BA_allMedics # 0];
DK_BA_mkr setMarkerTypeLocal "loc_Hospital";
DK_BA_mkr setMarkerColorLocal "ColorYellow";	
DK_BA_mkr setMarkerSizeLocal [0.72,0.72];

["ntf_bonus_amb_spawned",[]] call bis_fnc_showNotification;


// ICON 3D & MARKER
if (!isNil "DK_BA_eachFrame") then
{
	removeMissionEventHandler ["EachFrame", DK_BA_eachFrame];
	DK_BA_eachFrame = nil;
};

DK_BA_eachFrame = addMissionEventHandler ["EachFrame",
{
	call DK_fnc_hudAmbulance;
}];


// Check when it's finish
[] spawn
{
	for "_i" from 0 To 160 do
	{
		if !(lifeState player isEqualTo "INCAPACITATED") exitWith {};

		if (DK_BA_allMedics findIf {alive _x} isEqualTo -1) exitWith
		{
			["ntf_bonus_amb_killed_A",[]] call bis_fnc_showNotification;
			uiSleep 2;
			["ntf_bonus_amb_killed_B",[]] call bis_fnc_showNotification;	
		};

		uiSleep 1;
	};

	if !(isNil "DK_BA_mkr") then
	{
		deleteMarkerLocal DK_BA_mkr;
	};
	if (!isNil "DK_BA_eachFrame") then
	{
		removeMissionEventHandler ["EachFrame", DK_BA_eachFrame];
	};

	/// DELETE / RE-INIT all variables
	DK_BA_allMedics = nil;
	DK_BA_mkr = nil;
	DK_BA_eachFrame = nil;
};

