//IF TRUE EXITWITH {};


if (!isServer) exitWith {};

waitUntil { DK_CLAG_Init_End };


#define slpPbLgc_Far 10
#define slpPbLgc_Near 5
#define slpPbLgc_See 3

#define LogicPuBa(LGC) _nul = DK_CLAG_Logics pushBackUnique LGC
#define LogicDel(LGC) _nul = DK_CLAG_Logics deleteAt (DK_CLAG_Logics find LGC)

#define LogicPedPuBa(LGC) _nul = DK_CLAG_LogicsPeds pushBackUnique LGC
#define LogicPedDel(LGC) _nul = DK_CLAG_LogicsPeds deleteAt (DK_CLAG_LogicsPeds find LGC)

#define LogicTeTrPuBa(LGC) _nul = DK_CLAG_LogicsTechsTramps pushBackUnique LGC
#define LogicTeTrDel(LGC) _nul = DK_CLAG_LogicsTechsTramps deleteAt (DK_CLAG_LogicsTechsTramps find LGC)

#define LogicGasPuBa(LGC) _nul = DK_CLAG_logicsGasStation pushBackUnique LGC
#define LogicGasDel(LGC) _nul = DK_CLAG_logicsGasStation deleteAt (DK_CLAG_logicsGasStation find LGC)

#define LogicFaunPuBa(LGC) _nul = DK_CLAG_LogicsFaun pushBackUnique LGC
#define LogicFaunDel(LGC) _nul = DK_CLAG_LogicsFaun deleteAt (DK_CLAG_LogicsFaun find LGC)

#define LogicVPKPuBa(LGC) _nul = DK_CLAG_logicsGlobVPK pushBackUnique LGC
#define LogicVPKDel(LGC) _nul = DK_CLAG_logicsGlobVPK deleteAt (DK_CLAG_logicsGlobVPK find LGC)

#define LogicVPKCTRYPuBa(LGC) _nul = DK_CLAG_logicsCtryRoadsVPK pushBackUnique LGC
#define LogicVPKCTRYDel(LGC) _nul = DK_CLAG_logicsCtryRoadsVPK deleteAt (DK_CLAG_logicsCtryRoadsVPK find LGC)

#define LogicVPKCTRYBPuBa(LGC) _nul = DK_CLAG_logicsCtryBuildVPK pushBackUnique LGC
#define LogicVPKCTRYBDel(LGC) _nul = DK_CLAG_logicsCtryBuildVPK deleteAt (DK_CLAG_logicsCtryBuildVPK find LGC)

#define LogicAirPuBa(LGC) _nul = DK_CLAG_LogicsAirAtLand pushBackUnique LGC
#define LogicAirDel(LGC) _nul = DK_CLAG_LogicsAirAtLand deleteAt (DK_CLAG_LogicsAirAtLand find LGC)

#define LogicBoatPuBa(LGC) _nul = DK_CLAG_LogicsBoats pushBackUnique LGC
#define LogicBoatDel(LGC) _nul = DK_CLAG_LogicsBoats deleteAt (DK_CLAG_LogicsBoats find LGC)

#define LogicEvtPuBa(LGC) _nul = DK_CLAG_LogicsEvents pushBackUnique LGC
#define LogicEvtDel(LGC) _nul = DK_CLAG_LogicsEvents deleteAt (DK_CLAG_LogicsEvents find LGC)

#define LogicTraffSecPuBa(LGC) _nul = DK_CLAG_LogicsTrafficSec pushBackUnique LGC
#define LogicTraffSecDel(LGC) _nul = DK_CLAG_LogicsTrafficSec deleteAt (DK_CLAG_LogicsTrafficSec find LGC)

#define LogicTraffMainPuBa(LGC) _nul = DK_CLAG_LogicsTrafficMain pushBackUnique LGC
#define LogicTraffMainDel(LGC) _nul = DK_CLAG_LogicsTrafficMain deleteAt (DK_CLAG_LogicsTrafficMain find LGC)



#define CntCIV DK_countNb_civ_CLAG < DK_CLAG_limitNumbersCiv
#define CntCIVat0 if (DK_countNb_civ_CLAG < 0) then {DK_countNb_civ_CLAG = 0}
#define CntPED DK_countNb_ped_CLAG < DK_CLAG_limitNumbersPed
#define CntPEDat0 if (DK_countNb_ped_CLAG < 0) then {DK_countNb_ped_CLAG = 0}
#define CntVPK DK_countNb_veh_CLAG < DK_CLAG_limitNumbersVeh
#define CntVPKat0 if (DK_countNb_veh_CLAG < 0) then {DK_countNb_veh_CLAG = 0}
#define CntAIR DK_countNb_air_CLAG < DK_CLAG_limitNumbersAir
#define CntAIRat0 if (DK_countNb_air_CLAG < 0) then {DK_countNb_air_CLAG = 0}
#define CntEVT DK_countNb_event_CLAG < DK_CLAG_LimiteNumberEvt
#define CntEVTat0 if (DK_countNb_event_CLAG < 0) then {DK_countNb_event_CLAG = 0}
#define CntTRAFF DK_countNb_traffic_CLAG < DK_CLAG_LimiteNumberTraff
#define CntTRAFFat0 if (DK_countNb_traffic_CLAG < 0) then {DK_countNb_traffic_CLAG = 0}
#define CntBOATS DK_countNb_boats_CLAG < DK_CLAG_LimiteNumberBoats
#define CntBOATSat0 if (DK_countNb_boats_CLAG < 0) then {DK_countNb_boats_CLAG = 0}


#define S_Lgcs selectRandom DK_CLAG_Logics
#define S_LgcsTT selectRandom DK_CLAG_LogicsTechsTramps
#define S_LgcsPD selectRandom DK_CLAG_LogicsPeds
#define S_LgcsF selectRandom DK_CLAG_LogicsFaun

#define S_LgcsAL selectRandom DK_CLAG_LogicsAirAtLand
#define S_LgcsBT selectRandom DK_CLAG_LogicsBoats

#define S_LgcsGVPK selectRandom DK_CLAG_logicsGlobVPK
#define S_LgcsCRVPK selectRandom DK_CLAG_logicsCtryRoadsVPK
#define S_LgcsCBVPK selectRandom DK_CLAG_logicsCtryBuildVPK

#define S_LgcsGS selectRandom DK_CLAG_logicsGasStation
#define S_LgcsEVT selectRandom DK_CLAG_LogicsEvents

#define S_LgcsTRAFFm selectRandom DK_CLAG_LogicsTrafficMain
#define S_LgcsTRAFFs selectRandom DK_CLAG_LogicsTrafficSec


#define noLgcs DK_CLAG_Logics isEqualTo []
#define noLgcsTT DK_CLAG_LogicsTechsTramps isEqualTo []
#define noLgcsPD DK_CLAG_LogicsPeds isEqualTo []
#define noLgcsF DK_CLAG_LogicsFaun isEqualTo []

#define noLgcsAL DK_CLAG_LogicsAirAtLand isEqualTo []
#define noLgcsBOAT DK_CLAG_LogicsBoats isEqualTo []

#define noLgcsGVPK DK_CLAG_logicsGlobVPK isEqualTo []
#define noLgcsCRVPK DK_CLAG_logicsCtryRoadsVPK isEqualTo []
#define noLgcsCBVPK DK_CLAG_logicsCtryBuildVPK isEqualTo []

