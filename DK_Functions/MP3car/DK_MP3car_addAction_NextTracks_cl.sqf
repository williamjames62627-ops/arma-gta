
_this addAction ["<t color='#FFEF0F'>MP3 Player : </t>" + "Next track",
{
	(_this # 0) remoteExecCall ["DK_fnc_MP3car_NextTracks", 2];

} ,nil,-3,false,true,"","player isEqualTo driver _target"];