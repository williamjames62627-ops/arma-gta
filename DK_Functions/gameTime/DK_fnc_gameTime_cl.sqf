if !(hasInterface) exitWith {};


[] spawn
{
	private "_time";

	[DK_vTxt_cntDownMinLeft, safezoneX + 0.389,safezoneY + 0.024,100000,0,0,DK_lyDyn_cntDwn2] spawn BIS_fnc_dynamicText;
	[DK_vTxt_cntDown1 + str (round ((estimatedEndServerTime - serverTime) / 60)), safezoneX - 0.6,safezoneY + 0.013,120,0,0,DK_lyDyn_cntDwn1] spawn BIS_fnc_dynamicText;


	while { ((estimatedEndServerTime - serverTime) > 300) } do
	{
		_time = (estimatedEndServerTime - serverTime) - 60;

		uiSleep 50;
		waitUntil { uiSleep 0.2; ((estimatedEndServerTime - serverTime)  < _time) OR ((estimatedEndServerTime - serverTime) <= 300) };

		[DK_vTxt_cntDown1 + str (round ((estimatedEndServerTime - serverTime) / 60)),  safezoneX - 0.6,safezoneY + 0.013,120,0,0,DK_lyDyn_cntDwn1] spawn BIS_fnc_dynamicText;
	};


	[DK_vTxt_cntDownMinLeft2, safezoneX + 0.389,safezoneY + 0.024,100000,0,0,DK_lyDyn_cntDwn2] spawn BIS_fnc_dynamicText;
	[DK_vTxt_cntDown2 + (str round ((call BIS_fnc_missionTimeLeft) / 60)), safezoneX - 0.6,safezoneY+ 0.013,120,0,0,DK_lyDyn_cntDwn1] spawn BIS_fnc_dynamicText;

	while { ((estimatedEndServerTime - serverTime) > 60) } do
	{
		_time = (estimatedEndServerTime - serverTime) - 60;

		uiSleep 40;
		waitUntil { uiSleep 0.2; ((estimatedEndServerTime - serverTime)  < _time) OR ((estimatedEndServerTime - serverTime) <= 60) };

		[DK_vTxt_cntDown2 + (str round ((call BIS_fnc_missionTimeLeft) / 60)), safezoneX - 0.6,safezoneY+ 0.013,120,0,0,DK_lyDyn_cntDwn1] spawn BIS_fnc_dynamicText;

	};


	[DK_vTxt_colorRedF + DK_vTxt_cntDownMinLeft, safezoneX + 0.389,safezoneY + 0.024,100000,0,0,DK_lyDyn_cntDwn2] spawn BIS_fnc_dynamicText;
	[DK_vTxt_cntDown1 + DK_vTxt_colorRedF + "1",  safezoneX - 0.6,safezoneY + 0.013,120,0,0,DK_lyDyn_cntDwn1] spawn BIS_fnc_dynamicText;

	waitUntil { uiSleep 0.2; ((estimatedEndServerTime - serverTime) < 1) };

	["", 0,0,0,0,0,DK_lyDyn_cntDwn2] spawn BIS_fnc_dynamicText;
	[DK_vTxt_cntDown1 + DK_vTxt_colorRedF + "Last Mission", safezoneX - 0.55,safezoneY + 0.013,100000,0,0,DK_lyDyn_cntDwn1] spawn BIS_fnc_dynamicText;
};