#define noLgcsGS DK_CLAG_logicsGasStation isEqualTo []
#define noLgcsEVT DK_CLAG_LogicsEvents isEqualTo []

#define noLgcsTRAFFmain DK_CLAG_LogicsTrafficMain isEqualTo []
#define noLgcsTRAFFsec DK_CLAG_LogicsTrafficSec isEqualTo []

#define nbEvtRdm [1,2,3,4,5]
DK_nbEvtRdm = +nbEvtRdm;
#define DK_nbEvtRdmDel(NB) private _nul = DK_nbEvtRdm deleteAt (DK_nbEvtRdm find NB)

#define eye(X,A) [vehicle X, "IFIRE"] checkVisibility [eyePos X, A] > 0

#define lgcsWtCivDel(L) _nul = DK_CLAG_arr_lgcsWtCiv deleteAt (DK_CLAG_arr_lgcsWtCiv find L)
#define lgcsWtEndCivDel(L) _nul = DK_CLAG_arr_lgcsWtEndCiv deleteAt (DK_CLAG_arr_lgcsWtEndCiv find L)
#define lgcsWtBehaCivDel(L) _nul = DK_CLAG_arr_lgcsWtBehaCiv deleteAt (DK_CLAG_arr_lgcsWtBehaCiv find L)

#define lgcsWtTechTrDel(L) _nul = DK_CLAG_arr_lgcsWtTechTr deleteAt (DK_CLAG_arr_lgcsWtTechTr find L)
#define lgcsWtEndTeTrDel(L) _nul = DK_CLAG_arr_lgcsWtEndTeTr deleteAt (DK_CLAG_arr_lgcsWtEndTeTr find L)
#define lgcsWtBehaTeTrDel(L) _nul = DK_CLAG_arr_lgcsWtBehaTeTr deleteAt (DK_CLAG_arr_lgcsWtBehaTeTr find L)

#define lgcsWtPedDel(L) _nul = DK_CLAG_arr_lgcsWtPed deleteAt (DK_CLAG_arr_lgcsWtPed find L)
#define lgcsWtEndCivPedDel(L) _nul = DK_CLAG_arr_lgcsWtEndCivPed deleteAt (DK_CLAG_arr_lgcsWtEndCivPed find L)
#define lgcsWtBehaCivPedDel(L) _nul = DK_CLAG_arr_lgcsWtBehaCivPed deleteAt (DK_CLAG_arr_lgcsWtBehaCivPed find L)

#define lgcsWtEvtDel(L) _nul = DK_CLAG_arr_lgcsWtEvt deleteAt (DK_CLAG_arr_lgcsWtEvt find L)
#define lgcsWtFaunDel(L) _nul = DK_CLAG_arr_lgcsWtFaun deleteAt (DK_CLAG_arr_lgcsWtFaun find L)

#define lgcsWtAirDel(L) _nul = DK_CLAG_arr_lgcsWtAir deleteAt (DK_CLAG_arr_lgcsWtAir find L)
#define lgcsWtEndAirDel(L) _nul = DK_CLAG_arr_lgcsWtEndAir deleteAt (DK_CLAG_arr_lgcsWtEndAir find L)

#define lgcsWtBoatsDel(L) _nul = DK_CLAG_arr_lgcsWtBoat deleteAt (DK_CLAG_arr_lgcsWtBoat find L)
#define lgcsWtEndBoatsDel(L) _nul = DK_CLAG_arr_lgcsWtEndBoats deleteAt (DK_CLAG_arr_lgcsWtEndBoats find L)

#define lgcsWtTraffSecDel(L) _nul = DK_CLAG_arr_lgcsWtTraffs deleteAt (DK_CLAG_arr_lgcsWtTraffs find L)
#define lgcsWtTraffMainDel(L) _nul = DK_CLAG_arr_lgcsWtTraffm deleteAt (DK_CLAG_arr_lgcsWtTraffm find L)

#define lgcsWtVPKDel(L) _nul = DK_CLAG_arr_lgcsWtVPK deleteAt (DK_CLAG_arr_lgcsWtVPK find L)
#define lgcsWtEndVPKDel(L) _nul = DK_CLAG_arr_lgcsWtEndVPK deleteAt (DK_CLAG_arr_lgcsWtEndVPK find L)


#define lgcsWtVPKCTRYDel(L) _nul = DK_CLAG_arr_lgcsWtVPKCTRY deleteAt (DK_CLAG_arr_lgcsWtVPKCTRY find L)
#define lgcsWtVPKCTRYBDel(L) _nul = DK_CLAG_arr_lgcsWtVPKCTRYB deleteAt (DK_CLAG_arr_lgcsWtVPKCTRYB find L)

#define lgcsWtGasDel(L) _nul = DK_CLAG_arr_lgcsWtGas deleteAt (DK_CLAG_arr_lgcsWtGas find L)
#define lgcsWtEndGasDel(L) _nul = DK_CLAG_arr_lgcsWtEndGas deleteAt (DK_CLAG_arr_lgcsWtEndGas find L)
#define lgcsWtBehaGasDel(L) _nul = DK_CLAG_arr_lgcsWtBehaGas deleteAt (DK_CLAG_arr_lgcsWtBehaGas find L)

//#define vehHardLmt { (alive _x) && { (_x isKindOf "LandVehicle") && { (simulationEnabled _x) } } } count vehicles
#define vehHardLmt { (_x isKindOf "LandVehicle") && { (simulationEnabled _x) } } count vehicles

DK_CLAG_nbVehHardLmt = round ((DK_CLAG_limitNumbersVeh + DK_CLAG_LimiteNumberTraff) * 1.8) - 1;


DK_CLAG_arr_lgcsWtCiv = [];
DK_CLAG_arr_lgcsWtEndCiv = [];
DK_CLAG_arr_lgcsWtBehaCiv = [];

DK_CLAG_arr_lgcsWtTechTr = [];
DK_CLAG_arr_lgcsWtEndTeTr = [];
DK_CLAG_arr_lgcsWtBehaTeTr = [];

DK_CLAG_arr_lgcsWtPed = [];
DK_CLAG_arr_lgcsWtEndCivPed = [];
DK_CLAG_arr_lgcsWtBehaCivPed = [];

DK_CLAG_arr_lgcsWtEvt = [];
DK_CLAG_arr_lgcsWtFaun = [];

DK_CLAG_arr_lgcsWtAir = [];
DK_CLAG_arr_lgcsWtEndAir = [];

DK_CLAG_arr_lgcsWtBoat = [];
DK_CLAG_arr_lgcsWtEndBoats = [];

DK_CLAG_arr_lgcsWtTraffs = [];
DK_CLAG_arr_lgcsWtTraffm = [];

DK_CLAG_arr_lgcsWtVPK = [];
DK_CLAG_arr_lgcsWtEndVPK = [];

DK_CLAG_arr_lgcsWtVPKCTRY = [];
DK_CLAG_arr_lgcsWtVPKCTRYB = [];

DK_CLAG_arr_lgcsWtGas = [];
DK_CLAG_arr_lgcsWtEndGas = [];
DK_CLAG_arr_lgcsWtBehaGas = [];


DK_CLAG_noBandit = true;


