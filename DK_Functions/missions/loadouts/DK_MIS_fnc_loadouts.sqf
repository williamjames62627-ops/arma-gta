if (!isServer) exitWith {};

///// /// FACES
#define afroFaceA ["AfricanHead_01", "AfricanHead_02", "AfricanHead_03"]
#define afroFaceB ["TanoanHead_A3_01", "TanoanHead_A3_02", "TanoanHead_A3_03", "TanoanHead_A3_04", "TanoanHead_A3_05", "TanoanHead_A3_06", "TanoanHead_A3_07", "TanoanHead_A3_08"]
#define asianFace ["AsianHead_A3_01", "AsianHead_A3_02", "AsianHead_A3_03", "AsianHead_A3_04", "AsianHead_A3_05", "AsianHead_A3_06", "AsianHead_A3_07"]



////////////////////////////
/////  CLOTHINGS GANGS  ///
//////////////////////////

// Thugs
#define DK_unifThugDel(STF) private _nul = DK_unifThug deleteAt (DK_unifThug find STF)
#define unifThug ["U_IG_Guerilla1_1", "U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_5_F","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_BG_Guerilla2_3","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_I_L_Uniform_01_tshirt_olive_F","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy"]
DK_unifThug = +unifThug;

#define vestBelt "V_Rangemaster_belt"
#define vestBando ["V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_rgr","V_BandollierB_khk"]

#define DK_headThugDel(STF) private _nul = DK_headThug deleteAt (DK_headThug find STF)
#define headThug ["G_Balaclava_blk","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"]
DK_headThug = +headThug;

#define DK_hatThugDel(STF) private _nul = DK_hatThug deleteAt (DK_hatThug find STF)
#define hatThug ["H_Beret_blk", "H_Cap_blk_CMMG", "H_Cap_blk", "H_Cap_oli", "H_Hat_Safari_olive_F", "H_Cap_grn", "H_Cap_red", "H_Cap_tan_specops_US", "H_Cap_tan", "H_Cap_khaki_specops_UK", "H_Cap_usblack", "H_Cap_blk_Raven", "H_Cap_brn_SPECOPS"]
DK_hatThug = +hatThug;


// Looter
#define DK_unifLooterDel(STF) private _nul = DK_unifLooter deleteAt (DK_unifLooter find STF)
#define unifLooter ["U_C_E_LooterJacket_01_F", "U_C_E_LooterJacket_01_F", "U_C_E_LooterJacket_01_F", "U_C_E_LooterJacket_01_F", "U_C_E_LooterJacket_01_F", "U_C_E_LooterJacket_01_F", "U_I_L_Uniform_01_tshirt_skull_F", "U_I_L_Uniform_01_tshirt_skull_F"]
DK_unifLooter = +unifLooter;


// Ballas
#define DK_unifBallasDel(STF) private _nul = DK_unifBallas deleteAt (DK_unifBallas find STF)
#define unifBallas ["U_C_Poor_1", "U_C_Poor_1", "U_C_Man_casual_4_F"]
DK_unifBallas = +unifBallas;

#define DK_hatBallasDel(STF) private _nul = DK_hatBallas deleteAt (DK_hatBallas find STF)
#define hatBallas ["H_Bandanna_blu", "H_Bandanna_blu", "H_Cap_blu"]
DK_hatBallas = +hatBallas;

#define headBallas ["G_Bandanna_aviator","G_Bandanna_blk"]


// Triads
#define hatTriads ["H_Bandanna_mcamo", "H_Bandanna_sand", "H_Booniehat_mcamo"]

#define DK_headTriadsDel(STF) private _nul = DK_headTriads deleteAt (DK_headTriads find STF)
#define headTriads ["G_Aviator", "G_Bandanna_beast", "G_Bandanna_shades", "G_Bandanna_sport", "G_Combat", "G_Shades_Black", "G_Shades_Red", "G_Sport_Blackred", "G_Goggles_VR"]
DK_headTriads = +headTriads;


// Dominicans
#define DK_unifDomiDel(STF) private _nul = DK_unifDomi deleteAt (DK_unifDomi find STF)
#define unifDomi ["U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Para_1_F", "U_BG_Guerilla1_2_F", "U_I_C_Soldier_Para_3_F"]
DK_unifDomi = +unifDomi;

#define vestMedDomi ["V_TacVest_oli", "V_TacVest_khk"]

#define hatDomi ["H_Cap_oli", "H_Booniehat_oli", "H_Bandanna_khk"]


// Albanians
#define DK_unifAlbanDel(STF) private _nul = DK_unifAlban deleteAt (DK_unifAlban find STF)
#define unifAlban ["U_B_CTRG_Soldier_2_F", "U_B_CTRG_Soldier_urb_2_F", "U_BG_Guerilla1_1", "U_BG_Guerilla2_1", "U_BG_Guerilla2_3", "U_I_C_Soldier_Para_5_F", "U_I_G_Story_Protagonist_F", "U_I_G_resistanceLeader_F", "U_I_C_Soldier_Bandit_3_F", "U_C_Mechanic_01_F"]
DK_unifAlban = +unifAlban;

#define vestMedAlban ["V_TacVest_camo", "V_TacVest_blk", "V_TacVest_brn"]

#define hatAlban ["H_Shemag_olive", "H_ShemagOpen_tan", "H_Shemag_olive", "H_ShemagOpen_tan", "H_ShemagOpen_khk"]


// VIP Civilians
#define DK_unifVIPcivDel(STF) private _nul = DK_unifVIPciv deleteAt (DK_unifVIPciv find STF)
#define unifVIPciv ["U_C_Journalist", "U_C_Uniform_Scientist_01_formal_F", "U_C_Uniform_Scientist_01_F", "U_NikosBody", "U_NikosAgedBody"]
DK_unifVIPciv = +unifVIPciv;


////////////////////////////
/////  WEAPONS GANG  //////
//////////////////////////

// Thugs (weapons)
#define DK_ThugHgunsSmgDel(STF) private _nul = DK_ThugHgunsSmg deleteAt (DK_ThugHgunsSmg find STF)
#define ThugHgunsSmg ["hgun_ACPC2_F", "hgun_P07_F", "hgun_Pistol_heavy_02_Yorris_F", "hgun_Rook40_F", "hgun_Pistol_01_F", "hgun_PDW2000_F", "hgun_ACPC2_F", "hgun_P07_F", "hgun_Pistol_heavy_02_Yorris_F", "hgun_Rook40_F", "hgun_Pistol_01_F", "hgun_PDW2000_F","sgun_HunterShotgun_01_F"]
DK_ThugHgunsSmg = +ThugHgunsSmg;

#define DK_ThugHgunsSmgsDel(STF) private _nul = DK_ThugHgunsSmgs deleteAt (DK_ThugHgunsSmgs find STF)
#define ThugHgunsSmgs ["hgun_ACPC2_F", "hgun_P07_F", "hgun_Pistol_heavy_02_Yorris_F", "hgun_Rook40_F", "hgun_Pistol_01_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "SMG_05_F", "SMG_05_F", "SMG_05_F"]
DK_ThugHgunsSmgs = +ThugHgunsSmgs;

#define DK_ThugSmgsDel(STF) private _nul = DK_ThugSmgs deleteAt (DK_ThugSmgs find STF)
#define ThugSmgs ["hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "SMG_05_F", "SMG_05_F", "SMG_05_F", "SMG_05_F"]
DK_ThugSmgs = (+ThugSmgs) + (+ThugHgunsSmgs) ;

#define DK_ThugMk20AKsMk14SmgsDel private _nul = DK_ThugMk20AKsMk14Smgs deleteAt 0
#define ThugMk20AKsMk14Smgs ["arifle_Mk20_plain_F", "arifle_Mk20_plain_F", "arifle_Mk20_F", "arifle_Mk20_F", "arifle_AKS_F", selectRandom ["srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F"], "SMG_05_F", "hgun_PDW2000_F"]
DK_ThugMk20AKsMk14Smgs = +ThugMk20AKsMk14Smgs;


// Looter (weapons)
#define DK_LooterSGsaweHgunDel(STF) private _nul = DK_LooterSGsaweHgun deleteAt (DK_LooterSGsaweHgun find STF)
#define LooterSGsaweHgun ["sgun_HunterShotgun_01_sawedoff_F", "sgun_HunterShotgun_01_sawedoff_F", "sgun_HunterShotgun_01_sawedoff_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_F"]
DK_LooterSGsaweHgun = +LooterSGsaweHgun;

#define DK_LooterSGmk14Del(STF) private _nul = DK_LooterSGmk14 deleteAt (DK_LooterSGmk14 find STF)
#define LooterSGmk14 ["sgun_HunterShotgun_01_sawedoff_F", "sgun_HunterShotgun_01_sawedoff_F", "sgun_HunterShotgun_01_sawedoff_F", "sgun_HunterShotgun_01_sawedoff_F", "sgun_HunterShotgun_01_sawedoff_F", "srifle_DMR_06_hunter_F", "srifle_DMR_06_hunter_F", "srifle_DMR_06_hunter_F"]
DK_LooterSGmk14 = +LooterSGmk14;


// Ballas (weapons)
#define DK_BallasSmgsMgDel(STF) private _nul = DK_BallasSmgsMg deleteAt (DK_BallasSmgsMg find STF)
#define BallasSmgsMg ["hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "hgun_PDW2000_F", "LMG_Mk200_F"]
DK_BallasSmgsMg = +BallasSmgsMg;

#define DK_BallasP90MarCyrusMxSWDel(STF) private _nul = DK_BallasP90MarCyrusMxSW deleteAt (DK_BallasP90MarCyrusMxSW find STF)
#define BallasP90MarCyrusMxSW ["SMG_03_black", "SMG_03_camo", "SMG_03_hex", selectRandom ["SMG_03_black", "SMG_03_camo", "SMG_03_hex"], "srifle_DMR_05_blk_F", "srifle_DMR_02_F", "arifle_MX_SW_F", "arifle_MX_SW_F"]
DK_BallasP90MarCyrusMxSW = +BallasP90MarCyrusMxSW;


// Triads (weapons)
#define DK_TriadsSmgsDel(STF) private _nul = DK_TriadsSmgs deleteAt (DK_TriadsSmgs find STF)
#define TriadsSmgs ["SMG_01_F", "SMG_01_F", "SMG_01_F", "SMG_01_F", "SMG_01_F", "SMG_01_F", "SMG_01_F", "SMG_01_F"]
DK_TriadsSmgs = +TriadsSmgs;

#define DK_TriadsSparCarAspDel private  _nul = DK_TriadsSparCarAsp deleteAt 0
#define TriadsSparCarAsp ["arifle_SPAR_01_snd_F", "arifle_SPAR_01_snd_F", "arifle_SPAR_01_snd_F", "arifle_CTAR_hex_F", "arifle_CTAR_hex_F", "arifle_CTAR_hex_F", "srifle_DMR_04_Tan_F", selectRandom ["arifle_SPAR_02_snd_F", "arifle_CTARS_hex_F"]]
DK_TriadsSparCarAsp = +TriadsSparCarAsp;


// Dominicans (weapons)
#define DK_DomiTrgMK14ZafirAADel(STF) private _nul = DK_DomiTrgMK14ZafirAA deleteAt (DK_DomiTrgMK14ZafirAA find STF)
#define DomiTrgMK14ZafirAA ["arifle_TRG20_F", "arifle_TRG20_F", "arifle_TRG20_F", "arifle_TRG20_F", "arifle_TRG20_F", "arifle_TRG20_F", selectRandom ["srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F"], "LMG_Zafir_F"]
DK_DomiTrgMK14ZafirAA = +DomiTrgMK14ZafirAA;


// Albanians (weapons)
#define DK_AlbanKalashsATAADel private _nul = DK_AlbanKalashsATAA deleteAt 0
#define AlbanKalashsATAA ["arifle_AKS_F", "arifle_AKM_F", "arifle_AK12_F", "arifle_AKS_F", "arifle_AKM_F", "arifle_AK12_F", "arifle_AK12U_F", "arifle_AK12_GL_F", "arifle_RPK12_F"]
DK_AlbanKalashsATAA = +AlbanKalashsATAA;


////////////////////////////////
/////  WEAPONS ORDER FORCES  //
//////////////////////////////

// Police (weapons)
#define policeHgun "hgun_Pistol_heavy_01_F"
#define policeSmg "SMG_05_F"
#define policeHgunsSmgs ["hgun_Pistol_heavy_01_F", "SMG_05_F"]

#define policeHeliHgun "hgun_ACPC2_F"
#define policeHeliSmg1 "SMG_05_F"
#define policeHeliSmg2 "SMG_02_F"

#define policeAcoGun "optic_MRD"
#define policeAcoSmg "optic_Aco_smg"
#define policeAco "optic_Aco"

// Army
#define DK_army_MRAPDel private _nul = DK_army_MRAP deleteAt 0
#define DK_army_ZamackDel private _nul = DK_army_Zamack deleteAt 0
#define armyCAR "arifle_CTAR_blk_F"
#define armyMK1 "srifle_DMR_03_khaki_F"
#define armyHMG "MMG_02_camo_F"
#define armyPrometSG "arifle_MSBS65_UBS_F"
#define armySparAT "arifle_SPAR_01_khk_F"

#define army_MRAP [armyCAR, armyHMG, armyMK1]
DK_army_MRAP = +army_MRAP;

#define army_Zamack [armyCAR, armyMK1, armyHMG, armyPrometSG, armySparAT]
DK_army_Zamack = +army_Zamack;



//////////////////////////
/////  REWARDS BOX   /////
//////////////////////////

// items
#define items_dot ["optic_Holosight", "optic_ACO_grn"]
#define items_dot_smg ["optic_Holosight_smg", "optic_ACO_grn_smg"]
#define items_scope2x ["optic_Arco", "optic_MRCO", "optic_Hamr"]
#define items_scopeArmy2x "optic_Arco_blk_F"
#define items_scopeFBI2x "optic_Arco_blk_F"
#define items_scopeArmyXx "optic_AMS"
#define items_scopeXx ["optic_SOS", "optic_DMS"]
#define items_scopeXxDLC ["optic_SOS", "optic_SOS", "optic_SOS", "optic_KHS_blk", "optic_KHS_blk", "optic_KHS_blk", "optic_DMS", "optic_DMS", "optic_DMS", "optic_AMS", "optic_AMS_snd", "optic_AMS_khk"]
#define items_supp_45 "muzzle_snds_acp"
#define items_supp_9m "muzzle_snds_L"

