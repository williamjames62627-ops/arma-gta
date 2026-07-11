if (!isServer) exitWith {};


call DK_fnc_music_house_select;
DK_start_music_house = true;
publicVariable "DK_start_music_house";

private _house = (missionNamespace getVariable "houseMusicTrack") # 2;
private _time = time + 330;
while { true } do
{
	while { (time < _time) && { !(playableUnits findIf {_x distance2D _house < 700} isEqualTo -1) } } do
	{
		uiSleep 45;
	};

	call DK_fnc_music_house_select;

	_house = (missionNamespace getVariable "houseMusicTrack") # 2;
	_time = time + 330;
};