DK_copsPatrol = 0;
DK_copsPatrolMax = "Par_patrolCops" call BIS_fnc_getParamValue;

DK_SFTnb = 0;
DK_SFTnbMax = "Par_fuelTruckSmall" call BIS_fnc_getParamValue;


/// LOOP MANAGER ///
#define CNTtraffNb(NB) DK_countNb_traffic_CLAG = DK_countNb_traffic_CLAG + NB

#define U_Sleep 0.02
#define FA_Sleep 2
#define AIR_Sleep 0.25
#define V_Sleep 0.04
#define EVT_Sleep 0.07
#define TRAFF_Sleep 0.02
#define BOAT_Sleep 0.25

#define slpFlee 180
#define slpDead 300 


if (DK_CLAG_debugModHint) then
{
	[] spawn
	{
		private "_counted";

		while { true } do
		{

			uiSleep 3.5;
			_counted = format ["Spawns: %1 - Civs chat: %2 - Peds: %4 - Dogs: %3 - Vehs Park: %5 - Veh Traffic: %8 - Boats: %9 - Faun: %6 - Air: %7 - Event road side: %10",
			(count DK_CLAG_Logics) + (count DK_CLAG_LogicsPeds) + (count DK_CLAG_logicsCtryRoadsVPK) + (count DK_CLAG_logicsGlobVPK) + (count DK_CLAG_LogicsFaun) + (count DK_CLAG_logicsGasStation) + (count DK_CLAG_LogicsTechsTramps) + (count DK_CLAG_LogicsAirAtLand) + (count DK_CLAG_LogicsTrafficSec) + (count DK_CLAG_LogicsTrafficMain),
			DK_countNb_civ_CLAG, DK_countNb_dog_CLAG, DK_countNb_ped_CLAG, DK_countNb_veh_CLAG, DK_countNb_faun_CLAG, DK_countNb_air_CLAG, DK_countNb_traffic_CLAG, DK_countNb_boats_CLAG, DK_countNb_event_CLAG]; 

			hintSilent _counted;
	//		{ hintSilent _counted } remoteExecCall 
	//		copyToClipboard _counted;
		};
	};
};


/// // LOOPS CORE MANAGER

/// LIMITE depend Time
if (["Par_limitCivIfNight", 1] call BIS_fnc_getParamValue isEqualTo 1) then
{
	DK_CLAG_limitNumbersCiv_init = DK_CLAG_limitNumbersCiv;
	DK_CLAG_limitNumbersPed_init = DK_CLAG_limitNumbersPed;
	DK_CLAG_limitNumbersDog_init = DK_CLAG_limitNumbersDog;
	DK_CLAG_limitNumbersFaun_init = DK_CLAG_limitNumbersFaun;
	DK_CLAG_limitNumbersVeh_init = DK_CLAG_limitNumbersVeh;
	DK_CLAG_LimiteNumberTraff_init = DK_CLAG_LimiteNumberTraff;

	[] spawn
	{
		private "_dayTime";

		uiSleep 5;

		while { true } do
		{
			_dayTime = daytime;
			if ((_daytime < 5) OR (_daytime > 19)) then
			{
				DK_CLAG_limitNumbersCiv = DK_CLAG_limitNumbersCiv_init / 2;
				DK_CLAG_limitNumbersPed = DK_CLAG_limitNumbersPed_init / 2;
				DK_CLAG_limitNumbersDog = DK_CLAG_limitNumbersDog_init / 2;
				DK_CLAG_limitNumbersFaun = DK_CLAG_limitNumbersFaun_init / 3;
				DK_CLAG_limitNumbersVeh = DK_CLAG_limitNumbersVeh_init * 2;
				DK_CLAG_LimiteNumberTraff = DK_CLAG_LimiteNumberTraff_init / 2;
			}
			else
			{
				DK_CLAG_limitNumbersCiv = DK_CLAG_limitNumbersCiv_init;
				DK_CLAG_limitNumbersPed = DK_CLAG_limitNumbersPed_init;
				DK_CLAG_limitNumbersDog = DK_CLAG_limitNumbersDog_init;
				DK_CLAG_limitNumbersFaun = DK_CLAG_limitNumbersFaun_init;
				DK_CLAG_limitNumbersVeh = DK_CLAG_limitNumbersVeh_init;
				DK_CLAG_LimiteNumberTraff = DK_CLAG_LimiteNumberTraff_init;
			};

			uiSleep 300;
		};
	};
};


// Number of vehicles in traffic manager
[] spawn
{
	private "_nil";

	while { true } do
	{
		waitUntil { uiSleep 1; !(DK_vehsTrafficsAr isEqualTo []) };

		{
//			hint "loop 1";
			_x params ["_veh", "_civ"];
//			hint "loop 2";

			if ( (isNil "_veh") OR (isNull _veh) OR (isNil "_civ") OR (isNull _civ) ) then
			{
//				hint "loop 3";
				_nil = DK_vehsTrafficsAr deleteAt (DK_vehsTrafficsAr find _x);
				CNTtraffNb(-1)
			};

			uiSleep 0.03;

		} forEach DK_vehsTrafficsAr;
	};

};


///\\\\ Pushback manager ////\\\