// AR short or medium caliber
#define wpns_5x56_c ["arifle_Mk20C_plain_F", "arifle_Mk20C_F", "arifle_TRG20_F", "arifle_TRG20_F"]
#define wpns_5x56 ["arifle_Mk20_plain_F", "arifle_Mk20_F", "arifle_TRG21_F", "arifle_TRG21_F"]
#define wpns_5x56_gl ["arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_F", "arifle_TRG21_GL_F", "arifle_TRG21_GL_F"]
#define wpns_Spar_c ["arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F"]
#define wpns_Spar_gl ["arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F"]
#define wpns_Spar_lmg "arifle_SPAR_02_snd_F"
#define wpns_Car_c ["arifle_CTAR_blk_F", "arifle_CTAR_ghex_F", "arifle_CTAR_hex_F"]
#define wpns_Car_gl ["arifle_CTAR_GL_blk_F", "arifle_CTAR_GL_ghex_F", "arifle_CTAR_GL_hex_F"]
#define wpns_Car_lmg "arifle_CTARS_ghex_F"
#define wpns_P90_c ["SMG_03C_TR_black", "SMG_03C_TR_camo", "SMG_03C_TR_hex", "SMG_03C_TR_khaki"]
#define wpns_P90 ["SMG_03_black", "SMG_03_camo", "SMG_03_khaki", "SMG_03_hex"]
#define wpns_MX_c ["arifle_MXC_Black_F", "arifle_MXC_F"]
#define wpns_MX_gl ["arifle_MX_GL_F", "arifle_MX_GL_Black_F"]
#define wpns_Kat_c "arifle_Katiba_C_F"
#define wpns_Kat_gl "arifle_Katiba_GL_F"
#define wpnsArmy_Spar_gl "arifle_SPAR_01_GL_khk_F"
#define wpnsArmy_TRG_gl "arifle_TRG21_GL_F"
#define wpnsArmy_Promet_gl "arifle_MSBS65_GL_F"
#define wpnsArmy_MX_gl "arifle_MX_GL_Black_F"

// Machin Gun
#define wpns_Lim "LMG_03_F"
#define wpns_Mk200 "LMG_Mk200_F"

// Marksmen (vanilla)
#define wpns_Mk18 "srifle_EBR_F"
#define wpns_MX_M ["arifle_MXM_F", "arifle_MXM_Black_F"]
#define wpns_Rahim "srifle_DMR_01_F"
#define wpns_Kat "arifle_Katiba_F"
// Marksmen (DLCs)
#define wpns_Cyrius ["srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f"]
#define wpnsArmy_Mar10 "srifle_DMR_02_camo_F"
#define wpns_Mar10 ["srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F"]
#define wpns_Mk14 ["srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F"]
#define wpns_CMR ["srifle_DMR_07_ghex_F", "srifle_DMR_07_hex_F"]
#define wpns_Spar ["arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F"]

// Sniper Rifle (vanilla)
#define wpns_Lynx ["srifle_GM6_F", "srifle_GM6_camo_F"]
#define wpns_M320 ["srifle_LRR_F", "srifle_LRR_camo_F"]

// Launcher AA
#define lnchrArmy_AA "launch_I_Titan_F"
#define lnchr_AA ["launch_I_Titan_F", "launch_O_Titan_F", "launch_B_Titan_F"]

// Launcher AT
#define lnchrArmy_MRAWS ["launch_MRAWS_green_rail_F", "launch_MRAWS_green_F"]
#define lnchr_MRAWS ["launch_MRAWS_green_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_olive_F", "launch_MRAWS_sand_rail_F", "launch_MRAWS_sand_F"]

#define lnchrArmy_Verona "launch_O_Vorona_green_F"
#define lnchr_Verona ["launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"]

#define lnchrArmy_RPG32 "launch_RPG32_green_F"
#define lnchr_RPG32 ["launch_RPG32_green_F", "launch_RPG32_ghex_F", "launch_RPG32_F"]


// Select right unit loadout
DK_MIS_fnc_slctUnitsLO = {

	params ["_allUnits", "_uniform", "_weapons", "_vest", "_nbUnits"];


	private "_nil";

	if (isNil "_nbUnits") then
	{
		_nbUnits = count _allUnits;
	};

	_allUnits apply
	{
		_x addRating 2000;
		_x call DK_fnc_addEH_getInMan_dynSim;
	};

	switch ( _uniform ) do
	{
		case "uniform_thug_N1" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Thug;
				_x allowFleeing 0.3;

				uiSleep	0.06;	// Sleep for performance
			};
			
		};

		case "uniform_thug_N2" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest,nil,2] call DK_fnc_LO_Thug;
				_x allowFleeing 0.2;

				uiSleep	0.06;	// Sleep for performance
			};

			if (_weapons isEqualTo "wpns_Mk20AKsMk14SmgsAT") then
			{
				if !(_allUnits # 0 getVariable ["DK_roleUnit", ""] isEqualTo "isRfr") then
				{
					(_allUnits # 0) call DK_fnc_LO_addAT_1;
				};
			};
		};

		case "uniform_looter" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Looter;
				_x allowFleeing 0.2;

				uiSleep	0.06;	// Sleep for performance
			};
			
		};

		case "uniform_Ballas" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Ballas;
				_x allowFleeing 0.15;

				uiSleep	0.06;	// Sleep for performance
			};
			
		};

		case "uniform_Triads" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Triads;
				_x allowFleeing 0.3;

				uiSleep	0.06;	// Sleep for performance
			};

			call
			{
				if (_weapons isEqualTo "wpns_TriadsSmgsAT") exitWith
				{
					(_allUnits # 0) call DK_fnc_LO_addAT_1;

					if (_nbUnits > 13) then
					{
						(_allUnits # 13) call DK_fnc_LO_addAT_1;
					};
				};

				if (_weapons isEqualTo "wpns_TriadsSparCarAspAT") then
				{
					(_allUnits # 0) call DK_fnc_LO_addAT_1;

					if (_nbUnits > 13) then
					{
						(_allUnits # 13) call DK_fnc_LO_addAT_1;
					};
				};
			};
		};

		case "uniform_Dominicans" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Dominicans;
				_x allowFleeing 0.1;

				uiSleep	0.06;	// Sleep for performance
			};

			if (_weapons isEqualTo "wpns_DomiTrgMK14ZafirAA") then
			{
				(_allUnits # 0) call DK_fnc_LO_addAA;

				if (_nbUnits > 14) then
				{
					(_allUnits # 14) call DK_fnc_LO_addAA;
				};
			};	
		};

		case "uniform_Albanians" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Albanians;
				_x allowFleeing 0.1;

				uiSleep	0.06;	// Sleep for performance
			};

			if (_weapons isEqualTo "wpns_AlbanKalashsATAA") then
			{
				if !(_allUnits # 0 getVariable ["DK_roleUnit", ""] isEqualTo "isRfr") then
				{
					(_allUnits # 0) call DK_fnc_LO_addAT_1;

					if (_nbUnits > 8) then
					{
						(_allUnits # 8) call DK_fnc_LO_addAA;
					};
				};
			};	
		};

		case "uniform_Police" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_Police;
				_x allowFleeing 0.1;

				uiSleep	0.06;
			};
		};

		case "uniform_FBI" :
		{
			_allUnits apply
			{
				[_x,_weapons,_vest] call DK_fnc_LO_FBI;
				_x allowFleeing 0.1;

				uiSleep	0.06;
			};
		};

		case "uniform_Army_Zamack" :
		{
			_allUnits apply
			{
				[_x] call DK_fnc_LO_Army_Zamack;
				_x allowFleeing 0.05;

				uiSleep	0.06;
			};
		};

		case "uniform_Army_MRAP" :
		{
			_allUnits apply
			{
				[_x] call DK_fnc_LO_Army_MRAP;
				_x allowFleeing 0.05;

				uiSleep	0.06;
			};
		};

		case "uniform_Army_Default" :
		{
			_allUnits apply
			{
				[_x] call DK_fnc_LO_Army_Default;
				_x allowFleeing 0.05;

				uiSleep	0.06;
			};
		};

		case "C_Plane_Civil_01_racing_F" ;
		case "C_Heli_Light_01_civil_F" :
		{
			_allUnits apply
			{
				_x call DK_fnc_LO_VIPciv;
				_x allowFleeing 0.2;

				uiSleep	0.06;
			};
		};

		case "O_Heli_Transport_04_medevac_F" :
		{
			_allUnits apply
			{
				_x call DK_fnc_LO_VIPmed;
				_x allowFleeing 0.3;

				uiSleep	0.06;
			};
		};

		case "C_IDAP_Heli_Transport_02_F" :
		{
			_allUnits apply
			{
				_x call DK_fnc_LO_VIPidap;
				_x allowFleeing 0.3;

				uiSleep	0.06;
			};
		};
	};
};


/////// Ennemies Gangs & Order Forces
DK_fnc_LO_Thug = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_bandoBelt") then
	{
		_unit call DK_fnc_LO_vest_bandoBelt;
	};

	// Uniform
	private _uniform = selectRandom DK_unifThug;
	DK_unifThugDel(_uniform);
	_unit forceAddUniform _uniform;

	if (DK_unifThug isEqualTo []) then
	{
		DK_unifThug = +unifThug;
		DK_unifThugDel(_uniform);
	};

	// Head
	if (_niv isEqualTo 2) then
	{
		private _head = selectRandom DK_headThug;
		DK_headThugDel(_head);
		_unit addGoggles _head;

		if (DK_headThug isEqualTo []) then
		{
			DK_headThug = +headThug;
			DK_headThugDel(_head);
		};
	}
	else
	{
		if (selectRandom [true,false]) then
		{
			private _hat = selectRandom DK_hatThug;
			_unit addHeadgear _hat;

			DK_hatThugDel(_hat);

			if (DK_hatThug isEqualTo []) then
			{
				DK_hatThug = +hatThug;
				DK_hatThugDel(_hat);
			};
		};
	};

