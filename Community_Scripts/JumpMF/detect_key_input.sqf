//////////////////////////////////////////////////////////////////
// Script File for [Arma 3] - detect_key_input.sqf
// Created by: Das Attorney
// Modified by: AgentRev
// Re Modified by: Der Kroi
//////////////////////////////////////////////////////////////////

//#define HORDE_JUMPMF_SLOWING_MULTIPLIER 0.9
#define HORDE_JUMPMF_SLOWING_MULTIPLIER 1
// #define HORDE_JUMPMF_IMPUSLE 2.5
#define HORDE_JUMPMF_IMPUSLE 4.5

private ["_pressedKey", "_handled", "_move", "_moveM", "_moveP"];
_pressedKey = _this select 1;
_handled = false;

if (_pressedKey in actionKeys "GetOver") then
{
	if (horde_jumpmf_var_jumping) exitWith
	{
		_handled = true;
	};

	if (vehicle player isEqualTo player) then
	{
		_move = animationState player;
		_moveM = toLower (_move select [8,4]);
		_moveP = toLower (_move select [4,4]);

		if (_moveM in ["mrun","meva"] && _moveP in ["perc","pknl"] && isTouchingGround player) then
		{
			horde_jumpmf_var_jumping = true;

			private _prevVel = velocity player;


			horde_jumpmf_var_prevVel = _prevVel;
			horde_jumpmf_var_vel1 = nil;
			horde_jumpmf_var_vel2 = _prevVel # 2;

			private _frameEvent = addMissionEventHandler ["EachFrame",
			{
				horde_jumpmf_var_vel1 = ((velocity player) # 2) + ([0,HORDE_JUMPMF_IMPUSLE] select isNil "horde_jumpmf_var_vel1");

				// Ignore very high downward accelerations caused by step transitions, otherwise this kills the player
				if (horde_jumpmf_var_vel1 - horde_jumpmf_var_vel2 < -7) then
				{
					horde_jumpmf_var_vel1 = horde_jumpmf_var_vel2;
				};

				player setVelocity
				[
					(horde_jumpmf_var_prevVel # 0) * HORDE_JUMPMF_SLOWING_MULTIPLIER,
					(horde_jumpmf_var_prevVel # 1) * HORDE_JUMPMF_SLOWING_MULTIPLIER,
					horde_jumpmf_var_vel1 min HORDE_JUMPMF_IMPUSLE
				];

				horde_jumpmf_var_vel2 = (velocity player) # 2;
			}];

			[_move, _prevVel, _frameEvent] spawn
			{
				params ["_prevMove", "_prevVel", "_frameEvent"];

				uiSleep 0.15;
				waitUntil
				{
					(isTouchingGround player) OR (((getPosASLW player) # 2) < -0.2)
				};

				removeMissionEventHandler ["EachFrame", _frameEvent];

				if (isTouchingGround player) then
				{
					player setVelocity
					[
						_prevVel # 0,
						_prevVel # 1,
						(velocity player) # 2
					];
				}
				else
				{
					player setVelocity [0,0,0];
				};

				uiSleep 0.5; // Cooldown
				horde_jumpmf_var_jumping = false;
			};

			_handled = true;
		};
	};
};

_handled