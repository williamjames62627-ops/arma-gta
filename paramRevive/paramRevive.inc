
class ReviveDuration
{
	title = $STR_A3_ReviveDuration;
	isGlobal = 1;

	values[] = {
		6,
		-100,
		10,
		12,
		15,
		20,
		25,
		30
	};
	texts[] = {
		6,
		"8  -  (default)",
		10,
		12,
		15,
		20,
		25,
		30
	};
	default = -100;
	function = "bis_fnc_paramReviveDuration";
};

class ReviveBleedOutDuration
{
	title = $STR_A3_BleedOutDuration;
	isGlobal = 1;

	values[] = {
		10,
		15,
		20,
		30,
		45,
		60,
		90,
		-100,
		180
	};
	texts[] = {
		10,
		15,
		20,
		30,
		45,
		60,
		90,
		"135  -  (default)",
		180
	};
	default = -100;
	function = "bis_fnc_paramReviveBleedOutDuration";
};

class ReviveForceRespawnDuration
{
	title = $STR_A3_ForceRespawnDuration;
	isGlobal = 1;

	values[] = {
		-100,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	};
	texts[] = {
		"2  -  (default)",
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	};
	default = -100;
	function = "bis_fnc_paramReviveForceRespawnDuration";
};