///	// Weapon
	private _gangSide = "mis_thug";
	call
	{
		if (_wpnLvl isEqualTo "wpns_hgunsSmg") exitWith
		{
			private _weapon = selectRandom DK_ThugHgunsSmg;
			DK_ThugHgunsSmgDel(_weapon);

			if (DK_ThugHgunsSmg isEqualTo []) then
			{
				DK_ThugHgunsSmg = +ThugHgunsSmg;
			};

			if (_weapon in ["hgun_P07_F","hgun_Rook40_F"]) then
			{
				_ammoStyle = "30Rnd_9x21_Yellow_Mag";
			};

			[_unit,_weapon,2,_ammoStyle] call BIS_fnc_addWeapon;
		};

		if (_wpnLvl isEqualTo "wpns_hgunsSmgs") exitWith
		{
			private _weapon = selectRandom DK_ThugHgunsSmgs;
			DK_ThugHgunsSmgsDel(_weapon);

			if (DK_ThugHgunsSmgs isEqualTo []) then
			{
				DK_ThugHgunsSmgs = +ThugHgunsSmgs;
			};

			call
			{
				if (_weapon in ["hgun_P07_F","hgun_Rook40_F"]) exitWith
				{
					_ammoStyle = "30Rnd_9x21_Yellow_Mag";
				};

				if (_weapon isEqualTo "SMG_05_F") exitWith
				{
					_ammoStyle = "30Rnd_9x21_Mag_SMG_02";
				};

				if (_weapon isEqualTo "hgun_PDW2000_F") then
				{
					_ammoStyle = "30Rnd_9x21_Mag";
				};
			};

			[_unit,_weapon,2,_ammoStyle] call BIS_fnc_addWeapon;
		};

		if (_wpnLvl isEqualTo "wpns_smgs") exitWith
		{
			private _weapon = selectRandom DK_ThugSmgs;
			DK_ThugSmgsDel(_weapon);

			if (DK_ThugSmgs isEqualTo []) then
			{
				DK_ThugSmgs = +ThugSmgs;
			};

			call
			{
				if (_weapon in ["hgun_P07_F","hgun_Rook40_F"]) exitWith
				{
					_ammoStyle = "30Rnd_9x21_Yellow_Mag";
				};

				if (_weapon isEqualTo "SMG_05_F") exitWith
				{
					_ammoStyle = "30Rnd_9x21_Mag_SMG_02";
				};

				if (_weapon isEqualTo "hgun_PDW2000_F") then
				{
					_ammoStyle = "30Rnd_9x21_Mag";
				};
			};

			[_unit,_weapon,2,_ammoStyle] call BIS_fnc_addWeapon;
		};

		if (_wpnLvl isEqualTo "wpns_Mk20AKsMk14SmgsAT") then
		{
			private _weapon = DK_ThugMk20AKsMk14Smgs # 0;
			DK_ThugMk20AKsMk14SmgsDel;

			if (DK_ThugMk20AKsMk14Smgs isEqualTo []) then
			{
				DK_ThugMk20AKsMk14Smgs = +ThugMk20AKsMk14Smgs;
			};

			call
			{
				if (_weapon isEqualTo "arifle_AKS_F") exitWith
				{
					[_unit,_weapon,4,"30Rnd_545x39_Mag_F"] call BIS_fnc_addWeapon;
					_gangSide = "mis_thug2";
				};

				if (_weapon in wpns_5x56) exitWith
				{
					[_unit,_weapon,3,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
					_gangSide = "mis_thug2";
				};

				if (_weapon in ["srifle_DMR_06_camo_F","srifle_DMR_06_olive_F"]) exitWith
				{
					[_unit,_weapon,4,"20Rnd_762x51_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom (selectRandom [items_dot,items_scope2x]));
					_gangSide = "mis_thug2";
				};

				if (_weapon isEqualTo "hgun_PDW2000_F") exitWith
				{
					[_unit,_weapon,4,"30Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot_smg);
					_unit addPrimaryWeaponItem items_supp_9m;
				};

				if (_weapon isEqualTo "SMG_05_F") then
				{
					[_unit,_weapon,4,"30Rnd_9x21_Mag_SMG_02"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot_smg);
					_unit addPrimaryWeaponItem items_supp_9m;
				};
			};
		};
	};

	_unit call DK_MIS_fnc_skillThug;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillThug];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";
	_unit setVariable ["pitch", 0.95 + (random 0.10)];

	_unit setVariable ["DK_side", _gangSide, true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrThug];
	_unit setVariable ["DK_scoreScd", DK_scrThugScd];

///	// Set random face white or black
	if (selectRandom [true,false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

};

DK_fnc_LO_Looter = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Uniform
	private _uniform = selectRandom DK_unifLooter;
	DK_unifLooterDel(_uniform);
	_unit forceAddUniform _uniform;

	if (DK_unifLooter isEqualTo []) then
	{
		DK_unifLooter = +unifLooter;
		DK_unifLooterDel(_uniform);
	};

	// Vest (gilet)
	if ( (_vest isEqualTo "vest_bando") && { (_uniform isEqualTo "U_I_L_Uniform_01_tshirt_skull_F") } ) then
	{
		_unit addVest "V_BandollierB_blk";
	};

	// Head
	if (selectRandom [true, false, false, false]) then
	{
		_unit addGoggles "G_Aviator";
	};
	if (selectRandom [true, false, false, false]) then
	{
		_unit addHeadgear "H_Bandanna_gry";
	};


///	// Weapon
	private _gangSide = "mis_Looter";
	call
	{
		if (_wpnLvl isEqualTo "wpns_SGsaweHgun") exitWith
		{
			private _weapon = selectRandom DK_LooterSGsaweHgun;
			DK_LooterSGsaweHgunDel(_weapon);

			if (DK_LooterSGsaweHgun isEqualTo []) then
			{
				DK_LooterSGsaweHgun = +LooterSGsaweHgun;
			};

			if (_weapon isEqualTo "sgun_HunterShotgun_01_sawedoff_F") then
			{
				[_unit, _weapon, 5, "2Rnd_12Gauge_Pellets"] call BIS_fnc_addWeapon;
			}
			else
			{
				[_unit, _weapon, 7, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
			};
		};

		if (_wpnLvl isEqualTo "wpns_SGmk14") exitWith
		{
			private _weapon = selectRandom DK_LooterSGmk14;
			DK_LooterSGmk14Del(_weapon);

			if (DK_LooterSGmk14 isEqualTo []) then
			{
				DK_LooterSGmk14 = +LooterSGmk14;
			};

			if (_weapon isEqualTo "sgun_HunterShotgun_01_sawedoff_F") then
			{
				[_unit, _weapon, 5, "2Rnd_12Gauge_Pellets"] call BIS_fnc_addWeapon;
			}
			else
			{
				[_unit, _weapon, 5, "10Rnd_Mk14_762x51_Mag"] call BIS_fnc_addWeapon;
			};
		};
	};

	_unit call DK_MIS_fnc_skillLooter;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillLooter];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";
	_unit setVariable ["pitch", 0.95 + (random 0.10)];

	_unit setVariable ["DK_side", _gangSide, true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrLooter];
	_unit setVariable ["DK_scoreScd", DK_scrLooterScd];

///	// Set random face white or black
/*	if (selectRandom [true,false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};
*/
};


DK_fnc_LO_Ballas = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_bando") then
	{
		_unit call DK_fnc_LO_vest_bando;
	};

	// Uniform
	private _uniform = selectRandom DK_unifBallas;
	DK_unifBallasDel(_uniform);
	_unit forceAddUniform _uniform;

	if (DK_unifBallas isEqualTo []) then
	{
		DK_unifBallas = +unifBallas;
		DK_unifBallasDel(_uniform);
	};

	// Face
	_unit addGoggles (selectRandom headBallas);

	// Head
	private _hat = selectRandom DK_hatBallas;
	_unit addHeadgear _hat;
	DK_hatBallasDel(_hat);

	if (DK_hatBallas isEqualTo []) then
	{
		DK_hatBallas =	+hatBallas;
		DK_hatBallasDel(_hat);
	};

///	// Weapon
	private _gangSide = "mis_ballas";
	call
	{
		if (_wpnLvl isEqualTo "wpns_BallasSmgsMg") exitWith
		{
			private _weapon = DK_BallasSmgsMg # 0; 
			DK_BallasSmgsMgDel(_weapon);

			if (DK_BallasSmgsMg isEqualTo []) then
			{
				DK_BallasSmgsMg = +BallasSmgsMg;
			};

			call
			{
				if (_weapon isEqualTo "hgun_PDW2000_F") exitWith
				{
					[_unit,_weapon,2,"30Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot_smg);
				};

				if (_weapon isEqualTo "LMG_Mk200_F") then
				{
					[_unit,_weapon,2,"200Rnd_65x39_cased_Box_Tracer"] call BIS_fnc_addWeapon;
					_gangSide = "mis_ballas2";
				};
			};
		};

		if (_wpnLvl isEqualTo "wpns_BallasP90MarCyrusMxSW") then
		{
			private _weapon = DK_BallasP90MarCyrusMxSW # 0; 
			DK_BallasP90MarCyrusMxSWDel(_weapon);

			if (DK_BallasP90MarCyrusMxSW isEqualTo []) then
			{
				DK_BallasP90MarCyrusMxSW = +BallasP90MarCyrusMxSW;
			};

			call
			{
				if (_weapon in wpns_P90) exitWith
				{
					[_unit,_weapon,5,"50Rnd_570x28_SMG_03"] call BIS_fnc_addWeapon;
				};

				if (_weapon isEqualTo "srifle_DMR_05_blk_F") exitWith
				{
					[_unit,_weapon,5,"10Rnd_93x64_DMR_05_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom (selectRandom [items_dot,items_scope2x]));
				};

				if (_weapon isEqualTo "srifle_DMR_02_F") exitWith
				{
					[_unit,_weapon,4,"10Rnd_338_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom (selectRandom [items_dot,items_scope2x]));
				};

				if (_weapon isEqualTo "arifle_MX_SW_F") then
				{
					[_unit,_weapon,2,"100Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
					_unit addPrimaryWeaponItem "bipod_01_F_snd";
				};
			};

			_gangSide = "mis_ballas2";
		};

	};

	_unit call DK_MIS_fnc_skillBallas;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillBallas];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";
	_unit setVariable ["pitch", 0.95 + (random 0.10)];

	_unit setVariable ["DK_side", _gangSide, true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrBallas];
	_unit setVariable ["DK_scoreScd", DK_scrBallasScd];

///	// Set random face white or black
	if (selectRandom [true,true,true,true,true,true,true,false]) then
	{
		_afroFace = selectRandom afroFaceA;

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

};

DK_fnc_LO_Triads = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_belt") then
	{
		_unit call DK_fnc_LO_vest_belt;
	};

	// Uniform
	_unit forceAddUniform "U_OrestesBody";

	// Face
	if (selectRandom [true,true,false]) then
	{
		private _gogles = selectRandom DK_headTriads;
		_unit addGoggles _gogles;
		DK_headTriadsDel(_gogles);

		if (DK_headTriads isEqualTo []) then
		{
			DK_headTriads =	+headTriads;
			DK_headTriadsDel(_gogles);
		};
	};

	// Head
	_unit addHeadgear (selectRandom hatTriads);

///	// Weapon
	private _gangSide = "mis_triads";
	call
	{
		if (_wpnLvl isEqualTo "wpns_TriadsSmgsAT") exitWith
		{
			private _weapon = DK_TriadsSmgs # 0; 
			DK_TriadsSmgsDel(_weapon);

			if (DK_TriadsSmgs isEqualTo []) then
			{
				DK_TriadsSmgs = +TriadsSmgs;
			};

			call
			{
				if (_weapon isEqualTo "SMG_01_F") exitWith
				{
					[_unit,_weapon,2,"30Rnd_45ACP_Mag_SMG_01"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot_smg);
				};

				if (_weapon isEqualTo "hgun_PDW2000_F") then
				{
					[_unit,_weapon,2,"30Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot_smg);
				};
			};
		};

		if (_wpnLvl isEqualTo "wpns_TriadsSparCarAspAT") then
		{
			private _weapon = DK_TriadsSparCarAsp # 0; 
			DK_TriadsSparCarAspDel;

			if (DK_TriadsSparCarAsp isEqualTo []) then
			{
				DK_TriadsSparCarAsp = +TriadsSparCarAsp;
			};

			call
			{
				if (_weapon isEqualTo "arifle_SPAR_01_snd_F") exitWith
				{
					[_unit,_weapon,2,"30Rnd_556x45_Stanag_Sand"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};

				if (_weapon isEqualTo "arifle_CTAR_hex_F") exitWith
				{
					[_unit,_weapon,2,"30Rnd_580x42_Mag_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};

				if (_weapon isEqualTo "srifle_DMR_04_Tan_F") exitWith
				{
					[_unit,_weapon,3,"10Rnd_127x54_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem "bipod_02_F_tan";
					_unit addPrimaryWeaponItem (selectRandom items_scope2x);
				};

				if (_weapon isEqualTo "arifle_SPAR_02_snd_F") exitWith
				{
					[_unit,_weapon,1,"150Rnd_556x45_Drum_Sand_Mag_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem "bipod_02_F_tan";
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};

				if (_weapon isEqualTo "arifle_CTARS_hex_F") then
				{
					[_unit,_weapon,2,"100Rnd_580x42_hex_Mag_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};
			};

			_gangSide = "mis_triads2";
		};

	};

	_unit call DK_MIS_fnc_skillTriads;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillTriads];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";
	_unit setVariable ["pitch", 0.95 + (random 0.10)];

	_unit setVariable ["DK_side", _gangSide, true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrTriads];
	_unit setVariable ["DK_scoreScd", DK_scrTriadsScd];

///	// Set random face occi or asian
	if (selectRandom [true,true,true,true,true,true,true,true,true,true,true,true,true,false]) then
	{
		_asianFace = selectRandom asianFace;

		[_unit, _asianFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

};


DK_fnc_LO_Dominicans = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_mediumDomi") then
	{
		_unit call DK_fnc_LO_vest_mediumDomi;
	};

	// Uniform
	private _uniform = selectRandom DK_unifDomi;
	DK_unifDomiDel(_uniform);
	_unit forceAddUniform _uniform;

	if (DK_unifDomi isEqualTo []) then
	{
		DK_unifDomi = +unifDomi;
		DK_unifDomiDel(_uniform);
	};

	// Head
	_unit addHeadgear (selectRandom hatDomi);

///	// Weapon
	call
	{
		if (_wpnLvl isEqualTo "wpns_DomiTrgMK14ZafirAA") exitWith
		{
			private _weapon = DK_DomiTrgMK14ZafirAA # 0; 
			DK_DomiTrgMK14ZafirAADel(_weapon);

			if (DK_DomiTrgMK14ZafirAA isEqualTo []) then
			{
				DK_DomiTrgMK14ZafirAA = +DomiTrgMK14ZafirAA;
			};

			switch (_weapon) do
			{
				case "arifle_TRG20_F" :
				{
					[_unit,_weapon,4,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};

				case "srifle_DMR_06_camo_F" :
				{
					[_unit,_weapon,4,"20Rnd_762x51_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom (selectRandom [items_dot,items_scope2x]));
				};

				case "srifle_DMR_06_olive_F" :
				{
					[_unit,_weapon,4,"20Rnd_762x51_Mag"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom (selectRandom [items_dot,items_scope2x]));
				};

				case "LMG_Zafir_F" :
				{
					[_unit,_weapon,2,"150Rnd_762x54_Box_Tracer"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem "optic_Holosight";
				};
			};


		};
	};

	_unit call DK_MIS_fnc_skillDomi;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillDomi];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";
	_unit setVariable ["pitch", 0.95 + (random 0.10)];

	_unit setVariable ["DK_side", "mis_domi", true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrDomi];
	_unit setVariable ["DK_scoreScd", DK_scrDomiScd];

///	// Set random face occi or isles
	if (selectRandom [true,true,true,true,true,true,true,true,true,false]) then
	{
		_afroFace = selectRandom afroFaceB;

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

};

DK_fnc_LO_DomiHeli_pilot = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";

///	// Clothing

	// Uniform
	_this forceAddUniform (selectRandom DK_unifDomi);

	// Head
	_this addHeadgear (selectRandom hatDomi);

	// Glasse
	_this addGoggles "G_Aviator";


///	// Weapon
	[_this, "hgun_Pistol_heavy_02_F", 9, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
		_this enableGunLights "forceOn";
	};


	_this call DK_MIS_fnc_skillGunnerVeh;
	_this setVariable ["DK_skill", DK_MIS_fnc_skillGunnerVeh];
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";
	_this setVariable ["pitch", 0.95 + (random 0.10)];

	_this setVariable ["DK_side", "mis_alban", true];
	_this setVariable ["DK_stance", "UP"];
	_this setVariable ["DK_score", DK_scrAlban];
	_this setVariable ["DK_scoreScd", DK_scrAlbanScd];
};


DK_fnc_LO_Albanians = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_mediumAlban") then
	{
		_unit call DK_fnc_LO_vest_mediumAlban;
	};

	// Uniform
	private _uniform = selectRandom DK_unifAlban;
	DK_unifAlbanDel(_uniform);
	_unit forceAddUniform _uniform;

	if (DK_unifAlban isEqualTo []) then
	{
		DK_unifAlban = +unifAlban;
		DK_unifAlbanDel(_uniform);
	};

	// Head
	private _hat = selectRandom hatAlban;
	_unit addHeadgear _hat;

///	// Weapon
	call
	{
		if (_wpnLvl isEqualTo "wpns_AlbanKalashsATAA") exitWith
		{
			private _weapon = DK_AlbanKalashsATAA # 0; 
			DK_AlbanKalashsATAADel;

			if (DK_AlbanKalashsATAA isEqualTo []) then
			{
				DK_AlbanKalashsATAA = +AlbanKalashsATAA;
			};

			switch (_weapon) do
			{
				case "arifle_AKS_F" :
				{
					[_unit,_weapon,4,"30Rnd_545x39_Mag_F"] call BIS_fnc_addWeapon;
				};

				case "arifle_AKM_F" :
				{
					[_unit,_weapon,4,"30Rnd_762x39_Mag_F"] call BIS_fnc_addWeapon;
				};

				case "arifle_AK12_F" :
				{
					[_unit,_weapon,4,"30Rnd_762x39_Mag_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};

				case "arifle_AK12U_F" :
				{
					[_unit,_weapon,4,"30Rnd_762x39_AK12_Mag_Tracer_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};

				case "arifle_AK12_GL_F" :
				{
					[_unit,_weapon,4,"30Rnd_762x39_Mag_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
					for "_i" from 1 to 6 do { _unit addItemToVest "1Rnd_HE_Grenade_shell"; };
				};

				case "arifle_RPK12_F" :
				{
					[_unit, _weapon, 4, "75Rnd_762x39_Mag_Tracer_F"] call BIS_fnc_addWeapon;
					_unit addPrimaryWeaponItem (selectRandom items_dot);
				};
			};
		};
	};

	_unit call DK_MIS_fnc_skillAlban;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillAlban];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";
	_unit setVariable ["pitch", 0.95 + (random 0.10)];

	_unit setVariable ["DK_side", "mis_alban", true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrAlban];
	_unit setVariable ["DK_scoreScd", DK_scrAlbanScd];

};

DK_fnc_LO_AlbanHeli_pilot = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";

///	// Clothing

	// Uniform
	_this forceAddUniform (selectRandom ["U_I_G_resistanceLeader_F", "U_I_G_Story_Protagonist_F"]);

	// Head
	_this addHeadgear (selectRandom hatAlban);

	// Glasse
	_this addGoggles "G_Aviator";


///	// Weapon
	[_this, "hgun_Pistol_heavy_02_F", 9, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
		_this enableGunLights "forceOn";
	};


	_this call DK_MIS_fnc_skillAlban;
	_this setVariable ["DK_skill", DK_MIS_fnc_skillAlban];
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";
	_this setVariable ["pitch", 0.95 + (random 0.10)];

	_this setVariable ["DK_side", "mis_alban", true];
	_this setVariable ["DK_stance", "UP"];
	_this setVariable ["DK_score", DK_scrAlban];
	_this setVariable ["DK_scoreScd", DK_scrAlbanScd];
};

DK_fnc_LO_addAT_1 = {

	_this addBackpack "B_FieldPack_ocamo";

	call
	{
		if (call DK_fnc_allPlayersHaveDLC_apex) exitWith
		{
			for "_i" from 1 to 3 do
			{
				_this addItemToBackpack "RPG7_F";
			};

			_this addWeapon "launch_RPG7_F";
		};

		for "_i" from 1 to 3 do
		{
			_this addItemToBackpack "RPG32_F";
		};

		_this addWeapon "launch_RPG32_F";
	};

//	_this setSkill ["aimingAccuracy", 0.06];
//	_this setSkill ["aimingSpeed", 0.6];

};

DK_fnc_LO_addAA = {

	_this addBackpack "B_FieldPack_cbr";

	for "_i" from 1 to 2 do
	{
		_this addItemToBackpack "Titan_AA";
	};

	_this addWeapon "launch_B_Titan_F";

//	_this setSkill ["aimingAccuracy", 0.06];
//	_this setSkill ["aimingSpeed", 0.6];

};


DK_fnc_LO_leaders = {

	params ["", ""];


	{
		call
		{
			private _side = _x getVariable ["DK_side", ""];

			if (_side isEqualTo "mis_Looter") exitWith
			{
				_x forceAddUniform "U_I_L_Uniform_01_tshirt_skull_F";
				_x addHeadgear "H_Helmet_Skate";
				_x addVest "V_RebreatherB";
				_x addItemToUniform "2Rnd_12Gauge_Pellets";
			};

			if (_side isEqualTo "mis_thug") exitWith
			{
				_x addHeadgear "H_Helmet_Skate";
				_x addVest "V_RebreatherIR";
			};

			if (_side in ["mis_ballas", "mis_ballas2", "mis_thug2"]) exitWith
			{
				_x addHeadgear "H_HelmetB_grass";
				_x addVest (selectRandom ["V_TacVest_khk", "V_TacVest_camo"]);
			};

			if (_side in ["mis_triads", "mis_triads2"]) exitWith
			{
				_x addHeadgear "H_HelmetB_sand";
				_x addVest (selectRandom ["V_TacVest_brn", "V_TacVest_oli"]);
			};

			if (_side isEqualTo "mis_domi") exitWith
			{
				_x addHeadgear "H_HelmetSpecB_blk";
				_x addVest "V_PlateCarrierH_CTRG";
			};

			if (_side isEqualTo "mis_alban") then
			{
				_x addHeadgear "H_HelmetSpecB_paint2";
				_x addVest "V_PlateCarrier2_rgr";
			};
		};

		uiSleep 0.5;

	} count _this;
};

DK_fnc_LO_vest_bandoBelt = {

	_this call (selectRandom [DK_fnc_LO_vest_bando, DK_fnc_LO_vest_belt]);
};

DK_fnc_LO_vest_bando = {

	_this addVest (selectRandom vestBando);
};

DK_fnc_LO_vest_belt = {

	_this addVest vestBelt;
};

DK_fnc_LO_vest_mediumDomi = {

	_this addVest (selectRandom vestMedDomi);
};

DK_fnc_LO_vest_mediumAlban = {

	_this addVest (selectRandom vestMedAlban);
};



DK_fnc_LO_Police = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_mediumPolice") then
	{
		_unit addVest "V_TacVest_blk_POLICE";
	};

	// Uniform
	_unit forceAddUniform "U_C_Journalist";

	// Head
	_unit addHeadgear "H_Cap_police";

	// Glasse
	if (selectRandom [true,true,false]) then
	{
		_unit addGoggles "G_Aviator";
	};


	// Weapon
	call
	{
		if (_wpnLvl isEqualTo "wpns_smgs") exitWith
		{
			[_unit, policeSmg, 10, "30Rnd_9x21_Mag_SMG_02_Tracer_Green"] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem policeAcoSmg;

			if (call DK_fnc_checkIfNight) then
			{
				_unit addPrimaryWeaponItem "acc_flashlight";	
				_unit enableGunLights "forceOn";
			};

			_unit call DK_fnc_forceSingleFire;
		};

		if (_wpnLvl isEqualTo "wpns_hgunsSmgs") exitWith
		{
			private _weapon = selectRandom policeHgunsSmgs;

			if (_weapon isEqualTo policeHgun) exitWith
			{
				[_unit, _weapon, 10, "11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
				_unit addHandgunItem policeAcoGun;

				if (call DK_fnc_checkIfNight) then
				{
					_unit addHandgunItem "acc_flashlight_pistol";	
					_unit enableGunLights "forceOn";
				};
			};

			[_unit, _weapon, 10, "30Rnd_9x21_Mag_SMG_02_Tracer_Green"] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem policeAcoSmg;

			if (call DK_fnc_checkIfNight) then
			{
				_unit addPrimaryWeaponItem "acc_flashlight";	
				_unit enableGunLights "forceOn";
			};

			_unit call DK_fnc_forceSingleFire;
		};

		if (_wpnLvl isEqualTo "wpns_hguns") then
		{
			[_unit, policeHgun, 10, "11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
			_unit addHandgunItem policeAcoGun;

			if (call DK_fnc_checkIfNight) then
			{
				_unit addHandgunItem "acc_flashlight_pistol";	
				_unit enableGunLights "forceOn";
			};
		};
	};

	// Add Range finder
	if (leader (group _unit) isEqualTo _unit) then
	{
		_unit addWeapon "Binocular";
	};

	_unit call DK_MIS_fnc_skillPolice;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillPolice];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "cops", true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrPolice];
	_unit setVariable ["DK_scoreScd", DK_scrPoliceScd];

///	// Set random face white or black
	if (selectRandom [true,false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 1.01 + (random 0.12)];

///	// Set WANTED poits to add to the gauge
	_unit setVariable ["wantedVal", 0.5];
	_unit setVariable ["DK_idMission", DK_idMission];


};

DK_fnc_LO_PoliceHeli_pilot = {

	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	_this addVest "V_TacVest_blk_POLICE";

	// Uniform
	_this forceAddUniform "U_B_GEN_Commander_F";

	// Head
	_this addHeadgear "H_HeadSet_black_F";

	// Glasse
	_this addGoggles "G_Bandanna_aviator";


///	// Weapon
	[_this, "hgun_Pistol_heavy_02_F", 15, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
	_this addHandgunItem "optic_Yorris";

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
		_this enableGunLights "forceOn";
	};


	_this call DK_MIS_fnc_skillPolice;
	_this setVariable ["DK_skill", DK_MIS_fnc_skillPolice];
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "cops", true];
	_this setVariable ["DK_stance", "UP"];
	_this setVariable ["DK_score", DK_scrPolice];
	_this setVariable ["DK_scoreScd", DK_scrPoliceScd];

///	// Set random face white or black
	if (selectRandom [true,false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_this, _afroFace] remoteExecCall ["setFace", DK_isDedi, _this]; 
	};

///	// Set voice pitch
	_this setVariable ["pitch", 1.07];

///	// Set WANTED poits to add  to the gauge
	_this setVariable ["wantedVal", 1];
	_this setVariable ["DK_idMission", DK_idMission];

	_this setVariable ["onHeli", true];
};

DK_fnc_LO_PoliceHeli_crew = {

	params ["_unit", "_weapons", "_orderWeapon"];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	_unit addVest "V_TacVest_blk_POLICE";

	// Uniform
	_unit forceAddUniform "U_B_GEN_Commander_F";

	// Head
	_unit addHeadgear "H_PASGT_basic_black_F";

	// Glasse
	_unit addGoggles "G_Balaclava_TI_blk_F";


///	// Weapon
	switch ( _weapons ) do
	{
		case "wpns_hgunsSmgs" :
		{
			call
			{
				if (_orderWeapon isEqualTo 1) exitWith
				{
					[_unit, policeHeliHgun, 12, "9Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;

					if (call DK_fnc_checkIfNight) then
					{
						_unit addHandgunItem "acc_flashlight_pistol";	
						_unit enableGunLights "forceOn";
					};
				};

				[_unit, policeHeliSmg2, 12, "30Rnd_9x21_Mag_SMG_02_Tracer_Green"] call BIS_fnc_addWeapon;
				_unit addPrimaryWeaponItem policeAcoSmg;

				if (call DK_fnc_checkIfNight) then
				{
					_unit addPrimaryWeaponItem "acc_flashlight";	
					_unit enableGunLights "forceOn";
				};

				_unit call DK_fnc_forceSingleFire;
			};
		};

		case "MXM" :
		{
			[_unit, "arifle_MXM_Black_F", 5, "100Rnd_65x39_caseless_black_mag_tracer"] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem "optic_MRCO";

			if (call DK_fnc_checkIfNight) then
			{
				_unit addPrimaryWeaponItem "acc_flashlight";	
				_unit enableGunLights "forceOn";
			};
		};

		case "P90" :
		{
			[_unit, "SMG_03_black", 5, "50Rnd_570x28_SMG_03"] call BIS_fnc_addWeapon;
		};
	};

	_unit call DK_MIS_fnc_skillTurretVeh;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillPolice];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "cops", true];
	_unit setVariable ["DK_stance", selectRandom ["MIDDLE", "UP"]];
	_unit setVariable ["DK_score", DK_scrPolice];
	_unit setVariable ["DK_scoreScd", DK_scrPoliceScd];

///	// Set random face white or black
	if (selectRandom [true,false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 0.97 - (random 0.12)];

///	// Set WANTED poits to add  to the gauge
	_unit setVariable ["wantedVal", 1];
	_unit setVariable ["DK_idMission", DK_idMission];

	_unit setVariable ["onHeli", true];
};

DK_fnc_LO_FBI = {

	params ["_unit", "_wpnLvl", "_vest", ["_ammoStyle", 0], ["_niv",0]];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Vest (gilet)
	if (_vest isEqualTo "vest_beltFBI") then
	{
		_unit addVest "V_Rangemaster_belt";
	};

	// Uniform
	_unit forceAddUniform "U_Marshal";

	// Glasse
	_unit addGoggles "G_Spectacles_Tinted";


///	// Weapon
	call
	{
		if (_wpnLvl isEqualTo "wpns_MXC") exitWith
		{
			[_unit, "arifle_MXC_Black_F", 6, "30Rnd_65x39_caseless_black_mag_Tracer"] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem policeAco;

			if (call DK_fnc_checkIfNight) then
			{
				_unit addPrimaryWeaponItem "acc_flashlight";	
				_unit enableGunLights "forceOn";
			};

	//		_unit call DK_fnc_forceSingleFire;
		};

	};

	// Add Range finder
	_unit addWeapon "Binocular";


	_unit call DK_MIS_fnc_skillFBI;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillFBI];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "fbi", true];
	_unit setVariable ["DK_stance", "UP"];
	_unit setVariable ["DK_score", DK_scrFBI];
	_unit setVariable ["DK_scoreScd", DK_scrFBIScd];

///	// Set random face white or black
	if (selectRandom [true, false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 0.97 + (random 0.06)];

///	// Set WANTED poits to add  to the gauge
	_unit setVariable ["wantedVal", 0.5];
	_unit setVariable ["DK_idMission", DK_idMission];
};

DK_fnc_LO_FBIhg = {

	params ["_waitLO", "_unit"];


	waitUntil { scriptDone _waitLO };

	if ( (isNil "_unit") OR (!alive _unit) ) exitWith {};

	[_unit, "hgun_Pistol_heavy_01_F", 10, "11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
	_unit addHandgunItem "muzzle_snds_acp";
	_unit addHandgunItem "optic_MRD";

	if (call DK_fnc_checkIfNight) then
	{
		_unit addHandgunItem "acc_flashlight_pistol";	
		_unit enableGunLights "forceOn";
	};
};

DK_fnc_LO_Army_Zamack = {

	params ["_unit"];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

	// Select weapon
	private _weapon = DK_army_Zamack # 0;
	DK_army_ZamackDel;
	if (DK_army_Zamack isEqualTo []) then
	{
		DK_army_Zamack = +army_Zamack;
	};

///	// Clothing

	// Uniform
	_unit forceAddUniform "U_I_CombatUniform";

	// Helmet
	_unit addHeadgear "H_HelmetB";

	// Vest (gilet)
	switch (_weapon) do
	{
		case "arifle_CTAR_blk_F" :
		{
			_unit addVest "V_PlateCarrierIA1_dgtl";

			_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";
			for "_i" from 1 to 10 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
			_unit addWeapon "arifle_CTAR_blk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";

			// Glasse
			_unit addGoggles "G_Tactical_Clear";
		};

		case "srifle_DMR_03_khaki_F" :
		{
			_unit addVest "V_PlateCarrierIA2_dgtl";

			for "_i" from 1 to 3 do {_unit addItemToVest "20Rnd_762x51_Mag";};
			for "_i" from 1 to 10 do {_unit addItemToVest "20Rnd_762x51_Mag";};
			_unit addWeapon "srifle_DMR_03_khaki_F";
			_unit addPrimaryWeaponItem "optic_Holosight_khk_F";

			// Glasse
			_unit addGoggles "G_Tactical_Black";
		};

		case "MMG_02_camo_F" :
		{
			_unit addVest "V_PlateCarrierSpec_rgr";
			_unit addBackpack "B_Carryall_oli";

			_unit addItemToVest "130Rnd_338_Mag";
			for "_i" from 1 to 3 do {_unit addItemToBackpack "130Rnd_338_Mag";};
			_unit addWeapon "MMG_02_camo_F";
			_unit addPrimaryWeaponItem "optic_MRCO";
			_unit addPrimaryWeaponItem "bipod_01_F_mtp";

			// Glasse
			_unit addGoggles "G_Tactical_Black";
		};

		case "arifle_MSBS65_UBS_F" :
		{
			_unit addVest "V_PlateCarrierIA1_dgtl";

			for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_msbs_mag_Tracer";};
			for "_i" from 1 to 8 do {_unit addItemToVest "6Rnd_12Gauge_Pellets";};
			_unit addWeapon "arifle_MSBS65_UBS_F";
			_unit addPrimaryWeaponItem "optic_Holosight_khk_F";

			// Glasse
			_unit addGoggles "G_Tactical_Black";
		};

		case "arifle_SPAR_01_khk_F" :
		{
			_unit addVest "V_PlateCarrierIA1_dgtl";
			_unit addBackpack "B_Carryall_oli";

			for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
			_unit addWeapon "arifle_SPAR_01_khk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_khk_F";

			call
			{
				if (call DK_fnc_allPlayersHaveDLC_tanks) exitWith
				{
					_unit addWeapon (selectRandom lnchrArmy_MRAWS);
					_unit addSecondaryWeaponItem "MRAWS_HEAT_F";
					for "_i" from 1 to 3 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
				};

				_unit addWeapon lnchrArmy_RPG32;
				_unit addSecondaryWeaponItem "RPG32_F";
				for "_i" from 1 to 3 do {_unit addItemToBackpack "RPG32_F";};
			};

			// Glasse
			_unit addGoggles "G_Tactical_Black";
		};

	};

	// Add Range finder
	_unit addWeapon "Rangefinder";


	if (call DK_fnc_checkIfNight) then
	{
		_unit linkItem "NVGoggles_INDEP";
	};



	_unit call DK_MIS_fnc_skillArmy;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillArmy];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "army", true];
	_unit setVariable ["DK_stance", "MIDDLE"];
	_unit setVariable ["DK_score", DK_scrArmy];
	_unit setVariable ["DK_scoreScd", DK_scrArmyScd];

///	// Set random face white or black
	if (selectRandom [true, false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 0.97 + (random 0.3)];

///	// Set WANTED poits to add to the gauge
	_unit setVariable ["wantedVal", 1];
	_unit setVariable ["DK_idMission", DK_idMission];
};

DK_fnc_LO_Army_MRAP = {

	params ["_unit"];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

	// Select weapon
	private _weapon = DK_army_MRAP # 0;
	DK_army_MRAPDel;
	if (DK_army_MRAP isEqualTo []) then
	{
		DK_army_MRAP = +army_MRAP;
	};

///	// Clothing

	// Uniform
	_unit forceAddUniform "U_I_CombatUniform";

	// Helmet
	_unit addHeadgear "H_HelmetB";

	// Vest (gilet)
	switch (_weapon) do
	{
		case "arifle_CTAR_blk_F" :
		{
			_unit addVest "V_PlateCarrierIA1_dgtl";

			_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";
			for "_i" from 1 to 10 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
			_unit addWeapon "arifle_CTAR_blk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";

			// Glasse
			_unit addGoggles "G_Tactical_Clear";
		};

		case "srifle_DMR_03_khaki_F" :
		{
			_unit addVest "V_PlateCarrierIA2_dgtl";

			for "_i" from 1 to 3 do {_unit addItemToVest "20Rnd_762x51_Mag";};
			for "_i" from 1 to 10 do {_unit addItemToVest "20Rnd_762x51_Mag";};
			_unit addWeapon "srifle_DMR_03_khaki_F";
			_unit addPrimaryWeaponItem "optic_Holosight_khk_F";

			// Glasse
			_unit addGoggles "G_Tactical_Black";
		};

		case "MMG_02_camo_F" :
		{
			_unit addVest "V_PlateCarrierSpec_rgr";
			_unit addBackpack "B_Carryall_oli";

			_unit addItemToVest "130Rnd_338_Mag";
			for "_i" from 1 to 3 do {_unit addItemToBackpack "130Rnd_338_Mag";};
			_unit addWeapon "MMG_02_camo_F";
			_unit addPrimaryWeaponItem "optic_MRCO";
			_unit addPrimaryWeaponItem "bipod_01_F_mtp";

			// Glasse
			_unit addGoggles "G_Tactical_Black";
		};

	};

	// Add Range finder
	_unit addWeapon "Rangefinder";


	if (call DK_fnc_checkIfNight) then
	{
		_unit linkItem "NVGoggles_INDEP";
	};



	_unit call DK_MIS_fnc_skillArmy;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillArmy];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "army", true];
	_unit setVariable ["DK_stance", "MIDDLE"];
	_unit setVariable ["DK_score", DK_scrArmy];
	_unit setVariable ["DK_scoreScd", DK_scrArmyScd];

///	// Set random face white or black
	if (selectRandom [true, false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 0.97 + (random 0.3)];

///	// Set WANTED poits to add  to the gauge
	_unit setVariable ["wantedVal", 1];
	_unit setVariable ["DK_idMission", DK_idMission];
};

DK_fnc_LO_Army_Default = {

	params ["_unit"];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

///	// Clothing

	// Uniform
	_unit forceAddUniform "U_I_CombatUniform";

	// Helmet
	_unit addHeadgear "H_HelmetB";

	// Vest (gilet)
	_unit addVest "V_PlateCarrierIA1_dgtl";

	// Glasse
	_unit addGoggles "G_Tactical_Clear";

	// Weapon
	_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";
	for "_i" from 1 to 10 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
	_unit addWeapon "arifle_CTAR_blk_F";
	_unit addPrimaryWeaponItem "optic_Holosight_blk_F";



	if (call DK_fnc_checkIfNight) then
	{
		_unit linkItem "NVGoggles_INDEP";
	};


	_unit call DK_MIS_fnc_skillArmy;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillArmy];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "army", true];
	_unit setVariable ["DK_stance", "MIDDLE"];
	_unit setVariable ["DK_score", DK_scrArmy];
	_unit setVariable ["DK_scoreScd", DK_scrArmyScd];

///	// Set random face white or black
	if (selectRandom [true, false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 0.97 + (random 0.3)];

///	// Set WANTED poits to add  to the gauge
	_unit setVariable ["wantedVal", 1];
	_unit setVariable ["DK_idMission", DK_idMission];
};


DK_fnc_LO_ArmyHeli_pilot = {


	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";

	// Uniform
	_this forceAddUniform "U_I_CombatUniform";

	// Helmet
	_this addHeadgear "H_PilotHelmetHeli_I";

	// Weapon
	[_this, "hgun_Pistol_heavy_02_F", 15, "6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
	_this addHandgunItem "optic_Yorris";

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
	};

	_this addGoggles "G_Bandanna_beast";

	_this call DK_MIS_fnc_skillGunnerVeh;
	_this setVariable ["DK_skill", DK_MIS_fnc_skillArmy];
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_side", "army", true];
	_this setVariable ["DK_stance", "MIDDLE"];
	_this setVariable ["DK_score", DK_scrArmy];
	_this setVariable ["DK_scoreScd", DK_scrArmyScd];

///	// Set random face white or black
	if (selectRandom [true, false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_this, _afroFace] remoteExecCall ["setFace", DK_isDedi, _this]; 
	};

///	// Set voice pitch
	_this setVariable ["pitch", 0.97 + (random 0.3)];

///	// Set WANTED poits to add  to the gauge
	_this setVariable ["wantedVal", 1];
	_this setVariable ["DK_idMission", DK_idMission];

	_this setVariable ["onHeli", true];
};

DK_fnc_LO_ArmyHeli_crew = {

	params ["_unit", "_weapon"];


	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit linkItem "ItemRadio";

	// Uniform
	_unit forceAddUniform "U_I_CombatUniform";

	// Helmet
	_unit addHeadgear "H_HelmetB";

	// Vest
	_unit addVest "V_PlateCarrierIA1_dgtl";

	// Weapon
	switch (_weapon) do
	{
		case "CAR_LMG" :
		{
			for "_i" from 1 to 5 do {_unit addItemToVest "100Rnd_580x42_Mag_Tracer_F";};
			_unit addWeapon "arifle_CTARS_blk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";

			_unit addItemToUniform "MiniGrenade";
			_unit addItemToUniform "SmokeShell";
		};

		case "SPAR_LMG" :
		{
			for "_i" from 1 to 4 do {_unit addItemToVest "150Rnd_556x45_Drum_Green_Mag_Tracer_F";};
			_unit addWeapon "arifle_SPAR_02_khk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_khk_F";
			_unit addPrimaryWeaponItem "bipod_01_F_khk";
		};

		case "CAR" :
		{
			_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";
			for "_i" from 1 to 10 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
			_unit addWeapon "arifle_CTAR_blk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";

			for "_i" from 1 to 2 do {_unit addItemToUniform "MiniGrenade";};
			for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
		};

		case "SPAR_C" :
		{
			for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
			_unit addWeapon "arifle_SPAR_01_khk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_khk_F";
		};

	};

	_unit addGoggles "G_Balaclava_TI_G_blk_F";


	if (call DK_fnc_checkIfNight) then
	{
		_unit linkItem "NVGoggles_INDEP";
	};


	_unit call DK_MIS_fnc_skillArmy;
	_unit setVariable ["DK_skill", DK_MIS_fnc_skillArmy];
	_unit enableFatigue false;
	_unit disableAI "AUTOCOMBAT";

	_unit setVariable ["DK_side", "army", true];
	_unit setVariable ["DK_stance", "MIDDLE"];
	_unit setVariable ["DK_score", DK_scrArmy];
	_unit setVariable ["DK_scoreScd", DK_scrArmyScd];

///	// Set random face white or black
	if (selectRandom [true, false]) then
	{
		_afroFace = selectRandom (selectRandom [afroFaceA,afroFaceB]);

		[_unit, _afroFace] remoteExecCall ["setFace", DK_isDedi, _unit]; 
	};

///	// Set voice pitch
	_unit setVariable ["pitch", 0.97 + (random 0.3)];

///	// Set WANTED poits to add  to the gauge
	_unit setVariable ["wantedVal", 1];
	_unit setVariable ["DK_idMission", DK_idMission];

	_unit setVariable ["onHeli", true];
};


/////// VIP civilian
DK_fnc_LO_VIPciv = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";


	// Uniform
	private _uniform = selectRandom DK_unifVIPciv;
	DK_unifVIPcivDel(_uniform);
	_this forceAddUniform _uniform;

	if (DK_unifVIPciv isEqualTo []) then
	{
		DK_unifVIPciv = +unifVIPciv;
		DK_unifVIPcivDel(_uniform);
	};

	removeGoggles  _this;


	_this setSkill 0;
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_score", DK_scrVIPciv];
};

DK_fnc_LO_VIPmed = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";


	// Uniform
	_this forceAddUniform "U_B_PilotCoveralls";
	_this addHeadgear "H_PilotHelmetHeli_B";

	removeGoggles  _this;


	_this setSkill 0;
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_score", DK_scrVIPmed];
};

DK_fnc_LO_VIPidap = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	_this setUnitLoadout (configFile >> "EmptyLoadout");
	_this linkItem "ItemRadio";


	// Uniform
	_this forceAddUniform "U_C_IDAP_Man_casual_F";
	_this addHeadgear "H_HeadSet_white_F";

	removeGoggles  _this;


	_this setSkill 0;
	_this enableFatigue false;
	_this disableAI "AUTOCOMBAT";

	_this setVariable ["DK_score", DK_scrVIPmed];
};


/////// Vehicles Police / FBI / Army
DK_fnc_LO_heli_Alban = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	clearBackpackCargoGlobal _this;
	_this addBackpackCargoGlobal ["B_Parachute", 4];

	call
	{
		if ( (selectRandom [true,false]) && { (call DK_fnc_allPlayersHaveDLC_contact) } ) exitWith
		{
			_this addWeaponWithAttachmentsCargoGlobal [["arifle_RPK12_F", "", "", (selectRandom items_dot), ["75Rnd_762x39_Mag_Tracer_F", 75], [], ""], 1];
			_this addItemCargoGlobal ["75Rnd_762x39_Mag_Tracer_F", 2];
		};

		if ( (selectRandom [true,false]) && { (call DK_fnc_allPlayersHaveDLC_apex) } ) exitWith
		{
			_this addWeaponWithAttachmentsCargoGlobal [["arifle_AK12_GL_F", "", "", (selectRandom items_dot), ["30Rnd_762x39_Mag_F", 30], ["1Rnd_HE_Grenade_shell", 1], ""], 1];
			_this addItemCargoGlobal ["30Rnd_762x39_Mag_F", 8];
			_this addItemCargoGlobal ["1Rnd_HE_Grenade_shell", 3];
		};

		_this addWeaponWithAttachmentsCargoGlobal [["LMG_Zafir_F", "", "", "optic_Holosight", ["150Rnd_762x54_Box_Tracer", 150], [], ""], 1];
		_this addItemCargoGlobal ["150Rnd_762x54_Box_Tracer", 2];
	};

	call
	{
		if (call DK_fnc_allPlayersHaveDLC_apex) exitWith
		{
			_this addItemCargoGlobal ["launch_RPG7_F", 1];
			_this addItemCargoGlobal ["RPG7_F", 3];
		};

		_this addItemCargoGlobal ["launch_RPG32_F", 1];
		_this addItemCargoGlobal ["RPG32_F", 3];
	};
};

DK_fnc_LO_heliDomi = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	clearBackpackCargoGlobal _this;
	_this addBackpackCargoGlobal ["B_Parachute", 4];

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			_this addWeaponWithAttachmentsCargoGlobal [[selectRandom ["srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F"], "", "", if (call DK_MIS_ALWD_OPTC) then { _this addItemCargoGlobal [selectRandom items_scope2x, 1] } else { _this addItemCargoGlobal [selectRandom items_dot, 1] }, ["20Rnd_762x51_Mag", 20], [], ""], 1];
			_this addItemCargoGlobal ["20Rnd_762x51_Mag", 8];
		};

		if (selectRandom [true,false]) exitWith
		{
			_this addWeaponWithAttachmentsCargoGlobal [["arifle_TRG21_GL_F", "", "", (selectRandom items_dot), ["30Rnd_556x45_Stanag", 30], ["1Rnd_HE_Grenade_shell", 1], ""], 1];
			_this addItemCargoGlobal ["30Rnd_556x45_Stanag", 8];
			_this addItemCargoGlobal ["1Rnd_HE_Grenade_shell", 3];
		};

		_this addWeaponWithAttachmentsCargoGlobal [["LMG_Zafir_F", "", "", "optic_Holosight", ["150Rnd_762x54_Box_Tracer", 150], [], ""], 1];
		_this addItemCargoGlobal ["150Rnd_762x54_Box_Tracer", 2];
	};

	[_this, 1, 3] call DK_MIS_fnc_LO_AA;
};

DK_fnc_LO_heli_police = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	clearBackpackCargoGlobal _this;
	_this addBackpackCargoGlobal ["B_Parachute", 4];

	_this addItemCargoGlobal ["SMG_03C_black", 1];
	_this addItemCargoGlobal ["50Rnd_570x28_SMG_03", 3];


	_this addItemCargoGlobal ["launch_B_Titan_F", 1];
	_this addItemCargoGlobal ["Titan_AA", 2];

	_this addItemCargoGlobal ["20Rnd_762x51_Mag", 5];

	if (call DK_MIS_ALWD_OPTC) then
	{
		_this addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_06_olive_F", "", "", items_scopeFBI2x, ["20Rnd_762x51_Mag", 20], [], ""], 1];
		_this addItemCargoGlobal [policeAco, 1];
	}
	else
	{
		_this addItemCargoGlobal [policeAco, 1];
		_this addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_06_olive_F", "", "", policeAco, ["20Rnd_762x51_Mag", 20], [], ""], 1];
	};
};

DK_fnc_LO_heli_army = {

	if ((isNil "_this") OR (isNull _this) OR (!alive _this)) exitWith {};

	clearBackpackCargoGlobal _this;
	_this addBackpackCargoGlobal ["B_Parachute", 5];

	[_this, 1, 2, true] call DK_MIS_fnc_LO_AA;

	_this addItemCargoGlobal ["SMG_03C_black", 1];
	_this addItemCargoGlobal ["50Rnd_570x28_SMG_03", 3];


	_this addItemCargoGlobal ["20Rnd_762x51_Mag", 5];

	if (call DK_MIS_ALWD_OPTC) then
	{
		_this addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_06_olive_F", "", "", items_scopeFBI2x, ["20Rnd_762x51_Mag", 20], [], ""], 1];
		_this addItemCargoGlobal [policeAco, 1];
	}
	else
	{
		_this addItemCargoGlobal [policeAco, 1];
		_this addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_06_olive_F", "", "", policeAco, ["20Rnd_762x51_Mag", 20], [], ""], 1];
	};

	// added Demolition charge
	if (call DK_ALWD_EXPL) then
	{
		_this addItemCargoGlobal ["SatchelCharge_Remote_Mag",2];
	};
};


DK_fnc_LO_van_fbi = {

	call
	{
		if (selectRandom [true, false, false]) exitWith
		{
			_this addItemCargoGlobal ["11Rnd_45ACP_Mag", 7];
			_this addWeaponWithAttachmentsCargoGlobal [["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "", "optic_MRD", ["11Rnd_45ACP_Mag", 11], [], ""], 1];
		};

		_this addWeaponWithAttachmentsCargoGlobal [["arifle_MXC_Black_F", "", "", policeAco, ["30Rnd_65x39_caseless_black_mag_Tracer", 30], [], ""], 1];
	};

	_this addItemCargoGlobal ["100Rnd_65x39_caseless_black_mag", 2];
};

DK_fnc_LO_offRoad_police = {

	clearItemCargoGlobal _this;

	if (missionNamespace getVariable ["wantedMissionVal", 0] isEqualTo 0) exitWith
	{
		if ( (time > DK_middleTime) OR (selectRandom [true, true, false]) ) exitWith
		{
			_this addItemCargoGlobal ["30Rnd_556x45_Stanag", 5];
			_this addWeaponWithAttachmentsCargoGlobal [["arifle_TRG20_F", "", "", policeAcoSmg, ["30Rnd_556x45_Stanag", 30], [], ""], 1];
		};

		_this addItemCargoGlobal ["Binocular", 1];
		[_this, 4] call DK_MIS_fnc_LO_ammo;
	};

	_this addItemCargoGlobal ["30Rnd_556x45_Stanag", 7];
	_this addWeaponWithAttachmentsCargoGlobal [["arifle_TRG20_F", "", "", policeAcoSmg, ["30Rnd_556x45_Stanag", 30], [], ""], 1];
};


DK_fnc_LO_army_ProwlerVeh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

	[_this, 1, true, 2, true] call DK_MIS_fnc_LO_ATsDLC;
	_this addBackpackCargoGlobal ["B_Carryall_oli", if (_nbItems isEqualTo 1) then {1} else {2}];
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {2}];

	_this addItemCargoGlobal ["SmokeShell", if (_nbItems isEqualTo 1) then {2} else {4}];

	_this addItemCargoGlobal ["NVGoggles_INDEP", if (_nbItems isEqualTo 1) then {1} else {2}];		
};

DK_fnc_LO_army_ProwlerATVeh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

	[_this, 0, 6] call DK_MIS_fnc_LO_HE;
	_this addItemCargoGlobal ["1Rnd_HE_Grenade_shell", if (_nbItems isEqualTo 1) then {2} else {4}];
	_this addBackpackCargoGlobal ["B_Carryall_oli", if (_nbItems isEqualTo 1) then {1} else {2}];
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {2}];

	_this addItemCargoGlobal ["SmokeShell", if (_nbItems isEqualTo 1) then {2} else {4}];

	if (call DK_MIS_ALWD_OPTC) then
	{
		_this addItemCargoGlobal [selectRandom items_scope2x, if (_nbItems isEqualTo 1) then {1} else {round (_nbItems / 2)}];
	};

	_this addItemCargoGlobal ["NVGoggles_INDEP", if (_nbItems isEqualTo 1) then {1} else {2}];		
};

DK_fnc_LO_army_ZamackVeh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsHalf = round (_nbItems / 2);

	[_this, if (_nbItems isEqualTo 1) then {1} else {2}, true, 2, true] call DK_MIS_fnc_LO_ATsDLC;
	[_this, if (_nbItems isEqualTo 1) then {1} else {2}, 2, true] call DK_MIS_fnc_LO_AA;

	_this addItemCargoGlobal ["V_PlateCarrierIA1_dgtl", 1];
	_this addItemCargoGlobal ["V_PlateCarrierIA2_dgtl", 1];
	_this addItemCargoGlobal ["V_PlateCarrierIAGL_dgtl", 1];
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {3}];

	_this addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
	_this addItemCargoGlobal ["B_UavTerminal", 1];

	_this addItemCargoGlobal ["130Rnd_338_Mag", _nbItemsHalf + 1];

	_this addItemCargoGlobal ["1Rnd_SmokePurple_Grenade_shell", 4];

	if (call DK_MIS_ALWD_OPTC) then
	{
		_this addItemCargoGlobal [selectRandom items_scope2x, _nbItemsHalf];
		_this addItemCargoGlobal [selectRandom items_scopeXx, _nbItemsHalf];
	};

	_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		

	// added Demolition charge
	if (call DK_ALWD_EXPL) then
	{
		_this addItemCargoGlobal ["SatchelCharge_Remote_Mag",2];
	};
};

