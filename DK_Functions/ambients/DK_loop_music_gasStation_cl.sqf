if !(hasInterface) exitWith {};


#define trackList [["GasStation01", 4.174], ["GasStation01", 4.174]]
DK_music_GasStation_trackList = +trackList;

DK_music_gasStation_obj = [];


// Init : Get Gas Station object in array
{
	private _house = (nearestObjects [_x,["Land_fs_roof_F"],3,true]) # 0;

	if !(isNil "_house") then
	{
		DK_music_gasStation_obj pushBackUnique _house;
	};

} forEach [[20789.7,16672.4,2.9247],[19965.1,11447.5,2.92454],[23379.5,19799,2.92468],[25701.3,21372.7,2.92459],[21230.6,7116.75,2.92437],[17417.1,13936.6,2.9903],[16750.9,12513.1,2.92443],[16875.1,15469.6,2.83848]];


waitUntil { getClientStateNumber > 9 };

private _time = time;
private ["_track", "_trackNFO", "_slpTime", "_nil"]; 
uiSleep 1;

while { !(DK_music_gasStation_obj isEqualTo []) } do
{
	// Change track every 15 min
/*	if (time > _time) then
	{
		_trackNFO = selectRandom DK_music_GasStation_trackList;
		_nil = DK_music_GasStation_trackList deleteAt (DK_music_GasStation_trackList find _trackNFO);
		if (DK_music_GasStation_trackList isEqualTo []) then
		{
			DK_music_GasStation_trackList = +trackList;
			_nil = DK_music_GasStation_trackList deleteAt (DK_music_GasStation_trackList find _trackNFO);
		};

		_track = _trackNFO # 0;
		_slpTime = (_trackNFO # 1) - 0.033;

		_time = time + 900;
	};
*/
	// Play music if player near GS & if GS not destroyed
	{
		if !(damage _x isEqualTo 1) then
		{
			if (player distance2D _x < 500) then
			{
				_x say3D ["GasStation01", 160, 1, true];
			};
		}
		else
		{
			_nil = DK_music_gasStation_obj deleteAt (DK_music_gasStation_obj find _x);
		};

	} count DK_music_gasStation_obj;

	uiSleep 4.141;
};
