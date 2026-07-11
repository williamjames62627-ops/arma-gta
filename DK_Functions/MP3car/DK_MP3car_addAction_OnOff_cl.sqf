

_this addAction ["<t color='#FFEF0F'>MP3 Player : </t>" + "On/Off",
{
	[(_this # 0)] remoteExecCall ["DK_fnc_MP3car_OnOff", 2];

} ,nil,-4,false,true,"","player isEqualTo driver _target"];