DK_fnc_LO_army_MRAPveh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

	[_this, 1, true, 6] call DK_MIS_fnc_LO_sniperArmy;

	_this addItemCargoGlobal ["V_PlateCarrierIA2_dgtl", if (_nbItems isEqualTo 1) then {1} else {2}];		
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {2}];

	_this addItemCargoGlobal ["NVGoggles_INDEP", if (_nbItems isEqualTo 1) then {1} else {2}];		

	// added Demolition charge
	if (call DK_ALWD_EXPL) then
	{
		_this addItemCargoGlobal ["SatchelCharge_Remote_Mag",1];
	};
};

DK_fnc_LO_army_MoraVeh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

	_this addItemCargoGlobal ["V_PlateCarrierSpec_rgr", if (_nbItems isEqualTo 1) then {1} else {2}];		
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {2}];

	[_this, 1, true, 7, 2] call	DK_MIS_fnc_LO_AR_GL_light_Army;

	_this addItemCargoGlobal ["SmokeShellBlue", 2];
	_this addItemCargoGlobal ["SmokeShellOrange", 2];

	_this addItemCargoGlobal ["NVGoggles_INDEP", if (_nbItems isEqualTo 1) then {1} else {2}];		
};

DK_fnc_LO_army_KumaVeh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

	_this addItemCargoGlobal ["V_PlateCarrierSpec_rgr", if (_nbItems isEqualTo 1) then {1} else {2}];		
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {2}];

	[_this, 1, true, 7, 2] call	DK_MIS_fnc_LO_AR_GL_Light_Army;
	[_this, 1, true, 7, 2] call	DK_MIS_fnc_LO_AR_GL_Med_Army;

	_this addItemCargoGlobal ["SmokeShell", 2];
	_this addItemCargoGlobal ["SmokeShell", 2];

	_this addItemCargoGlobal ["NVGoggles_INDEP", if (_nbItems isEqualTo 1) then {1} else {2}];		
};

