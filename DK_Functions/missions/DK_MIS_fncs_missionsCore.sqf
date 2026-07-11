if !(isServer) exitWith {};


#define txtrOffR01 ["a3\soft_f\offroad_01\data\offroad_01_ext_base01_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base04_co.paa","a3\soft_f_enoch\offroad_01\data\offroad_01_ext_grn_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_co.paa","a3\soft_f\offroad_01\data\offroad_01_ext_base02_co.paa"]


#define DelInCUM(TODEL) private _nul = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find TODEL)
#define DelInEmpV(TODEL) private _nul = DK_emptyVeh deleteAt (DK_emptyVeh find TODEL)

#define chckExpEng(V,EH) [V,EH] call DK_fnc_check_exploseEngine
#define chckSmkEng(V,EH) [V,EH] spawn DK_fnc_check_smokeEngine

#define crtV(C) createVehicle [C, [random 500,random 500,2000 + (random 100)], [], 0, "CAN_COLLIDE"]
#define crtU(G,C) G createUnit [C, [0,0,50], [], 0, "CAN_COLLIDE"]

#define vehCls selectRandom DK_classVeh_cls
#define vehSprtOffrd selectRandom DK_classVeh_SprtOffrd
#define vehOffrd selectRandom DK_classVeh_Offrd

#define projectAir ["M_Titan_AA", "M_Titan_AP", "M_Titan_AT", "R_PG7_F", "DemoCharge_Remote_Ammo", "SatchelCharge_Remote_Ammo", "R_PG32V_F", "R_TBG32V_F", "M_Vorona_HEAT", "M_Vorona_HE"]

/*
#define DK_animsPrimWpDel(A) private _nul = DK_animsPrimWp deleteAt (DK_animsPrimWp find A)
//#define animsPrimWp ["Acts_Ambient_Aggressive", "Acts_Ambient_Agreeing", "Acts_Ambient_Approximate", "Acts_Ambient_Cleaning_Nose", "Acts_Ambient_Defensive", "Acts_Ambient_Disagreeing", "Acts_Ambient_Disagreeing_with_pointing", "Acts_Ambient_Facepalm_1", "Acts_Ambient_Facepalm_2", "Acts_Ambient_Gestures_Sneeze", "Acts_Ambient_Gestures_Tired", "Acts_Ambient_Gestures_Yawn", "Acts_Ambient_Huh", "Acts_Ambient_Picking_Up", "Acts_Ambient_Relax_1", "Acts_Ambient_Relax_2", "Acts_Ambient_Relax_3", "Acts_Ambient_Relax_4", "Acts_Ambient_Rifle_Drop", "Acts_Ambient_Shoelaces", "Acts_Ambient_Stretching"]
#define animsPrimWp ["Acts_Ambient_Agreeing", "Acts_Ambient_Approximate", "Acts_Ambient_Cleaning_Nose", "Acts_Ambient_Defensive", "Acts_Ambient_Disagreeing", "Acts_Ambient_Facepalm_1", "Acts_Ambient_Facepalm_2", "Acts_Ambient_Gestures_Sneeze", "Acts_Ambient_Gestures_Tired", "Acts_Ambient_Gestures_Yawn", "Acts_Ambient_Huh", "Acts_Ambient_Relax_2", "Acts_Ambient_Rifle_Drop", "Acts_Ambient_Shoelaces", "Acts_Ambient_Stretching"]
DK_animsPrimWp = +animsPrimWp;
*/

/// Compile Variable

// Sound
#define victorySnd ["snd_MisCplt1", "snd_MisCplt2", "snd_MisCplt3", "snd_MisCplt4"]
DK_victorySnd = +victorySnd;


// Hint random Insult, Contain car etc
#define insultKill ["fucking", "bastards", "wankers", "assholes", "dumbass"]
DK_insultKill = +insultKill;

#define containTakeCar ["cocaine", "canabis", "tsipouro", "heroin", "weapons", "crystal meth", "organs", "opium", "ecstasy", "ketamine"]
DK_containTakeCar = + containTakeCar;


#define VIPcivRole ["the crack smoking usher", "the lawyer Tom Goldberg", "the wacky scientist", "the unfaithful banker"]
DK_VIPcivRole = +VIPcivRole;

#define IDAProle ["the director of IDAP", "the IDAP smuggler"]
DK_IDAProle = +IDAProle;

#define medRole ["the surgeon of Petrovic wife", "the virologist Roualt"]
DK_medRole = +medRole;

#define copsRole ["the venal commissioner", "that rapist motherfucker"]
DK_copsRole = +copsRole;

#define albaRole ["the Albanian cook", "the Albanian cook"]
DK_albaRole = +albaRole;

#define domiRole ["the illuminated Dominican", "the Dominican sorcerer"]
DK_domiRole = +domiRole;

#define VIParmyRole ["Colonel ", "Petrovic's old friend, General "]
DK_VIParmyRole = +VIParmyRole;




// Classes
DK_classVeh_cls = ["C_SUV_01_F","C_SUV_01_F","B_G_Offroad_01_F","B_G_Offroad_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F"];
DK_classVeh_SprtOffrd = ["B_G_Offroad_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F"];
DK_classVeh_Offrd = ["B_G_Offroad_01_F","C_Offroad_02_unarmed_F"];
DK_classVeh_Triads = "C_Hatchback_01_sport_F";
DK_classVeh_Ballas = "B_G_Offroad_01_F";
DK_classVeh_DomiLMG = "I_C_Offroad_02_LMG_F";
DK_classVeh_DomiAT = "I_C_Offroad_02_AT_F";
DK_classVeh_Domi = "I_C_Offroad_02_unarmed_F";
DK_classVeh_AlbanHMG = "I_G_Offroad_01_armed_F";
DK_classVeh_AlbanAT = "I_G_Offroad_01_AT_F";
DK_classVeh_Alban = "I_G_Offroad_01_F";

#define classVehTC_cls ["C_SUV_01_F", "B_G_Offroad_01_F", "C_Hatchback_01_F", "C_Offroad_02_unarmed_F"]
DK_classVehTcOdr_cls = +classVehTC_cls;


/// Compile Functions

// Technical
DK_MIS_create_ID_mission = {

	("DK_MIS_ID_ThisMission" + (str DK_nbMisCpltd))
};

DK_MIS_TakeCar_searchMoreRescuePlace = {

	private ["_pos", "", ""];


	for "_i" from 0 to 25 step 1 do
	{
		_pos = selectRandom DK_MIS_posStart_K01;

	//	_pos
	};
};

DK_MIS_Kill_mkrTargets = {

	params ["_allUnits", "_idMission"];


	private ["_mkr1", "_mkr2", "_nil"];
	_allUnits = +_allUnits;

	{
		if (!isNil "_x") then
		{
			deleteMarker _x;
		};

	} count DK_MIS_tgMarkers;

	DK_MIS_tgMarkers = [];
	private _mkrNb = 0;
	{
		_mkrNb = _mkrNb + 1;

		_mkr1 = createMarker  [("DK_mkr" + _idMission + (str _mkrNb)), _x];
		_mkr1 setMarkerType "hd_dot";
		_mkr1 setMarkerColor "ColorRed";
		_mkr1 setMarkerSize [0.8,0.8];

		_x setVariable ["hisMkr", _mkr1, true];

		_nil = DK_MIS_tgMarkers pushBackUnique _mkr1;

	} count _allUnits;


	while { (DK_MIS_var_missInProg) } do
	{
		{
			call
			{
				if (alive _x) exitWith
				{
					(_x getVariable "hisMkr") setMarkerPos (getPosATLVisual _x);
				};

				_mkr2 = _x getVariable "hisMkr";
				if (!isNil "_mkr2") then
				{
					deleteMarker _mkr2;
					DK_MIS_tgMarkers deleteAt (DK_MIS_tgMarkers find _mkr2);
					_nil = _allUnits deleteAt (_allUnits find _x);
				};
				
			};

		} count _allUnits;

		uiSleep 0.08;
	};

	{
		if (!isNil "_x") then
		{
			deleteMarker _x;
		};

	} count DK_MIS_tgMarkers;
};



// Divers for vehicles & props
DK_MIS_fnc_crtVeh_cls = {

	params [["_initVeh", true], ["_byOrder", false]];


	private "_class";
	call
	{
		if _byOrder exitWith
		{
			_nbPlayerMaxInTeam = ([] call DK_fnc_cntMaxPlyrsByFam) # 0;

			if (_nbPlayerMaxInTeam isEqualTo 2) exitWith
			{
				_class = "B_G_Offroad_01_F";
			};

			_class = selectRandom DK_classVehTcOdr_cls;
			private _nul = DK_classVehTcOdr_cls deleteAt (DK_classVehTcOdr_cls find _class);

			if (DK_classVehTcOdr_cls isEqualTo []) then
			{
				DK_classVehTcOdr_cls = +classVehTC_cls;
				_nul = DK_classVehTcOdr_cls deleteAt (DK_classVehTcOdr_cls find _class);
			};
		};

		_class = vehCls;
	};

	_veh = crtV(_class);

	[_veh, _class] call DK_fnc_CLAG_vehColor;


	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVan_looters = {

	params [["_initVeh", true]];


	_veh = crtV("C_Van_01_transport_F");

	[
		_veh,
		[selectRandom ["Guerilla_08", "Guerilla_03", "Guerilla_02"], 1], 
		true

	] call BIS_fnc_initVehicle;


	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtQuad_looters = {

	params [["_initVeh", true]];


	_veh = crtV("C_Quadbike_01_F");

	[
		_veh,
		["Black", 1], 
		true

	] call BIS_fnc_initVehicle;


	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_sprtOffrd = {

	params [["_initVeh", true]];

	private _class = vehSprtOffrd;

	_veh = crtV(_class);

	[_veh, _class] call DK_fnc_CLAG_vehColor;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_offrd = {

	params [["_initVeh", true]];

	private _class = vehOffrd;

	private _veh = crtV(_class);

	[_veh, _class] call DK_fnc_CLAG_vehColor;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Ballas = {

	params [["_initVeh", true], ["_haveMP3", false], ["_MP3on", true]];


	_veh = crtV(DK_classVeh_Ballas);

	[
		_veh,
		["Green",1], 
		["HideDoor1",0,"HideDoor2",0,"HideDoor3",0,"HideBackpacks",1,"HideBumper1",1,"HideBumper2",0,"HideConstruction",0,"hidePolice",1,"HideServices",1,"BeaconsStart",0,"BeaconsServicesStart",0]

	] call BIS_fnc_initVehicle;

	_veh setObjectTextureGlobal [0, "a3\soft_f\offroad_01\data\offroad_01_ext_base05_co.paa"];

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	if _haveMP3 then
	{
		[_veh, _MP3on, [["MP3music02", 18.125], ["MP3music03", 14.793], ["MP3music04", 24], ["MP3music07", 40.435], ["MP3music05", 8]]] spawn DK_fnc_MP3car_init;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Triads = {

	params [["_initVeh", true], ["_haveMP3", false], ["_MP3on", true]];

	_veh = crtV(DK_classVeh_Triads);

	[
		_veh,
		["Orange",1], 
		true

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	if _haveMP3 then
	{
		[_veh, _MP3on, [["MP3music01", 32], ["MP3music06", 35.559], ["MP3music08", 23.001]]] spawn DK_fnc_MP3car_init;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_DomiGun = {

	params [["_initVeh", true], ["_weaponType", "LMG"]];


	private "_veh";

	call
	{
		if (_weaponType isEqualTo "LMG") exitWith
		{
			_veh = crtV(DK_classVeh_DomiLMG);
		};

		_veh = crtV(DK_classVeh_DomiAT);
	};

	[
		_veh,
		["Brown",1], 
		["hideLeftDoor",0,"hideRightDoor",0,"hideRearDoor",1,"hideFenders",1,"hideHeadSupportFront",1,"hideSpareWheel",1]

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Domi = {

	params [["_initVeh", true]];


	_veh = crtV(DK_classVeh_Domi);

	[
		_veh,
		["Brown",1], 
		["hideLeftDoor",0,"hideRightDoor",0,"hideRearDoor",1,"hideBullbar",0,"hideFenders",1,"hideHeadSupportRear",1,"hideHeadSupportFront",1,"hideRollcage",1,"hideSeatsRear",0,"hideSpareWheel",1]

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_AlbanGun = {

	params [["_initVeh", true], ["_weaponType", "HMG"]];


	private "_veh";

	call
	{
		if (_weaponType isEqualTo "HMG") exitWith
		{
			_veh = crtV(DK_classVeh_AlbanHMG);
		};

		_veh = crtV(DK_classVeh_AlbanAT);
	};

	[
		_veh,
		["Guerilla_" + (selectRandom ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]),1], 
		["HideDoor1",0,"HideDoor2",0,"HideDoor3",1,"HideBackpacks",0,"HideBumper1",1,"HideBumper2",0,"HideConstruction",0]

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};

DK_MIS_fnc_crtVeh_Alban = {

	params [["_initVeh", true]];


	_veh = crtV(DK_classVeh_Alban);

	[
		_veh,
		["Guerilla_" + (selectRandom ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]),1], 
		["HideDoor1",0,"HideDoor2",0,"HideDoor3",1,"HideBackpacks",0,"HideBumper1",1,"HideBumper2",0,"HideConstruction",0,"hidePolice",1,"HideServices",1,"BeaconsStart",0,"BeaconsServicesStart",0]

	] call BIS_fnc_initVehicle;

	if _initVeh then
	{
		_veh call DK_MIS_fnc_initVeh;
	};

	_veh setUnloadInCombat [FALSE,FALSE]; 


	_veh
};


DK_MIS_fnc_initVeh = {

	addToRemainsCollector [_this];
	clearItemCargoGlobal _this;


	_this setVariable ["DK_actRepOFF", true];

	/// Set some variable's according to vehicle type -- 0 & 1 = explose & smoke engine -  2 = index Hull (then explose vehicle)
	private _vehType = typeOf _this;
	switch (_vehType) do
	{
		case "C_Offroad_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "B_G_Offroad_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "C_SUV_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeSUV,DK_fnc_smokeAloneSUV,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_SUV", 0, _this];
		};
		case "C_Offroad_02_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WD,DK_fnc_smokeAloneMB_4WD,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "C_Hatchback_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeHB,DK_fnc_smokeAloneHB,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Hatchback", 0, _this];
		};
		case "C_Hatchback_01_sport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeHB,DK_fnc_smokeAloneHB,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Hatchback", 0, _this];
		};
		case "C_Van_01_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeTruck,DK_fnc_smokeAloneTruck,20]];
			_this remoteExecCall ["DK_addEH_handleDmg_Truck", 0, _this];
		};
		case "C_Van_01_box_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeTruck,DK_fnc_smokeAloneTruck,20]];
			_this remoteExecCall ["DK_addEH_handleDmg_Truck", 0, _this];
		};
		case "C_Van_02_vehicle_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "C_Van_02_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "B_GEN_Van_02_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "C_Truck_02_covered_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeZamack,DK_fnc_smokeAloneZamack,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Zamack", 0, _this];
		};
		case "C_Truck_02_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeZamack,DK_fnc_smokeAloneZamack,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Zamack", 0, _this];
		};
		case "I_C_Offroad_02_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WD,DK_fnc_smokeAloneMB_4WD,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "I_C_Offroad_02_LMG_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WDarmed,DK_fnc_smokeAloneMB_4WD,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "I_C_Offroad_02_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WDarmed,DK_fnc_smokeAloneMB_4WD,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "I_G_Offroad_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "I_G_Offroad_01_armed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoadArmed,DK_fnc_smokeAloneOffRoadArmed,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "I_G_Offroad_01_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoadArmed,DK_fnc_smokeAloneOffRoadArmed,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "C_Offroad_01_repair_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "C_Van_02_service_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "C_Van_02_medevac_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};

		case "B_T_LSV_01_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_Prowler", 0, _this];
		};
		case "B_LSV_01_armed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_Prowler", 0, _this];
		};
		case "B_T_LSV_01_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_Prowler", 0, _this];
		};

		case "C_Quadbike_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeQuad, DK_fnc_smokeAloneQuad, 19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Quad", 0, _this];
		};
	};


	if !(_vehType in ["I_MRAP_03_F", "I_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F", "I_MBT_03_cannon_F"]) then
	{
		_this addEventHandler ["Dammaged",
		{
			params ["_veh", "_selection", "_damage", "_hitIndex", "_hitPoint"];

		///	// Check for spawn fired engine & explose this
			if (_hitPoint isEqualTo "hitengine") then
			{
				if (_damage > 0.89) then
				{
					chckExpEng(_veh,_thisEventHandler);
				};
			};

		///	// Check for create smoked engine if veh is dead
			if (_hitPoint isEqualTo "hithull") then
			{
				chckSmkEng(_veh,_thisEventHandler);
			};

		///	// Check for activate repair field
			if ( (_veh getVariable ["DK_actRepOFF", true]) && { (_veh call zlt_fnc_vehicledamaged) } ) then
			{
				_veh setVariable ["DK_actRepOFF", false];
				private _idActRepair = _veh remoteExecCall ["DK_addActRepair", DK_isDedi, true];
				_veh setVariable ["DK_IDzltRepair", _idActRepair];
			};
		}];

		_this addMPEventHandler ["mpKilled",
		{
			_this call DK_fnc_Eh_MPkilledVeh;
		}];

		_this addEventHandler ["Deleted",
		{
			params ["_veh"];

			private _idActRepair = _veh getVariable "DK_IDzltRepair";
			if (!isNil "_idActRepair") then
			{
				remoteExecCall ["", _idActRepair];
			};

			private _idFlipJIP = _veh getVariable "idFlipJIP";
			if (!isNil "_idFlipJIP") then
			{
				remoteExecCall ["", _idFlipJIP];
			};
		}];
	};
};