///// In Core Manager Loop
[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtCiv"];

	while { uiSleep 1; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtCiv = +DK_CLAG_arr_lgcsWtCiv;

		{
			if (_time > _x # 1) then
			{
				lgcsWtCivDel(_x);
				LogicPuBa(_x # 0);
			};

			uiSleep 0.02;

		} count _DK_CLAG_arr_lgcsWtCiv;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtCiv)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtTechTr"];

	while { uiSleep 1; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtTechTr = +DK_CLAG_arr_lgcsWtTechTr;

		{
			if (_time > _x # 1) then
			{
				lgcsWtTechTrDel(_x);
				LogicTeTrPuBa(_x # 0);
			};

			uiSleep 0.03;

		} count _DK_CLAG_arr_lgcsWtTechTr;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtTechTr)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtPed"];

	while { uiSleep 1; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtPed = +DK_CLAG_arr_lgcsWtPed;

		{
			if (_time > _x # 1) then
			{
				lgcsWtPedDel(_x);
				LogicPedPuBa(_x # 0);
			};

			uiSleep 0.02;

		} count _DK_CLAG_arr_lgcsWtPed;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtPed)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtFaun"];

	while { uiSleep 5; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtFaun = +DK_CLAG_arr_lgcsWtFaun;

		{
			if (_time > _x # 1) then
			{
				lgcsWtFaunDel(_x);
				LogicFaunPuBa(_x # 0);
			};

			uiSleep 0.5;

		} count _DK_CLAG_arr_lgcsWtFaun;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtFaun)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtAir"];

	while { uiSleep 1; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtAir = +DK_CLAG_arr_lgcsWtAir;

		{
			if (_time > _x # 1) then
			{
				lgcsWtAirDel(_x);
				LogicAirPuBa(_x # 0);
			};

			uiSleep 0.05;

		} count _DK_CLAG_arr_lgcsWtAir;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtAir)));
	};
};

[] spawn
{
	private ["_nul", "_time"];

	while { uiSleep 3; true } do
	{
		_time = time;

		{
			if (_time > _x # 1) then
			{
				lgcsWtBoatsDel(_x);
				LogicBoatPuBa(_x # 0);
			};

			uiSleep 0.1;

		} count DK_CLAG_arr_lgcsWtBoat;

//		hint str (count DK_CLAG_arr_lgcsWtBoat);
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtTraffs"];

	while { uiSleep 0.5; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtTraffs = +DK_CLAG_arr_lgcsWtTraffs;

		{
			if (_time > _x # 1) then
			{
				lgcsWtTraffSecDel(_x);
				LogicTraffSecPuBa(_x # 0);
			};

			uiSleep 0.02;

		} count _DK_CLAG_arr_lgcsWtTraffs;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtTraffs)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtTraffm"];

	while { uiSleep 0.5; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtTraffm = +DK_CLAG_arr_lgcsWtTraffm;

		{
			if (_time > _x # 1) then
			{
				lgcsWtTraffMainDel(_x);
				LogicTraffMainPuBa(_x # 0);
			};

			uiSleep 0.02;

		} count _DK_CLAG_arr_lgcsWtTraffm;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtTraffm)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtVPK"];

	while { uiSleep 2; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtVPK = +DK_CLAG_arr_lgcsWtVPK;

		{
			if (_time > _x # 1) then
			{
				lgcsWtVPKDel(_x);
				LogicVPKPuBa(_x # 0);
			};

			uiSleep 0.04;

		} count _DK_CLAG_arr_lgcsWtVPK;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtVPK)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtVPKCTRY"];

	while { uiSleep 1; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtVPKCTRY = +DK_CLAG_arr_lgcsWtVPKCTRY;

		{
			if (_time > _x # 1) then
			{
				lgcsWtVPKCTRYDel(_x);
				LogicVPKCTRYPuBa(_x # 0);
			};

			uiSleep 0.02;

		} count _DK_CLAG_arr_lgcsWtVPKCTRY;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtVPKCTRY)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtVPKCTRYB"];

	while { uiSleep 1; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtVPKCTRYB = +DK_CLAG_arr_lgcsWtVPKCTRYB;

		{
			if (_time > _x # 1) then
			{
				lgcsWtVPKCTRYBDel(_x);
				LogicVPKCTRYBPuBa(_x # 0);
			};

			uiSleep 0.02;

		} count _DK_CLAG_arr_lgcsWtVPKCTRYB;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtVPKCTRYB)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtGas"];

	while { uiSleep 2; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtGas = +DK_CLAG_arr_lgcsWtGas;

		{
			if (_time > _x # 1) then
			{
				lgcsWtGasDel(_x);
				LogicGasPuBa(_x # 0);
			};

			uiSleep 0.2;

		} count _DK_CLAG_arr_lgcsWtGas;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtGas)));
	};
};

[] spawn
{
	private ["_nul", "_time", "_DK_CLAG_arr_lgcsWtEvt"];

	while { uiSleep 3; true } do
	{
		_time = time;
		_DK_CLAG_arr_lgcsWtEvt = +DK_CLAG_arr_lgcsWtEvt;

		{
			if (_time > _x # 1) then
			{
				lgcsWtEvtDel(_x);
				LogicEvtPuBa(_x # 0);
			};

			uiSleep 0.05;

		} count _DK_CLAG_arr_lgcsWtEvt;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtEvt)));
	};
};


///// In Functions Files

// Units civils
[] spawn
{
	private ["_nul", "_array", "_beha", "_nTime"];

	while { uiSleep 4; true } do
	{
//		private _time = time;
		{
			if !(_x # 1 getVariable ["DK_behaviour", ""] isEqualTo _x # 2) then
			{
				lgcsWtBehaCivDel(_x);
				_array = _x # 0;
				call
				{
					_beha = _array # 0 getVariable ["DK_behaviour", ""];

					if (_beha isEqualTo "flee") exitWith
					{
						_nTime = time + slpFlee;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					if (_beha isEqualTo "dead") exitWith
					{
						_nTime = time + slpDead;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					_nul = _array pushBack 0;
				};

				_nul = DK_CLAG_arr_lgcsWtEndCiv pushBackUnique _array;
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtBehaCiv;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtBehaCiv)));
	};
};

[] spawn
{
	private ["_nul", "_array"];

	while { uiSleep 5; true } do
	{
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
				lgcsWtEndCivDel(_array);
				LogicPuBa(_logic);
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtEndCiv;

//		hint str (count DK_CLAG_arr_lgcsWtEndCiv);
	};
};


[] spawn
{
	private ["_nul", "_array", "_beha", "_nTime"];

	while { uiSleep 4; true } do
	{
		{
			if !(_x # 1 getVariable ["DK_behaviour", ""] in (_x # 2)) then
			{
				lgcsWtBehaCivPedDel(_x);
				_array = _x # 0;
				call
				{
					_beha = _array # 0 getVariable ["DK_behaviour", ""];

					if (_beha isEqualTo "flee") exitWith
					{
						_nTime = time + slpFlee;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					if (_beha isEqualTo "dead") exitWith
					{
						_nTime = time + slpDead;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					_nul = _array pushBack 0;
				};

				_nul = DK_CLAG_arr_lgcsWtEndCivPed pushBackUnique _array;
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtBehaCivPed;

//		hint str (count DK_CLAG_arr_lgcsWtBehaCivPed);
	};
};

[] spawn
{
	private ["_nul", "_array", "_logicLink"];

	while { uiSleep 5; true } do
	{
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
				lgcsWtEndCivPedDel(_array);
				_nul = DK_CLAG_LogicsPeds pushBackUnique _logic;

				_logicLink = _logic getVariable "logicLink";
				if (!isNil "_logicLink") then
				{
					_nul = DK_CLAG_LogicsPeds pushBackUnique _logicLink;
				};
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtEndCivPed;

//		hint str (count DK_CLAG_arr_lgcsWtEndCivPed);
	};
};


[] spawn
{
	private ["_nul", "_array", "_beha", "_nTime"];

	while { uiSleep 4; true } do
	{
		{
			if !(_x # 1 getVariable ["DK_behaviour", ""] isEqualTo _x # 2) then
			{
				lgcsWtBehaTeTrDel(_x);
				_array = _x # 0;
				call
				{
					_beha = _array # 0 getVariable ["DK_behaviour", ""];

					if (_beha isEqualTo "flee") exitWith
					{
						_nTime = time + slpFlee;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					if (_beha isEqualTo "dead") exitWith
					{
						_nTime = time + slpDead;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					_nul = _array pushBack 0;
				};

				_nul = DK_CLAG_arr_lgcsWtEndTeTr pushBackUnique _array;
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtBehaTeTr;
	};
};

[] spawn
{
	private ["_nul", "_array"];

	while { uiSleep 5; true } do
	{
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
				lgcsWtEndTeTrDel(_array);
				_nul = DK_CLAG_LogicsTechsTramps pushBackUnique _logic;
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtEndTeTr;

//		hint str (count DK_CLAG_arr_lgcsWtEndTeTr);
	};
};


[] spawn
{
	private ["_nul", "_array", "_beha", "_nTime"];

	while { uiSleep 6; true } do
	{
		{
			if !(_x # 1 getVariable ["DK_behaviour", ""] isEqualTo _x # 2) then
			{
				lgcsWtBehaGasDel(_x);
				_array = _x # 0;
				call
				{
					_beha = _array # 0 getVariable ["DK_behaviour", ""];

					if (_beha isEqualTo "flee") exitWith
					{
						_nTime = time + slpFlee;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					if (_beha isEqualTo "dead") exitWith
					{
						_nTime = time + slpDead;
						_nul = _array pushBack _nTime;
						_array set [1, (_nTime + (_array # 1))];
					};

					_nul = _array pushBack 0;
				};

				_nul = DK_CLAG_arr_lgcsWtEndGas pushBackUnique _array;
			};

			uiSleep 0.3;

		} count DK_CLAG_arr_lgcsWtBehaGas;
	};
};

[] spawn
{
	private ["_nul", "_array"];

	while { uiSleep 6; true } do
	{
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
				lgcsWtEndGasDel(_array);
				_nul = DK_CLAG_logicsGasStation pushBackUnique _logic;
			};

			uiSleep 0.3;

		} count DK_CLAG_arr_lgcsWtEndGas;

//		hint str (count DK_CLAG_arr_lgcsWtEndGas);
	};
};

// Vehicles
[] spawn
{
	private ["_nul", "_array"];

	while { uiSleep 3; true } do
	{
		private _time = time;
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp", "_parents"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
				lgcsWtEndVPKDel(_array);

				call
				{
					if (_parents isEqualTo "logicsVPK") exitWith
					{
						_nul = DK_CLAG_logicsGlobVPK pushBackUnique _logic;
					};
					if (_parents isEqualTo "logicsCtryVPK") exitWith
					{
						_nul = DK_CLAG_logicsCtryRoadsVPK pushBackUnique _logic;
					};
					if (_parents isEqualTo "logicsCtryBuildVPK") then
					{
						_nul = DK_CLAG_logicsCtryBuildVPK pushBackUnique _logic;
					};
				};
			};

			uiSleep 0.2;

		} count DK_CLAG_arr_lgcsWtEndVPK;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtEndVPK)));
	};
};

[] spawn
{
	private ["_nul", "_array"];

	while { uiSleep 5; true } do
	{
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
				lgcsWtEndBoatsDel(_array);
				_nul = DK_CLAG_logicsBoats pushBackUnique _logic;
			};

			uiSleep 0.5;

		} count DK_CLAG_arr_lgcsWtEndBoats;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtEndBoats)));
	};
};

[] spawn
{
	private ["_nul", "_array"];

	while { uiSleep 5; true } do
	{
		{
			_array = _x;
			_array params ["_logic", "_time", "_mkrPos", "_dis", "_slp"];

			if ( (time > _slp) && { (playableUnits findIf {_x distance2D _mkrPos < _dis} isEqualTo -1) OR (time > _time) } ) then
			{
		//		lgcsWtEndAirDel(_array);
				_nul = DK_CLAG_arr_lgcsWtEndAir deleteAt (DK_CLAG_arr_lgcsWtEndAir find _array);
				_nul = DK_CLAG_LogicsAirAtLand pushBackUnique _logic;
			};

			uiSleep 0.5;

		} count DK_CLAG_arr_lgcsWtEndAir;

//		hint (str (time - _time) + " : " + (str (count DK_CLAG_arr_lgcsWtEndAir)));
	};
};



/// Spawn life manager

/// CIVILIANS
if ( !(DK_CLAG_limitNumbersCiv isEqualTo 0) OR !(DK_CLAG_limitNumbersPed isEqualTo 0) && { ((DK_CLAG_CIV_sidewalk_allowed) OR (DK_CLAG_benchs_allowed) OR (DK_CLAG_chairs_allowed) OR (DK_CLAG_churchs_allowed) OR (DK_CLAG_kiosks_allowed) OR (DK_CLAG_hunterHut_allowed) OR (DK_CLAG_trampHut_allowed) OR (DK_CLAG_techWarehouse_allowed) OR (DK_CLAG_constructionSite_allowed)) } ) then
{
	[] spawn
	{
		private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type"];


		while { true } do
		{
			while { !(CntPED) && { !(CntCIV) } } do
			{
				uiSleep 1;
			};

			_toSleep = true;

			if !(noLgcs) then
			{
				_toSleep = false;

				if (CntCIV) then
				{
					CntCIVat0;

					_lgcSrc = S_Lgcs;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicDel(_lgcSrc);

						private "_lgc";
						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};


						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							if (isNil "_mkrPos") exitWith {};

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 40) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtCiv pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
										};

										if ( (_x distance2D _mkrPos < 400) && { (eye(_x,_lgcASL)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtCiv pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";
										if (_type isEqualTo "isMkrSw") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCiv.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isBench") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivBench.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isChair") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivChair.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isKiosk") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivKsk.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isChurch") exitWith
										{
											_lgc exec "DK_CLAG\DK_CLAG_crtCivChurch.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isSitFlr") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivSitFlr.sqs";
											uiSleep 0.1;
										};
									};
								};

								DK_CLAG_arr_lgcsWtCiv pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
							};
						};
					};

					uiSleep U_Sleep;
				};
			};

			if !(noLgcsTT) then
			{
				_toSleep = false;

				if (CntCIV) then
				{
					CntCIVat0;

					_lgcSrc = S_LgcsTT;

					if !(_lgcSrc isEqualTo [] ) then
					{
						LogicTeTrDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};


						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 40) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
										};

										if ( (_x distance2D _mkrPos < 400) && { (eye(_x,_lgcASL)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";

										if (_type isEqualTo "isHutTramp") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivHutTramp.sqs";
										};
										if (_type isEqualTo "isWarehouse") exitWith
										{
											[_mkrPos,_lgc,_lgcSrc] exec "DK_CLAG\DK_CLAG_crtCivTechWH.sqs";
										};
										if (_type isEqualTo "isBossWarehouse") exitWith
										{
											[_mkrPos,_lgc,_lgcSrc] exec "DK_CLAG\DK_CLAG_crtCivTechBossWH.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isTechnicians") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivTechsGroup.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isConstruc") exitWith
										{
											[_mkrPos,_lgc,_lgcSrc] exec "DK_CLAG\DK_CLAG_crtCivConstru.sqs";
											uiSleep 0.1;
										};
									};
								};

								DK_CLAG_arr_lgcsWtTechTr pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
							};
						};
					};

					uiSleep U_Sleep;
				};
			};


			if !(noLgcsPD) then
			{
				_toSleep = false;

				if (CntPED) then
				{
					CntPEDat0;

					_lgcSrc = S_LgcsPD;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicPedDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};


						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 40) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtPed pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
										};

										if ( (_x distance2D _mkrPos < 400) && { (eye(_x,_lgcASL)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtPed pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";
										if (_type isEqualTo "isHouse") exitWith
										{
											call
											{
												if (DK_CLAG_noBandit) exitWith
												{
													DK_CLAG_noBandit = false;
													[_mkrPos, _lgc] call DK_fnc_CLAG_crtCivPedBandit;
												};

												[_mkrPos, _lgc] call DK_fnc_CLAG_crtCivPed;
											};

											uiSleep 0.2;
										};
										if (_type isEqualTo "isHut") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtCivHut;
											uiSleep 0.1;
										};
										if (_type isEqualTo "isHikerWalker") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtCivHikerWalker;
											uiSleep 0.05;
										};
										if (_type isEqualTo "isHikerCamp") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtCivHikerCamp;
											uiSleep 0.1;
										};
										if (_type isEqualTo "isATM") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtCivATM;
											uiSleep 0.05;
										};
									};
								};

								DK_CLAG_arr_lgcsWtPed pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
							};
						};
					};

					uiSleep U_Sleep;
				};
			};

			if (_toSleep) then
			{
				uiSleep 8;
			};
		};
	};
};

/// ANIMALS
if ( !(DK_CLAG_limitNumbersFaun isEqualTo 0) && {(DK_CLAG_farmsNanimals_allowed)} ) then
{
	[] spawn
	{
		private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type"];


		while { true } do
		{
			_toSleep = true;

			if !(noLgcsF) then
			{
				_toSleep = false;

					_lgcSrc = S_LgcsF;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicFaunDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};

						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 120) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtFaun pushBackUnique [_lgcSrc, (time + 2)];
										};

										if ( (_x distance2D _mkrPos < 400) && { (eye(_x,_lgcASL)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtFaun pushBackUnique [_lgcSrc, (time + 2)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";

										if (_type isEqualTo "isFaun") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtFaun;
											uiSleep 1;
										};
										if (_type isEqualTo "isFaunRoad") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtFaunRoad;
											uiSleep 1;
										};
									};
								};

								DK_CLAG_arr_lgcsWtFaun pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
							};
						};
					};

					uiSleep FA_Sleep;
			};

			if (_toSleep) then
			{
				uiSleep 10;
			};
		};
	};
};

