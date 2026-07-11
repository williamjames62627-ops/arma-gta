if (!isServer) exitWith {};

#define DK_vestDel(STF) private _nul = DK_vestCiv deleteAt (DK_vestCiv find STF)
#define DK_hatDel(STF) private _nul = DK_hatCiv deleteAt (DK_hatCiv find STF)
#define DK_googDel(STF) private _nul = DK_googCiv deleteAt (DK_googCiv find STF)

#define DK_vestHikerDel(STF) private _nul = DK_vestCivHiker deleteAt (DK_vestCivHiker find STF)
#define DK_hatHikerDel(STF) private _nul = DK_hatCivHiker deleteAt (DK_hatCivHiker find STF)

#define DK_vestTrampDel(STF) private _nul = DK_vestCivTramp deleteAt (DK_vestCivTramp find STF)

#define DK_hatTechDel(STF) private _nul = DK_hatCivTech deleteAt (DK_hatCivTech find STF)

// DEFAULT CIVILIAN'S
#define vestCiv ["U_C_Uniform_Scientist_02_formal_F", "U_I_L_Uniform_01_tshirt_sport_F", "U_I_L_Uniform_01_tshirt_black_F", "U_C_Man_casual_3_F","U_C_Mechanic_01_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_4_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_BG_Guerilla2_3","U_C_man_sport_1_F","U_C_man_sport_3_F","U_C_man_sport_2_F","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_C_Poor_1"]
#define hatCiv ["H_Beret_blk","H_Hat_Safari_olive_F","H_Hat_Safari_sand_F","H_Booniehat_tan","H_Cap_blk","H_Cap_blu","H_Cap_grn","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Cap_khaki_specops_UK","H_Cap_usblack","H_Hat_blue","H_Hat_brown","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_StrawHat","H_StrawHat_dark"]
#define googCiv ["G_Aviator","G_Lady_Blue","G_Shades_Blue","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Spectacles","G_Sport_Red","G_Sport_Blackyellow","G_Sport_BlackWhite","G_Sport_Checkered","G_Sport_Blackred","G_Sport_Greenblack","G_Squares_Tinted"]

#define vestCivHK ["U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla1_2_F","U_BG_Guerilla3_1"]
#define hatCivHK ["H_Hat_Safari_olive_F","H_Hat_Safari_sand_F","H_Booniehat_tan","H_Booniehat_oli"]
#define googCivHK ["G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Shades_Blue"]
#define bagCivHK ["B_Carryall_cbr","B_Carryall_oli","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_FieldPack_cbr","B_FieldPack_oucamo","B_FieldPack_oli","B_FieldPack_khk"]

#define vestCivTP ["U_I_C_Soldier_Bandit_5_F","U_C_Mechanic_01_F","U_C_Poloshirt_salmon","U_C_Man_casual_5_F"]

#define vestCivTech "U_C_WorkerCoveralls"
#define hatCivTech ["H_Construction_basic_white_F","H_Cap_grn_BI","H_Cap_blk_CMMG","H_Cap_blk_ION","H_Cap_red","H_Cap_usblack","H_Cap_tan_specops_US","H_Cap_brn_SPECOPS"]

#define vestCivBoss ["U_Rangemaster","U_Competitor","U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F"]

#define vestBoat ["U_C_man_sport_2_F","U_C_man_sport_3_F","U_C_man_sport_1_F","U_C_Poloshirt_tricolour","U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_B_Wetsuit"]
#define vestScoot ["U_C_man_sport_2_F","U_C_man_sport_3_F","U_C_man_sport_1_F"]

#define vestFarm ["U_C_Uniform_Farmer_01_F"]

DK_vestCiv = +vestCiv;
DK_hatCiv = +hatCiv;
DK_googCiv = +googCiv;

DK_vestCivHiker = +vestCivHK;
DK_hatCivHiker = +hatCivHK;

DK_vestCivTramp = +vestCivTP;

DK_hatCivTech = +hatCivTech;

