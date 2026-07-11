
/// FADE Screen & Sounds
0 fadeSound 0;
private _time = time + 45;


_time spawn
{
	waitUntil { (getClientStateNumber > 9) OR (time > _this) };

	["mtwLogo.jpg", false, 10, 6, [0, 2.8]] spawn BIS_fnc_textTiles;
	playMusic "connectServer";
	
	uiSleep 6;

	// Logo down-right screen
	[DK_vImg_logo,  safeZoneX + safeZoneW - 0.79 * 3 / 4, safeZoneY + safeZoneH - 0.24, 360, 3, 0, DK_lyDyn_logoF] spawn bis_fnc_dynamicText;

	uiSleep 2.5;

	DK_vTxt_presentationTitre hintC
	[
		"You are part of the " + str (roleDescription player) + " family, and you work for Kenny Petrovic.",
		"Blufor isn't you team, your group is your team, aswell as your family.",
		"You can only trust " + str (roleDescription player) + " family members, and Kenny Petrovic.",
		"Your family is in direct confrontation with other families (only players). Your goal is to gain the most respect points.",
		"RED target: KILL or DESTROY (gang member, traitor, delivery truck...).",
		"PURPLE target: STEAL and drop (vehicle or case). Do not destroy !",
		"YELLOW target: DROP location for vehicle or briefcase (only seen by the driver/carrier).",
		"You can follow waypoints (3D Icons) that point objectives locations.",
		"Your GPS is your minimap. Check it to locate targets, aswell as nearby members of your family.",
		"If your family has the highest score when match ends, they will dominate others forever.",
		"You can choose from 3 vehicle types before spawning with it.",
		"All cars can be field-repaired anytime."
	];

	uiSleep 10;
	4 fadeSound 1;
};

/// Debug UI Respawn
call
{
	[] spawn
	{
		forceRespawn player;
		uiSleep 3;

		waitUntil {playerRespawnTime > 1};
		player setDamage 1;

		uiSleep 3;
	};

	[] spawn
	{
		waitUntil {playerRespawnTime > 1};

		uiSleep 2;

		setPlayerRespawnTime 8;
//		setPlayerRespawnTime 15;
	};
};


/// HIDE FUCKING OBJECT'S ROADKILLS
if (!isServer) then
{
	DK_hideFence = ["Par_hideFence", 0] call BIS_fnc_getParamValue;
	DK_hideMound = ["Par_hideMound", 0] call BIS_fnc_getParamValue;
	DK_hideRock = ["Par_hideRock", 0] call BIS_fnc_getParamValue;

	if (DK_hideFence isEqualTo 0) then
	{
		_objs = nearestTerrainObjects [[28685.4,11867.9,195], ["fence"], 14000];
		{
			_str = format ["%1", _x];
			_class = _str select [(count _str) - 20];

			if (_class in ["wired_fence_8m_f.p3d", "wired_fence_4m_f.p3d", "ired_fence_8md_f.p3d", "ired_fence_4md_f.p3d"]) then
			{
				hideObject _x;
			};

		} count _objs;
	};

	if (0 in [DK_hideMound, DK_hideRock]) then
	{
		private _toHide = [];
		if (DK_hideMound isEqualTo 0) then
		{
			_toHide append ["mound01_8m_f.p3d", "mound02_8m_f.p3d"];
		};
		if (DK_hideRock isEqualTo 0) then
		{
			_toHide append ["pstone_03_lc.p3d", "ones_erosion.p3d", "tstone_01_lc.p3d", "luntstone_01.p3d", "luntstone_02.p3d", "luntstone_03.p3d"];
		};

		_objs = nearestTerrainObjects [[28685.4,11867.9,195], ["hide"], 14000];
		{
			_str = format ["%1", _x];
			_class = _str select [(count _str) - 16];

	//		if (_class in ["mound01_8m_f.p3d", "mound02_8m_f.p3d", "pstone_03_lc.p3d", "ones_erosion.p3d", "tstone_01_lc.p3d", "luntstone_01.p3d", "luntstone_02.p3d", "luntstone_03.p3d"]) then
			if (_class in _toHide) then
			{
				hideObject _x;
			};

		} count _objs;
	};

	DK_hideFence = nil;
	DK_hideMound = nil;
	DK_hideRock = nil;
};