/// EVENTS
if ( !(DK_CLAG_LimiteNumberEvt isEqualTo 0) && {(DK_CLAG_EVENT_allowed)} ) then
{
	[] spawn
	{
		private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type", "_rdm"];


		while { true } do
		{
			while { !(CntEVT) } do
			{
				uiSleep 15;
			};

			CntEVTat0;

			_toSleep = true;

			if !(noLgcsEVT) then
			{
				_toSleep = false;

					_lgcSrc = S_LgcsEVT;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicEvtDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};


						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 100) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtEvt pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
										};

										if ( (_x distance2D _mkrPos < 600) && { (eye(_x,_lgcASL)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtEvt pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";
										if (_type isEqualTo "isEVNT_CBD") exitWith
										{
											_rdm = selectRandom DK_nbEvtRdm;
											DK_nbEvtRdmDel(_rdm);

											if (DK_nbEvtRdm isEqualTo []) then
											{
												DK_nbEvtRdm = +nbEvtRdm;
												DK_nbEvtRdmDel(_rdm);
											};

											switch _rdm do
											{
												case 1 :
												{
													[_mkrPos, _lgc] call DK_fnc_CLAG_crtEVT_CBD;
												};

												case 2 :
												{
													[_mkrPos, _lgc] call DK_fnc_CLAG_crtEVT_CopsCtrl;
												};

												case 3 :
												{
													[_mkrPos,_lgc] call DK_fnc_CLAG_crtEVT_Tractor;
												};

												case 4 :
												{
													[_mkrPos, _lgc] call DK_fnc_CLAG_crtEVT_HeyBale;
												};

												case 5 :
												{
													[_mkrPos, _lgc] call DK_fnc_CLAG_crtEVT_Market;
												};
											};

											uiSleep 0.25;
										};
										if (_type isEqualTo "isEVNT_JUMPzam") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtEVT_JUMPcons;

											uiSleep 0.25;
										};
									};
								};

								DK_CLAG_arr_lgcsWtEvt pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
							};
						};
					};

					uiSleep EVT_Sleep;
			};

			if (_toSleep) then
			{
				uiSleep 8;
			};
		};
	};
};