DK_fnc_LO_army_GorgonVeh = {

	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;


	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

	[_this, 1, true, 7, 2] call	DK_MIS_fnc_LO_AR_GL_Med_Army;

	_this addItemCargoGlobal ["V_PlateCarrierIAGL_dgtl", if (_nbItems isEqualTo 1) then {1} else {2}];		
	_this addItemCargoGlobal ["H_HelmetB", if (_nbItems isEqualTo 1) then {1} else {2}];

	_this addItemCargoGlobal ["1Rnd_SmokeBlue_Grenade_shell", 2];
	_this addItemCargoGlobal ["1Rnd_SmokeOrange_Grenade_shell", 2];

	_this addItemCargoGlobal ["NVGoggles_INDEP", if (_nbItems isEqualTo 1) then {1} else {4}];		
};


/// // Rewards
DK_MIS_fnc_LO_reward_lvl_1 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsHalf = round (_nbItems / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added Handugn with 30 rounds
	[_this, _nbItemsHalf] call DK_MIS_fnc_LO_handgun30rd;


	call
	{
		if (selectRandom [true, false]) exitWith
		{
			// added Grenades
			[_this, _nbItems, 1, 2] call DK_MIS_fnc_LO_HE;
		};

		// added SMG
		[_this, _nbItemsHalf] call DK_MIS_fnc_LO_SMG;
	};
};

