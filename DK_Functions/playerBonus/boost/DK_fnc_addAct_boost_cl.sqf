if (!hasInterface) exitWith {};


DK_coolDownNOS = true;

_this addAction ["<t color='#ff9933' >NOS</t>  (R)",
{
	(_this # 0) call DK_fnc_boost;

} ,nil,0,false,true,"reloadMagazine","DK_coolDownNOS && player == driver _target" ];

