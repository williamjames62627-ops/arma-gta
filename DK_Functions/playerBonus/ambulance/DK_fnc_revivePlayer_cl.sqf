
["",1,player] call BIS_fnc_reviveOnState;
player setVariable ["#rev", 1];
player setCaptive true;
player setVariable ["timeEhHD", nil];
player setVariable ["DK_isICPCT", false];
player setVariable ["hitSlp", false];

player setDamage 0;
for "_i" from 0 to 11 do
{
	player setHitIndex [ _i, 0];
};

[] spawn
{
	uiSleep 10;
	player setCaptive false;
};