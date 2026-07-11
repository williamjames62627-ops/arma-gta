

private _actuMoney = _this getVariable "DK_moneyWallet";

if (isNil "_actuMoney") then
{
	_this setVariable ["DK_moneyWallet", 0];	
};

if ( (_this getVariable "DK_moneyWallet") >= (call DK_AMB_COSTP) ) then
{
	remoteExecCall ["DK_fnc_chckAllowedAmb", _this];
};