/////// Ambient Life
DK_fnc_LO_Civ = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	private _uniform = selectRandom DK_vestCiv;
	DK_vestDel(_uniform);
	_this forceAddUniform _uniform;

	if (DK_vestCiv isEqualTo []) then
	{
		DK_vestCiv = +vestCiv;
		DK_vestDel(_uniform);
	};

	if (selectRandom [true, false, false]) then
	{

		_hat = selectRandom DK_hatCiv;
		_this addHeadgear _hat;

		DK_hatDel(_hat);

		if (DK_hatCiv isEqualTo []) then
		{
			DK_hatCiv =	+hatCiv;
			DK_hatDel(_hat);
		};
	};

	if (selectRandom [true, false, false]) then
	{

		_goog = selectRandom DK_googCiv;
		_this addGoggles _goog;

		DK_googDel(_goog);

		if (DK_googCiv isEqualTo []) then
		{
			DK_googCiv = +googCiv;
			DK_googDel(_goog);
		};
	};

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Civ_bandit = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");


	private _uniform = selectRandom DK_vestCiv;
	DK_vestDel(_uniform);
	_this forceAddUniform _uniform;

	if (DK_vestCiv isEqualTo []) then
	{
		DK_vestCiv = +vestCiv;
		DK_vestDel(_uniform);
	};

	if (selectRandom [true,false]) then
	{

		_hat = selectRandom DK_hatCiv;
		_this addHeadgear _hat;

		DK_hatDel(_hat);

		if (DK_hatCiv isEqualTo []) then
		{
			DK_hatCiv =	+hatCiv;
			DK_hatDel(_hat);
		};
	};

	if (selectRandom [true,false]) then
	{

		_goog = selectRandom DK_googCiv;
		_this addGoggles _goog;

		DK_googDel(_goog);

		if (DK_googCiv isEqualTo []) then
		{
			DK_googCiv = +googCiv;
			DK_googDel(_goog);
		};
	};

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Hunter = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_HunterBody_grn";
	_this addHeadgear "H_Booniehat_tan";
	_this addWeapon "Binocular";

	_this addBackpack "B_AssaultPack_Kerry";
	[_this, "sgun_HunterShotgun_01_F", 12, "2Rnd_12Gauge_Slug"] call BIS_fnc_addWeapon;


	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Herdsman = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform (selectRandom ["U_C_HunterBody_grn","U_BG_Guerilla3_1"]);
	_this addWeapon "Binocular";

	_face = selectRandom ["GreekHead_A3_08","GreekHead_A3_04","GreekHead_A3_03"];
	[_this, _face] remoteExecCall ["setFace", DK_isDedi, _this]; 


	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Hiker = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	private _uniform = selectRandom DK_vestCivHiker;
	DK_vestHikerDel(_uniform);
	_this forceAddUniform _uniform;

	if (DK_vestCivHiker isEqualTo []) then
	{
		DK_vestCivHiker = +vestCivHK;
		DK_vestHikerDel(_uniform);
	};


	_hat = selectRandom DK_hatCivHiker;
	DK_hatHikerDel(_hat);
	_this addHeadgear _hat;

	if (DK_hatCivHiker isEqualTo []) then
	{
		DK_hatCivHiker = +hatCivHK;
		DK_hatHikerDel(_hat);
	};

	_goog = selectRandom googCivHK;
	_this addGoggles _goog;

	_bag = selectRandom bagCivHK;
	_this addBackpack _bag;


	if (selectRandom [true,false]) then
	{
		_this addWeapon "Binocular";
	};

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Tramp = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	private _uniform = selectRandom DK_vestCivTramp;
	DK_vestTrampDel(_uniform);
	_this forceAddUniform _uniform;

	if (DK_vestCivTramp isEqualTo []) then
	{
		DK_vestCivTramp = +vestCivTP;
		DK_vestTrampDel(_uniform);
	};


	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_CivTech = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform vestCivTech;

	_hat = selectRandom DK_hatCivTech;
	DK_hatTechDel(_hat);
	_this addHeadgear _hat;

	if (DK_hatCivTech isEqualTo []) then
	{
		DK_hatCivTech =	+hatCivTech;
		DK_hatTechDel(_hat);
	};

	if (selectRandom [true,false]) then
	{
		_this addBackpack "B_LegStrapBag_black_F";
	};

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_CivBoss = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform (selectRandom vestCivBoss);
	_this addGoggles "G_Shades_Black";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Repair = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_ConstructionCoverall_Black_F";
	_this addBackpack "B_LegStrapBag_coyote_F";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Constru = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_ConstructionCoverall_Blue_F";
	_this addVest "V_Safety_orange_F";

	if (selectRandom [true,false]) then
	{
		_this addHeadgear "H_Construction_basic_orange_F";
	};

	if (selectRandom [true,false]) then
	{
		_this addGoggles "G_EyeProtectors_F";
	};

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_marketDealer = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform (selectRandom ["U_BG_Guerilla2_2", "U_I_C_Soldier_Bandit_4_F"]);
	_this addHeadgear (selectRandom ["H_Hat_tan", "H_Hat_checker", "H_Hat_brown", "H_Hat_blue"]);


	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_DriverBoat = {

	params ["_civ","_uniform"];


	_civ setUnitLoadout (configFile >> "EmptyLoadout");

	private "_uniform";
	call
	{
		if (isNil "_uniform") exitWith
		{
			_uniform = selectRandom vestBoat;		
		};

		_uniform = _this # 1;
	};

	_civ forceAddUniform _uniform;

	if (selectRandom [true,false]) then
	{

		_hat = selectRandom hatCiv;
		_civ addHeadgear _hat;

	};

	_goog = selectRandom googCiv;
	_civ addGoggles _goog;


	_civ setSkill 0.1;
	_civ disableAI "AUTOCOMBAT";

	_civ setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_civ];
};

