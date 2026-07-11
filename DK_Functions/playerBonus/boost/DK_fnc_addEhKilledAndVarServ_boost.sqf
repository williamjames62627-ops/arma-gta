
params ["_veh","_netId"];



_veh setVariable ["BoostInit_IdJip",_netId];

_veh addMPEventHandler ["mpKilled",
{
	params ["_veh"];

	if (isServer) then
	{
		private _netID = _veh getVariable "BoostInit_IdJip";
		if !(isNil "_netId") then
		{
			remoteExecCall ["", _netID];
			_veh setVariable ["BoostInit_IdJip", nil];
		};
	};

	if (hasInterface) then
	{
		removeAllActions _veh;
	};
}];

_veh addEventHandler ["Deleted",
{
	params ["_veh"];

	private _netID = _veh getVariable "BoostInit_IdJip";
	if !(isNil "_netId") then
	{
		remoteExecCall ["", _netID];
		_veh setVariable ["BoostInit_IdJip", nil];
	};
}];