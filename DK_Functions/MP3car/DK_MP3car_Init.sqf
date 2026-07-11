
if (isServer) then
{
	call compileFinal preprocessFileLineNumbers "DK_Functions\MP3car\DK_MP3car_fncs.sqf";
};

if (hasInterface) then		// compileFinal
{
	call compileFinal preprocessFileLineNumbers "DK_Functions\MP3car\DK_MP3car_fncs_cl.sqf";
	DK_MP3car_addActions_cl = compile preprocessFileLineNumbers "DK_Functions\MP3car\DK_MP3car_addActions_cl.sqf";
	DK_MP3car_addAct_NextTracks_cl = compile preprocessFileLineNumbers "DK_Functions\MP3car\DK_MP3car_addAction_NextTracks_cl.sqf";
	DK_MP3car_addAct_OnOff_cl = compile preprocessFileLineNumbers "DK_Functions\MP3car\DK_MP3car_addAction_OnOff_cl.sqf";
};