DK_MIS_fnc_LO_reward_lvl_2 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsHalf = round (_nbItems / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added Handugn with 30 rounds
	[_this, _nbItemsHalf] call DK_MIS_fnc_LO_handgun30rd;


	// added SMG
	[_this, _nbItemsHalf] call DK_MIS_fnc_LO_SMG;


	// added Sound Suppressor
	_this addItemCargoGlobal [(selectRandom [items_supp_9m, items_supp_45]), 1];

	// added Flashlight
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_3 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added SMG or Handgun
	switch ( selectRandom [1,2,3] ) do
	{
		case 1 :
		{
			// added SMG
			[_this, _nbItemsQuarter, true] call DK_MIS_fnc_LO_SMG;
		};

		case 2 :
		{
			// added Handugn with 30 rounds & Silencer
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_handgun30rd;
			_this addItemCargoGlobal [items_supp_9m, 1];
		};	

		case 3 :
		{
			// added P90
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_P90_c;
		};
	};


	// added AR 5.56 C
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_5x56_c;

	// added Flashlight
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_4 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsHalf = round (_nbItems / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added AR 5.56 C
	[_this, _nbItemsHalf] call DK_MIS_fnc_LO_5x56_c;


	// added Grenades
	[_this, _nbItems, 1, 2] call DK_MIS_fnc_LO_HE;


	// added Anti-Air
	[_this] call DK_MIS_fnc_LO_AA;

	// added Demolition charge or RPG
	call
	{
		if ( (call DK_ALWD_EXPL) && { (selectRandom [true, false]) } ) exitWith
		{
			_this addItemCargoGlobal ["DemoCharge_Remote_Mag",1];
		};

		[_this, _nbItemsHalf] call DK_MIS_fnc_LO_5x56;
	};

	// added Flashlight
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_5 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;

	call
	{
		_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];

		if ((_wantedLevel >= 8) && {(_wantedLevel <= 19)}) exitWith
		{
			// added AR 5.56 GL
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_5x56_gl;

			// added AR Spar GL & Car GL (Apex)
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_SparCar_gl;
		};

		// added AR 5.56 C
		[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_5x56_c;

		// added AR Spar & Car (Apex)
		[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_SparCar_c;
	};

	// added Sound Suppressor
	_this addItemCargoGlobal [(selectRandom [items_supp_9m, items_supp_45]), 1];

	// added Night Vision
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_6 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added P90
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_P90_c;


	// added Mk18
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mk18;

	call
	{
		_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];

		// added RPG
		if ((_wantedLevel >= 8) && {(_wantedLevel <= 19)}) exitWith
		{
			[_this, 1, true, 2] call DK_MIS_fnc_LO_RPGs;
		};

		// added AR Spar GL & Car GL (Apex)
		if (call DK_fnc_allPlayersHaveDLC_apex) exitWith
		{
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_SparCar_gl;
		};

		// added AR 5.56 GL
		[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_5x56_gl;
	};

	// added Night Vision
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_7 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	call
	{
		_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];

		if ((_wantedLevel >= 8) && {(_wantedLevel <= 19)}) exitWith
		{
			// added AR Katiba GL or MX GL
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mx_Kat_gl;


			// added SR
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Lynx_M320;


			// added Mk18
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mk18;


			// added RPG
			[_this, 1, true, 3] call DK_MIS_fnc_LO_RPGs;
		};


		// added AR 5.56 or MXC or Katiba C
		switch ( selectRandom [1,2] ) do
		{
			case 1 :
			{
				[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mk18;
			};

			case 2 :
			{
				[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mx_Kat_c;
			};
		};


		// added P90 or Mk18
		switch ( selectRandom [1,2] ) do
		{
			case 1 :
			{
				[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_P90_c;
			};

			case 2 :
			{
				[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_5x56;
			};
		};


		// added Handugn with 30 rounds & maybe Silencer
		[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_handgun30rd;

		if (selectRandom [true, false]) then
		{
			_this addItemCargoGlobal [items_supp_9m, 1];
		};


		// added Demolition charge
		if ( (call DK_ALWD_EXPL) && { (selectRandom [true, false]) } ) then
		{
			_this addItemCargoGlobal ["DemoCharge_Remote_Mag",1];
		};
	};


	// added Grenades
	[_this, _nbItems, 2, 3] call DK_MIS_fnc_LO_HE;

	// added Night Vision
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_8 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added Machin Gun MK200
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mk200;


	// added Machin Gun Lim or AR Spar or AR Car (Apex)
	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Lim;
		};

		case 2 :
		{
			[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_SparCar_c;
		};
	};

	// added RPG or AA
	call
	{
		_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];

		if ((_wantedLevel >= 8) && {(_wantedLevel <= 19)}) exitWith
		{
			switch ( selectRandom [1,2] ) do
			{
				case 1 :
				{
					// added Anti-Air
					[_this, 1, 2] call DK_MIS_fnc_LO_AA;
				};

				case 2 :
				{
					// added RPG
					[_this, 1, false, 2] call DK_MIS_fnc_LO_RPGs;
				};
			};
		};
	};

	// added Night Vision
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_9 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added random Vanilla Marksmen
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_MarksmenVanilla;


	// added random DLCs Marksmen
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_MarksmenDLCs;


	// added RPG
	call
	{
		_wantedLevel = missionNamespace getVariable ["wantedMissionVal", 0];

		if ((_wantedLevel >= 8) && {(_wantedLevel <= 19)}) exitWith
		{
			[_this, 1, false, 3] call DK_MIS_fnc_LO_RPGs;
		};
	};

	// added Night Vision
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};

DK_MIS_fnc_LO_reward_lvl_10 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsQuarter = round (round (_nbItems / 2) / 2);


	// added Ammo & Aco/Holo link to difficulty params start (everytime)
	[_this, _nbItems] call DK_MIS_fnc_LO_ammoDot;


	// added Spar LMG & Car LMG
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_SparCar_lmg;


	// added AR MXC or Katiba C
	[_this, _nbItemsQuarter] call DK_MIS_fnc_LO_Mx_Kat_c;


	// added Sound Suppressor
	_this addItemCargoGlobal [(selectRandom [items_supp_9m, items_supp_45]), 1];


	// added Grenades
	[_this, _nbItems, 1, 2] call DK_MIS_fnc_LO_HE;


	// added Demolition charge
	if (call DK_ALWD_EXPL) then
	{
		_this addItemCargoGlobal ["DemoCharge_Remote_Mag",1];
	};


	// added Anti-Air
	[_this, 1, 3] call DK_MIS_fnc_LO_AA;


	// added RPG
	[_this, 1, false, 4] call DK_MIS_fnc_LO_RPGs;

	// added Night Vision
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};
};


DK_MIS_fnc_LO_reward_lvl_50 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsHalf = round (_nbItems / 2);
	_nbItemsQuarter = round (_nbItemsHalf / 2);

	// added Kevlar lvl 1
	_this addItemCargoGlobal ["V_PlateCarrierIA1_dgtl", _nbItemsHalf];
	_this addItemCargoGlobal ["H_HelmetB", _nbItemsHalf];


	[_this, _nbItemsHalf, true, 10, 4] call DK_MIS_fnc_LO_AR_GL_light_Army;

	call
	{
		if ( (selectRandom [true, false]) && {(call DK_fnc_allPlayersHaveDLC_marksmen)} ) exitWith
		{
			[_this, 1, 7] call DK_MIS_fnc_LO_ASPorRahim;
		};

		if (selectRandom [true, false]) exitWith
		{
			[_this, 1, true, 1] call DK_MIS_fnc_LO_MGArmy;
		};

		[_this, 1, true, 8] call DK_MIS_fnc_LO_sniperArmy;
	};

	call
	{
		if (selectRandom [true,false]) exitWith
		{
			[_this, 1, true, 3, true] call DK_MIS_fnc_LO_ATsDLC;
		};

		[_this, 1, 3, true] call DK_MIS_fnc_LO_AA;
	};



	// added Grenades
	[_this, 0, 3] call DK_MIS_fnc_LO_HE;

	// added Optic
	if (call DK_MIS_ALWD_OPTC) then
	{
		_this addItemCargoGlobal [selectRandom items_scope2x, _nbItemsQuarter];
		_this addItemCargoGlobal [selectRandom items_scopeXx, _nbItemsQuarter];
	};

	// added NVG
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};

	// added Demolition charge
	if (call DK_ALWD_EXPL) then
	{
		_this addItemCargoGlobal ["DemoCharge_Remote_Mag", _nbItemsQuarter];
	};

	// added Grenades
	_this addItemCargoGlobal ["SmokeShell", _nbItemsHalf];
};