// UI Hit Marker
DK_fnc_wndd_En_hit = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_En_Hit_cl.sqf";
DK_fnc_wndd_Fr_hit = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_Fr_Hit_cl.sqf";

DK_fnc_wndd_En_Dwn = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_En_Down_cl.sqf";
DK_fnc_wndd_Fr_Dwn = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_Fr_Down_cl.sqf";

DK_fnc_wndd_En_Kl = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_En_Kill_cl.sqf";
DK_fnc_wndd_Fr_Kl = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_Fr_Kill_cl.sqf";

DK_fnc_wndd_Medic_Kl = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_wounded_Medic_Kill_cl.sqf";


DK_fnc_KF_KillerFr = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Killer_Friendly_cl.sqf";
DK_fnc_KF_GroupFr = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Group_Frendly_cl.sqf";
DK_fnc_KF_EnnemyFr = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Ennemy_Friendly_cl.sqf";

DK_fnc_KF_KillerEn = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Killer_Ennemy_cl.sqf";
DK_fnc_KF_GroupEn = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Group_Ennemy_cl.sqf";
DK_fnc_KF_EnnemyEn = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Ennemy_Ennemy_cl.sqf";

DK_fnc_KF_KilledFr = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Killed_Friendly_cl.sqf";
DK_fnc_KF_KilledEn = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_Killed_Ennemy_cl.sqf";

DK_fnc_KF_KillerScd = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_killFeed_KillerAndKilled_cl.sqf";

/// ICONE Player and mate
[] execVM "Community_Scripts\QS_icons.sqf"; // THX to Quicksilver
disableMapIndicators [true,true,true,true];

// UI 3D Icones
DK_addEH_3dIcone_Mate = compile preprocessFileLineNumbers "DK_Functions\UI\DK_add_3dIcone_Mate_cl.sqf";
DK_fnc_3dIcone_Mate = compile preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_3dIcone_Mate_cl.sqf"; 
call compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fncs_forceFirstView_cl.sqf";
DK_inLoop_FFV = false;
call DK_addEH_3dIcone_Mate;

// Handle Variables INCAPACITATED
DK_fnc_ICPCTsetVar = compileFinal preprocessFileLineNumbers "DK_Functions\Incapacitated\DK_fnc_Incapa_setVar_cl.sqf";

// Info Mod on player map
private _nil = [] execVM "DK_Texts\DK_infoOnMap.sqf";

/// Added Event Handler for PLAYER
waitUntil { !isNull player };
_nil = player execVM "DK_Functions\playerCapacity\DK_init_EventHandlersAtStart_cl.sqf";

/// Set Variable for TK Manager
player setVariable ["DK_gaugeTK",0];

// Unlock Door
DK_fnc_unlockDoor = compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fnc_unlockDoors_cl.sqf";

// Check visibility
DK_fnc_checkIfVisUnit = compileFinal preprocessFileLineNumbers "DK_Functions\DK_fnc_checkIfPlayerSeesUnit_cl.sqf";

// Get Params
DK_weaponStart_init = "Par_weaponStart" call BIS_fnc_getParamValue;
if (isNil "DK_weaponStart") then
{
	DK_weaponStart = compileFinal "DK_weaponStart_init";
};

/// // Bonus Player
DK_fnc_areaNotSecureNotif_altis = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\DK_fnc_showNotifAreaNotSecure_altis_cl.sqf";
DK_fnc_areaNotSecureNotif_LJ = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\DK_fnc_showNotifAreaNotSecure_LJ_cl.sqf";
DK_fnc_showNotifNoMoney_LJ = compileFinal preprocessFileLineNumbers "DK_Functions\playerBonus\DK_fnc_showNotifNoMoney_LJ_cl.sqf";

// Force Respawn button
DK_fnc_forceRespawn_cl = compileFinal preprocessFileLineNumbers "DK_Functions\forceRespawn\DK_fnc_forceRespawn_cl.sqf";
execVM "DK_Functions\forceRespawn\DK_loop_waitRespawnButton.sqf";

