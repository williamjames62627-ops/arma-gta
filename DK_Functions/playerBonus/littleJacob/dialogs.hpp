
// Tiers choice
class JacobWeaponMenu_Chs0
{
	idd=2702;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectPal_0: RscButton
		{
			idc = 1600;
			text = "Tier 1  - $ 75 => 100";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL0);";
		};

		class DK_GUI_Jacob_SelectPal_1: RscButton
		{
			idc = 1601;
			text = "Tier 2  - Unlocked at 500 points";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			action = "";
		};

		class DK_GUI_Jacob_SelectPal_2: RscButton
		{
			idc = 1602;
			text = "Tier 3  - Unlocked at 1500 points";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class DK_GUI_Jacob_SelectPal_3: RscButton
		{
			idc = 1603;
			text = "Tier 4  - Unlocked at 2500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class DK_GUI_Jacob_SelectPal_4: RscButton
		{
			idc = 1604;
			text = "Tier 5  - Unlocked at 3500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class RscButton_1601: RscButton
		{
			idc = 1605;
			text = "X";
			x = 0.658655 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.8 * GUI_GRID_H;
			action = "call DK_fnc_bonus_LJ_Esc_01;";
		};
	};

};

class JacobWeaponMenu_Chs01
{
	idd=2702;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectPal_0: RscButton
		{
			idc = 1600;
			text = "Tier 1  - $ 75 => 100";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL0);";
		};

		class DK_GUI_Jacob_SelectPal_1: RscButton
		{
			idc = 1601;
			text = "Tier 2  - $ 150 => 170";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL1);";
		};

		class DK_GUI_Jacob_SelectPal_2: RscButton
		{
			idc = 1602;
			text = "Tier 3  - Unlocked at 1500 points";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class DK_GUI_Jacob_SelectPal_3: RscButton
		{
			idc = 1603;
			text = "Tier 4  - Unlocked at 2500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class DK_GUI_Jacob_SelectPal_4: RscButton
		{
			idc = 1604;
			text = "Tier 5  - Unlocked at 3500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class RscButton_1601: RscButton
		{
			idc = 1602;
			text = "X";
			x = 0.658655 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.8 * GUI_GRID_H;
			action = "call DK_fnc_bonus_LJ_Esc_01;";
		};
	};

};

class JacobWeaponMenu_Chs012
{
	idd=2702;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectPal_0: RscButton
		{
			idc = 1600;
			text = "Tier 1  - $ 75 => 100";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL0);";
		};

		class DK_GUI_Jacob_SelectPal_1: RscButton
		{
			idc = 1601;
			text = "Tier 2  - $ 150 => 170";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL1);";
		};

		class DK_GUI_Jacob_SelectPal_2: RscButton
		{
			idc = 1602;
			text = "Tier 3  - $ 250 => 350";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL2);";
		};

		class DK_GUI_Jacob_SelectPal_3: RscButton
		{
			idc = 1603;
			text = "Tier 4  - Unlocked at 2500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class DK_GUI_Jacob_SelectPal_4: RscButton
		{
			idc = 1604;
			text = "Tier 5  - Unlocked at 3500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class RscButton_1601: RscButton
		{
			idc = 1603;
			text = "X";
			x = 0.658655 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.8 * GUI_GRID_H;
			action = "call DK_fnc_bonus_LJ_Esc_01;";
		};
	};

};

class JacobWeaponMenu_Chs0123
{
	idd=2702;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectPal_0: RscButton
		{
			idc = 1600;
			text = "Tier 1  - $ 75 => 100";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL0);";
		};

		class DK_GUI_Jacob_SelectPal_1: RscButton
		{
			idc = 1601;
			text = "Tier 2  - $ 150 => 170";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL1);";
		};

		class DK_GUI_Jacob_SelectPal_2: RscButton
		{
			idc = 1602;
			text = "Tier 3  - $ 250 => 350";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL2);";
		};

		class DK_GUI_Jacob_SelectPal_3: RscButton
		{
			idc = 1603;
			text = "Tier 4  - $ 300 => 550";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL3);";
		};

		class DK_GUI_Jacob_SelectPal_4: RscButton
		{
			idc = 1604;
			text = "Tier 5  - Unlocked at 3500 points";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = { 0.45, 0.45, 0.45, 1 };
			sizeEx = 1.4 * GUI_GRID_H;
			action = "";
		};

		class RscButton_1601: RscButton
		{
			idc = 1603;
			text = "X";
			x = 0.658655 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.8 * GUI_GRID_H;
			action = "call DK_fnc_bonus_LJ_Esc_01;";
		};
	};

};

class JacobWeaponMenu_Chs01234
{
	idd=2702;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectPal_0: RscButton
		{
			idc = 1600;
			text = "Tier 1  - $ 75 => 100";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL0);";
		};

		class DK_GUI_Jacob_SelectPal_1: RscButton
		{
			idc = 1601;
			text = "Tier 2  - $ 150 => 170";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL1);";
		};

		class DK_GUI_Jacob_SelectPal_2: RscButton
		{
			idc = 1602;
			text = "Tier 3  - $ 250 => 350";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL2);";
		};

		class DK_GUI_Jacob_SelectPal_3: RscButton
		{
			idc = 1603;
			text = "Tier 4  - $ 300 => 550";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL3);";
		};

		class DK_GUI_Jacob_SelectPal_4: RscButton
		{
			idc = 1604;
			text = "Tier 5  - $ 380 => 680";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "private _handle = createdialog (call DK_LJ_WP_PAL4);";
		};

		class RscButton_1601: RscButton
		{
			idc = 1603;
			text = "X";
			x = 0.658655 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.8 * GUI_GRID_H;
			action = "call DK_fnc_bonus_LJ_Esc_01;";
		};
	};

};