/// AIR at LAND
if ( !(DK_CLAG_limitNumbersAir isEqualTo 0) && { !(DK_CLAG_LogicsAirAtLand isEqualTo []) } ) then
{
	[] spawn
	{
		private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type"];


		while { true } do
		{
			_toSleep = true;

			if !(noLgcsAL) then
			{
				if (CntAIR) then
				{
					CntAIRat0;

					_toSleep = false;

					_lgcSrc = S_LgcsAL;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicAirDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};

						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 100) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtAir pushBackUnique [_lgcSrc, (time + 2)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";

										if (_type isEqualTo "isJet") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtJET;
											uiSleep 0.15;
										};
										if (_type isEqualTo "isHeli") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtHELI;
											uiSleep 0.15;
										};
										if (_type isEqualTo "isHeliL") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtHELIL;
											uiSleep 0.15;
										};
									};
								};

								DK_CLAG_arr_lgcsWtAir pushBackUnique [_lgcSrc, (time + 3)];
							};
						};
					};
				};

				uiSleep AIR_Sleep;
			};

			if (_toSleep) then
			{
				uiSleep 2;
			};
		};
	};
};

/// BOATS
if ( !(DK_CLAG_LimiteNumberBoats isEqualTo 0) && { (DK_CLAG_stasBoats_allowed) && { !(DK_CLAG_LogicsBoats isEqualTo []) } } ) then
{
	[] spawn
	{
		private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type"];


		while { true } do
		{
			while { !(CntBOATS) } do
			{
				uiSleep 15;
			};

			CntBOATSat0;

			_toSleep = true;

			if !(noLgcsBOAT) then
			{
				_toSleep = false;

					_lgcSrc = S_LgcsBT;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicBoatDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};


						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";

									{
										if (_x distance2D _mkrPos < 60) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtBoat pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
										};

										if ( (_x distance2D _mkrPos < 400) && { (eye(_x,_lgcASL)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtBoat pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
										};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";
										if (_type isEqualTo "isStasBoat") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtStasBoat;
											uiSleep 0.25;
										};
										if (_type isEqualTo "isMoveBoat") exitWith
										{
											[_mkrPos, _lgc] call DK_fnc_CLAG_crtMoveBoat;
											uiSleep 0.25;
										};
									};
								};

								DK_CLAG_arr_lgcsWtBoat pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
							};
						};
					};

					uiSleep BOAT_Sleep;
			};

			if (_toSleep) then
			{
				uiSleep 5;
			};
		};
	};
};


