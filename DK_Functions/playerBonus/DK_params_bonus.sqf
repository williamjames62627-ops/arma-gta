
[] spawn
{
	uiSleep 10;

	/// Ambulance
	if (isNil "DK_nbAmb") then
	{
		DK_nbAmb = 0;
	};

	/// Little JAcob
	if (isNil "DK_weapon_LJ_InProgress") then
	{
		DK_weapon_LJ_InProgress = false;
	};

	if !(isServer) exitWith {};

	"DK_weapon_LJ_InProgress" addPublicVariableEventHandler
	{
		_this params ["", "_inProg"];

		if _inProg then
		{
			[] spawn DK_fnc_bonus_LJ_debugInProg;
		};
	};

};


/// Ambulance
DK_AMB_SCORE_MINI = compileFinal "4";
DK_AMB_SCORE_MAX_PAL1 = compileFinal "1999";
DK_AMB_SCORE_MAX_PAL2 = compileFinal "3999";

DK_AMB_COST = compileFinal "-35";
DK_AMB_COSTP = compileFinal "35";
DK_AMB_COST_KILL = compileFinal "-25";


/// Little Jacob
DK_LJ_SCORE_MINI = compileFinal "249";				// points
DK_LJ_WP_SCORE_MAX_PAL0 = compileFinal "500";
DK_LJ_WP_SCORE_MAX_PAL1 = compileFinal "1500";
DK_LJ_WP_SCORE_MAX_PAL2 = compileFinal "2500";
DK_LJ_WP_SCORE_MAX_PAL3 = compileFinal "3500";

DK_LJ_WP_ChsPAL0 = compileFinal "'JacobWeaponMenu_Chs0'";
DK_LJ_WP_ChsPAL01 = compileFinal "'JacobWeaponMenu_Chs01'";
DK_LJ_WP_ChsPAL012 = compileFinal "'JacobWeaponMenu_Chs012'";
DK_LJ_WP_ChsPAL0123 = compileFinal "'JacobWeaponMenu_Chs0123'";
DK_LJ_WP_ChsPAL01234 = compileFinal "'JacobWeaponMenu_Chs01234'";

DK_LJ_WP_PAL0 = compileFinal "'JacobWeaponMenu_00'";
DK_LJ_WP_PAL1 = compileFinal "'JacobWeaponMenu_01'";
DK_LJ_WP_PAL2 = compileFinal "'JacobWeaponMenu_02'";
DK_LJ_WP_PAL3 = compileFinal "'JacobWeaponMenu_03'";
DK_LJ_WP_PAL4 = compileFinal "'JacobWeaponMenu_04'";

DK_LJ_WP_CNTDWN = compileFinal (str (["Par_LJcountdown", 600] call BIS_fnc_getParamValue));

DK_LJ_WP_costAmmo = compileFinal "65";

DK_LJ_WP_cost_1_0 = compileFinal "75";
DK_LJ_WP_cost_2_0 = compileFinal "100";

DK_LJ_WP_cost_1_1 = compileFinal "150";
DK_LJ_WP_cost_2_1 = compileFinal "170";

DK_LJ_WP_cost_1_2 = compileFinal "250";
DK_LJ_WP_cost_2_2 = compileFinal "250";
DK_LJ_WP_cost_3_2 = compileFinal "350";
DK_LJ_WP_cost_4_2 = compileFinal "350";

DK_LJ_WP_cost_1_3 = compileFinal "400";
DK_LJ_WP_cost_2_3 = compileFinal "300";
DK_LJ_WP_cost_3_3 = compileFinal "350";
DK_LJ_WP_cost_4_3 = compileFinal "300";
DK_LJ_WP_cost_5_3 = compileFinal "550";

DK_LJ_WP_cost_1_4 = compileFinal "500";
DK_LJ_WP_cost_2_4 = compileFinal "400";
DK_LJ_WP_cost_3_4 = compileFinal "450";
DK_LJ_WP_cost_4_4 = compileFinal "380";
DK_LJ_WP_cost_5_4 = compileFinal "680";



/// // Optics & Charge Exp
call
{
	_optic = "Par_allowOptics" call BIS_fnc_getParamValue;
	if (_optic isEqualTo 0) exitWith
	{
		DK_LJ_ALWD_OPTC = compileFinal "false";
		DK_MIS_ALWD_OPTC = compileFinal "false";
	};
	if (_optic isEqualTo 1) exitWith
	{
		DK_LJ_ALWD_OPTC = compileFinal "true";
		DK_MIS_ALWD_OPTC = compileFinal "false";
	};
	if (_optic isEqualTo 2) exitWith
	{
		DK_LJ_ALWD_OPTC = compileFinal "false";
		DK_MIS_ALWD_OPTC = compileFinal "true";
	};
	if (_optic isEqualTo 3) then
	{
		DK_LJ_ALWD_OPTC = compileFinal "true";
		DK_MIS_ALWD_OPTC = compileFinal "true";
	};
};

call
{
	_explosif = "Par_allowExplosifs" call BIS_fnc_getParamValue;
	if (_explosif isEqualTo 0) exitWith
	{
		DK_LJ_ALWD_EXPL = compileFinal "false";
		DK_ALWD_EXPL = compileFinal "false";
	};
	if (_explosif isEqualTo 1) exitWith
	{
		DK_LJ_ALWD_EXPL = compileFinal "true";
		DK_ALWD_EXPL = compileFinal "false";
	};
	if (_explosif isEqualTo 2) exitWith
	{
		DK_LJ_ALWD_EXPL = compileFinal "false";
		DK_ALWD_EXPL = compileFinal "true";
	};
	if (_explosif isEqualTo 3) then
	{
		DK_LJ_ALWD_EXPL = compileFinal "true";
		DK_ALWD_EXPL = compileFinal "true";
	};
};



