

_this addAction ["<t color='#FFEF0F'>On/Off beacon</t>",
{
	params ["_veh"];


	if (_veh getVariable "beacon_ON") then
	{
		_veh setVariable ["beacon_ON",false,true];
	}
	else
	{
		_veh setVariable ["beacon_ON",true,true];
	};

} ,nil,-4,true,true,"","player isEqualTo driver _target"];