/// TRAFFIC
if ( (DK_CLAG_traffic_allowed) && { !(DK_CLAG_LimiteNumberTraff isEqualTo 0) } ) then
{
	[] spawn
	{
		private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type", "_roadCore", "_road", "_playerNrst", "_exit"];


		private _disMin = DK_CLAG_Default_DisMinTraffic;
		private _disMinFly = _disMin / 2;
		private _disMax = DK_CLAG_Default_DisMaxTraffic;
		DK_CLAG_Default_DisMinTraffic = nil;

		while { true } do
		{
			while { !(CntTRAFF) OR (vehHardLmt > DK_CLAG_nbVehHardLmt) } do
			{
				uiSleep 1;
			};

			CntTRAFFat0;


				_toSleep = true;

				if !(noLgcsTRAFFsec) then
				{
					_toSleep = false;

					_roadCore = S_LgcsTRAFFs;
					_road = _roadCore # 0;

					LogicTraffSecDel(_roadCore);

					call
					{
						_bl = false;

						_playUnits = playableUnits call KK_fnc_arrayShuffle;

						{
							_playerNrst = _x;
							if (_x distance2D _road < _disMax) exitWith
							{
								_bl = true;
							};

						} count _playUnits;

						call
						{
							if _bl exitWith
							{
								_bl = true;
								_exit = false;

								{
									if (((getPosATL _x ) # 2) < 50) then
									{
										if (_x distance2D _road < _disMin) exitWith
										{
											_bl = false;
											_exit = true;

											DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + 4)];
										};

										if ( (_x distance2D _road < 800) && { (eye(_x,_road)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + 2)];
										};
									}
									else
									{
										if (_x distance2D _road < _disMinFly) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + 4)];
										};
									};

									if _exit exitWith {};

								} count _playUnits;

								if _bl then
								{
									call
									{
										if (DK_copsPatrol < DK_copsPatrolMax) exitWith
										{
											[_roadCore, _playerNrst] call DK_fnc_CLAG_crtCopsPatrol;
											uiSleep 0.07;
										};

										[_roadCore,_playerNrst] exec "DK_CLAG\DK_CLAG_crtTRAFFIC.sqs";
										uiSleep 0.07;
									};
								};
							};

							DK_CLAG_arr_lgcsWtTraffs pushBackUnique [_roadCore, (time + 5)];
						};
					};

					uiSleep TRAFF_Sleep;
				};

				if !(noLgcsTRAFFmain) then
				{
					_toSleep = false;

					_roadCore = S_LgcsTRAFFm;
					_road = _roadCore # 0;

					LogicTraffMainDel(_roadCore);

					call
					{
						_bl = false;

						_playUnits = playableUnits call KK_fnc_arrayShuffle;

						{
							_playerNrst = _x;
							if (_x distance2D _road < _disMax) exitWith
							{
								_bl = true;
							};

						} count _playUnits;

						call
						{
							if _bl exitWith
							{
								_bl = true;
								_exit = false;

								{
									if (((getPosATL _x ) # 2) < 50) then
									{
										if (_x distance2D _road < _disMin) exitWith
										{
											_bl = false;
											_exit = true;

											DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + 3)];
										};

										if ( (_x distance2D _road < 800) && { (eye(_x,_road)) } ) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + 2)];
										};
									}
									else
									{
										if (_x distance2D _road < _disMinFly) exitWith
										{
											_bl = false;

											DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + 3)];
										};
									};

									if _exit exitWith {};

								} count _playUnits;

								if _bl then
								{
									call
									{
										if (DK_copsPatrol < DK_copsPatrolMax) exitWith
										{
											[_roadCore, _playerNrst, true] call DK_fnc_CLAG_crtCopsPatrol;
											uiSleep 0.07;
										};

										if (DK_SFTnb < DK_SFTnbMax) exitWith
										{
											[_roadCore, _playerNrst] call DK_fnc_CLAG_crtTRAFFICm_SFT;
											uiSleep 0.07;
										};

										[_roadCore, _playerNrst, true] exec "DK_CLAG\DK_CLAG_crtTRAFFICm.sqs";
										uiSleep 0.07;
									};
								};
							};

							DK_CLAG_arr_lgcsWtTraffm pushBackUnique [_roadCore, (time + 5)];
						};
					};

					uiSleep TRAFF_Sleep;
				};

				if (_toSleep) then
				{
					uiSleep 8;
				};
		};
	};
};