DK_MIS_fnc_LO_reward_lvl_51 = {

	_nbItems = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;
	_nbItemsHalf = round (_nbItems / 2);
	_nbItemsQuarter = round (_nbItemsHalf / 2);

	// added Kevlar lvl 1
	_this addItemCargoGlobal ["V_PlateCarrierIA2_dgtl", _nbItemsQuarter];
	_this addItemCargoGlobal ["V_PlateCarrierSpec_rgr", _nbItemsQuarter];
	_this addItemCargoGlobal ["H_HelmetB", _nbItemsHalf];


	[_this, _nbItemsHalf, true, 10, 4] call DK_MIS_fnc_LO_AR_GL_light_Army;

	[_this, 1, 7] call DK_MIS_fnc_LO_ASPorRahim;

	call
	{
		if (selectRandom [true, false]) exitWith
		{
			[_this, 1, true, 1] call DK_MIS_fnc_LO_MGArmy;
		};

		[_this, 1, true, 8] call DK_MIS_fnc_LO_sniperArmy;
	};

	[_this, 1, true, 3, true] call DK_MIS_fnc_LO_ATsDLC;
	[_this, 1, 3, true] call DK_MIS_fnc_LO_AA;


	// added Drone
	_this addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
	_this addItemCargoGlobal ["B_UavTerminal", 1];

	// added Grenades
	[_this, 0, 3] call DK_MIS_fnc_LO_HE;

	// added Optic
	if (call DK_MIS_ALWD_OPTC) then
	{
		_this addItemCargoGlobal [selectRandom items_scope2x, _nbItemsQuarter];
		_this addItemCargoGlobal [selectRandom items_scopeXx, _nbItemsQuarter];
	};

	// added NVG
	if (call DK_fnc_checkIfNight) then
	{
		_this addItemCargoGlobal ["NVGoggles_INDEP", _nbItems];		
		_this addItemCargoGlobal ["acc_flashlight", _nbItems];
	};

	// added Demolition charge
	if (call DK_ALWD_EXPL) then
	{
		_this addItemCargoGlobal ["SatchelCharge_Remote_Mag", _nbItemsQuarter];
	};

	// added Grenades
	_this addItemCargoGlobal ["SmokeShell", _nbItemsHalf];
};


DK_MIS_fnc_LO_ammo = {

	params ["_ammoBox", "_nbItems", ["_ammoToCrew", false]];


	call
	{
		private _wpStr = call DK_weaponStart;

		if (_wpStr isEqualTo 0) exitWith
		{
			_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItems];
		};

		if (_wpStr isEqualTo 1) exitWith
		{
			_ammoBox addItemCargoGlobal ["30Rnd_45ACP_Mag_SMG_01", _nbItems];
		};

		if (_wpStr isEqualTo 2) exitWith
		{
			_ammoBox addItemCargoGlobal ["9Rnd_45ACP_Mag", _nbItems];
		};
	};

	if !(_ammoToCrew) exitWith {};

	private _time = time + 5;
	waitUntil { uiSleep 1; (time > _time) OR (isNil "_ammoBox") OR (isNull _ammoBox) OR (!alive _ammoBox) OR !((crew _ammoBox) isEqualTo []) };

	if ((time > _time) OR (isNil "_ammoBox") OR (isNull _ammoBox) OR (!alive _ammoBox)) exitWith {};

	uiSleep 1;

	if ((isNil "_ammoBox") OR (isNull _ammoBox) OR (!alive _ammoBox)) exitWith {};

	private _crew = crew _ammoBox;
	private _slct = _crew findIf {alive _x};

	if (_slct isEqualTo -1) exitWith {};

	private _mag = primaryWeaponMagazine (_crew # _slct);

	if (_mag isEqualTo []) exitWith
	{
		_mag = secondaryWeaponMagazine (_crew # _slct);

		if !(_mag isEqualTo []) then
		{
			_ammoBox addItemCargoGlobal [_mag # 0, _nbItems];
		};
	};

	_ammoBox addItemCargoGlobal [_mag # 0, _nbItems];
};

DK_MIS_fnc_LO_ammoDot = {

	params ["_ammoBox", ["_nbItems", 1]];


	if (isNil "_ammoBox") exitWith {};

	call
	{
		_wpStr = call DK_weaponStart;

		if (_wpStr isEqualTo 0) exitWith
		{
			_ammoBox addItemCargoGlobal [selectRandom items_dot, _nbItems];
			_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItems * 5];
		};

		if (_wpStr isEqualTo 1) exitWith
		{
			_ammoBox addItemCargoGlobal [selectRandom items_dot_smg, _nbItems];
			_ammoBox addItemCargoGlobal ["30Rnd_45ACP_Mag_SMG_01", _nbItems * 5];
		};

		if (_wpStr isEqualTo 2) exitWith
		{
			_ammoBox addItemCargoGlobal ["9Rnd_45ACP_Mag", _nbItems * 10];
		};
	};
};

DK_MIS_fnc_LO_handgun30rd = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [selectRandom ["hgun_Rook40_F","hgun_P07_F"], _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["30Rnd_9x21_Mag", _nbItemsDiv * 7];

};

DK_MIS_fnc_LO_SMG = {

	params ["_ammoBox", "_nbItemsDiv", ["_sil", false]];

	
	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{		
			_ammoBox addItemCargoGlobal ["SMG_05_F", _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_9x21_Mag_SMG_02", _nbItemsDiv * 9];
		};

		case 2 :
		{		
			_ammoBox addItemCargoGlobal ["hgun_PDW2000_F", _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_9x21_Mag", _nbItemsDiv * 9];
		};

	};

	if _sil then
	{
		_ammoBox addItemCargoGlobal [items_supp_9m, 1];
	};

	for "_i" from 1 to _nbItemsDiv do
	{
		_ammoBox addItemCargoGlobal [selectRandom [items_supp_9m, selectRandom items_dot_smg], 1];
	};
};

DK_MIS_fnc_LO_HE = {

	params ["_ammoBox", "_nbItems", ["_choice1", 1], ["_choice4", 2]];

	if (_nbItems > 4) exitWith
	{
		_ammoBox addItemCargoGlobal ["MiniGrenade", _choice4];
	};

	_ammoBox addItemCargoGlobal ["MiniGrenade", _choice1];
};

DK_MIS_fnc_LO_5x56_c = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [selectRandom wpns_5x56_c, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * 9];

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_5x56_gl = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [selectRandom wpns_5x56_gl, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * 9];
	_ammoBox addItemCargoGlobal ["1Rnd_HE_Grenade_shell", _nbItemsDiv * 2];

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_5x56 = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [selectRandom wpns_5x56, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * 9];

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_SparCar_c = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Spar_c, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * 9];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Car_c, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_580x42_Mag_F", _nbItemsDiv * 9];
		};
	};

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_SparCar_gl = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Spar_gl, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * 9];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Car_gl, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_580x42_Mag_F", _nbItemsDiv * 9];
		};
	};

	_ammoBox addItemCargoGlobal ["1Rnd_HE_Grenade_shell", _nbItemsDiv * 3];
	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_SparCar_lmg = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [wpns_Spar_lmg, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["150Rnd_556x45_Drum_Sand_Mag_F", _nbItemsDiv * 2];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [wpns_Car_lmg, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["100Rnd_580x42_ghex_Mag_F", _nbItemsDiv * 2];
		};
	};

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_P90_c = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [selectRandom wpns_P90_c, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["50Rnd_570x28_SMG_03", _nbItemsDiv * 5];

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_P90 = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [selectRandom wpns_P90, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["50Rnd_570x28_SMG_03", _nbItemsDiv * 5];

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_Mk18 = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [wpns_Mk18, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["20Rnd_762x51_Mag", _nbItemsDiv * 7];

	if (call DK_MIS_ALWD_OPTC) then
	{
		_ammoBox addItemCargoGlobal [selectRandom items_scope2x, _nbItemsDiv];
	}
	else
	{
		_ammoBox addItemCargoGlobal [selectRandom items_dot, _nbItemsDiv];
	};
};

DK_MIS_fnc_LO_Mx_Kat_c = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_MX_c, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_mag", _nbItemsDiv * 9];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [wpns_Kat_c, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_green", _nbItemsDiv * 9];
		};
	};

	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_Mx_Kat_gl = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_MX_gl, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_mag", _nbItemsDiv * 9];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [wpns_Kat_gl, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_green", _nbItemsDiv * 9];
		};
	};

	_ammoBox addItemCargoGlobal ["1Rnd_HE_Grenade_shell", _nbItemsDiv * 2];
	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_Mk200 = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [wpns_Mk200, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", _nbItemsDiv * 2];
	_ammoBox addItemCargoGlobal ["bipod_02_F_blk", _nbItemsDiv];
};

DK_MIS_fnc_LO_Lim = {

	params ["_ammoBox", "_nbItemsDiv"];


	_ammoBox addItemCargoGlobal [wpns_Lim, _nbItemsDiv];
	_ammoBox addItemCargoGlobal ["200Rnd_556x45_Box_Tracer_F", _nbItemsDiv * 2];

//	_ammoBox addItemCargoGlobal [selectRandom items_dot,  _nbItemsDiv];
};

