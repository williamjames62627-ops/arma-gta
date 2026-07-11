#define nos ["NOS_01","NOS_02","NOS_03","NOS_04"]

DK_nosSndSrc = +nos;

private _track = selectRandom DK_nosSndSrc;
private _nul = DK_nosSndSrc deleteAt (DK_nosSndSrc find _track);

if (DK_nosSndSrc isEqualTo []) then
{
	DK_nosSndSrc = +nos;
	private _nil = DK_nosSndSrc deleteAt (DK_nosSndSrc find _track);
};

_track
