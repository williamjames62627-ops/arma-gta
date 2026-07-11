if (!hasInterface) exitWith {};

/// COLOR'S

DK_vTxt_colorRed = "<t color='#F00000'>";
DK_vTxt_colorRedNoShdw = "<t color='#F00000' shadow='0'>";
DK_vTxt_colorRedShadw2 = "<t color='#F00000' shadow='2'>";
DK_vTxt_colorYel = "<t color='#fdff1a'>";
DK_vTxt_colorCiv = "<t color='#640aeb'>";

DK_vTxt_colorKill = "<t color='#E6292C'>";
DK_vTxt_colorTake = "<t color='#b739b4'>";
DK_vTxt_colorRescue = "<t color='#FAF200'>";

// Team's
DK_vTxt_colorBluF = "<t color='#0095ff'>"; // Blue
DK_vTxt_colorRedF = "<t color='#fd1f1f'>"; // Red
DK_vTxt_colorGreenP = "<t color='#00FF11'>"; // Green

// TEXTS
DK_vTxt_presentationTitre = "MTW Freemode: Basic Rules";

// RESPAWN
DK_vTxt_spwnProtctActNFO = "<t color='#FFFFFF' size = '.8' shadow='2'> Spawn protection activated in :";
DK_vTxt_spwnProtctWarn = "<t color='#F00000' size = '.75' shadow='2'> Go back to your mission";

//DK_vTxt_spwnProtctGoodWay = "<t size = '.42' shadow='2'>Continue to driving in this direction until you <t color='#FAF200' size='.42' shadow='2'>leave spawn area</t>";
DK_vTxt_spwnProtctGoodWay = "<t size = '.42' shadow='2'>Head outside the red zone until you <t color='#FAF200' size='.42' shadow='2'>leave spawn area</t>";

DK_vTxt_spwnProtctShowPlayer = "<t size='.42' shadow='2' color='#FAF200' >move</t><t size='.42' shadow='2' > from there, active physical object detected";

// FUEL
DK_vTxt_lowFuel = "<t shadow='2' color='#ff0000' size = '.45'>Warning !<br/><t  size = '.56'>Low fuel level";

// TIPS
DK_vTxt_Tips = "<t shadow='2' color='#01cbc2' size = '1.15'>TIP #";


///	// WOUNDED UI

	// Wounded
	DK_vTxt_EnFiKil = "<t shadow='2' color='#ffd11a' size = '.5'>Killed <t color='#E6292C'>%1  <t color='#ffffff'> 25 pts";
	DK_vTxt_EnFiIncap = "<t shadow='2' color='#ffd11a' size = '.5'>Incapacitated <t color='#eb6a0f'>%1  <t color='#ffffff'> 15 pts";
	DK_vTxt_EnFiWnd = "<t shadow='2' color='#ffd11a' size = '.5'>Wounded <t color='#ffffff'>%1";

	DK_vTxt_FrFiKil = "<t shadow='2' color='#F00000' size = '.5'>Warning !  <t color='#ffd11a' size = '.5'>Killed your brother<t color='#F00000'> %1  <t color='#F00000' size = '.5'> -25 pts";
	DK_vTxt_FrFiIncap = "<t shadow='2' color='#F00000' size = '.5'>Warning !  <t color='#ffd11a' size = '.5'>Incapacitated your brother<t color='#eb6a0f'> %1  <t color='#F00000' size = '.5'> -25 pts";
	DK_vTxt_FrFi = "<t shadow='2' color='#F00000' size = '.5'>Warning !  <t color='#ffd11a' size = '.5'>Family fire on <t color='#ffffff'>%1  <t color='#F00000' size = '.5'> -1 pts";

	DK_vTxt_MedicKil = "<t shadow='2' color='#ffd11a' size = '.5'>Medics are your friends. <t color='#F00000' size = '.5'>Dont kill them !  <t color='#F00000' size = '.5'> " + (str (call DK_AMB_COST_KILL)) + " pts";

	// Incapa by
	DK_vTxt_incaByFr = "<t shadow='2' color='#ffd11a' size = '.5' shadow='2'>" + "Incapacitated by " + DK_vTxt_colorBluF;
	DK_vTxt_incaByEn = "<t shadow='2' color='#ffd11a' size = '.5' shadow='2'>" + "Incapacitated by " + DK_vTxt_colorRedF;

	// Killed by
	DK_vTxt_killedByFr = "<t shadow='2' color='#ffd11a' size = '.5' shadow='2'>" + "Killed by " + DK_vTxt_colorBluF;
	DK_vTxt_killedByEn = "<t shadow='2' color='#ffd11a' size = '.5' shadow='2'>" + "Killed by " + DK_vTxt_colorRedF;