DK_MIS_fnc_LO_MarksmenVanilla = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2,3] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_MX_M, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_mag", _nbItemsDiv * 7];
		};

		case 2 :
		{
			[_ammoBox, _nbItems, _nbItemsDiv] call DK_MIS_fnc_LO_Mk18;
		};

		case 3 :
		{
			_ammoBox addItemCargoGlobal [wpns_Rahim, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["10Rnd_762x54_Mag", _nbItemsDiv * 7];
		};
	};

	if (selectRandom [true,false]) then
	{
		_ammoBox addItemCargoGlobal ["bipod_02_F_blk", _nbItemsDiv];
	};

	if (call DK_MIS_ALWD_OPTC) then
	{
		_ammoBox addItemCargoGlobal [(selectRandom (selectRandom [items_dot,items_scope2x])), _nbItemsDiv];
	}
	else
	{
		_ammoBox addItemCargoGlobal [selectRandom items_dot, _nbItemsDiv];
	};
};

DK_MIS_fnc_LO_MarksmenDLCs = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2,3,4,5] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Cyrius, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["10Rnd_93x64_DMR_05_Mag", _nbItemsDiv * 7];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Mar10, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["10Rnd_338_Mag", _nbItemsDiv * 7];
		};

		case 3 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Mk14, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["20Rnd_762x51_Mag", _nbItemsDiv * 7];
		};

		case 4 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_CMR, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["20Rnd_650x39_Cased_Mag_F", _nbItemsDiv * 7];
		};

		case 5 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Spar, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["20Rnd_762x51_Mag", _nbItemsDiv * 7];
		};

	};

	if (selectRandom [true,false]) then
	{
		_ammoBox addItemCargoGlobal ["bipod_02_F_blk", _nbItemsDiv];
	};

	if (call DK_MIS_ALWD_OPTC) then
	{
		_ammoBox addItemCargoGlobal [(selectRandom (selectRandom [items_dot,items_scope2x])), _nbItemsDiv];
	}
	else
	{
		_ammoBox addItemCargoGlobal [selectRandom items_dot, _nbItemsDiv];
	};
};

DK_MIS_fnc_LO_Lynx_M320 = {

	params ["_ammoBox", "_nbItemsDiv"];


	switch ( selectRandom [1,2] ) do
	{
		case 1 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_Lynx, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["5Rnd_127x108_Mag", _nbItemsDiv * 7];
		};

		case 2 :
		{
			_ammoBox addItemCargoGlobal [selectRandom wpns_M320, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["7Rnd_408_Mag", _nbItemsDiv * 6];
		};
	};

	if (call DK_MIS_ALWD_OPTC) then
	{
		if (call DK_fnc_allPlayersHaveDLC_marksmen) then
		{
			_ammoBox addItemCargoGlobal [selectRandom items_scopeXxDLC, _nbItemsDiv];
		}
		else
		{
			_ammoBox addItemCargoGlobal [selectRandom items_scopeXx, _nbItemsDiv];
		};
	}
	else
	{
		_ammoBox addItemCargoGlobal [selectRandom items_dot, _nbItemsDiv];
	};
};

DK_MIS_fnc_LO_MGArmy = {

	params ["_ammoBox", ["_nbItemsDiv", 1], ["_MGsDLC", true], ["_nbAmmo", 1]];


	call
	{
		if ( (_MGsDLC) && {(call DK_fnc_allPlayersHaveDLC_marksmen)} ) exitWith
		{
			_ammoBox addItemCargoGlobal ["130Rnd_338_Mag", _nbItemsDiv * _nbAmmo];
			_ammoBox addWeaponWithAttachmentsCargoGlobal [["MMG_02_camo_F", "", "", "optic_Holosight_blk_F", ["130Rnd_338_Mag", 130], [], "bipod_01_F_mtp"], _nbItemsDiv]
		};

		_ammoBox addItemCargoGlobal ["150Rnd_762x54_Box_Tracer", _nbItemsDiv * _nbAmmo];
		_ammoBox addWeaponWithAttachmentsCargoGlobal [["LMG_Zafir_F", "", "", "optic_Holosight", ["150Rnd_762x54_Box_Tracer", 150], [], ""], _nbItemsDiv];
	};

};

DK_MIS_fnc_LO_sniperArmy = {

	params ["_ammoBox", ["_nbItemsDiv", 1], ["_SRsDLC", true], ["_nbAmmo", 5]];


	call
	{
		if ( (_SRsDLC) && {(call DK_fnc_allPlayersHaveDLC_marksmen)} ) exitWith
		{
			_ammoBox addItemCargoGlobal ["10Rnd_338_Mag", _nbItemsDiv * _nbAmmo];

			if (call DK_MIS_ALWD_OPTC) exitWith
			{
				_ammoBox addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_02_camo_F", "", "", items_scopeArmyXx, ["10Rnd_338_Mag", 10], [], "bipod_01_F_blk"], _nbItemsDiv]
			};

			_ammoBox addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_02_camo_F", "", "", "optic_Holosight_blk_F", ["10Rnd_338_Mag", 10], [], "bipod_01_F_blk"], _nbItemsDiv]
		};

		_ammoBox addItemCargoGlobal ["7Rnd_408_Mag", _nbItemsDiv * _nbAmmo];

		if (call DK_MIS_ALWD_OPTC) exitWith
		{
			_ammoBox addWeaponWithAttachmentsCargoGlobal [["srifle_LRR_F", "", "", items_scopeArmyXx, ["7Rnd_408_Mag", 7], [], ""], _nbItemsDiv]
		};

		_ammoBox addWeaponWithAttachmentsCargoGlobal [["srifle_LRR_F", "", "", "optic_Holosight_blk_F", ["7Rnd_408_Mag", 7], [], ""], _nbItemsDiv]
	};

};

DK_MIS_fnc_LO_AR_GL_light_Army = {

	params ["_ammoBox", ["_nbItemsDiv", 1], ["_GLsDLC", true], ["_nbAmmo", 7], ["_nbAmmoHE", 3]];


	_ammoBox addItemCargoGlobal ["1Rnd_HE_Grenade_shell", _nbItemsDiv * _nbAmmoHE];

	call
	{
		if ( (_GLsDLC) && {(call DK_fnc_allPlayersHaveDLC_apex)} ) exitWith
		{
			_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * _nbAmmo];
			_ammoBox addWeaponWithAttachmentsCargoGlobal [[wpnsArmy_Spar_gl, "", "", "optic_Holosight_khk_F", ["30Rnd_556x45_Stanag", 30], ["1Rnd_HE_Grenade_shell", 1], ""], _nbItemsDiv]
		};

		_ammoBox addItemCargoGlobal ["30Rnd_556x45_Stanag", _nbItemsDiv * _nbAmmo];
		_ammoBox addWeaponWithAttachmentsCargoGlobal [[wpnsArmy_TRG_gl, "", "", "optic_Holosight_blk_F", ["30Rnd_556x45_Stanag", 30], ["1Rnd_HE_Grenade_shell", 1], ""], _nbItemsDiv]
	};

};

DK_MIS_fnc_LO_AR_GL_Med_Army = {

	params ["_ammoBox", ["_nbItemsDiv", 1], ["_GLsDLC", true], ["_nbAmmo", 7], ["_nbAmmoHE", 3]];


	_ammoBox addItemCargoGlobal ["1Rnd_HE_Grenade_shell", _nbItemsDiv * _nbAmmoHE];

	call
	{
		if ( (_GLsDLC) && {(call DK_fnc_allPlayersHaveDLC_marksmen)} ) exitWith
		{
			_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_msbs_mag", _nbItemsDiv * _nbAmmo];
			_ammoBox addWeaponWithAttachmentsCargoGlobal [[wpnsArmy_Promet_gl, "", "", "optic_Holosight_blk_F", ["30Rnd_65x39_caseless_msbs_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""], _nbItemsDiv]
		};

		_ammoBox addItemCargoGlobal ["30Rnd_65x39_caseless_black_mag_Tracer", _nbItemsDiv * _nbAmmo];
		_ammoBox addWeaponWithAttachmentsCargoGlobal [[wpnsArmy_MX_gl, "", "", "optic_Holosight_blk_F", ["30Rnd_65x39_caseless_black_mag_Tracer", 30], ["1Rnd_HE_Grenade_shell", 1], ""], _nbItemsDiv]
	};

};

DK_MIS_fnc_LO_ASPorRahim = {

	params ["_ammoBox", ["_nbItems", 1], ["_nbAmmo", 7]];


	call
	{
		if (call DK_fnc_allPlayersHaveDLC_marksmen) exitWith
		{
			_ammoBox addItemCargoGlobal ["10Rnd_127x54_Mag", _nbItems * _nbAmmo];
			_ammoBox addWeaponWithAttachmentsCargoGlobal [["srifle_DMR_04_F", "", "", "", ["10Rnd_127x54_Mag", 10], [], ""], _nbItems];
		};

		_ammoBox addItemCargoGlobal ["10Rnd_762x54_Mag", _nbItems * _nbAmmo];
		_ammoBox addWeaponWithAttachmentsCargoGlobal [[wpns_Rahim, "muzzle_snds_B_snd_F", "", "", ["10Rnd_762x54_Mag", 10], [], "bipod_02_F_hex"], _nbItems];
	};
};

DK_MIS_fnc_LO_RPGs = {

	params ["_ammoBox", ["_nbItemsDiv", 1], ["_oldRPG", false], ["_nbAmmo", selectRandom [2,3]]];


	call
	{
		if ( (_oldRPG) && {(call DK_fnc_allPlayersHaveDLC_apex)} ) exitWith
		{
			_ammoBox addItemCargoGlobal ["launch_RPG7_F", _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["RPG7_F", _nbItemsDiv * _nbAmmo];
		};

		_ammoBox addItemCargoGlobal ["launch_RPG32_F", _nbItemsDiv];
		_ammoBox addItemCargoGlobal ["RPG32_F", _nbItemsDiv * _nbAmmo];
	};
};

DK_MIS_fnc_LO_ATsDLC = {

	params ["_ammoBox", ["_nbItemsDiv", 1], ["_ATsDLC", true], ["_nbAmmo", selectRandom [2,3]], ["_onlyArmy", false]];


	call
	{
		if ( (_ATsDLC) && {(call DK_fnc_allPlayersHaveDLC_tanks)} ) exitWith
		{
			if (selectRandom [true,false]) exitWith
			{
				_ammoBox addItemCargoGlobal [ if _onlyArmy then {lnchrArmy_Verona} else {selectRandom lnchr_Verona}, _nbItemsDiv];
				_ammoBox addItemCargoGlobal ["Vorona_HEAT", _nbItemsDiv * _nbAmmo];
			};

			_ammoBox addItemCargoGlobal [ if _onlyArmy then {selectRandom lnchrArmy_MRAWS} else {selectRandom lnchr_MRAWS}, _nbItemsDiv];
			_ammoBox addItemCargoGlobal ["MRAWS_HEAT_F", _nbItemsDiv * _nbAmmo];
		};

		_ammoBox addItemCargoGlobal [ if _onlyArmy then {lnchrArmy_RPG32} else {selectRandom lnchr_RPG32}, _nbItemsDiv];
		_ammoBox addItemCargoGlobal ["RPG32_F", _nbItemsDiv * _nbAmmo];
	};
};

DK_MIS_fnc_LO_AA = {

	params ["_ammoBox", ["_nbAA", 1], ["_nbAmmo", 2], ["_onlyArmy", false]];


	call
	{
		if _onlyArmy exitWith
		{
			_ammoBox addItemCargoGlobal [lnchrArmy_AA, _nbAA];
		};

		_ammoBox addItemCargoGlobal [selectRandom lnchr_AA, _nbAA];
	};

	_ammoBox addItemCargoGlobal ["Titan_AA", _nbAmmo];
};


// Bonus
DK_fnc_LO_amb_heli_ammoBox = {

	params ["_Bonus", "_lvlStuff"];


	clearMagazineCargoGlobal _Bonus;
	clearWeaponCargoGlobal _Bonus;
	clearItemCargoGlobal _Bonus;
	clearBackpackCargoGlobal _Bonus;


	_Bonus addItemCargoGlobal [if (time < (DK_cntTmGameStart / 2)) then { "V_PlateCarrierIA1_dgtl"} else { "V_PlateCarrierIA2_dgtl" }, if ((([] call DK_fnc_cntMaxPlyrsByFam) # 0) isEqualTo 1) then {1} else {2}];
	_Bonus addBackpackCargoGlobal ["B_Carryall_oli", if ((([] call DK_fnc_cntMaxPlyrsByFam) # 0) isEqualTo 1) then {1} else {2}];
	_Bonus addItemCargoGlobal ["H_HelmetB", if ((([] call DK_fnc_cntMaxPlyrsByFam) # 0) isEqualTo 1) then {1} else {2}];
	_Bonus addItemCargoGlobal ["SmokeShellOrange",  if ((([] call DK_fnc_cntMaxPlyrsByFam) # 0) isEqualTo 1) then {3} else {6}];

	if (call DK_fnc_checkIfNight) then
	{
		_Bonus addItemCargoGlobal ["NVGoggles_INDEP", 2];		
	};

	switch _lvlStuff do
	{
		case 1 :
		{
			[_Bonus, 1, true, 2, true] call DK_MIS_fnc_LO_ATsDLC;

			_Bonus addItemCargoGlobal ["130Rnd_338_Mag", 3];
			_Bonus addWeaponWithAttachmentsCargoGlobal [["MMG_02_camo_F", "", "", "optic_MRCO", ["130Rnd_338_Mag", 130], [], "bipod_01_F_mtp"], 1];

			[_Bonus, 1, true, 9] call DK_MIS_fnc_LO_sniperArmy;
		};

		case 2 :
		{
			[_Bonus, 2, true, 11, 5] call DK_MIS_fnc_LO_AR_GL_Med_Army;
			_Bonus addBackpackCargoGlobal ["B_UAV_06_backpack_F", 1];
			_Bonus addItemCargoGlobal ["B_UavTerminal", 1];
		};

	};
};



DK_fnc_add_handGun_cops = {

	[_this, policeHgun, 10, "11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
	_this addHandgunItem policeAcoGun;

	if (call DK_fnc_checkIfNight) then
	{
		_this addHandgunItem "acc_flashlight_pistol";	
		_this enableGunLights "forceOn";
	};
};

