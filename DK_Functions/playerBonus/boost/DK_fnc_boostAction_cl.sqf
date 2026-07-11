

	private _spd = speed _this;

	if ( (isEngineOn _this) && { (_spd > 0.5) && { (isTouchingGround _this) && { (_this getHitPointDamage "HitEngine" < 0.9) && { (fuel _this > 0.025) } } } } ) then
	{
		private _posVehHigh = (getPos _this) # 2;

		if ( (_posVehHigh < 0.75) && { (_posVehHigh > -0.29) } ) then
		{
			call
			{
				DK_coolDownNOS = false;

				private _nul = [_this,"NOS_start",100,1] spawn DK_fnc_say3D;
				_this spawn
				{
					_this call DK_fnc_smoke_boost_cl;
					private _nul = [_this,call DK_fnc_slcNosSnd,125,1] spawn DK_fnc_say3D;
					uiSleep (0.1 + (random 0.08));

					_this call DK_fnc_smoke_boost_cl;
					_nul = [_this,call DK_fnc_slcNosSnd,125,1] spawn DK_fnc_say3D;
					uiSleep (0.1 + (random 0.08));

					_this call DK_fnc_smoke_boost_cl;
					_nul = [_this,call DK_fnc_slcNosSnd,125,1] spawn DK_fnc_say3D;
					uiSleep (0.1 + (random 0.08));

					_this call DK_fnc_smoke_boost_cl;
					_nul = [_this,call DK_fnc_slcNosSnd,125,1] spawn DK_fnc_say3D;
					uiSleep (0.1 + (random 0.08));
				};

				if (_spd <= 40) exitWith
				{
					_this spawn
					{
						private _velMoSpace = velocityModelSpace _this;
						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 8, (_velMoSpace # 2) + 0.25];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.1;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 13, (_velMoSpace # 2) + 0.22];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.125;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 16, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.155;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 20, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.15;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 26, (_velMoSpace # 2) + 0.20];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.13;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 30, (_velMoSpace # 2) + 0.15];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.1;

						call
						{
							if ((fuel _this) <= 0.2) exitWith
							{
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								DK_coolDownNOS = true;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
							};
							uiSleep 6;
							DK_coolDownNOS = true;
						};
					};
				};
				if ( (_spd > 40) && { (_spd < 105) } ) exitWith
				{
					_this spawn
					{
						private _velMoSpace = velocityModelSpace _this;
						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 8, (_velMoSpace # 2) + 0.25];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.1;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 12, (_velMoSpace # 2) + 0.22];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.125;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 15, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.155;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 22, (_velMoSpace # 2) + 0.20];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.20;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 24, (_velMoSpace # 2) + 0.15];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.18;

						call
						{
							if ((fuel _this) <= 0.2) exitWith
							{
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								DK_coolDownNOS = true;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
							};
							uiSleep 6;
							DK_coolDownNOS = true;
						};
					};
				};

				if ( (_spd >= 105) && { (_spd < 170) } ) exitWith
				{
					_this spawn
					{
						private _velMoSpace = velocityModelSpace _this;
						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 8, (_velMoSpace # 2) + 0.25];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.1;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 12, (_velMoSpace # 2) + 0.22];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.125;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 15, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.155;


						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 15, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.2;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 20, (_velMoSpace # 2) + 0.20];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.18;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 22, (_velMoSpace # 2) + 0.15];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.15;

						call
						{
							if ((fuel _this) <= 0.2) exitWith
							{
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								DK_coolDownNOS = true;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
							};
							uiSleep 6;
							DK_coolDownNOS = true;
						};
					};
				};

				if (_spd >= 170) exitWith
				{
					_this spawn
					{
						private _velMoSpace = velocityModelSpace _this;
						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 8, (_velMoSpace # 2) + 0.25];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.1;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 12, (_velMoSpace # 2) + 0.22];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.125;

						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 15, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.155;


						_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 15, (_velMoSpace # 2) + 0.20];
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.2;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 20, (_velMoSpace # 2) + 0.20];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.18;

						if (isTouchingGround _this) then
						{
							_this setVelocityModelSpace [_velMoSpace # 0, (_velMoSpace # 1) + 22, (_velMoSpace # 2) + 0.15];
						};
						_this setFuel (fuel _this) - 0.009;
						uiSleep 0.15;

						call
						{
							if ((fuel _this) <= 0.2) exitWith
							{
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
								DK_coolDownNOS = true;
								[DK_vTxt_lowFuel,-1,0.1,0.5,0.5,0,DK_lyDyn_LowFuel] spawn BIS_fnc_dynamicText;
								uiSleep 2.2;
							};
							uiSleep 6;
							DK_coolDownNOS = true;
						};
					};
				};

				DK_coolDownNOS = true;
			};
		};
	};

