//if (typeOf _this isEqualTo "B_Parachute") exitWith {};


[_this, (selectRandom ["doorCar_op1","doorCar_op2"]), 160, (0.85 + (random 0.3)), true] call DK_fnc_say3D;

private _spd = speed _this;

if ( (_spd > -4) && { (_spd <= 4) } ) exitWith
{
	player setPos (player modelToWorldVisual [0,0.5,0.55]);

	player setVelocity [0,0,0];
};

if ( (_spd > 4) && { (_spd <= 14) } ) exitWith
{
	player setPosATL (player modelToWorldVisual [0,0.75,0.55]);
	player setVelocity [0,0,0];
};

if ( (_spd > 14) && { (_spd <= 81) } ) exitWith
{
	player allowDamage false;

	if !( lineIntersects [player modelToWorldVisualWorld [0,-0.1,1.1], player modelToWorldVisualWorld [0,1.4,1.1], player, vehicle player] ) then
	{
		player setPosATL (player modelToWorldVisual [0,1.35,0.55]);
	};
	player setVelocity [0,0,0];

	DK_getOutAPB_actDam = false;
	[] spawn
	{
		uiSleep 0.6;
		if (isNull objectParent player) then
		{
			DK_getOutAPB_actDam = true;
		};
	};
	[] spawn
	{
		waitUntil { (isTouchingGround player) OR DK_getOutAPB_actDam };
		player allowDamage true;
	};
};

if ( (_spd > 81) && { (_spd < 136) } ) exitWith
{
	player allowDamage false;
		
	if !( lineIntersects [player modelToWorldVisualWorld [0,-0.1,1.1], player modelToWorldVisualWorld [0,1.4,1.1], player, vehicle player] ) then
	{
		player setPosATL (player modelToWorldVisual [0,1.35,0.55]);
	};

	DK_getOutAPB_actDam = false;
	[] spawn
	{
		uiSleep 0.6;
		if (isNull objectParent player) then
		{
			DK_getOutAPB_actDam = true;
		};
	};
	[] spawn
	{
		waitUntil { (isTouchingGround player) OR DK_getOutAPB_actDam };
		player allowDamage true;
	};
};

/// REVERSE
if ( (_spd <= -4) && { (_spd >= -14) } ) exitWith
{
//	player setPos (player modelToWorldVisual [0,0.75,0.55]);
	player setPosATL (player modelToWorldVisual [0,0.75,0.55]);
	player setVelocity [0,0,0];
};

if ( (_spd < -14) && { (_spd >= -81) } ) exitWith
{
	player allowDamage false;

	if !( lineIntersects [player modelToWorldVisualWorld [0,-0.1,1.1], player modelToWorldVisualWorld [0,1.4,1.1], player, vehicle player] ) then
	{
		player setPosATL (player modelToWorldVisual [0,1.35,0.55]);
	};
	player setVelocity [0,0,0];

	DK_getOutAPB_actDam = false;
	[] spawn
	{
		uiSleep 0.6;
		if (isNull objectParent player) then
		{
			DK_getOutAPB_actDam = true;
		};
	};
	[] spawn
	{
		waitUntil { (isTouchingGround player) OR DK_getOutAPB_actDam };
		player allowDamage true;
	};
};

if ( (_spd < -81) && { (_spd > -136) } ) then
{
	player allowDamage false;
		
	if not ( lineIntersects [player modelToWorldVisualWorld [0,-0.1,1.1], player modelToWorldVisualWorld [0,1.4,1.1], player, vehicle player] ) then
	{
		player setPosATL (player modelToWorldVisual [0,1.35,0.55]);
	};

	DK_getOutAPB_actDam = false;
	[] spawn
	{
		uiSleep 0.6;
		if (isNull objectParent player) then
		{
			DK_getOutAPB_actDam = true;
		};
	};
	[] spawn
	{
		waitUntil { (isTouchingGround player) OR DK_getOutAPB_actDam };
		player allowDamage true;
	};
};