DK_MIS_fnc_initVehWhenEnd = {

	if ( (isNil "_this") OR (isNull _this) OR (!alive _this) ) exitWith {};


	if !(_this getVariable ["initVehEnd", false]) then
	{
		_this setVariable ["initVehEnd", true];

		private _nil = DK_emptyVeh pushBackUnique _this;
	};
};

DK_MIS_TakeCar_initVeh = {

	addToRemainsCollector [_this];
	clearItemCargoGlobal _this;


	_this setVariable ["DK_actRepOFF", true];

	/// Set some variable's according to vehicle type -- 0 & 1 = explose & smoke engine -  2 = index Hull (then explose vehicle)
	switch (typeOf _this) do
	{
		case "C_Offroad_01_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_OffRoad", 0, _this];
			_this setVariable ["DK_score", DK_scrOffroadTC];
		};
		case "B_G_Offroad_01_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_OffRoad", 0, _this];
			_this setVariable ["DK_score", DK_scrOffroadTC];
		};
		case "C_SUV_01_F" :		// Road : 51 km/h	Offroad : 39 km/h
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_SUV", 0, _this];
			_this setVariable ["DK_score", DK_scrSuvTC];
		};
		case "C_Offroad_02_unarmed_F" :	// Road : 51 km/h	Offroad : 51 km/h
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Jeep", 0, _this];
			_this setVariable ["DK_score", DK_scrJeepTC];
		};
		case "C_Hatchback_01_F" :	// Road : 78 km/h	Offroad : 44 km/h
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Hatchback", 0, _this];
			_this setVariable ["DK_score", DK_scrHatchTC];
		};
		case "C_Hatchback_01_sport_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Hatchback", 0, _this];
			_this setVariable ["DK_score", DK_scrHatchSpTC];
		};
		case "C_Van_01_transport_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Truck", 0, _this];
		};
		case "C_Van_01_box_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Truck", 0, _this];
		};
		case "C_Van_02_vehicle_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Van", 0, _this];
		};
		case "C_Van_02_transport_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Van", 0, _this];
		};
		case "C_Truck_02_covered_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Zamack", 0, _this];
		};
		case "C_Truck_02_transport_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Zamack", 0, _this];
		};
		case "I_C_Offroad_02_unarmed_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Jeep", 0, _this];
			_this setVariable ["DK_score", DK_scrJeepTC];
		};
		case "I_C_Offroad_02_LMG_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Jeep", 0, _this];
			_this setVariable ["DK_score", DK_scrJeepTC];
		};
		case "I_C_Offroad_02_AT_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Jeep", 0, _this];
			_this setVariable ["DK_score", DK_scrJeepTC];
		};
		case "I_G_Offroad_01_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_OffRoad", 0, _this];
			_this setVariable ["DK_score", DK_scrOffroadTC];
		};
		case "I_G_Offroad_01_armed_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_OffRoad", 0, _this];
			_this setVariable ["DK_score", DK_scrOffroadTC];
		};
		case "I_G_Offroad_01_AT_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_OffRoad", 0, _this];
			_this setVariable ["DK_score", DK_scrOffroadTC];
		};
		case "C_Offroad_01_repair_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_OffRoad", 0, _this];
		};
		case "C_Van_02_service_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Van", 0, _this];
		};
		case "C_Van_02_medevac_F" :
		{
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Van", 0, _this];
		};

		case "B_T_LSV_01_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Prowler", 0, _this];
		};
		case "B_LSV_01_armed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Prowler", 0, _this];
		};
		case "B_T_LSV_01_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Prowler", 0, _this];
		};

		case "C_Quadbike_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeQuad, DK_fnc_smokeAloneQuad, 19]];
			_this remoteExecCall ["DK_addEH_handleDmg_TC_Quad", 0, _this];
		};
	};


	_this addEventHandler ["Dammaged",
	{
		params ["_veh", "_selection", "_damage", "_hitIndex", "_hitPoint"];


	///	// Check for create smoked engine if veh is dead
		if (_hitPoint isEqualTo "hithull") then
		{
			chckSmkEng(_veh,_thisEventHandler);
		};

	///	// Check for activate repair field
		if ( (_veh getVariable ["DK_actRepOFF", true]) && { (_veh call zlt_fnc_vehicledamaged) } ) then
		{
			_veh setVariable ["DK_actRepOFF", false];

			private _idActRepair = _veh getVariable "DK_IDzltRepair";
			call
			{
				if (isNil "_idActRepair") exitWith
				{
					_idActRepair = _veh remoteExecCall ["DK_addActRepair", DK_isDedi, true];
				};

				_idActRepair = _veh remoteExecCall ["DK_addActRepair", DK_isDedi, _idActRepair];
			};

			_veh setVariable ["DK_IDzltRepair", _idActRepair];
		};
	}];

	_this addMPEventHandler ["mpKilled",
	{
		_this call DK_fnc_Eh_MPkilledVeh;
	}];

	_this addEventHandler ["GetIn",
	{
		params ["_vehicle", "_role", "_unit"];


		if (_role isEqualTo "driver") then
		{
			_vehicle setVariable ["driverChange", _unit];
		};
	}];
	
	_this addEventHandler ["SeatSwitched",
	{
		params ["_vehicle", "_unit1"];
	

		if (driver _vehicle isEqualTo _unit1) then
		{
			_vehicle setVariable ["driverChange", _unit1];
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_veh"];

		private _idActRepair = _veh getVariable "DK_IDzltRepair";
		if (!isNil "_idActRepair") then
		{
			remoteExecCall ["", _idActRepair];
		};

		private _idFlipJIP = _veh getVariable "idFlipJIP";
		if (!isNil "_idFlipJIP") then
		{
			remoteExecCall ["", _idFlipJIP];
		};
	}];
};


DK_MIS_reInitVehNormal = {

	if ( (isNil "_this") OR (isNull _this) OR (!alive _this) ) exitWith {};


	if (_this getVariable ["DK_actRepOFF", ""] isEqualTo "") then
	{
		_this setVariable ["DK_actRepOFF", true];
	};

	addToRemainsCollector [_this];

	/// Set some variable's according to vehicle type -- 0 & 1 = explose & smoke engine -  2 = index Hull (then explose vehicle)
	_this remoteExecCall ["DK_fnc_removeEhHd_cl", DK_isDedi];


	if (isNil {_this getVariable "idFlipJIP"}) then
	{
		private _idFlipJIP = _this remoteExecCall ["DK_addAction_flipVeh", DK_isDedi, true];
		_this setVariable ["idFlipJIP", _idFlipJIP];
	};


	switch (typeOf _this) do
	{
		case "C_Offroad_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "B_G_Offroad_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "C_SUV_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeSUV,DK_fnc_smokeAloneSUV,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_SUV", 0, _this];
		};
		case "C_Offroad_02_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WD,DK_fnc_smokeAloneMB_4WD,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "C_Hatchback_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeHB,DK_fnc_smokeAloneHB,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Hatchback", 0, _this];
		};
		case "C_Hatchback_01_sport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeHB,DK_fnc_smokeAloneHB,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Hatchback", 0, _this];
		};
		case "C_Van_01_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeTruck,DK_fnc_smokeAloneTruck,20]];
			_this remoteExecCall ["DK_addEH_handleDmg_Truck", 0, _this];
		};
		case "C_Van_01_box_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeTruck,DK_fnc_smokeAloneTruck,20]];
			_this remoteExecCall ["DK_addEH_handleDmg_Truck", 0, _this];
		};
		case "C_Van_02_vehicle_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "C_Van_02_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "C_Truck_02_covered_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeZamack,DK_fnc_smokeAloneZamack,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Zamack", 0, _this];
		};
		case "C_Truck_02_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeZamack,DK_fnc_smokeAloneZamack,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Zamack", 0, _this];
		};
		case "C_Offroad_01_repair_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "C_Van_02_service_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "C_Van_02_medevac_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "B_GEN_Van_02_transport_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeVan,DK_fnc_smokeAloneVan,4]];
			_this remoteExecCall ["DK_addEH_handleDmg_Van", 0, _this];
		};
		case "I_C_Offroad_02_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WD,DK_fnc_smokeAloneMB_4WD,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "I_C_Offroad_02_LMG_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WDarmed,DK_fnc_smokeAloneMB_4WDArmed,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};
		case "I_G_Offroad_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoad,DK_fnc_smokeAloneOffRoad,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "I_G_Offroad_01_armed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoadArmed,DK_fnc_smokeAloneOffRoadArmed,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "I_G_Offroad_01_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeOffRoadArmed,DK_fnc_smokeAloneOffRoadArmed,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_OffRoad", 0, _this];
		};
		case "I_C_Offroad_02_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeMB_4WDarmed,DK_fnc_smokeAloneMB_4WDArmed,19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Jeep", 0, _this];
		};

		case "B_T_LSV_01_unarmed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_Prowler", 0, _this];
		};
		case "B_LSV_01_armed_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_Prowler", 0, _this];
		};
		case "B_T_LSV_01_AT_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeProwler, DK_fnc_smokeAloneProwler, 5]];
			_this remoteExecCall ["DK_addEH_handleDmg_Prowler", 0, _this];
		};

		case "C_Quadbike_01_F" :
		{
			_this setVariable ["DK_typeOf", [DK_fnc_smokeQuad, DK_fnc_smokeAloneQuad, 19]];
			_this remoteExecCall ["DK_addEH_handleDmg_Quad", 0, _this];
		};
	};


	private _idsEhDynSim = _this getVariable "DK_idEhDynSim";
	if (!isNil "_idsEhDynSim") then
	{
		_idsEhDynSim params ["_idEhDynSim01", "_idEhDynSim02"];
		_this removeEventHandler ["GetIn", _idEhDynSim01];
		_this removeEventHandler ["GetOut", _idEhDynSim02];
	};

	_this addEventHandler ["GetIn",
	{
		params ["_veh"];

		// Manage Clean Up
		if !( (crew _veh) findIf {alive _x} isEqualTo -1 ) then
		{
			DelInCUM(_veh);
			_veh setVariable ["cleanUpOn",false];
			DK_emptyVeh pushBackUnique _veh;
		};
	}];


	_this addEventHandler ["Dammaged",
	{
		params ["_veh", "_selection", "_damage", "_hitIndex", "_hitPoint"];

		// Check for spawn fired engine & explose this
		if (_hitPoint isEqualTo "hitengine") then
		{
			if (_damage > 0.89) then
			{
				chckExpEng(_veh,_thisEventHandler);
			};
		};

		// Check for create smoked engine if veh is dead
		if (_hitPoint isEqualTo "hithull") then
		{
			chckSmkEng(_veh,_thisEventHandler);
		};

		///	// Check for activate repair ON
		if ( (_veh getVariable ["DK_actRepOFF", true]) && { (_veh call zlt_fnc_vehicledamaged) } ) then
		{
			_veh setVariable ["DK_actRepOFF", false];
			private _idActRepair = _veh remoteExecCall ["DK_addActRepair", allPlayers, _veh];
			_veh setVariable ["DK_IDzltRepair", _idActRepair];
		};

	}];

	_this addEventHandler ["Killed",
	{
		params ["_veh"];

		_veh setVariable ["cleanUpOn",true];
		DelInEmpV(_veh);
		DelInCUM(_veh);

		_veh remoteExecCall ["DK_fnc_removeActRepair", DK_isDedi];
		private _idActRepair = _veh getVariable "DK_IDzltRepair";
		if (!isNil "_idActRepair") then
		{
			remoteExecCall ["", _idActRepair];
		};

		private _idFlipJIP = _veh getVariable "idFlipJIP";
		if (!isNil "_idFlipJIP") then
		{
			remoteExecCall ["", _idFlipJIP];
		};
	}];

	_this addEventHandler ["Deleted",
	{
		params ["_veh"];

		private _idActRepair = _veh getVariable "DK_IDzltRepair";
		if (!isNil "_idActRepair") then
		{
			remoteExecCall ["", _idActRepair];
		};

		private _idFlipJIP = _veh getVariable "idFlipJIP";
		if (!isNil "_idFlipJIP") then
		{
			remoteExecCall ["", _idFlipJIP];
		};
	}];
};

DK_MIS_fnc_vehicle_removeAllEH = {

	if ( (isNil "_this") OR (isNull _this) ) exitWith {};

	_this removeAllEventHandlers "Hit";
	_this removeAllEventHandlers "Killed";
	_this removeAllEventHandlers "Dammaged";
	_this removeAllEventHandlers "GetIn";
	_this removeAllEventHandlers "GetOut";
	_this removeAllEventHandlers "handleDamage";

	private _ehIdKilled = _this getVariable "ehIdKilled";
	if (!isNil "_ehIdKilled") then
	{
		_this removeMPEventHandler ["MPKilled", _ehIdKilled];
	};
};