/// PARKED VEHICLES
if ( !(DK_CLAG_limitNumbersVeh isEqualTo 0) && { !(DK_CLAG_logicsGlobVPK isEqualTo []) OR !(DK_CLAG_logicsCtryRoadsVPK isEqualTo []) OR !(DK_CLAG_logicsCtryBuildVPK isEqualTo []) OR !(DK_CLAG_logicsGasStation isEqualTo []) OR (DK_CLAG_garagesServ_allowed) } ) then
{
	private ["_playUnits", "_toSleep", "_lgcSrc", "_lgc", "_bl", "_mkrPos", "_dis", "_lgcASL", "_type", "_exit"];


	while { true } do
	{
		while { !(CntVPK) OR (vehHardLmt > DK_CLAG_nbVehHardLmt) } do
		{
			uiSleep 1;
		};

		CntVPKat0;

		_toSleep = true;

		if !(noLgcsGVPK) then
		{
			_toSleep = false;

			_lgcSrc = S_LgcsGVPK;

			if  !(_lgcSrc isEqualTo [] ) then
			{
				LogicVPKDel(_lgcSrc);

				call
				{
					if (_lgcSrc isEqualType []) exitWith
					{
						_lgc = selectRandom _lgcSrc;
					};

					_lgc = _lgcSrc;
				};


				call
				{
					_bl = false;
					_mkrPos = _lgc getVariable "mkrPos";
					_dis = _lgc getVariable "choiceDis";

					_playUnits = playableUnits call KK_fnc_arrayShuffle;

					{
						if (_x distance2D _mkrPos < _dis) exitWith
						{
							_bl = true;
						};

					} count _playUnits;

					call
					{
						if _bl exitWith
						{
							_bl = true;
							_lgcASL = _lgc getVariable "posASL";
							_exit = false;

							{
								if (_x distance2D _mkrPos < 75) exitWith
								{
									_bl = false;
									_exit = true;

									DK_CLAG_arr_lgcsWtVPK pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
								};

								if ( (((getPosATL _x ) # 2) < 50) && { (_x distance2D _mkrPos < 800) && { (eye(_x,_lgcASL)) } } ) then
								{
									_bl = false;
									_exit = true;

									DK_CLAG_arr_lgcsWtVPK pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
								};

								if _exit exitWith {};

							} count _playUnits;

							if _bl then
							{
								_type = _lgc getVariable "type";

								if (_type isEqualTo "isVPK_CLV") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_OFR") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_OFR.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LTT") exitWith
								{
									[_mkrPos,_lgc,_lgcSrc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LTB") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTB.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LT") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLVVT") exitWith
								{
									call
									{
										if (round (random 10) isEqualTo 10) exitWith
										{
											[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VANT.sqs";
										};

										[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_OFRLTT") then
								{
									call
									{
										if ((round (random 4)) isEqualTo 4) exitWith
										{
											[_mkrPos,_lgc,_lgcSrc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
										};

										[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_OFR.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_VANC") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VANC.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_VANT") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VANT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_VAN") exitWith
								{
									[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VAN.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLVV") exitWith
								{
									call
									{
										if (round (random 10) isEqualTo 10) exitWith
										{
											[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VAN.sqs";
										};

										[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLVVC") exitWith
								{
									call
									{
										if (round (random 10) isEqualTo 10) exitWith
										{
											[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VANC.sqs";
										};

										[_mkrPos,_lgc,"logicsVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
							};
						};

						DK_CLAG_arr_lgcsWtVPK pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
					};
				};

				uiSleep V_Sleep;
			};
		};

		if !(noLgcsCRVPK) then
		{
			_toSleep = false;

			_lgcSrc = S_LgcsCRVPK;

			if  !(_lgcSrc isEqualTo [] ) then
			{
				LogicVPKCTRYDel(_lgcSrc);

				call
				{
					if (_lgcSrc isEqualType []) exitWith
					{
						_lgc = selectRandom _lgcSrc;
					};

					_lgc = _lgcSrc;
				};


				call
				{
					_bl = false;
					_mkrPos = _lgc getVariable "mkrPos";
					_dis = _lgc getVariable "choiceDis";

					_playUnits = playableUnits call KK_fnc_arrayShuffle;

					{
						if (_x distance2D _mkrPos < _dis) exitWith
						{
							_bl = true;
						};

					} count _playUnits;

					call
					{
						if (_bl) exitWith
						{
							_bl = true;
							_lgcASL = _lgc getVariable "posASL";
							_exit = false;

							{
								if (_x distance2D _mkrPos < 75) exitWith
								{
									_bl = false;
									_exit = true;

									DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
								};

								if ( (((getPosATL _x ) # 2) < 50) && { (_x distance2D _mkrPos < 800) && { (eye(_x,_lgcASL)) } } ) exitWith
								{
									_bl = false;
									_exit = true;

									DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
								};

								if _exit exitWith {};

							} count _playUnits;

							if (_bl) then
							{
								_type = _lgc getVariable "type";

								if (_type isEqualTo "isVPK_CLVVT") exitWith
								{
									call
									{
										if (round (random 10) isEqualTo 10) exitWith
										{
											[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VANT.sqs";
										};

										[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLVLTT") exitWith
								{
									call
									{
										if (round (random 7) isEqualTo 7) exitWith
										{
											[_mkrPos,_lgc,_lgcSrc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
										};

										[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLV") exitWith
								{
									[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LTT") exitWith
								{
									[_mkrPos,_lgc,_lgcSrc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_OFRLTT") then
								{
									call
									{
										if ((round (random 4)) isEqualTo 4) exitWith
										{
											[_mkrPos,_lgc,_lgcSrc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
										};

										[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_OFR.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LT") exitWith
								{
									[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_OFR") exitWith
								{
									[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_OFR.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_ZAM") exitWith
								{
									[_mkrPos,_lgc,"logicsCtryVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_ZAM.sqs";
									uiSleep 0.05;
								};
							};
						};

						DK_CLAG_arr_lgcsWtVPKCTRY pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
					};
				};

				uiSleep V_Sleep;
			};
		};

		if !(noLgcsCBVPK) then
		{
			_toSleep = false;

			_lgcSrc = S_LgcsCBVPK;

			if  !(_lgcSrc isEqualTo [] ) then
			{
				LogicVPKCTRYBDel(_lgcSrc);

				call
				{
					if (_lgcSrc isEqualType []) exitWith
					{
						_lgc = selectRandom _lgcSrc;
					};

					_lgc = _lgcSrc;
				};


				call
				{
					_bl = false;
					_mkrPos = _lgc getVariable "mkrPos";
					_dis = _lgc getVariable "choiceDis";

					_playUnits = playableUnits call KK_fnc_arrayShuffle;

					{
						if (_x distance2D _mkrPos < _dis) exitWith
						{
							_bl = true;
						};

					} count _playUnits;

					call
					{
						if (_bl) exitWith
						{
							_bl = true;
							_lgcASL = _lgc getVariable "posASL";
							_exit = false;

							{
								if (_x distance2D _mkrPos < 75) exitWith
								{
									_bl = false;
									_exit = true;

									DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_lgcSrc, (time + slpPbLgc_Near)];
								};


								if ( (((getPosATL _x ) # 2) < 80) && { (_x distance2D _mkrPos < 600) && { (eye(_x,_lgcASL)) } } ) exitWith
								{
									_bl = false;
									_exit = true;

									DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_lgcSrc, (time + slpPbLgc_See)];
								};

								if _exit exitWith {};

							} count _playUnits;

							if (_bl) then
							{
								_type = _lgc getVariable "type";

								if (_type isEqualTo "isVPK_CLVVT") exitWith
								{
									call
									{
										if (round (random 10) isEqualTo 10) exitWith
										{
											[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_VANT.sqs";
										};

										[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLVLTT") exitWith
								{
									call
									{
										if (round (random 7) isEqualTo 7) exitWith
										{
											[_mkrPos,_lgc,_lgcSrc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
										};

										[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_CLV") exitWith
								{
									[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_CLV.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LTT") exitWith
								{
									[_mkrPos,_lgc,_lgcSrc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_OFRLTT") then
								{
									call
									{
										if ((round (random 4)) isEqualTo 4) exitWith
										{
											[_mkrPos,_lgc,_lgcSrc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LTT.sqs";
										};

										[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_OFR.sqs";
									};

									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_LT") exitWith
								{
									[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_LT.sqs";
									uiSleep 0.05;
								};
								if (_type isEqualTo "isVPK_ZAM") then
								{
									[_mkrPos,_lgc,"logicsCtryBuildVPK"] exec "DK_CLAG\DK_CLAG_crtVPK_ZAM.sqs";
									uiSleep 0.05;
								};
							};
						};

						DK_CLAG_arr_lgcsWtVPKCTRYB pushBackUnique [_lgcSrc, (time + slpPbLgc_Far)];
					};
				};

				uiSleep V_Sleep;
			};
		};

		if !(noLgcsGS) then
		{
			_toSleep = false;

					_lgcSrc = S_LgcsGS;

					if  !(_lgcSrc isEqualTo [] ) then
					{
						LogicGasDel(_lgcSrc);

						call
						{
							if (_lgcSrc isEqualType []) exitWith
							{
								_lgc = selectRandom _lgcSrc;
							};

							_lgc = _lgcSrc;
						};


						call
						{
							_bl = false;
							_mkrPos = _lgc getVariable "mkrPos";
							_dis = _lgc getVariable "choiceDis";

							_playUnits = playableUnits call KK_fnc_arrayShuffle;

							{
								if (_x distance2D _mkrPos < _dis) exitWith
								{
									_bl = true;
								};

							} count _playUnits;

							call
							{
								if (_bl) exitWith
								{
									_bl = true;
									_lgcASL = _lgc getVariable "posASL";
									_exit = false;

									{
										if (_x distance2D _mkrPos < 75) exitWith
										{
											_bl = false;
											_exit = true;

											DK_CLAG_arr_lgcsWtGas pushBackUnique [_lgcSrc, (time + 5)];
										};

//										if (((getPosATL _x ) # 2) < 80) then
//										{
											if ( (((getPosATL _x ) # 2) < 80) && { (_x distance2D _mkrPos < 600) && { (eye(_x,_lgcASL)) } } ) exitWith
											{
												_bl = false;
												_exit = true;

												DK_CLAG_arr_lgcsWtGas pushBackUnique [_lgcSrc, (time + 5)];
											};
//										};

										if _exit exitWith {};

									} count _playUnits;

									if (_bl) then
									{
										_type = _lgc getVariable "type";

										if (_type isEqualTo "isGS") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivGS.sqs";
											uiSleep 0.15;
										};
										if (_type isEqualTo "isGarageCar") exitWith
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivGarageCar.sqs";
											uiSleep 0.1;
										};
										if (_type isEqualTo "isGarageRep") then
										{
											[_mkrPos,_lgc] exec "DK_CLAG\DK_CLAG_crtCivGarageRep.sqs";
											uiSleep 0.1;
										};
									};
								};

								DK_CLAG_arr_lgcsWtGas pushBackUnique [_lgcSrc, (time + 20)];
							};
						};

						uiSleep V_Sleep;
					};
		};

		if (_toSleep) then
		{
			uiSleep 8;
		};

	};
};