///	// HUD
// Player & Family
DK_fnc_UI_moneyWallet = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_UI_moneyWallet_cl.sqf";
DK_fnc_UI_familyScore = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_UI_familyScore_cl.sqf";
DK_fnc_UI_familyTop = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_UI_familyTop_cl.sqf";
DK_fnc_UI_familyMbsNb = compileFinal preprocessFileLineNumbers "DK_Functions\UI\DK_fnc_UI_familyMembersNb_cl.sqf";


/// Allow Medic player
call compileFinal preprocessFileLineNumbers "DK_Functions\playerCapacity\DK_fncs_playerHeal.sqf";


// Handle Respawn button (escape)
DK_menu_RespawnButton = compileFinal "'DK_Respawn_Button'";


// Ambient Musics & SFX in map
execVM "DK_Functions\ambients\DK_loop_music_gasStation_cl.sqf"
execVM "DK_Functions\ambients\DK_loop_music_houses_cl.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\ambients\DK_fncs_amb_SFXmap_cl.sqf";

// Action for no owner DLC Fly
call compileFinal preprocessFileLineNumbers "DK_Functions\vehicles\DK_fncs_addAction_dlcFly_cl.sqf";


// Check if players have DLCs & Set variable for server
private _ownedDLCS = [];
private _listDLCs = getDLCs 1;

if (395180 in _listDLCs) then	// Apex
{
	_ownedDLCS pushBackUnique "Apex";
};

if (332350 in _listDLCs) then	// Marksmen
{
	_ownedDLCS pushBackUnique "Marksmen";
};

if (798390 in _listDLCs) then	// Tanks
{
	_ownedDLCS pushBackUnique "Tanks";
};

if (1021790 in _listDLCs) then	// Contact
{
	_ownedDLCS pushBackUnique "Contact";
};

if (571710 in _listDLCs) then	// IDAP
{
	_ownedDLCS pushBackUnique "IDAP";
};

if (601670 in _listDLCs) then	// Jet
{
	_ownedDLCS pushBackUnique "Jet";
};

if (304380 in _listDLCs) then	// Helicoper
{
	_ownedDLCS pushBackUnique "Heli";
};

player setVariable ["listDLCs", _ownedDLCS, true];

enableRadio false;

/*
// Simple shop from HoverGuy
[] execVM "HG\Setup\fn_clientInitialization.sqf";
*/



// Use all uniform without restriction (Thx pierremgi <3)