DK_MIS_slctObjLinkToAI = {

	private "_classObjectMiddleAI";

	call
	{
		if (rain > 0) exitWith
		{
			_classObjectMiddleAI = selectRandom ["Land_cargo_addon02_V1_F","Land_cargo_addon02_V2_F"];
		};

		if ( (call DK_fnc_checkIfNight) OR (overcast > 0.45) ) exitWith
		{
			_classObjectMiddleAI = selectRandom ["FirePlace_burning_F","Campfire_burning_F"];
		};

		_classObjectMiddleAI = selectRandom ["Land_Campfire_F","Land_WoodenLog_F","Land_FirePlace_F"];
	};

	_classObjectMiddleAI
};


DK_MIS_fnc_breakEngine = {

	params ["_vehicle", "_idMission"];


	private ["_crateSmk", "_time", "_enginHit"];

	while { (!isNull _vehicle) && { (alive _vehicle) && { (_idMission isEqualTo DK_idMission) } } } do
	{
		waitUntil { uiSleep 0.5; (isNil "_vehicle") OR (isNull _vehicle) OR (!alive _vehicle) OR (speed _vehicle > 40) OR (speed _vehicle < -50) OR !(_idMission isEqualTo DK_idMission) };

		if ( (isNull _vehicle) OR (!alive _vehicle) OR !(_idMission isEqualTo DK_idMission) ) exitWith {};


		// Break Engine Half when speed is more than 40 km/h
		[_vehicle, "hitengine", 0.49] remoteExecCall ["DK_fnc_setHitPoint", _vehicle];

		// Create box Engine Smoke for 4 sec
		_crateSmk = _vehicle call DK_fnc_crtBoxSMokeEngine;
		[_vehicle, "vtolHit1", 500, 0.5 + (random 1.2), true] call DK_fnc_say3D;
		uiSleep 4;
		deleteVehicle _crateSmk;

		// Loop waiting Engin is used more than 40 km/h until 60 sec

		for "_i" from 0 to 60 do
		{
			_time = time + 1;

			waitUntil { uiSleep 0.4; (isNil "_vehicle") OR (isNull _vehicle) OR (!alive _vehicle) OR !(_idMission isEqualTo DK_idMission) OR (_vehicle getHitPointDamage "HitEngine" > 0.9) OR (_vehicle getHitPointDamage "HitEngine" isEqualTo 0) OR ((time > _time) && { (speed _vehicle > 40) }) };

			if ( (isNil "_vehicle") OR (isNull _vehicle) OR (!alive _vehicle) OR !(_idMission isEqualTo DK_idMission) OR (_vehicle getHitPointDamage "HitEngine" > 0.9) OR (_vehicle getHitPointDamage "HitEngine" isEqualTo 0) ) exitWith {};
		};

		if ( (isNil "_vehicle") OR (isNull _vehicle) OR (!alive _vehicle) OR !(_idMission isEqualTo DK_idMission) ) exitWith {};

		// Break Engine Full
		_enginHit = _vehicle getHitPointDamage "HitEngine";

		if ( !(_enginHit isEqualTo 1) && { !(_enginHit isEqualTo 0) } ) then
		{
			[_vehicle, "hitengine", 1] remoteExecCall ["DK_fnc_setHitPoint", _vehicle];
		};

		if !(_enginHit isEqualTo 0) then
		{
			_crateSmk = _vehicle call DK_fnc_crtBoxSMokeEngine;
			[_vehicle, "vtolHit1", 500, 0.5 + (random 1.2), true] call DK_fnc_say3D;

			uiSleep 0.65;
			[_vehicle, "vtolHit2", 500, 0.5 + (random 1.2), true] call DK_fnc_say3D;

			uiSleep 15;

			if ( (!isNil "_crateSmk") && { (!isNull _crateSmk) } ) then
			{
				deleteVehicle _crateSmk;
			};
		};
	};
};

DK_fnc_crtBoxSMokeEngine = {

	_crateSmk = createVehicle ["Box_NATO_Grenades_F", [0,0,200], [], 0, "CAN_COLLIDE"];
	_crateSmk hideObjectGlobal true;
	_crateSmk disableCollisionWith _this;
	_crateSmk attachTo [_this, [0,1.5,-0.7]];
	_crateSmk setDamage 1;


	_crateSmk
};


DK_MIS_fnc_wpDriver = {

	params ["_grp", "_distance", "_rdmPos", "_nil", "_pos"];


	private _unit = leader _grp;
	private _exit = false;
	private _veh = vehicle _unit;
	private _blackArea = +DK_mkrs_spawnProtect + ["DK_MTW_mkr_limitMap_1"];

	private _allRoads = (_unit getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) - 20) + (random 40) ]) nearRoads (_distance /2);

	if (count _allRoads > 70) then
	{
		_allRoads = [_allRoads, 1.5] call DK_fnc_shuffleDiviseArray;
	};

	private _angle = selectRandom [1,2];
	private _angleLaps = 0;
	private _time = time + 12;
	private _cnt = (count _allRoads) + 15000;

	for "_i" from 0 to _cnt do
	{
		if !(_allRoads isEqualTo []) then
		{
	//		hint ("allRoads : " + (str _cnt) + " : " + (str _i));

			_rdmPos = selectRandom _allRoads;

			if ( (!isNil "_rdmPos") && { (_blackArea findIf { (getMarkerPos  _x) distance2D _rdmPos < 2000 } isEqualTo -1) && { (DK_blackListWP findIf { _rdmPos inArea _x } isEqualTo -1) && { ((nearestTerrainObjects [_rdmPos, [], 20, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) } } } ) exitWith
			{
				_exit = true;
			};

			_nil = _allRoads deleteAt (_allRoads find _rdmPos);
			_rdmPos = nil;
		}
		else
		{
	//		hint ("Angle : " + (str _cnt) + " : " + (str _i));

			call
			{
				if (_angleLaps < 2) exitWith
				{
					if (_angle isEqualTo 1) exitWith
					{
						_allRoads = (_veh getPos [_distance, (getDir _veh) + 75]) nearRoads (_distance /2);

						if (count _allRoads > 60) then
						{
							_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
						};

						_angle = 2;
						_angleLaps = _angleLaps + 1;
					};

					if (_angle isEqualTo 2) exitWith
					{
						_allRoads = (_veh getPos [_distance, (getDir _veh) - 75]) nearRoads (_distance /2);

						if (count _allRoads > 60) then
						{
							_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
						};

						_angle = 1;
						_angleLaps = _angleLaps + 1;
					};
				};

				if (_angleLaps isEqualTo 2) then
				{
					_angle = random 360;
				};

				_allRoads = (_veh getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) + _angle) ]) nearRoads (_distance /2);

				if (count _allRoads > 60) then
				{
					_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
				};

				_angle = _angle + 10;
				_angleLaps = _angleLaps + 1;
			};
		};

		_unit = leader _grp;
		if ( (isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_exit) OR (time > _time) OR (_angleLaps > 38) ) exitWith {};

		uiSleep 0.05;
	};

	if (!isNil "_rdmPos") then
	{
		_rdmPos = getPosATL _rdmPos;
	}
	else
	{
		_rdmPos = DK_centerPostionMap;
	};

	_unit = leader _grp;
	if (alive _unit) then
	{
		_unit doMove _rdmPos;

		// DEBUG
/*		private _mkrNzme = str (random 1000);
		private _markerstr = createMarker [_mkrNzme, _rdmPos];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [50, 50];
*/		// DEBUG

		uiSleep 3;

		_unit = leader _grp;
		if ( (isNil "_unit") OR (isNull _unit) OR (!alive _unit) ) exitWith {};


		_veh = vehicle _unit;
		_time = time + ((_unit distance2D _rdmPos) / 2.2);
		_veh setVariable ["wpPos", getPosATL _veh];

		DK_MIS_arr_manageSafeWp pushBack [_grp, _veh, _time, _distance, _rdmPos];
	};
};

DK_MIS_loop_manageSafeDriver = {

	private ["_nil", "_pos", "_unit"];


	While { uiSleep 1; DK_MIS_var_missInProg && { DK_idMission isEqualTo _this } } do
	{
		private _time = time;

		{
			_x params ["_grp", "_veh", "_time", "_distance", "_rdmPos"];


			_unit = leader _grp;

			call
			{
				if ((isNil "_unit") OR (isNull _unit) OR (!alive _unit) OR (_unit distance2D _rdmPos < 99) OR !(_unit getVariable ["DK_behaviour", ""] isEqualTo "drive") OR (time > _time) OR !(DK_wheels findIf {(_veh getHit _x) isEqualTo 1} isEqualTo -1)) exitWith
				{
					_nil = DK_MIS_arr_manageSafeWp deleteAt (DK_MIS_arr_manageSafeWp find _x);

					if ( (!isNil "_unit") && { (!isNull _unit) && { (alive _unit) && { (_unit getVariable ["DK_behaviour", ""] isEqualTo "drive") && { (DK_wheels findIf {(_veh getHit _x) isEqualTo 1} isEqualTo -1) } } } } ) then
					{
						_nil = [_unit, _distance] spawn DK_MIS_fnc_wpDriver;
					};
				};

				_pos = _veh getVariable ["wpPos", [worldSize / 2, worldSize / 2, 0]];

				_nil = [_unit, _veh] call DK_fnc_manageSpdTraff;

				uiSleep 0.05;

				_nil = [_veh, _pos] call DK_fnc_manageFrcRoadTraff;

				_veh setVariable ["wpPos", getPosATL _veh];
			};

			uiSleep 0.05;

		} count DK_MIS_arr_manageSafeWp;

//		hint (str (time - _time) + " : " + (str (DK_MIS_arr_manageSafeWp)));
	};
};

DK_MIS_fnc_nextChase = {

	if (!isServer) exitWith {};

	params ["_unitsCrew", "_vehicleRfr", "_grp", ["_objTarget", objNull]];


	uiSleep 2;

	if (_unitsCrew findIf {alive _x} isEqualTo -1) exitWith
	{
		if ( (!isNil "_vehicleRfr") && { (!isNull _vehicleRfr) && { (alive _vehicleRfr) } } ) then
		{
			_vehicleRfr call DK_MIS_fnc_vehicle_removeAllEH;
			_vehicleRfr call DK_MIS_reInitVehNormal;
			_vehicleRfr call DK_MIS_fnc_initVehWhenEnd;
			_vehicleRfr forceSpeed -1;
			_vehicleRfr limitSpeed 250;
		};
	};

	private _idSHooter = _unitsCrew findIf { !(assignedTarget _x isEqualTo objNull) };
	if !(_idSHooter isEqualTo -1) exitWith
	{
		private _shooter = assignedTarget (_unitsCrew # _idSHooter);

		if ( (!isNil "_vehicleRfr") && { (!isNull _vehicleRfr) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) && { (alive _vehicleRfr) } } } } ) then
		{
			[_unitsCrew, _grp, _vehicleRfr, _shooter, [], 1, _shooter, "RED"] call DK_fnc_AiFollow_rfr;
		}
		else
		{
			[_unitsCrew, _shooter, _grp] spawn DK_loop_AiFollow_rfrFoot;
		};
	};

	_grp call DK_fnc_delAllWp;

	private "_fnc_condSSVOR";
	if ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) } ) then
	{
		_fnc_condSSVOR = {

			(isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget) OR ( (_objTarget isKindOf "Man") && { (isPlayer _objTarget) OR (side (group _objTarget) isEqualTo west) && { (lifeState _objTarget isEqualTo "INCAPACITATED") } } )
		};
	}
	else
	{
		_fnc_condSSVOR = {

			(isNil "_objTarget") OR (isNull _objTarget) OR (!alive _objTarget)
		};
	};


	// Target Down, return to normal patrol
	if (call _fnc_condSSVOR) exitWith
	{
		_grp setBehaviour "CARELESS";
		_grp setSpeedMode "LIMITED";

		// With car
		if ( (!isNil "_vehicleRfr") && { (!isNull _vehicleRfr) && { (canMove _vehicleRfr) && { (DK_wheels findIf {(_vehicleRfr getHit _x) isEqualTo 1} isEqualTo -1) } } } ) exitWith
		{
			[_grp, _vehicleRfr] spawn DK_MIS_Kill_02_AiInVeh_flee;
		};
	};

	// Vehicle cops down
	if ( (!isNil "_vehicleRfr") && (!isNull _vehicleRfr) && { (alive _vehicleRfr) } ) then
	{
		_vehicleRfr call DK_MIS_fnc_vehicle_removeAllEH;
		_vehicleRfr call DK_MIS_reInitVehNormal;
		_vehicleRfr call DK_MIS_fnc_initVehWhenEnd;
		_vehicleRfr forceSpeed -1;
		_vehicleRfr limitSpeed 250;
	};

	if !(_unitsCrew findIf { !(isNull objectParent _x) } isEqualTo -1) then
	{
		doStop _unitsCrew;
		private _waypoint = [_grp, _vehicleRfr, "GETOUT", nil, "NORMAL", "COMBAT"] call DK_fnc_AddWaypoint;
	};


	[_unitsCrew, _objTarget, _grp] spawn DK_loop_AiFollow_rfrFoot;
};


DK_fnc_initOrca = {

	addToRemainsCollector [_this];
	clearMagazineCargoGlobal _this;
	clearWeaponCargoGlobal _this;
	clearItemCargoGlobal _this;

	[
		_this,
		[selectRandom ["Blackcustom", "Blue", "Black"], 1], 
		true

	] call BIS_fnc_initVehicle;

};