///


// KILLFEED
DK_vTxt_formKF = "<t size='0.55' shadow='2'>";
DK_vTxt_TK_KF = "<t color='#FFFFFF'>  [TK]";
DK_vTxt_INC_KF = "<t color='#ff8c00'>  [Inc.]";

// PICTURE'S
DK_vImg_wrongWay = "<img size = '1.5' shadow='2' image='DK_Textures\UI\WrongWay.jpg'/>";
DK_vImg_logo = "<img size = '2.5' shadow='0' image='DK_Textures\UI\logoXs.paa'/>";

// HUD Timer countdown
DK_vTxt_cntDownMinLeft = "<t size='0.35' shadow='2' align='left'>min left";
DK_vTxt_cntDownMinLeft2 = "<t size='0.35' shadow='2' align='left' color='#FFE700'>min left";
DK_vTxt_cntDown1 = "<t size='0.5' shadow='2' align='right'>";
DK_vTxt_cntDown2 = "<t size='0.5' shadow='2' color='#FFE700' align='right'>";

// Bonus Ambulance
DK_vTxt_nfoActAmb = "<t color='#D8D819' shadow='2' size = '.7'>Use your action menu to call emergencies<br/><t color='#ffffff' shadow='2' size = '.43'>(The call is not visible if you do not try to use the action menu at least once to reappear)";

// HUD Info Player (money, points...)
DK_vTxt_nfoPlayerMoneyWallet = "<t align='left' size='0.55' shadow='2'>$ ";
DK_vTxt_nfoPlayerMoneySub = "<t color='#F00000' align='right' size='0.55' shadow='2'>";
DK_vTxt_nfoPlayerMoneyAdd = "<t color='#00FF11' align='right' size='0.55' shadow='2'>+";

DK_vTxt_nfoPlayerFamScr = "<t align='left' size='0.55' shadow='2'>";
DK_vTxt_nfoPlayerFamScrSub = "<t color='#F00000' align='right' size='0.55' shadow='2'>";
DK_vTxt_nfoPlayerFamScrAdd = "<t color='#0095ff' align='right' size='0.55' shadow='2'>+";

DK_vTxt_nfoPlayerFamTop1 = "<t size='0.5' shadow='2' align='left'>1. ";
DK_vTxt_nfoPlayerFamTop2 = "<t size='0.5' shadow='2' align='left'>2. ";
DK_vTxt_nfoPlayerFamTop3 = "<t size='0.5' shadow='2' align='left'>3. ";

DK_vTxt_nfoPlayerMatesNb = "<t align='left' size='0.55' shadow='2'>";



////////// MISSION \\\\\\\\\\\
DK_vTxt_MIS_hint_Kill =  DK_vTxt_colorKill + "<t size='1.9'>KILL</t><br/><t color='#FFFFFF' >";
DK_vTxt_MIS_hint_Take = DK_vTxt_colorTake + "<t size='1.9'>STEAL</t><br/><t color='#FFFFFF' >";
DK_vTxt_MIS_hint_nBringIt = DK_vTxt_colorRescue + "<t size='1.9'>BRING IT BACK</t><br/><t color='#FFFFFF' >";

DK_vTxt_MIS_hint_AA_gp = "<t size='0.95'><br/>-<br/>Gang squats have been marked on your map if you need AA launcher</t><br/><br/>";


