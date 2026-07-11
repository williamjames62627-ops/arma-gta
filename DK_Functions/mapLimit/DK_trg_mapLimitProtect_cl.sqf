if (!hasInterface) exitWith {};
/*
DK_trg_condLimitMapPrtct_B = true;
/*
private _size = getMarkerSize "DK_MTW_mkr_limitMap_1";
private _trg = createTrigger ["EmptyDetector", getMarkerPos "DK_MTW_mkr_limitMap_1", false];
_trg setTriggerArea [(_size # 0), (_size # 1), markerDir "DK_MTW_mkr_limitMap_1", true];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["vehicle player in thisList",
"
	if (alive player) then
	{
		call DK_fnc_trg_mapLimitProtect_cl;
	};
",
"
	DK_trg_condLimitMapPrtct_A = false;
	DK_trg_condLimitMapPrtct_B = true;
"];
*/
"DK_MTW_mkr_limitMap_1" setMarkerAlphaLocal 0;
