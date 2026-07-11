
//removeAllMissionEventHandlers "EachFrame";
if (!isNil "DK_rewards_EF") then
{
	removeMissionEventHandler ["EachFrame", DK_rewards_EF];
	DK_rewards_EF = nil;
};

if (!isNil "DK_mateNtargets_EF") then
{
	removeMissionEventHandler ["EachFrame", DK_mateNtargets_EF];
	DK_mateNtargets_EF = nil;
};

if (!isNil "DK_BA_eachFrame") then
{
	removeMissionEventHandler ["EachFrame", DK_BA_eachFrame];
	DK_BA_eachFrame = nil;
};

if (!isNil "DK_id_EF_WrongWay") then
{
	removeMissionEventHandler ["EachFrame", DK_id_EF_WrongWay];
	DK_id_EF_WrongWay = nil;
};

/*
if (!isNil "DK_LJ_EF") then
{
	removeMissionEventHandler ["EachFrame", DK_LJ_EF];
	DK_LJ_EF = nil;
};
*/


DK_lyDyn_spwnProtctActNFO cutText ["","PLAIN",0];
DK_lyDyn_countSPANFO cutText ["","PLAIN",0];
DK_lyDyn_spawnWay cutText ["","PLAIN",0];
DK_lyDyn_wounded1 cutText ["","PLAIN",0];
DK_lyDyn_wounded2 cutText ["","PLAIN",0];
DK_lyDyn_wounded3 cutText ["","PLAIN",0];
DK_lyDyn_wounded4 cutText ["","PLAIN",0];
DK_lyDyn_wounded5 cutText ["","PLAIN",0];
DK_lyDyn_wounded6 cutText ["","PLAIN",0];
DK_lyDyn_spwnProtctActNFO cutText ["","PLAIN",0];
DK_lyDyn_countSPANFO cutText ["","PLAIN",0];
DK_lyDyn_LowFuel cutText ["","PLAIN",0];



_player = player;
_player remoteExecCall ["DK_fnc_SP_setVarF", 2];