DK_vTxt_MIS_hint_Cplt = "<t color='#00FF11' size='1.5'>MISSION<br/>COMPLETED</t>";
DK_vTxt_MIS_hint_Fail = "<t color='#E6292C' size='1.5'>MISSION<br/>FAILED</t>";

DK_vTxt_MIS_hint_FailTgDstrydP = " destroyed the vehicle";
DK_vTxt_MIS_hint_FailTgDstryd = "The vehicle was destroyed";

// Text down screen when objectif in your hands
DK_vTxt_MIS_haveVehRescue = "<t shadow='2' align='center' size = '.43'>You drive the objective<br/>" + DK_vTxt_colorTake +"<t size = '.45'> BRING IT BACK <t color='#FFFFFF' size = '.43'>to Petrovic at the destination<t color='#FAF200' size = '.45'> MARKED <t color='#FFFFFF' size = '.43'>on your map";



/// WANTED \\\
DK_vTxt_wtd_wtd = "<t shadow='2' color='#FFFFFF' size = '.5'>WANTED";
DK_vTxt_wtd_strs = "<t shadow='2' color='#FFFFFF' size = '.75'>";



// 3D Icon Mates
DK_vImg3d_arwMateDown = "\a3\ui_f\data\IGUI\Cfg\Actions\arrow_down_gs.paa";
DK_vImg3d_arwMateUp = "\a3\ui_f\data\IGUI\Cfg\Actions\arrow_up_gs.paa";

DK_vImg3d_arwMateFar = "\a3\ui_f\data\IGUI\Cfg\NonAIVehicles\camera_ca.paa";

//3D Icon Rewards box
DK_vImg3d_rewards = "\A3\ui_f\data\map\vehicleicons\iconCrateOrd_ca.paa";

// LIMITE 73 charac


/// Layer's DynamicText -- NE PAS UTILISER "301"
DK_lyDyn_logoF = 10002;
DK_lyDyn_logo = 10001;
DK_lyDyn_fadeBlack = 10000;

DK_lyDyn_spawnWay = 900;

DK_lyDyn_wounded1 = 666;
DK_lyDyn_wounded2 = 667;
DK_lyDyn_wounded3 = 668;
DK_lyDyn_wounded4 = 669;
DK_lyDyn_wounded5 = 670;
DK_lyDyn_wounded6 = 671;

DK_lyDyn_woundedFr1 = 660;
DK_lyDyn_woundedFr2 = 661;
DK_lyDyn_woundedFr3 = 662;
DK_lyDyn_woundedFr4 = 663;
DK_lyDyn_woundedFr5 = 664;
DK_lyDyn_woundedFr6 = 665;

DK_lyDyn_KF1 = 672;
DK_lyDyn_KF2 = 673;
DK_lyDyn_KF3 = 674;
DK_lyDyn_KF4 = 675;
DK_lyDyn_KF5 = 676;

DK_lyDyn_suicide = 677;

DK_lyDyn_nfoPlayerMoneyAdd = 490;
DK_lyDyn_nfoPlayerMoneySub = 495;
DK_lyDyn_nfoPlayerMoneyWallet = 500;

DK_lyDyn_nfoPlayerFamScrAdd = 505;
DK_lyDyn_nfoPlayerFamScrSub = 510;
DK_lyDyn_nfoPlayerFamScr = 515;

DK_lyDyn_nfoPlayerMatesNb = 701;


DK_lyDyn_downScrnHaveRescue = 520;
DK_lyDyn_rfr = 521;
DK_lyDyn_Wanted = 522;
DK_lyDyn_Stars = 523;

DK_lyDyn_nfoPlayerFamTop1 = 530;
DK_lyDyn_nfoPlayerFamTop2 = 531;
DK_lyDyn_nfoPlayerFamTop3 = 532;

DK_lyDyn_tips = 700;

DK_lyDyn_spwnProtctActNFO = 50;
DK_lyDyn_countSPANFO = 51;

DK_lyDyn_LowFuel = 41;
DK_lyDyn_jump = 42;

DK_lyDyn_cntDwn1 = 52;
DK_lyDyn_cntDwn2 = 53;

DK_lyDyn_amb = 54;



