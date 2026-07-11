
private _actuMoney = _this getVariable "DK_moneyWallet";

if (isNil "_actuMoney") then
{
	_this setVariable ["DK_moneyWallet", 0];	
};

//if ( (_this getVariable "DK_moneyWallet") >= (call DK_RESPAWN_COST) ) then
//{
	[_this,-(call DK_RESPAWN_COST)] call DK_fnc_handlePlayerMoney;

	remoteExecCall ["DK_fnc_forceRespawn_cl", _this];
//};