/*
pierremgi_fnc_otherUnif = {

	params ["_type","_return"];


  if (_type == 0) exitWith {
    MGI_button = _return select 1; false
  };
  if (_type == 1 and !isnil "MGI_button" && {MGI_button == 1}) then {
    disableSerialization;
    _control = _return select 0;
    _index = _return select 1;
    private _idc = ctrlIDC _control;
    private _text = lbText [_idc, _index];
    private _picture = lbPicture [_idc,_index];
    private _uniforms = ("getText (_x >> 'displayName') == _text && getNumber (_x >> 'ItemInfo' >> 'type') == 801" configClasses (configFile >> "CfgWeapons"));
    if (count _uniforms > 0) then {
      [_idc,_text,_picture,_index,_uniforms] spawn {
        params ["_idc","_text","_picture","_index","_uniforms","_selectedUnif","_unifContClasses",["_uniformObject",objNull],["_selectedInvent",[]],"_items","_otherItems","_g0"];
        _currentUnif = uniform player;
        _currentInvent = uniformItems player;
        _selectedUnif = ((_uniforms select {toLower (gettext (_x >> "picture")) splitString "\"joinString "\" == _picture}) apply {configName _x}) select 0;

        if !(pl_container isKindOf "CAManBase") then {
          _unifContClasses = (everyContainer pl_container select { (_x select 0) select [0,2] == "U_" or ["_U_",(_x select 0)] call bis_fnc_instring or ["uniform",(_x select 0)] call bis_fnc_instring});
          _cnt = 0;
          for "_i" from 0 to _index do {
            if (lbText [_idc,_i] == _text) then {
              _cnt = _cnt +1;
              _uniformObject = _unifContClasses select {_selectedUnif == (_x select 0)} select (_cnt -1) select 1
            };
          };
        } else {
          _uniformObject = uniformContainer pl_container
        };
        _selectedInvent = [];
        {_selectedInvent pushback _x} foreach (itemCargo _uniformObject);
        if ( !(isNil "_uniformObject") && { !(_uniformObject isEqualTo objNull) && { (magazineCargo _uniformObject isEqualType []) } } ) then {
          {_selectedInvent pushback _x} foreach (magazineCargo _uniformObject);
        };
        if !(pl_container isKindOf "CAmanbase") then {
          _items = +itemCargo pl_container;
          _unifItems = _unifContClasses apply {_x select 0};
          _vestContClasses = (everyContainer pl_container select { (_x select 0) select [0,2] == "V_"});
          _vestItems = _vestContClasses apply {_x select 0};
          _otherItems = +_items - _unifItems - _vestItems;
          pl_container setVariable ["allconts",_unifContClasses+_vestContClasses];
          for "_i" from 0 to count (_unifContClasses+_vestContClasses) -1 do {
            if (((pl_container getVariable "allconts") select _i) select 1 == _uniformObject) exitWith {
              (pl_container getVariable "allconts") deleteAt _i
            };
          };
          pl_container setVariable ["allconts", +(pl_container getVariable "allconts") apply {[_x select 0, itemCargo (_x select 1), magazineCargo (_x select 1)]}];
          _g0 = pl_container;
          clearItemCargoGlobal _g0;
        } else {
          _g0 = createVehicle ["WeaponHolderSimulated_Scripted", (player modelToWorld [0,1,1]), [], 0, "CAN_COLLIDE"]
        };
        player forceAddUniform _selectedUnif;
        {player addItemToUniform _x} forEach _selectedInvent;
        call {
          if (pl_container isKindOf "CAManBase") exitWith {
            removeUniform pl_container
          };
          {
            _x params ["_cont",["_it",[]],["_mag",[]]];
            pl_container addItemCargoGlobal [_cont,1];
            _createdCont = pl_container call MGI_lastCont;
            {_createdCont addItemCargoGlobal [_x,1];true} count _it;
            {_createdCont addMagazineCargoGlobal [_x,1];true} count _mag;
          } forEach (pl_container getVariable ["allconts",[]]);
          {_g0 addItemCargoGlobal [_x,1]} forEach _otherItems;
        };
        _g0 addItemCargoGlobal [_currentUnif,1];
        _lastCont = _g0 call MGI_lastCont;
        {_lastCont addItemCargoGlobal [_x,1]} forEach _currentInvent;
        if (_g0 isKindOf "WeaponHolderSimulated" && {(count itemCargo _g0 + count magazineCargo _g0 + count weaponCargo _g0 + count backpackCargo _g0) == 0}) then {
          deleteVehicle _g0
        };
      };
    };
  };
  MGI_button = 0; false
};
*/

MGI_lastCont = compileFinal "
  params [['_cont',objNull]];
  private '_lastCont';
   _invent = (everyContainer _cont - (everyBackpack _cont apply {[typeOf _x,_x]}));
   if !(_invent isEqualTo []) then {
    _lastCont = _invent select (count _invent -1) select 1;
   } else {
    _lastCont = _cont;
   };
   _lastCont
";

player addEventHandler ["InventoryOpened",
{
	params ["_unit", "_container"];
 
 
	pl_container = _container;
	[] spawn
	{
		waitUntil {!(isNull findDisplay 602)};

		disableSerialization;

		{(findDisplay 602 displayCtrl _x) ctrlAddEventHandler ["MouseButtonClick", "[0,_this] call pierremgi_fnc_otherUnif"]} forEach [632,640];
		{(findDisplay 602 displayCtrl _x) ctrlAddEventHandler ["LBSelChanged", "[1,_this] spawn pierremgi_fnc_otherUnif"]} forEach [632,640];
	};
}];


player addEventHandler ["HandleRating",
{
	0
}];