DK_fnc_LO_DriverScoot = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_uniform = selectRandom vestScoot;		
	_this forceAddUniform _uniform;

	_goog = selectRandom googCiv;
	_this addGoggles _goog;


	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};


// Traffic
DK_fnc_LO_RepairSafe = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_ConstructionCoverall_Black_F";
	_this addVest "V_Safety_yellow_F";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_press = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_Journalist";
	_this addHeadgear "H_Cap_press";
	_this addGoggles "G_Shades_Red";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_racerTeamRS = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_Driver_3";
	_this addHeadgear "H_Cap_usblack";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_racerTeamVR = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_Driver_4";
	_this addHeadgear "H_Bandanna_surfer_blk";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_racerTeamFL = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_Driver_1";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_Astra = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_Scientist";
	_this addHeadgear "H_WirelessEarpiece_F";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_lightTT = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform vestCivTech;

	if (selectRandom [true,false]) then
	{
		_this addVest "V_Safety_yellow_F";
	};

	if (selectRandom [true,false]) then
	{
		if (DK_hatCivTech isEqualTo []) then
		{
			DK_hatCivTech =	+hatCivTech;
		};

		_this addHeadgear (selectRandom DK_hatCivTech);
	};

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_zamack = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_ConstructionCoverall_Blue_F";
	_this addVest "V_Safety_orange_F";
	_this addHeadgear "H_Construction_basic_orange_F";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};


// Bonus
DK_fnc_LO_Medic = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_C_Paramedic_01_F";
	_this addBackpack "B_Messenger_Gray_Medical_F";
	clearAllItemsFromBackpack _this;
	_this addGoggles "G_Respirator_blue_F";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";
	_this enableFatigue false;

	_this setVariable ["DK_side", "civ", true];
	addToRemainsCollector [_this];
};

DK_fnc_LO_LJ = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");

	_this forceAddUniform "U_I_C_Soldier_Para_2_F";
	_this addVest "V_Pocketed_black_F";
	_this addGoggles "G_Sport_Blackred";
	_this addWeapon "arifle_AKM_F";

	_this setSkill 0.1;
	_this disableAI "AUTOCOMBAT";
	_this enableFatigue false;

	_this setVariable ["DK_side", "civ", true];

	[_this, "TanoanHead_A3_04"] remoteExecCall ["setFace", DK_isDedi, _this]; 
	addToRemainsCollector [_this];
};


DK_fnc_LO_amb_ArmyHeli_pilot = {


	_this setUnitLoadout (configFile >> "EmptyLoadout");

	// Uniform
	_this forceAddUniform "U_I_CombatUniform";

	// Helmet
	_this addHeadgear "H_PilotHelmetHeli_I";

	_this addGoggles "G_Bandanna_beast";

	_this addVest "V_PlateCarrierIA1_dgtl";


	// Weapon
	for "_i" from 1 to 3 do {_this addItemToUniform "50Rnd_570x28_SMG_03";};
	for "_i" from 1 to 5 do {_this addItemToVest "50Rnd_570x28_SMG_03";};
	for "_i" from 1 to 5 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 4 do {_this addItemToVest "HandGrenade";};

	[_this, "hgun_Pistol_heavy_02_F", 15, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
	_this addHandgunItem "optic_Yorris";

	_this addWeapon "SMG_03_TR_khaki";
	_this addPrimaryWeaponItem "50Rnd_570x28_SMG_03";

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
		_this addPrimaryWeaponItem "acc_flashlight";
	};

	addToRemainsCollector [_this];
};

DK_fnc_LO_amb_ArmyJet_pilot = {


	_this setUnitLoadout (configFile >> "EmptyLoadout");

	// Uniform
	_this forceAddUniform "U_I_pilotCoveralls";

	// Helmet
	_this addHeadgear "H_PilotHelmetFighter_I";


	// Weapon
	for "_i" from 1 to 3 do {_this addItemToUniform "50Rnd_570x28_SMG_03";};

	[_this, "hgun_Pistol_heavy_02_F", 15, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
	_this addHandgunItem "optic_Yorris";

	_this addWeapon "SMG_03_TR_khaki";
	_this addPrimaryWeaponItem "50Rnd_570x28_SMG_03";

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
		_this addPrimaryWeaponItem "acc_flashlight";
	};

	addToRemainsCollector [_this];
};