DK_fnc_initCesar = {

	addToRemainsCollector [_this];
	clearBackpackCargoGlobal _this;
	_this addBackpackCargoGlobal ["B_Parachute",2];

	call
	{
		_rd = selectRandom [1,2,3,4,5,6,7,8];

		if (_rd isEqualTo 1) exitWith
		{
			[
				_this,
				["Wave_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 2) exitWith
		{
			[
				_this,
				["Wave_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 3) exitWith
		{
			[
				_this,
				["Racer_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 4) exitWith
		{
			[
				_this,
				["Racer_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 5) exitWith
		{
			[
				_this,
				["RedLine_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 6) exitWith
		{
			[
				_this,
				["RedLine_2",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		if (_rd isEqualTo 7) exitWith
		{
			[
				_this,
				["Tribal_1",1], 
				true

			] call BIS_fnc_initVehicle;
		};

		[
			_this,
			["Tribal_2",1], 
			true

		] call BIS_fnc_initVehicle;
	};
};

DK_fnc_initHeliBoatEnd = {

	DK_emptyVeh pushBackUnique _this;

	_this addEventHandler ["GetIn",
	{
		params ["_veh"];


		if !( (crew _veh) findIf {alive _x} isEqualTo -1 ) then
		{
			// Manage Clean Up
			DelInCUM(_veh);
			_veh setVariable ["cleanUpOn",false];
			DK_emptyVeh pushBackUnique _veh;

			// Manage Dyn Sim
			if (dynamicSimulationEnabled _veh) then
			{
				_veh enableDynamicSimulation false;
			};
		};
	}];


	_this addEventHandler ["Killed",
	{
		params ["_veh"];

		_veh setVariable ["cleanUpOn",true];
		DelInEmpV(_veh);
		DelInCUM(_veh);
		_veh enableDynamicSimulation false;
		_veh enableSimulationGlobal true;
	}];
};


DK_MIS_fnc_removeEhTrgAi = {

	params ["_units", "_grp"];


	private "_idEh";

	{
		if ( !(isNil "_x") && { !(isNull _x) } ) then
		{
			_x removeAllEventHandlers "FiredNear";

			_idEh = _x getVariable "idEhKilledTrgAI";
			if (!isNil "_idEh") then
			{
				_x removeEventHandler ["Killed", _idEh];
				_x setVariable ["idEhKilledTrgAI", nil];
				_idEh = nil;
			};

			_idEh = _x getVariable "idEhHitTrgAI";
			if (!isNil "_idEh") then
			{
				_x removeEventHandler ["Hit", _idEh];
				_x setVariable ["idEhHitTrgAI", nil];
				_idEh = nil;
			};
		};

	} count _units;

	if (isNil "_grp") exitWith {};

	{
		if ( !(isNil "_x") && { !(isNull _x) } ) then
		{
			_idEh = _x getVariable "idEhHitTrgAI";
			if (!isNil "_idEh") then
			{
				_x removeEventHandler ["Hit", _idEh];
				_x setVariable ["idEhHitTrgAI", nil];
				_idEh = nil;
			};
		};

	} count (_grp getVariable ["allVehicles", []]);
};


DK_MIS_fnc_crtHeliLand_AlbanGun = {

//	params [["_initVeh", true]];

	_heli = crtV("B_Heli_Light_01_dynamicLoadout_F");

	[
		_heli,
		nil,
		[
			"AddTread_Short", 0,
			"AddTread",0
		]

	] call BIS_fnc_initVehicle;

	_heli setObjectTextureGlobal [0, "a3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa"];

/*	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};
*/
	// Weapon's in heli
	_heli spawn DK_fnc_LO_heli_Alban;


	_heli
};

DK_MIS_fnc_crtHeliLand_DomiGun = {

//	params [["_initVeh", true]];

	_heli = crtV("O_Heli_Light_02_dynamicLoadout_F");

	[
		_heli,
		[selectRandom ["Black","Blackcustom"], 1], 
		true

	] call BIS_fnc_initVehicle;

/*	if _initVeh then
	{
		_heli call DK_fnc_init_vehFlyAir;
	};
*/
	// Weapon's in heli
	_heli spawn DK_fnc_LO_heliDomi;


	_heli
};




// Check if mission is finished, add score & add player in rewards Markers
DK_MIS_Kill_addEH_targetsDead = {

	private _idKilled = _this addMPEventHandler ["MPKilled",
	{
		params ["_unit", "_killer", "_instigator"];


		if !(isServer) then
		{
			// Count number targets are deads
			DK_nbTargets_Cnt = DK_nbTargets_Cnt + 1;

			// HUD Hint
			false call DK_MIS_fnc_Kill_Hint_cl;

			// HUD Marker
			deleteMarkerLocal (_unit getVariable "hisMkr");
		}
		else
		{
			// Count if mission is fisnish
			DK_nbTargets_Cnt = DK_nbTargets_Cnt + 1;

			if (DK_nbTargets_Cnt isEqualTo DK_nbTargets_Goal) then
			{
				DK_MIS_var_missInProg = false;
			};

			if (hasInterface) then
			{
				// Hud Hint
				false call DK_MIS_fnc_Kill_Hint_cl;

				// HUD Marker
				deleteMarkerLocal (_unit getVariable "hisMkr");
			};


			if (isNull _instigator) then
			{
				_instigator = _killer;
			};

			if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) && { !(_unit getVariable ["scrGiven", false]) } ) then
			{
				_unit setVariable ["scrGiven", true];

				// Add score to player
				[_instigator, _unit getVariable ["DK_score", 0]] call DK_fnc_addScr;

				// Add player in Rewards Markers list
				DK_MIS_playerRewardsMarkersList pushBackUnique _instigator;
			};
		};
	}];
};

DK_MIS_addEH_secondDead = {

	private _idKilled = _this addMPEventHandler ["MPKilled",
	{
		if (isServer) then
		{
			_this call DK_fnc_EH_secondDead;
		};
	}];
};

DK_fnc_EH_secondDead = {

	params ["_unit", "_killer", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
		{
			// Add score to player
			[_instigator, _unit getVariable ["DK_scoreScd", 1]] call DK_fnc_addScr;


			if !(_unit getVariable ["DK_side", ""] in ["cops", "fbi", "army"]) exitWith {};


			// Add WANTED level Mission if he'is order forces
			if (missionNamespace getVariable ["wantedMissionVal", 0] > 0) exitWith
			{
				private _wantedVal = _unit getVariable ["wantedVal", 0];
				if ( !(_wantedVal isEqualTo 0) && { (_unit getVariable ["DK_idMission", ""] isEqualTo DK_idMission) } ) then
				{
					_wantedVal call DK_MIS_fnc_addPointsToWantedLvl;
				};
			};

/*			// Start Wanted HUD to the player if he does not have a Wanted Hud (just added Hud, no wanted level)
			private _wantedLocalLvl1 = _instigator getVariable ["wantedLvl", []];
			private _wantedLocalLvl2 = +_wantedLocalLvl1;
			private _unitsCops = units _unit;

			if ( (_unitsCops findIf {_x in _wantedLocalLvl1} isEqualTo -1) && { !(_unitsCops findIf {alive _x} isEqualTo -1) } ) then
			{
				private _startHUD = false;

				if ({alive _x} count _wantedLocalLvl1 isEqualTo 0) then
				{
					_startHUD = true;
				};

				{
					if (alive _x) then
					{
						_wantedLocalLvl1 pushBackUnique _x;
					};

				} count _unitsCops;

				_instigator setVariable ["wantedLvl", _wantedLocalLvl1, true];

				if _startHUD then
				{
					_instigator remoteExecCall ["DK_add_HUD_wantedLvl_cl", _instigator];
				};
			};
*/
			// Sub time to Wanted Perso/Local if he'is order forces
//			if (_wantedLocalLvl2 findIf {alive _x} isEqualTo -1) exitWith {};

			if (_instigator getVariable ["DK_chaseTime1", -1] > -1) then
			{
				_instigator setVariable ["DK_chaseTime1", ((_instigator getVariable ["DK_chaseTime1", -1]) - 5)];
			};

			if (_instigator getVariable ["DK_chaseTime2", -1] > -1) then
			{
				_instigator setVariable ["DK_chaseTime2", ((_instigator getVariable ["DK_chaseTime2", -1]) - 5)];
			};

			if (_instigator getVariable ["DK_chaseTime3", -1] > -1) then
			{
				_instigator setVariable ["DK_chaseTime3", ((_instigator getVariable ["DK_chaseTime3", -1]) - 5)];
			};
		};
};

DK_MIS_TakeCar_addEH_targetsDestroyed = {

	private _idKilled = _this addMPEventHandler ["MPKilled",
	{
		params ["_vehicle", "_killer", "_instigator"];


		if (isNull _instigator) then
		{
			_instigator = _killer;
		};

		if !(isServer) then
		{
			// HUD Hint
			if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
			{
				_instigator call DK_MIS_fnc_Takecar_DestroyByP_Hint_cl;
			}
			else
			{
				call DK_MIS_fnc_Takecar_DestroyUnk_Hint_cl;
			};

			// HUD Marker
			deleteMarkerLocal (_vehicle getVariable "hisMkr");
		}
		else
		{
			DK_MIS_var_missInProg = false;

			if (hasInterface) then
			{
				// HUD Hint
				if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
				{
					_instigator call DK_MIS_fnc_Takecar_DestroyByP_Hint_cl;
				}
				else
				{
					call DK_MIS_fnc_Takecar_DestroyUnk_Hint_cl;
				};

				// HUD Marker
				deleteMarkerLocal (_vehicle getVariable "hisMkr");
			};

			if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
			{
				// Substrac score to player destroyer
				_scr = 0 - (_vehicle getVariable "DK_score");
				[_instigator, _scr, true] call DK_fnc_addScr;
			};
		};
	}];

	_this setVariable ["ehIdKilled", _idKilled];
};


DK_MIS_addEH_airScrTarget = {

	params ["_veh", "_target"];


	if ( (isNil "_veh") OR (!alive _veh) OR (isNil "_target") OR (!alive _target) ) exitWith {};

	_veh setVariable ["target", _target];


	_veh addEventHandler ["HandleDamage",
	{
		params ["_unit", "", "", "_source", "_projectile", "", "_instigator"];


		private _target = _unit getVariable "target";
		if ( !(_target getVariable ["scrGiven", false]) && { (_projectile in ["M_Titan_AA", "M_Titan_AP", "M_Titan_AT", "R_PG7_F", "DemoCharge_Remote_Ammo", "SatchelCharge_Remote_Ammo", "R_PG32V_F", "R_TBG32V_F"]) && { (!isNil "_target") && { (alive _target) && { (_target in (crew _unit)) } } } } ) then
		{
			_target setVariable ["scrGiven", true];

			call
			{
				if ( (isPlayer _source) OR (side (group _source) isEqualTo west) ) exitWith
				{
					_unit removeEventHandler ["HandleDamage", _thisEventHandler];
					_target setDamage 1;
					[_source, _target getVariable ["DK_score", 0]] call DK_fnc_addScr;

					// Add player in Rewards Markers list
					DK_MIS_playerRewardsMarkersList pushBackUnique _source;
				};

				if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) exitWith
				{
					_unit removeEventHandler ["HandleDamage", _thisEventHandler];
					_target setDamage 1;
					[_instigator, _target getVariable ["DK_score", 0]] call DK_fnc_addScr;

					// Add player in Rewards Markers list
					DK_MIS_playerRewardsMarkersList pushBackUnique _instigator;
				};


				if (typeName _projectile isEqualTo "OBJECT") then
				{
					(getShotParents _projectile) params ["", "_instigatorBis"];
				};

				if ( (!isNil "_instigatorBis") && { (isPlayer _instigatorBis) OR (side (group _instigatorBis) isEqualTo west) } ) then
				{
					_unit removeEventHandler ["HandleDamage", _thisEventHandler];
					_target setDamage 1;
					[_instigatorBis, _target getVariable ["DK_score", 0]] call DK_fnc_addScr;

					// Add player in Rewards Markers list
					DK_MIS_playerRewardsMarkersList pushBackUnique _instigatorBis;
				};
			};
		};
	}];
};


// AI driver
DK_MIS_fnc_searchWpPos_veh = {

	params ["_unitsGrp", "_distance", "_allRoads", "_rdmPos", "_nil", "_exit", "_slct", "_unit"];


	_slct = _unitsGrp findIf { alive _x };

	if !(_slct isEqualTo -1) then
	{
		_unit = _unitsGrp # _slct;

		private _exit = false;
		private _veh = vehicle _unit;
		private _blackArea = +DK_mkrs_spawnProtect + ["DK_MTW_mkr_limitMap_1"];

		_allRoads = (_unit getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) - 20) + (random 40) ]) nearRoads (_distance /2);

		if (count _allRoads > 70) then
		{
			_allRoads = [_allRoads, 1.5] call DK_fnc_shuffleDiviseArray;
		};

		private _angle = selectRandom [1,2];
		private _angleLaps = 0;
		private _time = time + 8;
		private _cnt = (count _allRoads) + 15000;

		for "_i" from 0 to _cnt do
		{
	//		hint str _allRoads;
			if !(_allRoads isEqualTo []) then
			{
	//			hint ("allRoads : " + (str _cnt) + " : " + (str _i));

				_rdmPos = selectRandom _allRoads;

				if ( (!isNil "_rdmPos") && { (_blackArea findIf { (getMarkerPos  _x) distance2D _rdmPos < 2000 } isEqualTo -1) && { (DK_blackListWP findIf { _rdmPos inArea _x } isEqualTo -1) && { ((nearestTerrainObjects [_rdmPos, [], 20, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) } } } ) exitWith
				{
					_exit = true;
				};

				_nil = _allRoads deleteAt (_allRoads find _rdmPos);
			}
			else
			{
		//		hint ("Angle : " + (str _allRoads) + " : " + (str _i));

				call
				{
					if (_angleLaps < 2) exitWith
					{
						if (_angle isEqualTo 1) exitWith
						{
							_allRoads = (_veh getPos [_distance, (getDir _veh) + 75]) nearRoads (_distance /2);

							if (count _allRoads > 60) then
							{
								_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
							};

							_angle = 2;
							_angleLaps = _angleLaps + 1;
						};

						if (_angle isEqualTo 2) exitWith
						{
							_allRoads = (_veh getPos [_distance, (getDir _veh) - 75]) nearRoads (_distance /2);

							if (count _allRoads > 60) then
							{
								_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
							};

							_angle = 1;
							_angleLaps = _angleLaps + 1;
						};
					};

					if (_angleLaps isEqualTo 2) then
					{
						_angle = random 360;
					};

					_allRoads = (_veh getPos [_distance, ((_veh getDir (_veh modelToWorldVisual [0,5,0])) + _angle) ]) nearRoads (_distance /2);

					if (count _allRoads > 60) then
					{
						_allRoads = [_allRoads, 2] call DK_fnc_shuffleDiviseArray;
					};

					_angle = _angle + 10;
					_angleLaps = _angleLaps + 1;
				};
			};

			if ( (_exit) OR (time > _time) OR (_angleLaps > 38) ) exitWith
			{
/*				call
				{
					if (_angleLaps > 38) exitWith {hint "(_angleLaps > 38)";};
					if (time > _time) exitWith {hint "(time > _time)";};
					if (!alive _unit) exitWith {hint "Unit dead";};
				};
*/			};

			if (!alive _unit) then
			{
				_slct = _unitsGrp findIf { alive _x };

				if !(_slct isEqualTo -1) then
				{
					_unit = _unitsGrp # _slct;
				};
			};

			if (!alive _unit) exitWith {};

			uiSleep 0.02;
		};
	};

	if (!isNil "_rdmPos") then
	{
		_rdmPos = getPos _rdmPos;
	}
	else
	{
//		hint "center of area mission";
		_rdmPos = DK_centerPostionMap;
	};

/*		// DEBUG
		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, _rdmPos];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [25, 25];
		// DEBUG
*/

	_rdmPos
};

DK_MIS_fnc_limitSpeedIfAlone = {

	params ["_grp", "_unitsGrp", "_leader", "_veh", "_playableUnits"];



	while { !(_unitsGrp findIf { alive _x } isEqualTo -1) } do
	{
		_leader = leader _grp;
		_veh = objectParent _leader;

		if (!isNull _veh) then
		{
			call
			{
				_playableUnits = playableUnits;

				if !(_playableUnits findIf { _x distance2D _veh < 26 } isEqualTo -1) exitWith
				{
					_veh limitSpeed 160;
				};

				if !(_playableUnits findIf { _x distance2D _veh < 80 } isEqualTo -1) exitWith
				{
					_veh limitSpeed 110;
				};

				if !(_playableUnits findIf { _x distance2D _veh < 300 } isEqualTo -1) exitWith
				{
					_veh limitSpeed 90;
				};

				_veh limitSpeed 60;
			};
		};

		uiSleep 4;
	};

};

DK_fnc_convoy = {

	params ["_grpFlwer", "_grpFlwed", "_vehFlwer", "_vehFlwed", ["_cond", 1]];


	private ["_disMin", "_maxLengthFlwer", "_maxLengthFlwed", "_time", "_leaderFlwer", "_leaderFlwed", "_wpPos", "_unitsGrp01", "_unitsGrp02", "_fnc_cond"];

	call
	{
		_unitsGrp01 = units _grpFlwer;
		_unitsGrp02 = units _grpFlwed;

		if (_cond isEqualTo 1) exitWith
		{
			_fnc_cond = { !DK_MIS_var_AiIsBlocked OR !DK_MIS_var_PlayersAreNotSeen OR !DK_MIS_var_missInProg OR (_unitsGrp01 findIf { alive _x } isEqualTo -1) OR (_unitsGrp02 findIf { alive _x } isEqualTo -1) };
		};

		_fnc_cond = { !(_unitsGrp01 findIf { !alive _x } isEqualTo -1) OR !(_unitsGrp02 findIf { !alive _x } isEqualTo -1) };
	};

	if ( (call _fnc_cond) OR (isNil "_grpFlwer") OR (isNil "_grpFlwed") ) exitWith {};

	if (!isNil "_vehFlwer") then
	{
		_bbr = boundingBoxReal _vehFlwer;
		_p1 = _bbr # 0;
		_p2 = _bbr # 1;
		_maxLengthFlwer = (abs ((_p2 # 1) - (_p1 # 1))) + 1;
		_disMin = round _maxLengthFlwer;
	};

	if (!isNil "_vehFlwed") then
	{
		_bbr = boundingBoxReal _vehFlwed;
		_p1 = _bbr # 0;
		_p2 = _bbr # 1;
		_maxLengthFlwed = (abs ((_p2 # 1) - (_p1 # 1))) + 1;
		_disMin = round (_disMin + _maxLengthFlwed);
	};

	if (isNil "_disMin") then
	{
		_disMin = 10;
	};

	private _disMinSpd = _disMin * 2;
	private _disMinWp = _maxLengthFlwer + 6;

	while { !(isNil "_grpFlwer") && { !(isNil "_grpFlwed") && { !(call _fnc_cond) } } } do
	{
		_ldrFlwer = leader _grpFlwer;
		_ldrFlwed = leader _grpFlwed;

		call
		{
			if ((_ldrFlwer distance _ldrFlwed) > _disMin) exitWith
			{
				_wpPos = _ldrFlwed getPos [_disMin, getDir _ldrFlwed];
			};

			_wpPos = _ldrFlwed getPos [_maxLengthFlwed, (getDir _ldrFlwed) - 180];
		};

		_ldrFlwer doMove _wpPos;

		/// DEBUG
//		private _arrow = createVehicle ["Sign_Arrow_Large_Pink_F", _wpPos, [], 0, "CAN_COLLIDE"];
		/// DEBUG


		_time = time + 3;
		while { uiSleep 0.3; (time < _time) && { ((_ldrFlwer distance _ldrFlwed) > _disMin) && { ((_ldrFlwer distance _wpPos) > _disMinWp) } } } do
		{
			call
			{
				if ((_ldrFlwer distance _ldrFlwed) < _disMinSpd) exitWith
				{
					_ldrFlwer limitSpeed (speed _ldrFlwed);
				};

				_ldrFlwer limitSpeed 300;
			};
		};

		_ldrFlwer limitSpeed 300;

		/// DEBUG
//		deleteVehicle _arrow;
		/// DEBUG

//		if (call _fnc_cond) exitWith {};
	};

	if ( (_cond isEqualTo 1) && { DK_MIS_var_AiIsBlocked && { DK_MIS_var_PlayersAreNotSeen && { DK_MIS_var_missInProg && { !(units _grpFlwer findIf {alive _x} isEqualTo -1) } } } } ) then
	{
		[_grpFlwer, 1000] spawn DK_MIS_fnc_wpDriver;
	};

};

/// AI Setup
DK_MIS_fnc_skillThug = {

	_this setSkill ["aimingAccuracy", 0.35];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 0.7];
	_this setSkill ["reloadSpeed", 0.3];
	_this setSkill ["spotDistance", 0.15];
	_this setSkill ["spotTime", 0.5];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillLooter = {

	_this setSkill ["aimingAccuracy", 0.22];
	_this setSkill ["aimingSpeed", 0.25];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 0.5];
	_this setSkill ["reloadSpeed", 0.3];
	_this setSkill ["spotDistance", 0.15];
	_this setSkill ["spotTime", 0.5];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillBallas = {

	_this setSkill ["aimingAccuracy", 0.33];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 0.8];
	_this setSkill ["reloadSpeed", 0.35];
	_this setSkill ["spotDistance", 0.15];
	_this setSkill ["spotTime", 0.6];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillTriads = {

	_this setSkill ["aimingAccuracy", 0.26];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 0.5];
	_this setSkill ["reloadSpeed", 0.45];
	_this setSkill ["spotDistance", 0.1];
	_this setSkill ["spotTime", 0.65];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillDomi = {

	_this setSkill ["aimingAccuracy", 0.26];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 0.8];
	_this setSkill ["reloadSpeed", 0.4];
	_this setSkill ["spotDistance", 0.1];
	_this setSkill ["spotTime", 0.58];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillAlban = {

	_this setSkill ["aimingAccuracy", 0.26];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 0.8];
	_this setSkill ["reloadSpeed", 0.4];
	_this setSkill ["spotDistance", 0.1];
	_this setSkill ["spotTime", 0.58];
	_this setSkill ["aimingShake", 0];
};


DK_MIS_fnc_skillPolice = {

	_this setSkill ["aimingAccuracy", 0.32];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 1];
	_this setSkill ["reloadSpeed", 0.3];
	_this setSkill ["spotDistance", 0.12];
	_this setSkill ["spotTime", 0.55];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillFBI = {

	_this setSkill ["aimingAccuracy", 0.3];
	_this setSkill ["aimingSpeed", 0.3];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 1];
	_this setSkill ["reloadSpeed", 0.3];
	_this setSkill ["spotDistance", 0.1];
	_this setSkill ["spotTime", 0.63];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillArmy = {

	_this setSkill ["aimingAccuracy", 0.27];
	_this setSkill ["aimingSpeed", 0.25];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 1];
	_this setSkill ["reloadSpeed", 0.25];
	_this setSkill ["spotDistance", 0.08];
	_this setSkill ["spotTime", 0.55];
	_this setSkill ["aimingShake", 0];
};


DK_MIS_fnc_skillTurretVeh = {

//	_this setSkill ["aimingAccuracy", 0.1];
	_this setSkill ["aimingAccuracy", 0.09];
	_this setSkill ["aimingSpeed", 0.8];
	_this setSkill ["commanding", 1];
	_this setSkill ["courage", 1];
	_this setSkill ["reloadSpeed", 0.7];
	_this setSkill ["spotDistance", 0.8];
	_this setSkill ["spotTime", 0.75];
	_this setSkill ["aimingShake", 0];
};

DK_MIS_fnc_skillGunnerVeh = {

	_this setSkill ["aimingAccuracy", 0.035];
	_this setSkill ["aimingSpeed", 0.15];
	_this setSkill ["commanding", 0.4];
	_this setSkill ["courage", 0.8];
	_this setSkill ["reloadSpeed", 0.3];
	_this setSkill ["spotDistance", 0.2];
	_this setSkill ["spotTime", 0.3];
	_this setSkill ["aimingShake", 1];
};


DK_MIS_EH_handleAmmoNweapons = {

	/// Handle ammo
	_this addEventHandler ["Reloaded",
	{
		params ["_unit", "", "", "_newMagazineNfo"];


		private _newMag = _newMagazineNfo # 0;

		if ( {_x isEqualTo _newMag} count magazines _unit < 2) then 
		{
			_unit addMagazines [_newMag, 2]; 
		}; 

	}];

	/// Handle clean up weapon when unit die
	_this addEventHandler [ "Put",
	{
		params[ "_unit", "_wpHold" ];


		_wpHold setVariable ["isObjectif", true];

		if !(_wpHold getVariable ["cleanUpOn",false]) then
		{
			[_wpHold,240,200] spawn DK_fnc_addAllTo_CUM;
		};
	}];


};

DK_fnc_handleAmmoVeh = {

	params ["_veh", "_driver"];


	while { (alive _driver) && { ((side _driver) in [east, resistance]) } } do
	{
//		systemChat "loop handle ammo veh";

		_veh setVehicleAmmoDef 1;

		uiSleep 60;
	};
};


DK_MIS_addEH_selectSeat = {

	_this addEventHandler ["GetInMan",
	{
		params ["_unit", "_role", "_vehicle"];

		call
		{
			if (typeOf _vehicle in ["I_G_Offroad_01_AT_F", "I_G_Offroad_01_armed_F", "I_C_Offroad_02_LMG_F", "I_C_Offroad_02_AT_F", "B_Heli_Attack_01_dynamicLoadout_F", "O_Heli_Attack_02_dynamicLoadout_F", "B_CTRG_Heli_Transport_01_sand_F", "I_Heli_light_03_dynamicLoadout_F", "O_Heli_Light_02_dynamicLoadout_F", "B_LSV_01_armed_F", "B_T_LSV_01_AT_F", "I_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F", "I_MBT_03_cannon_F"]) exitWith
			{
				_unit call DK_MIS_fnc_skillGunnerVeh;
			};

			_unit call DK_MIS_fnc_skillTurretVeh;
		};

		[_unit,_role,_vehicle,_thisEventHandler] call DK_fnc_selectSeat;
	}];

	_this addEventHandler ["GetOutMan",
	{
		params ["_unit"];

		_unit call (_unit getVariable "DK_skill");
	}];
};

DK_fnc_selectSeat = {

	params ["_unit", "_role", "_vehicle", "_thisEventHandler"];


	private _classVeh = typeOf _vehicle;


		// Offroad 01 civilian
		if (_classVeh in ["C_Offroad_01_F", "B_G_Offroad_01_F", "I_G_Offroad_01_F"]) exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit", "_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "turret", true];

						if ( ((_seats # 3) # 0) isEqualTo objNull ) exitWith
						{
							_unit moveInTurret [_vehicle, [3]];
							_unit spawn DK_fnc_turnOut;
						};

						if ( ((_seats # 2) # 0) isEqualTo objNull ) exitWith
						{
							_unit moveInTurret [_vehicle, [2]];
							_unit spawn DK_fnc_turnOut;
						};

						if ( ((_seats # 0) # 0) isEqualTo objNull ) exitWith
						{
							_unit moveInTurret [_vehicle, [0]];
						};

						if ( ((_seats # 1) # 0) isEqualTo objNull ) then
						{
							_unit moveInTurret [_vehicle, [1]];
						};
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Jeep civilian
		if (_classVeh in ["C_Offroad_02_unarmed_F", "I_C_Offroad_02_unarmed_F"]) exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_unit moveInCargo _vehicle;
						_unit spawn DK_fnc_turnOut;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Jeep armed
		if (_classVeh in ["I_C_Offroad_02_LMG_F", "I_G_Offroad_01_armed_F", "I_C_Offroad_02_AT_F", "I_G_Offroad_01_AT_F"]) exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						private _seats = fullCrew [_vehicle, "gunner", true];
						if ( (((_seats # 0) # 0) isEqualTo objNull) OR (!alive ((_seats # 0) # 0)) ) exitWith
						{
							_unit moveInGunner _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						_unit moveInCargo _vehicle;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Van Transport 1
		if (_classVeh isEqualTo "C_Van_01_transport_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						private _seats = fullCrew [_vehicle, "turret", true];

						if ( (((_seats # 3) # 0) isEqualTo objNull) OR (!alive ((_seats # 3) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [3]];
						};

						if ( (((_seats # 8) # 0) isEqualTo objNull) OR (!alive ((_seats # 8) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [8]];
						};

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [1]];
						};

						if ( (((_seats # 6) # 0) isEqualTo objNull) OR (!alive ((_seats # 6) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [6]];
						};

						if ( (((_seats # 0) # 0) isEqualTo objNull) OR (!alive ((_seats # 0) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [0]];
						};

						if ( (((_seats # 4) # 0) isEqualTo objNull) OR (!alive ((_seats # 4) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [4]];
						};

						if ( (((_seats # 5) # 0) isEqualTo objNull) OR (!alive ((_seats # 5) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [5]];
						};

						if ( (((_seats # 2) # 0) isEqualTo objNull) OR (!alive ((_seats # 2) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [2]];
						};

						if ( (((_seats # 9) # 0) isEqualTo objNull) OR (!alive ((_seats # 9) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [9]];
						};

						if ( (((_seats # 7) # 0) isEqualTo objNull) OR (!alive ((_seats # 7) # 0)) ) then
						{
							_unit moveInTurret [_vehicle, [7]];
						};
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Van Transport 2 DLC
		if (_classVeh isEqualTo "B_GEN_Van_02_transport_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						private _seats = fullCrew [_vehicle, "turret", true];

						if ( (((_seats # 0) # 0) isEqualTo objNull) OR (!alive ((_seats # 0) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [0]];
						};

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [1]];
						};

						if ( (((_seats # 2) # 0) isEqualTo objNull) OR (!alive ((_seats # 2) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [2]];
						};
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};



		// Helicopter MH-9 (Police)
		if (_classVeh isEqualTo "B_Heli_Light_01_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						_seats = fullCrew [_vehicle, "turret", true];
						if ( (((_seats # 3) # 0) isEqualTo objNull) OR (!alive ((_seats # 3) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [3]];
						};

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [1]];
						};

						_seats = fullCrew [_vehicle, "cargo", true];
						if ( (((_seats # 0) # 0) isEqualTo objNull) OR (!alive ((_seats # 0) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 0];
						};

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) then
						{
							_unit moveInCargo [_vehicle, 1];
						};
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Helicopter WY Hellcat (Army)
		if (_classVeh isEqualTo "I_Heli_light_03_dynamicLoadout_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };

				if (alive _unit) then
				{
					call
					{
						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 6) # 0) isEqualTo objNull) OR (!alive ((_seats # 6) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [1]];
						};

						if ( (((_seats # 7) # 0) isEqualTo objNull) OR (!alive ((_seats # 7) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [2]];
						};

						if ( (((_seats # 5) # 0) isEqualTo objNull) OR (!alive ((_seats # 5) # 0)) ) then
						{
							_unit moveInTurret [_vehicle, [0]];
						};

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 2];
						};
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Prowler Unarmed Army
		if (_classVeh isEqualTo "B_T_LSV_01_unarmed_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
				
				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 6) # 0) isEqualTo objNull) OR (!alive ((_seats # 6) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [5]];
						};

						if ( (((_seats # 3) # 0) isEqualTo objNull) OR (!alive ((_seats # 3) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [2]];
						};

						if ( (((_seats # 5) # 0) isEqualTo objNull) OR (!alive ((_seats # 5) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [4]];
						};

						if ( (((_seats # 4) # 0) isEqualTo objNull) OR (!alive ((_seats # 4) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [3]];
						};

						_unit moveInAny _vehicle;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Prowler Armed Army
		if (_classVeh in ["B_LSV_01_armed_F", "B_T_LSV_01_AT_F"]) exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
				
				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) exitWith
						{
							_unit moveInGunner _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						if ( (((_seats # 2) # 0) isEqualTo objNull) OR (!alive ((_seats # 2) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [1]]
						};

						if ( (((_seats # 3) # 0) isEqualTo objNull) OR (!alive ((_seats # 3) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [2]]
						};

						if ( (((_seats # 4) # 0) isEqualTo objNull) OR (!alive ((_seats # 4) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [3]]
						};

						_unit moveInAny _vehicle;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Zamack Army
		if (_classVeh in ["I_Truck_02_transport_F", "I_Truck_02_covered_F"]) exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
				
				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 15) # 0) isEqualTo objNull) OR (!alive ((_seats # 15) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [0]]

						};

						if ( (((_seats # 16) # 0) isEqualTo objNull) OR (!alive ((_seats # 16) # 0)) ) exitWith
						{
							_unit moveInTurret [_vehicle, [1]]
						};

						if ( (((_seats # 14) # 0) isEqualTo objNull) OR (!alive ((_seats # 14) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 13]

						};

						if ( (((_seats # 13) # 0) isEqualTo objNull) OR (!alive ((_seats # 13) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 12]
						};

						if ( (((_seats # 12) # 0) isEqualTo objNull) OR (!alive ((_seats # 12) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 11]

						};

						if ( (((_seats # 11) # 0) isEqualTo objNull) OR (!alive ((_seats # 11) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 10]
						};

						if ( (((_seats # 10) # 0) isEqualTo objNull) OR (!alive ((_seats # 10) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 9]

						};

						if ( (((_seats # 9) # 0) isEqualTo objNull) OR (!alive ((_seats # 9) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 8]
						};

						if ( (((_seats # 8) # 0) isEqualTo objNull) OR (!alive ((_seats # 8) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 7]

						};

						if ( (((_seats # 7) # 0) isEqualTo objNull) OR (!alive ((_seats # 7) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 6]
						};

						if ( (((_seats # 6) # 0) isEqualTo objNull) OR (!alive ((_seats # 6) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 5]
						};

						if ( (((_seats # 5) # 0) isEqualTo objNull) OR (!alive ((_seats # 5) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 4]

						};

						if ( (((_seats # 4) # 0) isEqualTo objNull) OR (!alive ((_seats # 4) # 0)) ) exitWith
						{
							_unit moveInCargo [_vehicle, 3]
						};

					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Mora Army
		if (_classVeh isEqualTo "I_APC_tracked_03_cannon_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
				
				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 8) # 0) isEqualTo objNull) OR (!alive ((_seats # 8) # 0)) ) exitWith
						{
							_unit moveInGunner _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						if ( (((_seats # 9) # 0) isEqualTo objNull) OR (!alive ((_seats # 9) # 0)) ) exitWith
						{
							_unit moveInCommander _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						_unit moveInAny _vehicle;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Kuma Army
		if (_classVeh isEqualTo "I_MBT_03_cannon_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
				
				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 1) # 0) isEqualTo objNull) OR (!alive ((_seats # 1) # 0)) ) exitWith
						{
							_unit moveInGunner _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						if ( (((_seats # 2) # 0) isEqualTo objNull) OR (!alive ((_seats # 2) # 0)) ) exitWith
						{
							_unit moveInCommander _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						_unit moveInAny _vehicle;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};

		// Gorgon Army
		if (_classVeh isEqualTo "I_APC_Wheeled_03_cannon_F") exitWith
		{
			_unit removeEventHandler ["GetInMan", _thisEventHandler];
			moveOut _unit;

			[_unit,_vehicle] spawn
			{
				params ["_unit","_vehicle"];


				waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
				
				if (alive _unit) then
				{
					call
					{
						private _grp = group _unit;

						if (    ({ alive _x } count units _grp isEqualTo 1) OR ( (!alive (driver _vehicle)) && { !(crew _vehicle findIf { (group _x isEqualTo _grp) && { (alive _x) } } isEqualTo -1) } )    ) exitWith
						{
							_unit moveInDriver _vehicle;
							_grp selectLeader _unit;
						};

						if (!alive driver _vehicle) then
						{
							private _unitsCrew = (units _grp) - [_unit];
							if !(_unitsCrew isEqualTo []) then
							{
								_grp selectLeader (selectRandom _unitsCrew);
							};
						};

						_seats = fullCrew [_vehicle, "", true];

						if ( (((_seats # 9) # 0) isEqualTo objNull) OR (!alive ((_seats # 9) # 0)) ) exitWith
						{
							_unit moveInGunner _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						if ( (((_seats # 10) # 0) isEqualTo objNull) OR (!alive ((_seats # 10) # 0)) ) exitWith
						{
							_unit moveInCommander _vehicle;
							_unit call DK_MIS_fnc_skillGunnerVeh;
						};

						_unit moveInAny _vehicle;
					};

					uiSleep 1;
					_unit call DK_MIS_addEH_selectSeat;
				};
			};
		};


		/// Other cars
		call
		{
			private _grp = group _unit;

			if (_role isEqualTo "driver") exitWith
			{
				_grp selectLeader _unit;
			};

			if (!alive (driver _vehicle)) then
			{
				_unit removeEventHandler ["GetInMan", _thisEventHandler];
				moveOut _unit;

				[_unit, _vehicle, _grp] spawn
				{
					params ["_unit", "_vehicle", "_grp"];


					waitUntil { uiSleep 0.1; (isNull objectParent _unit) OR !(alive _unit) };
	
					if (alive _unit) then
					{
						_unit moveInDriver _vehicle;
						_grp selectLeader _unit;

						uiSleep 1;
						_unit call DK_MIS_addEH_selectSeat;
					};
				};
			};
		};
};

DK_fnc_turnOut = {

	if (hasInterface) then
	{
		waitUntil { (cameraView != "GUNNER") OR (isNull _this) OR (!alive _this) OR (isNull (objectParent _this)) };

		if ( (!isNull _this) && { (alive _this) && { !(isNull (objectParent _this)) } } ) then
		{
			_this action ["TurnOut", objectParent _this];
		};
	}
	else
	{
		_this action ["TurnOut", objectParent _this];
	};
};

DK_fnc_turnIn = {

	if (hasInterface) then
	{
		waitUntil { !(cameraView isEqualTo "GUNNER") OR (isNull _this) OR (!alive _this) OR (isNull (objectParent _this)) };

		if ( (!isNull _this) && { (alive _this) && { !(isNull (objectParent _this)) } } ) then
		{
			_this action ["TurnIn", objectParent _this];
		};
	}
	else
	{
		_this action ["TurnIn", objectParent _this];
	};
};

DK_MIS_fnc_stayCloseArea = {

	params ["_grp", ["_disMax", 250], ["_disMin", 40], "_leader", "_time", "_waypoint"];


	private _unitsGrp = units _grp;
	private _areaToStayclose = (leader _grp) getVariable ["MIS_center", getPosATL (leader _grp)];

	while { !(_unitsGrp findIf { alive _x } isEqualTo -1) } do
	{
		_leader = leader _grp;

		if ( (alive _leader) && { (_leader distance2D _areaToStayclose > 85) && { ((isNull assignedTarget _leader) OR (playableUnits findIf { _x distance2D _leader < _disMax } isEqualTo -1)) } } ) then
		{
			_grp call DK_fnc_delAllWp;

			_grp setBehaviour "CARELESS";
			_grp setSpeedMode "FULL";
			_unitsGrp doFollow _leader;
			_leader disableAI "TARGET";
			_leader disableAI "AUTOTARGET";
			_leader doWatch objNull;

			if (_areaToStayclose isEqualType []) then
			{
				_leader doMove _areaToStayclose;
			}
			else
			{
				_leader doMove (getPosATL _areaToStayclose);
			};

			_waypoint = [_grp, _areaToStayclose, " if (!isServer) exitWith {}; (group this) setBehaviour (if (!isNil 'DK_MIS_var_behaviour') then {DK_MIS_var_behaviour} else {'AWARE'}); (group this) setSpeedMode (if (!isNil 'DK_MIS_var_speedUnits') then {DK_MIS_var_speedUnits} else {'FULL'}); ", "true", "MOVE", nil, "FULL", "CARELESS", 20] call DK_fnc_AddWaypointState;

			uiSleep 3;

			_time = time + 120;
			_leader enableAI "TARGET";
			_leader enableAI "AUTOTARGET";

			waitUntil { uiSleep 2; (leader _grp distance2D _areaToStayclose < _disMin) OR (time > _time) OR (_unitsGrp findIf { alive _x } isEqualTo -1) };

			if (_unitsGrp findIf { alive _x } isEqualTo -1) exitWith {};

			_grp setSpeedMode (if (!isNil "DK_MIS_var_speedUnits") then {DK_MIS_var_speedUnits} else {"FULL"});
			_grp call DK_fnc_delAllWp;
			_grp setBehaviour (if (!isNil "DK_MIS_var_behaviour") then {DK_MIS_var_behaviour} else {"AWARE"});
		};

		uiSleep 10;
	};
};



DK_MIS_Kill_addIsSeen = {
 
	params ["_allUnits", "_dis", "_fnc_triggerAI", ["_disMax", 250], ["_disMin", 40], "_IdPlayer", "_IdCorps", "_unit", "_targets"]; 
 

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	private _exit = false;
	while { DK_MIS_var_AiIsBlocked && { DK_MIS_var_PlayersAreNotSeen && { DK_MIS_var_missInProg } } } do 
	{
		{
			_unit = _x;

			if (alive _unit) then
			{
				// Check if unit see a friendly coprs
				_IdCorps = _allUnits findIf { !(_unit isEqualTo _x) && { (!alive _x) && { (_unit distance _x < 25) && { ([vehicle _x, "IFIRE"] checkVisibility [_x call DK_corpsPlace, _unit call DK_fnc_eyePlace] > 0.9) } } } };
				
				if !(_IdCorps isEqualTo -1) exitWith 
				{ 
					_exit = true;
					DK_MIS_var_PlayersAreNotSeen = false; 
					_targets = _allUnits # _IdCorps;
				};

				if _exit exitWith {};

				// Check if unit see a player
				_IdPlayer = playableUnits findIf { (_x distance _unit < _dis) && { ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _unit call DK_fnc_eyePlace] > 0.9) } };

				if !(_IdPlayer isEqualTo -1) exitWith 
				{
					_exit = true;
					DK_MIS_var_PlayersAreNotSeen = false;
					_targets = playableUnits #_IdPlayer;
				};

				if _exit exitWith {};

				uiSleep 0.07;
			};

			if _exit exitWith {};

		} count _allUnits; 
	 
		if _exit exitWith {};

		uiSleep (2 + (random 1.5));
	};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;

	uiSleep 0.2;

	if ( (DK_MIS_var_missInProg) && { (DK_MIS_var_AiIsBlocked) } ) then
	{
		DK_MIS_var_AiIsBlocked = false;
		[_allUnits, (group (_allUnits # 0))] call DK_MIS_fnc_removeEhTrgAi;
		[_allUnits, _disMax, _disMin, _targets] call _fnc_triggerAI;
	};
}; 

DK_MIS_Kill_addIsSeenAir = {
 
	params ["_allUnits", "_dis", "_fnc_triggerAI", "_unit"]; 
 

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	private _exit = false;
	while { DK_MIS_var_AiIsBlocked && { DK_MIS_var_PlayersAreNotSeen && { DK_MIS_var_missInProg } } } do 
	{
		{
			_unit = _x;

			if (alive _unit) then
			{
				// Check if unit see a player
				if !(playableUnits findIf { (_x distance2D _unit < _dis) && { ([vehicle _x, "IFIRE", vehicle _unit] checkVisibility [eyePos _x, eyePos _unit] > 0.9) } } isEqualTo -1) exitWith 
				{
					_exit = true;
					DK_MIS_var_PlayersAreNotSeen = false;
				};

				if _exit exitWith {};

				uiSleep 0.07;
			};

			if _exit exitWith {};

		} count _allUnits; 
	 
		if _exit exitWith {};

		uiSleep 2;
	};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;

	uiSleep 0.2;

	if ( (DK_MIS_var_missInProg) && { (DK_MIS_var_AiIsBlocked) } ) then
	{
		DK_MIS_var_AiIsBlocked = false;
		[_allUnits, (group (_allUnits # 0))] call DK_MIS_fnc_removeEhTrgAi;
		[_allUnits] call _fnc_triggerAI;
	};
}; 

DK_MIS_fnc_EhKilled_trgAI = {

	params ["_unit", "_killer", "_instigator", "", "_fnc_triggerAI", ["_disMax", 250], ["_disMin", 40]];


	if (isNull _instigator) then
	{
		_instigator = _killer;
	};

	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
	{
		[[_unit]] call DK_MIS_fnc_removeEhTrgAi;

		private _allUnits = _unit getVariable ["targetsMission", []];
		private _allUnitsTmp = +_allUnits;
		private _nil = _allUnitsTmp deleteAt (_allUnitsTmp find _unit);

		private _IdCorps = _allUnitsTmp findIf { (alive _x) && { (_unit distance _x < 3.2) OR ( (_unit distance _x < 30) && { ([vehicle _unit, "IFIRE"] checkVisibility [_unit call DK_corpsPlace, _x call DK_fnc_eyePlace] > 0.95) } ) } };

		if (_IdCorps isEqualTo -1) exitWith {};

		[_allUnitsTmp, (group _unit)] call DK_MIS_fnc_removeEhTrgAi;

		[_allUnits, _instigator, _disMax, _disMin, _fnc_triggerAI] spawn
		{
			if DK_MIS_var_AiIsBlocked then
			{
				params ["_allUnits", "_instigator", "_disMax", "_disMin", "_fnc_triggerAI"];


				DK_MIS_var_AiIsBlocked = false;
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};

DK_MIS_fnc_EhHit_trgAI = {

	params ["_unit", "_killer", "", "_instigator", "_fnc_triggerAI", ["_disMax", 250], ["_disMin", 40], "_thisEventHandler"];


	if (isNull _instigator) then
	{
		_instigator = _killer;
	};


	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
	{
		private _allUnits = _unit getVariable ["targetsMission", []];

		_unit removeEventHandler ["Hit", _thisEventHandler];
		_unit setVariable ["idEhHitTrgAI", nil];

		_unit setVariable ["DK_behaviour", ""];
		_unit enableAI "ANIM";
		_unit enableAI "MOVE";

		[_allUnits, _instigator, _unit, _disMax, _disMin, _fnc_triggerAI] spawn
		{
			params ["_allUnits", "_instigator", "_unit", "_disMax", "_disMin", "_fnc_triggerAI"];


			uiSleep (2 + (random 1));

			if ( (DK_MIS_var_AiIsBlocked) && { (alive _unit) } ) then
			{
				[_allUnits, (group _unit)] call DK_MIS_fnc_removeEhTrgAi;

				DK_MIS_var_AiIsBlocked = false;
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};

DK_MIS_fnc_EhFiredNear_trgAI = {

	params ["_unit", "_instigator", "", "", "", "", "", "", "_fnc_triggerAI", ["_disMax", 250], ["_disMin", 40]];


	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) && { !([_instigator] call Sparker_fnc_checkIfSilencer) } ) then
	{
		private _allUnits = _unit getVariable ["targetsMission", []];

		[_allUnits, (group _unit)] call DK_MIS_fnc_removeEhTrgAi;

		[_allUnits, _instigator, _unit, _disMax, _disMin, _fnc_triggerAI] spawn
		{
			if DK_MIS_var_AiIsBlocked then
			{
				params ["_allUnits", "_instigator", "_unit", "_disMax", "_disMin", "_fnc_triggerAI"];


				DK_MIS_var_AiIsBlocked = false;
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};

DK_MIS_fnc_EhHitNear_trgAI_Veh = {

	params ["_vehicle", "_killer", "", "_instigator", "_fnc_triggerAI", ["_disMax", 250], ["_disMin", 40]];


	if (isNull _instigator) then
	{
		_instigator = _killer;
	};


	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
	{
		private _allUnits = _vehicle getVariable ["targetsMission", []];

		[_allUnits, _vehicle] call DK_MIS_fnc_removeEhTrgAi;

		[_allUnits, _instigator, _disMax, _disMin, _fnc_triggerAI] spawn
		{
			if DK_MIS_var_AiIsBlocked then
			{
				params ["_allUnits", "_instigator", "_disMax", "_disMin", "_fnc_triggerAI"];


				DK_MIS_var_AiIsBlocked = false;
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};


DK_MIS_Kill_addIsSeen_gp = {
 
	params ["_allUnits", "_dis", "_fnc_triggerAI", ["_disMax", 80], ["_disMin", 25], "_IdPlayer", "_IdCorps", "_unit", "_targets"]; 
 

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress + 1;

	private _grp = group (leader (_allUnits # 0));
	private _exit = false;
	while { (_grp getVariable ["aiIsBlocked", true]) && { (_grp getVariable ["playersAreNotSeen", true]) && { DK_MIS_var_missInProg } } } do 
	{
		{
			_unit = _x;

			if (alive _unit) then
			{
				// Check if unit see a friendly coprs
				_IdCorps = _allUnits findIf { !(_unit isEqualTo _x) && { (!alive _x) && { (_unit distance _x < 25) && { ([vehicle _x, "IFIRE"] checkVisibility [_x call DK_corpsPlace, _unit call DK_fnc_eyePlace] > 0.9) } } } };
				
				if !(_IdCorps isEqualTo -1) exitWith 
				{ 
					_exit = true;
					_grp setVariable ["playersAreNotSeen", false];
					_targets = _allUnits # _IdCorps;
				};

				if _exit exitWith {};

				// Check if unit see a player
				_IdPlayer = playableUnits findIf { (_x distance _unit < _dis) && { ([vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _unit call DK_fnc_eyePlace] > 0.9) } };

				if !(_IdPlayer isEqualTo -1) exitWith 
				{
					_exit = true;
					_grp setVariable ["playersAreNotSeen", false];
					_targets = playableUnits #_IdPlayer;
				};

				if _exit exitWith {};

				uiSleep 0.07;
			};

			if _exit exitWith {};

		} count _allUnits; 
	 
		if _exit exitWith {};

		uiSleep (2 + (random 2));
	};

	DK_MIS_loopsInProgress = DK_MIS_loopsInProgress - 1;

	uiSleep 0.2;

	if ( (DK_MIS_var_missInProg) && { (_grp getVariable ["aiIsBlocked", true]) } ) then
	{
		_grp setVariable ["aiIsBlocked", false];
		[_allUnits, (group (_allUnits # 0))] call DK_MIS_fnc_removeEhTrgAi;
		[_allUnits, _disMax, _disMin, _targets] call _fnc_triggerAI;
	};
}; 

DK_MIS_fnc_EhKilled_trgAI_gp = {

	params ["_unit", "_killer", "_instigator", "", "_fnc_triggerAI", ["_disMax", 80], ["_disMin", 25]];


	if (isNull _instigator) then
	{
		_instigator = _killer;
	};

	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
	{
		[[_unit]] call DK_MIS_fnc_removeEhTrgAi;

		private _allUnits = _unit getVariable ["targetsMission", []];
		private _allUnitsTmp = +_allUnits;
		private _nil = _allUnitsTmp deleteAt (_allUnitsTmp find _unit);

		private _IdCorps = _allUnitsTmp findIf { (alive _x) && { (_unit distance _x < 3.2) OR ( (_unit distance _x < 30) && { ([vehicle _unit, "IFIRE"] checkVisibility [_unit call DK_corpsPlace, _x call DK_fnc_eyePlace] > 0.95) } ) } };


		if (_IdCorps isEqualTo -1) exitWith {};


		private _grp = group _unit;

		[_allUnitsTmp, _grp] call DK_MIS_fnc_removeEhTrgAi;

		[_allUnits, _instigator, _disMax, _disMin, _fnc_triggerAI, _grp] spawn
		{
			if ((_this # 5) getVariable ["aiIsBlocked", true]) then
			{
				params ["_allUnits", "_instigator", "_disMax", "_disMin", "_fnc_triggerAI", "_grp"];


				_grp setVariable ["aiIsBlocked", false];
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};

DK_MIS_fnc_EhHit_trgAI_gp = {

	params ["_unit", "_killer", "", "_instigator", "_fnc_triggerAI", ["_disMax", 80], ["_disMin", 25], "_thisEventHandler"];


	if (isNull _instigator) then
	{
		_instigator = _killer;
	};


	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
	{
		private _allUnits = _unit getVariable ["targetsMission", []];

		_unit removeEventHandler ["Hit", _thisEventHandler];
		_unit setVariable ["idEhHitTrgAI", nil];

		_unit setVariable ["DK_behaviour", ""];
		_unit enableAI "ANIM";
		_unit enableAI "MOVE";

		[_allUnits, _instigator, _unit, _disMax, _disMin, _fnc_triggerAI] spawn
		{
			params ["_allUnits", "_instigator", "_unit", "_disMax", "_disMin", "_fnc_triggerAI"];


			uiSleep (2 + (random 1));

			private _grp = group _unit;
			if ( (_grp getVariable ["aiIsBlocked", true]) && { (alive _unit) } ) then
			{
				[_allUnits, _grp] call DK_MIS_fnc_removeEhTrgAi;

				_grp setVariable ["aiIsBlocked", false];
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};

DK_MIS_fnc_EhFiredNear_trgAI_gp = {

	params ["_unit", "_instigator", "", "", "", "", "", "", "_fnc_triggerAI", ["_disMax", 80], ["_disMin", 25]];


	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) && { !([_instigator] call Sparker_fnc_checkIfSilencer) } ) then
	{
		private _allUnits = _unit getVariable ["targetsMission", []];

		private _grp = group _unit;

		[_allUnits, _grp] call DK_MIS_fnc_removeEhTrgAi;

		[_allUnits, _instigator, _unit, _disMax, _disMin, _fnc_triggerAI, _grp] spawn
		{
			if ((_this # 6) getVariable ["aiIsBlocked", true]) then
			{
				params ["_allUnits", "_instigator", "_unit", "_disMax", "_disMin", "_fnc_triggerAI", "_grp"];


				_grp setVariable ["aiIsBlocked", false];
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};

DK_MIS_fnc_EhHitNear_trgAI_Veh_gp = {

	params ["_vehicle", "_killer", "", "_instigator", "_fnc_triggerAI", ["_disMax", 80], ["_disMin", 25]];


	if (isNull _instigator) then
	{
		_instigator = _killer;
	};


	if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) then
	{
		private _allUnits = _vehicle getVariable ["targetsMission", []];

		[_allUnits, _vehicle] call DK_MIS_fnc_removeEhTrgAi;

		[_allUnits, _instigator, _disMax, _disMin, _fnc_triggerAI] spawn
		{
			private _grp = group ((_this # 0) # 0);
			if (_grp getVariable ["aiIsBlocked", true]) then
			{
				params ["_allUnits", "_instigator", "_disMax", "_disMin", "_fnc_triggerAI"];


				_grp setVariable ["aiIsBlocked", false];
				[_allUnits, _disMax, _disMin, _instigator] call _fnc_triggerAI;
			};
		};
	};
};


/// Detect silencer
Sparker_fnc_checkIfSilencer = {		// THX Sparker from BIS forum for this function <3

	params ["_unit"];

	//Check if the current weapon has an attachment in silencer slot
	private _s = _unit weaponAccessories (currentWeapon _unit) select 0;
	if !(_s isEqualTo "") exitWith
	{
		//Check if the silencer attachment is indeed a silencer by checking the audibleFire
		_a = getNumber (configfile >> "CfgWeapons" >> _s >> "ItemInfo" >> "AmmoCoef" >> "audibleFire");
		if(_a < 1) then
		{
			true
		}
		else
		{
			false
		};
	};

	//If there is no silencer, check weapon's ammo audibleFire coefficient
	_mag = currentMagazine (vehicle _unit);
	_ammo = getText (configFile >> "cfgMagazines" >> _mag >> "ammo");
	_ammoAudible = getNumber (configFile >> "cfgAmmo" >> _ammo >> "audibleFire");

	//Compare with threshold value
	if (_ammoAudible < 5.5) then
	{
		true
	}
	else
	{
		false
	};
};

/// AI Handle Damage
DK_MIS_addEH_HandleDmg = {

	if (isNil "_this") exitWith {};
	
	_this addEventHandler ["HandleDamage",
	{
		private _dmgInit = _this call DK_MIS_fnc_EhHandleDmg;


		_dmgInit
	}];


};

DK_MIS_fnc_EhHandleDmg = {

	params ["_unit", "_hitSlct", "_dmgTotal", "_source", "", "_hitPartIndex", "_instigator"];


	private "_dmgInit";

	call
	{
		if (_hitSlct isEqualTo "") exitWith
		{
			_dmgInit = damage _unit;
		};

		_dmgInit = _unit getHit _hitSlct;
	};


	if ( ((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && { !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } } ) then
	{
		_instigator = _source;
	};


	call
	{
		if ( (side (group _instigator) isEqualTo side (group _unit)) && { !(_unit isEqualTo _instigator) } ) exitWith
		{
			_dmgInit;
		};

		if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) exitWith
		{
			if !(_hitPartIndex in [0,2]) exitWith
			{
				switch (_unit getVariable ["DK_side", ""]) do
				{
					case "mis_thug" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2);
					};

					case "mis_Looter" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2);
					};

					case "mis_thug2" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2);
					};

					case "mis_ballas" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 3.4);
					};

					case "mis_ballas2" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 3.4);
					};

					case "mis_triads" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 3.4);
					};

					case "mis_triads2" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 3.4);
					};

					case "mis_domi" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 1.7);	// 2
					};

					case "mis_alban" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 1.7);	// 2
					};

					case "cops" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) * 1.25);
					};

					case "fbi" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2);
					};

					case "army" :
					{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) * 1.3);
					};

				};
			};

			_dmgInit = _dmgTotal;
		};

		_dmgInit = _dmgTotal;
	};


	_dmgInit
};

DK_MIS_fnc_noDmgSafeDriver = {

	private _idEH_HD = _this addEventHandler ["HandleDamage",
	{
		private _nil = _this pushBack _thisEventHandler;
		private _damage = _this call DK_MIS_fnc_Eh_HdlDmgSafeDriver;

		_damage
	}];

	_this setVariable ["idEhDmgSafe", _idEH_HD];
};

DK_MIS_fnc_Eh_HdlDmgSafeDriver = {

		params ["_veh", "_hitSlct", "_damage", "_source", "_projectile", "", "_instigator", "", "_thisEventHandler"];


		if ( ((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && { !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } } ) then
		{
			_instigator = _source;
		};

		if (side (group _instigator) isEqualTo west) exitWith
		{
			_veh removeEventHandler ["HandleDamage", _thisEventHandler];
			_veh setVariable ["idEhDmgSafe", nil];

			call
			{
				if (_hitSlct isEqualTo "") exitWith
				{
					_damage = damage _veh;
				};

				_damage = _veh getHit _hitSlct;
			};
		};

		if ( (_projectile isEqualTo "") OR (_instigator getVariable ["DK_side", ""] isEqualTo "civ") ) then
		{
			{
				_x setDamage 0;

			} count crew _veh;
			_damage = 0;
		};


		_damage
};


// Rewards
DK_MIS_fnc_crtRwrdWthTabl = {

	params [["_waitMov", scriptNull], "_pos", "_level", ["_obstacles", []], ["_exactPos", false]];


	private "_classBox";
	_lvlinNb = parseNumber (_level select [8]);

	call
	{
		if (_lvlinNb <= 2) exitWith
		{
			_classBox = "Box_IND_Wps_F";
		};

		if ((_lvlinNb > 2) && {(_lvlinNb <= 5)}) exitWith
		{
			_classBox = "Box_East_Wps_F";
		};

		if ((_lvlinNb > 5) && {(_lvlinNb <= 7)}) exitWith
		{
			_classBox = "Box_T_East_Wps_F";
		};

		if ((_lvlinNb > 7) && {(_lvlinNb <= 10)}) exitWith
		{
			_classBox = "Box_EAF_Wps_F";
		};

		if ((_lvlinNb > 50) && {(_lvlinNb <= 100)}) exitWith	// Special armée
		{
			_classBox = "Box_T_NATO_Wps_F";
		};
	};

	// Init rewards ammobox & table
	private _rwrdTable = createVehicle ["Land_CampingTable_F", [0,0,10], [], 0, "CAN_COLLIDE"];
	_rwrdTable allowDamage false;
	_rwrdTable setDir (random 360);
	private _rwrdBox = createVehicle [_classBox, [0,0,10], [], 0, "CAN_COLLIDE"];
	_rwrdBox allowDamage false;
//	_rwrdBox attachTo [_rwrdTable, [0,0.01,0.61]];
//	_rwrdBox setDir 7;

	_rwrdTable hideObjectGlobal true;
	_rwrdBox hideObjectGlobal true;

	clearWeaponCargoGlobal _rwrdBox;
	clearMagazineCargoGlobal _rwrdBox;

	switch ( _level ) do
	{
		case "rewards_1" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_1;
		};

		case "rewards_2" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_2;
		};

		case "rewards_3" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_3;
		};

		case "rewards_4" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_4;
		};

		case "rewards_5" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_5;
		};

		case "rewards_6" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_6;
		};

		case "rewards_7" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_7;
		};

		case "rewards_8" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_8;
		};

		case "rewards_9" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_9;
		};

		case "rewards_10" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_10;
		};


	};

//	player sideChat _level;

	// Waiting all units, vehicles & props are Placed before place Rewards table
	[_rwrdTable, _rwrdBox, _waitMov, _pos, _obstacles, _exactPos] spawn
	{
		params ["_rwrdTable", "_rwrdBox", "_waitMov", "_pos", "_obstacles", "_exactPos"];

	
		waitUntil { scriptDone _waitMov };

		uiSleep 0.5;

//		player sideChat ((str time) + " : move Rewards");
		call
		{
			if _exactPos exitWith
			{
				_rwrdTable setPos _pos;
				_rwrdTable setVectorUp surfaceNormal _pos;
			};

			_rwrdTable setVehiclePosition [_pos, [], 6, "NONE"];

			for "_i" from 0 to 30 step 1 do
			{
				if (isNull _rwrdTable) exitWith {};

				_exit = true;

				{
					if (isNull _rwrdTable) exitWith {};

					private _bbr = boundingBox _x;
					private _p1 = _bbr # 0;
					private _p2 = _bbr # 1;

					private _maxLength = ( abs ((_p2 # 1) - (_p1 # 1)) ) + 1.25;

					if (_rwrdTable distance2D _x < _maxLength) exitWith
					{
						_exit = false;
					};

					uiSleep 0.02;

				} count _obstacles;

				if _exit exitWith {};

				_rwrdTable setVehiclePosition [_pos, [], 3 + (_i / 2), "NONE"];
			};
		};

		if ((isNull _rwrdTable) OR (isNull _rwrdBox)) exitWith {};

		_rwrdTable hideObjectGlobal false;
		_rwrdBox hideObjectGlobal false;

		_rwrdBox attachTo [_rwrdTable, [0,0.01,0.61]];
		_rwrdBox setDir 7;

		uiSleep 1.5;
		detach _rwrdBox;

		uiSleep 1;
		[_rwrdBox,_rwrdTable] apply
		{
			_x enableDynamicSimulation true;
		};

//		player sideChat ((str time) + " : Rewards initialized");
	};

/*		// DEBUG
		private _mkrNzme = str (random 1000);
		_markerstr = createMarker [_mkrNzme, position _rwrdTable];
		_markerstr setMarkerShape "ELLIPSE";
		_mkrNzme setMarkerColor "ColorRed";
		_mkrNzme setMarkerSize [350, 50];
		// DEBUG
*/

	_rwrdBox spawn DK_MIS_fnc_debugReward;


	[_rwrdBox,_rwrdTable]
};

DK_MIS_fnc_crtRwrd = {

	params ["_pos", ["_level", "rewards_1"], ["_putOn", false], ["_dynSim", true]];


	private "_classBox";
	_lvlinNb = parseNumber (_level select [8]);

	call
	{
		if (_lvlinNb <= 2) exitWith
		{
			_classBox = "Box_IND_Wps_F";
		};

		if ((_lvlinNb > 2) && {(_lvlinNb <= 5)}) exitWith
		{
			_classBox = "Box_East_Wps_F";
		};

		if ((_lvlinNb > 5) && {(_lvlinNb <= 7)}) exitWith
		{
			_classBox = "Box_T_East_Wps_F";
		};

		if ((_lvlinNb > 7) && {(_lvlinNb <= 10)}) exitWith
		{
			_classBox = "Box_NATO_Wps_F";
		};

		if ((_lvlinNb > 49) && {(_lvlinNb <= 100)}) exitWith	// Special armée
		{
			_classBox = "Box_NATO_Equip_F";
		};
	};

	// Init rewards ammobox & table
	private _rwrdBox = createVehicle [_classBox, [0,0,10], [], 0, "CAN_COLLIDE"];
	_rwrdBox allowDamage false;

	call
	{
		if (typeName _putOn isEqualTo "OBJECT") exitWith
		{
			_rwrdBox attachTo [_putOn, [0,0,0.7]];
		};

		_rwrdBox setPosATL _pos;
	};

	_rwrdBox hideObjectGlobal true;

	clearItemCargoGlobal _rwrdBox;
	clearBackpackCargoGlobal _rwrdBox;
	clearWeaponCargoGlobal _rwrdBox;
	clearMagazineCargoGlobal _rwrdBox;

	switch ( _level ) do
	{
		case "rewards_1" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_1;
		};

		case "rewards_2" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_2;
		};

		case "rewards_3" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_3;
		};

		case "rewards_4" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_4;
		};

		case "rewards_5" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_5;
		};

		case "rewards_6" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_6;
		};

		case "rewards_7" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_7;
		};

		case "rewards_8" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_8;
		};

		case "rewards_9" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_9;
		};

		case "rewards_10" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_10;
		};

		case "rewards_50" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_50;
		};

		case "rewards_51" :
		{
			_rwrdBox call DK_MIS_fnc_LO_reward_lvl_51;
		};
	};

	if (isNull _rwrdBox) exitWith {};

	_rwrdBox hideObjectGlobal false;

	detach _rwrdBox;
	_rwrdBox setDir (random 360);

	if _dynSim then
	{
		_rwrdBox spawn
		{
			uiSleep 2;

			_this enableDynamicSimulation true;
		};
	};

	_rwrdBox spawn DK_MIS_fnc_debugReward;


	[_rwrdBox]
};

DK_MIS_fnc_crtRwrdAir = {

	params ["_plane", ["_lvlStuff", "rewards_1"]];


	if ((isNil "_plane") OR (isNull _plane)) exitWith {};

	private _bbr = boundingBoxReal _plane;
	_p1 = _bbr # 0;
	_p2 = _bbr # 1;
	private _maxLength = abs ((_p2 # 1) - (_p1 # 1));

	uiSleep 0.1;

	private _rwrdBox = ([(_plane modelToWorldVisual [0,0 - _maxLength,0]), _lvlStuff, false, false] call DK_MIS_fnc_crtRwrd) # 0;

	uiSleep 0.02;

	private _vel = velocityModelSpace _plane;
	_rwrdBox setVelocityModelSpace [((_vel # 0) / 2), ((_vel # 1) / 2), (_vel # 2)];

	uiSleep 0.5;

	_rwrdBox remoteExecCall ["DK_MIS_fnc_rewards3dIcone_cl", DK_MIS_playerRewardsMarkersList];
	[_rwrdBox] call DK_MIS_fnc_deleteReward;
};

DK_MIS_fnc_createRewardInVeh = {

	params [ "_vehicle", "_level"];


	switch ( _level ) do
	{
		case "rewards_1" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_1;
		};

		case "rewards_2" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_2;
		};

		case "rewards_3" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_3;
		};

		case "rewards_4" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_4;
		};

		case "rewards_5" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_5;
		};

		case "rewards_6" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_6;
		};

		case "rewards_7" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_7;
		};

		case "rewards_8" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_8;
		};

		case "rewards_9" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_9;
		};

		case "rewards_10" :
		{
			_vehicle call DK_MIS_fnc_LO_reward_lvl_10;
		};


	};
};


DK_MIS_addEH_rewardsAir = {

	_this addEventHandler ["Killed",
	{
		_this call DK_MIS_EH_rewardsAir;
	}];

};

DK_MIS_EH_rewardsAir = {

	params ["_unit", "_killer", "_insti"];


	if ( ((isNil "_insti") OR (isNull _insti) OR (_insti isEqualTo "")) && { !(isNil "_killer") && { (!isNull _killer) && { !(_killer isEqualTo "") } } } ) then
	{
		_insti = _killer;
	};

	if ( !(_unit getVariable ["rwrdsStrt", false]) && { (!isNull objectParent _unit) && { (isPlayer _insti) OR (side (group _insti) isEqualTo west) } } ) then
	{
		_unit setVariable ["rwrdsStrt", true];

		[objectParent _unit, _unit getVariable ["lvlStuff", "rewards_1"]] spawn DK_MIS_fnc_crtRwrdAir;
	};
};

DK_MIS_addEH_airScrTargetWthRewardsAir = {

	params ["_veh", "_target"];


	if ( (isNil "_veh") OR (!alive _veh) OR (isNil "_target") OR (!alive _target) ) exitWith {};

	_veh setVariable ["target", _target];


	_veh addEventHandler ["HandleDamage",
	{
		_this pushBack _thisEventHandler;
		_this call DK_MIS_EH_airScrTargetWthRewardsAir;
	}];
};

DK_MIS_EH_airScrTargetWthRewardsAir = {

	params ["_unit", "", "", "_source", "_projectile", "", "_instigator", "", "_thisEH"];


	private _target = _unit getVariable "target";
	if ( !(_target getVariable ["scrGiven", false]) && { (_projectile in projectAir) && { (!isNil "_target") && { (alive _target) && { (_target in (crew _unit)) } } } } ) then
	{
		call
		{
			if ( (isPlayer _source) OR (side (group _source) isEqualTo west) ) exitWith
			{
				_target setVariable ["scrGiven", true];
				[_unit, _thisEH, _target, _source] call DK_MIS_fnc_airScrTargetWthRewardsAir;
			};

			if ( (isPlayer _instigator) OR (side (group _instigator) isEqualTo west) ) exitWith
			{
				_target setVariable ["scrGiven", true];
				[_unit, _thisEH, _target, _instigator] call DK_MIS_fnc_airScrTargetWthRewardsAir;
			};


			if (typeName _projectile isEqualTo "OBJECT") then
			{
				(getShotParents _projectile) params ["", "_instigatorBis"];
			};

			if ( (!isNil "_instigatorBis") && { (isPlayer _instigatorBis) OR (side (group _instigatorBis) isEqualTo west) } ) then
			{
				_target setVariable ["scrGiven", true];
				[_unit, _thisEH, _target, _instigatorBis] call DK_MIS_fnc_airScrTargetWthRewardsAir;
			};
		};
	};
};

DK_MIS_fnc_airScrTargetWthRewardsAir = {

	params ["_air", "_thisEH", "_target", "_insti"];


	_air removeEventHandler ["HandleDamage", _thisEH];
	(driver _air) setDamage 1;

	[_insti, _target getVariable ["DK_score", 0]] call DK_fnc_addScr;

	if !(_target getVariable ["rwrdsStrt", false]) then
	{
		_target setVariable ["rwrdsStrt", true];

		// Add player in Rewards Markers list
		DK_MIS_playerRewardsMarkersList pushBackUnique _insti;

		[_air, _target getVariable ["lvlStuff", "rewards_1"]] spawn DK_MIS_fnc_crtRwrdAir;
		_air engineOn false;
	};
};


DK_MIS_fnc_deleteReward = {

	params ["_rewardBox", "_rewardTable", ["_timeDelRewards", DK_MIS_timeDelRewards], ["_disDelRewards", DK_MIS_disDelRewards]];


	if ( (isNil "_rewardBox") OR (isNull _rewardBox) ) exitWith {};

	uiSleep _timeDelRewards;

	if (!isNil "_rewardTable") then
	{
		[_rewardTable, 0, _disDelRewards, true] spawn DK_fnc_addAllTo_CUM;
	};

	[_rewardBox, 0, _disDelRewards, true] spawn DK_fnc_addAllTo_CUM;

};

DK_MIS_fnc_debugReward = {

	private _time = time + 60;

	waitUntil { uiSleep 2; (time > _time) OR (isNil "_this") OR (isNull _this) OR (!alive _this) OR (((getPosATL _this) # 2) < -3) OR (((getPosASL _this) # 2) < 0.5) };

//	if ( (time > _time) OR (isNil "_this") OR (isNull _this) OR (!alive _this) ) exitWith {};
	if ( (isNil "_this") OR (isNull _this) OR (!alive _this) ) exitWith {};


	if ( (((getPosATL _this) # 2) < -3) OR (((getPosASL _this) # 2) < 0.5) ) then
	{
		if (surfaceIsWater (getPosATL _this)) exitWith
		{
			private "_pos";
			for "_i" from 0 to 5000 step 100 do
			{
				_pos = [_this, 5 + _i, 50 + _i, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;

				if (count _pos isEqualTo 2) exitWith {};

				uiSleep 0.5;
			};

			_this setVehiclePosition [_pos, [], 0, "NONE"];
		};

		_this setVehiclePosition [_this, [], 0, "NONE"];
	};

};


// Hud
DK_MIS_slctInsult = {

	private _insult = selectRandom DK_insultKill;

	private _nul = DK_insultKill deleteAt (DK_insultKill find _insult);

	if (DK_insultKill isEqualTo []) then
	{
		DK_insultKill = +insultKill;
		_nul = DK_insultKill deleteAt (DK_insultKill find _insult);
	};


	_insult
};

DK_MIS_slctAirUnitRole = {

	params ["_className", "_class", "_unit"];


	private "_role";

	call
	{
		if (_class isEqualTo "cops") exitWith
		{
			_role = selectRandom DK_copsRole;

			private _nul = DK_copsRole deleteAt (DK_copsRole find _role);

			if (DK_copsRole isEqualTo []) then
			{
				DK_copsRole = +copsRole;
				_nul = DK_copsRole deleteAt (DK_copsRole find _role);
			};
		};

		if (_class isEqualTo "alba") exitWith
		{
			_role = selectRandom DK_albaRole;

			private _nul = DK_albaRole deleteAt (DK_albaRole find _role);

			if (DK_albaRole isEqualTo []) then
			{
				DK_albaRole = +albaRole;
				_nul = DK_albaRole deleteAt (DK_albaRole find _role);
			};
		};

		if (_class isEqualTo "domi") exitWith
		{
			_role = selectRandom DK_domiRole;

			private _nul = DK_domiRole deleteAt (DK_domiRole find _role);

			if (DK_domiRole isEqualTo []) then
			{
				DK_domiRole = +domiRole;
				_nul = DK_domiRole deleteAt (DK_domiRole find _role);
			};
		};

		if (_className in ["C_Heli_Light_01_civil_F", "C_Plane_Civil_01_racing_F"]) exitWith
		{
			_role = selectRandom DK_VIPcivRole;

			private _nul = DK_VIPcivRole deleteAt (DK_VIPcivRole find _role);

			if (DK_VIPcivRole isEqualTo []) then
			{
				DK_VIPcivRole = +VIPcivRole;
				_nul = DK_VIPcivRole deleteAt (DK_VIPcivRole find _role);
			};
		};

		if (_className isEqualTo "O_Heli_Transport_04_medevac_F") exitWith
		{
			_role = selectRandom DK_medRole;

			private _nul = DK_medRole deleteAt (DK_medRole find _role);

			if (DK_medRole isEqualTo []) then
			{
				DK_medRole = +medRole;
				_nul = DK_medRole deleteAt (DK_medRole find _role);
			};
		};

		if (_className isEqualTo "C_IDAP_Heli_Transport_02_F") exitWith
		{
			_role = selectRandom DK_IDAProle;

			private _nul = DK_IDAProle deleteAt (DK_IDAProle find _role);

			if (DK_IDAProle isEqualTo []) then
			{
				DK_IDAProle = +IDAProle;
				_nul = DK_IDAProle deleteAt (DK_IDAProle find _role);
			};
		};

		if (_class in ["army", "armyGH"]) exitWith
		{
			_role = (selectRandom DK_VIParmyRole) + (name _unit);

			private _nul = DK_VIParmyRole deleteAt (DK_VIParmyRole find _role);

			if (DK_VIParmyRole isEqualTo []) then
			{
				DK_VIParmyRole = +VIParmyRole;
				_nul = DK_VIParmyRole deleteAt (DK_VIParmyRole find _role);
			};
		};

		_role = "the unknown"
	};


	_role
};

DK_MIS_slctContain = {

	private _contain = selectRandom DK_containTakeCar;

	private _nul = DK_containTakeCar deleteAt (DK_containTakeCar find _contain);

	if (DK_containTakeCar isEqualTo []) then
	{
		DK_containTakeCar = +containTakeCar;
		_nul = DK_containTakeCar deleteAt (DK_containTakeCar find _contain);
	};


	_contain
};



/// // Sounds
DK_MIS_slctVictorySnd = {

	private _sound = selectRandom DK_victorySnd;

	private _nul = DK_victorySnd deleteAt (DK_victorySnd find _sound);

	if (DK_victorySnd isEqualTo []) then
	{
		DK_victorySnd = +victorySnd;
		_nul = DK_victorySnd deleteAt (DK_victorySnd find _sound);
	};


	_sound
};

DK_MIS_fnc_setCntPatrolCops = {

	private _ltdCops = "Par_patrolCops" call BIS_fnc_getParamValue;

	if ( (_this isEqualTo "I_officer_F") && { (_ltdCops > 1) } ) then
	{
		DK_copsPatrolMax = 1;
	};


	_ltdCops
};

// Count down ; maximum time for completed mission
DK_MIS_fnc_cntdwnMaxTimeMission = {

	private "_time";

	if (DK_cntdwnTime < 1) then
	{
		DK_cntdwnTime = DK_MIS_maxTimeMission;
	};

	if (DK_cntdwnTime < 1) exitWith {};

	while { _this isEqualTo DK_idMission } do
	{
		_time = time + 59;

		uiSleep 50;

		waitUntil { uiSleep 0.2; (time > _time) OR !(_this isEqualTo DK_idMission) };

		if !(_this isEqualTo DK_idMission) exitWith {};

		if (!isNil "DK_cntdwnTime") then
		{
			DK_cntdwnTime = DK_cntdwnTime - 60;
		};

		if (DK_cntdwnTime < 1) exitWith {};
	};
};


