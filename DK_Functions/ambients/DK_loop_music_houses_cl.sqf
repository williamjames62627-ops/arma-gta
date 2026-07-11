if (!hasInterface) exitWith {};


waitUntil { getClientStateNumber > 9 };
waitUntil { !(isNil "DK_start_music_house") };


private ["_trackNFO", "_track", "_slpTime", "_houseSrc"];
private _time = time;
uiSleep 1;

while { true } do
{
	if (time > _time) then
	{
		_trackNFO = missionNamespace getVariable "houseMusicTrack";
		_track = _trackNFO # 0;
		_slpTime = (_trackNFO # 1) - 0.033;
		_houseSrc = _trackNFO # 2;

		_time = time + 60;
	};

	if ( (player distance2D _houseSrc < 800) && { (damage _houseSrc < 0.5) } ) then
	{
		_houseSrc say3D [_track, 320, 1, true];
	}
	else
	{
		_slpTime = 20;
	};

	uiSleep _slpTime;
};