/// Weapons
class JacobWeaponMenu_00
{
	idd=2701;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectOnlyAmmo: RscButton
		{
			idc = 1605;
			text = "Ammo for primary weapon  - $ 65";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,0,0,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class DK_GUI_Jacob_SelectWeapon_01: RscButton
		{
			idc = 1600;
			text = "SMG :  Sting 9 mm  - $ 75";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,1,0,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_02: RscButton
		{
			idc = 1601;
			text = "AR :  TRG-20 5.56 mm  - $ 100";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,2,0,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class RscButton_1601: RscButton
		{
			idc = 1610;
			text = "<";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};

};

class JacobWeaponMenu_01
{
	idd=2701;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectOnlyAmmo: RscButton
		{
			idc = 1605;
			text = "Ammo for primary weapon  - $ 65";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,0,1,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class DK_GUI_Jacob_SelectWeapon_01: RscButton
		{
			idc = 1600;
			text = "AR :  AKS-74U 5.45 mm  (Apex DLC)  - $ 150";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,1,1,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_02: RscButton
		{
			idc = 1601;
			text = "AR :  Katiba Carbine 6.5 mm  - $ 170";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,2,1,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class RscButton_1601: RscButton
		{
			idc = 1610;
			text = "<";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};

};

class JacobWeaponMenu_02
{
	idd=2701;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectOnlyAmmo: RscButton
		{
			idc = 1605;
			text = "Ammo for primary weapon  - $ 65";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,0,2,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class DK_GUI_Jacob_SelectWeapon_01: RscButton
		{
			idc = 1600;
			text = "AR :  AKM 7.62 mm  (Apex DLC)  - $ 250";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,1,2,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_02: RscButton
		{
			idc = 1601;
			text = "AR :  Mk18 ABR 7.62 mm  - $ 250";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,2,2,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_03: RscButton
		{
			idc = 1602;
			text = "LMG :  Mk200 6.5 mm  - $ 350";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,3,2,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_04: RscButton
		{
			idc = 1603;
			text = "DMR :  Mk-I EMR 7.62 mm  (Marksman DLC)  - $ 350";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,4,2,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class RscButton_1601: RscButton
		{
			idc = 1610;
			text = "<";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};

class JacobWeaponMenu_03
{
	idd=2701;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectOnlyAmmo: RscButton
		{
			idc = 1605;
			text = "Ammo for primary weapon  - $ 65";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,0,3,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class DK_GUI_Jacob_SelectWeapon_01: RscButton
		{
			idc = 1600;
			text = "AR :  AK-12 7.62 mm  (Apex DLC)  - $ 400";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,1,3,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_02: RscButton
		{
			idc = 1601;
			text = "DMR :  MXM 6.5 mm  - $ 300";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,2,3,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_03: RscButton
		{
			idc = 1602;
			text = "LMG :  Mk200 6.5 mm  - $ 350";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,3,3,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_04: RscButton
		{
			idc = 1603;
			text = "LMG :  LIM-85 5.56 mm  (Apex DLC)  - $ 300";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,4,3,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_05: RscButton
		{
			idc = 1604;
			text = "DMR :  Cyrus 9.3 mm  (Marksman DLC)  - $ 550";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,5,3,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class RscButton_1601: RscButton
		{
			idc = 1610;
			text = "<";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};	

class JacobWeaponMenu_04
{
	idd=2701;
	movingEnable=false
	
	class controls 
	{
		class DK_GUI_Jacob_SelectOnlyAmmo: RscButton
		{
			idc = 1605;
			text = "Ammo for primary weapon  - $ 65";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.217883 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,0,4,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class DK_GUI_Jacob_SelectWeapon_01: RscButton
		{
			idc = 1600;
			text = "AR :  AK-12 GL 7.62 mm  (Apex DLC)  - $ 500";

			x = 0.341345 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,1,4,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_02: RscButton
		{
			idc = 1601;
			text = "AR :  MX 3GL 6.5 mm  - $ 400";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,2,4,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_03: RscButton
		{
			idc = 1602;
			text = "LMG :  Zafir 7.62 mm  - $ 450";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,3,4,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_04: RscButton
		{
			idc = 1603;
			text = "LMG :  LIM-85 5.56 mm  (Apex DLC)  - $ 380";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,4,4,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};
		class DK_GUI_Jacob_SelectWeapon_05: RscButton
		{
			idc = 1604;
			text = "SR :  M320 LRR .408  - $ 680";
			x = 0.341345 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.308496 * safezoneW;
			h = 0.0564236 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
			action = "closeDialog 0; [] spawn DK_fnc_bonus_LJ_Esc_02; private _player = player; [_player,5,4,getDLCs 1] remoteExecCall ['DK_fnc_bonus_LJ_verifMoney', 2]";
		};

		class RscButton_1601: RscButton
		{
			idc = 1610;
			text = "<";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.180267 * safezoneH + safezoneY;
			w = 0.0176284 * safezoneW;
			h = 0.0376157 * safezoneH;
			sizeEx = 1.7 * GUI_GRID_H;
			action = "closeDialog 0;";
		};
	};
};	