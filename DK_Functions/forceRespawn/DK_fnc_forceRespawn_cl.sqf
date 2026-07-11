if !(hasInterface) exitWith {};

forceRespawn player;

[] spawn
{
	waitUntil { playerRespawnTime > 1};

	uiSleep 1;

	setPlayerRespawnTime 34;
};