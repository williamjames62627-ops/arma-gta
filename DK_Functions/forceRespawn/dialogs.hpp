class DK_Respawn_Button
{
	idd=2701;
	movingEnable=false
	
	class controls 
	{
		class DK_Respawn_Button_Nfo: RscButton
		{
			idc = 1605;
			text = "Forcing respawn costs $150 and a penalty of 30 seconds";
			x = 0.376345 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.258496 * safezoneW;
			h = 0.06 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class DK_Respawn_ButtonYes: RscButton
		{
			idc = 1600;
			text = "Force respawn";

			x = 0.446345 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.108496 * safezoneW;
			h = 0.037 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; _player = player; _player remoteExecCall ['DK_fnc_checkMoneyRespawn', 2];";
		};
		class DK_Respawn_ButtonNo: RscButton
		{
			idc = 1601;
			text = "Cancel";
			x = 0.446345 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.108496 * safezoneW;
			h = 0.037 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};

};
