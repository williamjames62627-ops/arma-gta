
params ["_opak","_icon","_pos"];


if !(isNil "DK_LJ_Guy") then
{
	private _dis = player distance DK_LJ_Guy;

	call
	{
		if !(cameraView isEqualTo "GUNNER") exitWith
		{
			_opak = 0.89;
		};

		_opak = 0.4;
	};

	call
	{
		if ( DK_LJ_Guy call DK_fnc_checkIfVisUnit ) exitWith
		{
			_icon = DK_vImg3d_arwMateDown;
		};

		_icon = DK_vImg3d_arwMateUp;
	};

	call
	{
		if (_dis < 15) exitWith
		{
			call
			{
				if (isNull objectParent DK_LJ_Guy) exitWith
				{
					call
					{
						if (stance DK_LJ_Guy isEqualTo "PRONE") exitWith
						{
							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1];
						};

							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,2.2];
						};
					};

				_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1.5];
			};

			drawIcon3D [_icon,[0.572,0.909,0,_opak],_pos,0.5,0.5,0, "L.J.",2,0.036,"TahomaB","center",true];
		};

		if ( (_dis >= 15) && { (_dis <= 40) } ) exitWith
		{
			call
			{
				if (isNull objectParent DK_LJ_Guy) exitWith
				{
					call
					{
						if (stance DK_LJ_Guy isEqualTo "PRONE") exitWith
						{
							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1.4];
						};

							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,2.7];
						};
					};

				_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1.9];
			};

			drawIcon3D [_icon,[0.572,0.909,0,_opak],_pos,0.4,0.4,0, "L.J.",2,0.032,"TahomaB","center",true];
		};

		if ( (_dis > 40) && { (_dis <= 75) } ) exitWith
		{
			call
			{
				if (isNull objectParent DK_LJ_Guy) exitWith
				{
					call
					{
						if (stance DK_LJ_Guy isEqualTo "PRONE") exitWith
						{
							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1.55];
						};

							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,3.1];
						};
					};

				_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,2.25];
			};

			drawIcon3D [_icon,[0.572,0.909,0,_opak],_pos,0.32,0.32,0, "L.J.",2,0.030,"TahomaB","center",true];
		};

		if ( (_dis > 75) && { (_dis < 140) } ) exitWith
		{
			call
			{
				if (isNull objectParent DK_LJ_Guy) exitWith
				{
					call
					{
						if (stance DK_LJ_Guy isEqualTo "PRONE") exitWith
						{
							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1.53];
						};

							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,2.9];
						};
					};

				_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,2];
			};

			drawIcon3D [_icon,[0.572,0.909,0,_opak],_pos,0.23,0.23,0, "L.J.",2,0.025,"TahomaB","center",true];
		};

//		if ((_dis >= 140) && { (_dis < 950) } ) exitWith
		if (_dis >= 140) exitWith
		{
			call
			{
				if (isNull objectParent DK_LJ_Guy) exitWith
				{
					call
					{
						if (stance DK_LJ_Guy isEqualTo "PRONE") exitWith
						{
							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,1.15];
						};

							_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,3.3];
						};
					};

				_pos = (getPosATLVisual DK_LJ_Guy) vectorAdd [0,0,2.35];
			};

			drawIcon3D [_icon,[0.572,0.909,0,_opak],_pos,0.21,0.21,0, "L.J.",2,0.020,"TahomaB","center",true];
		};
	};
};

if (alive DK_LJ_Car) then
{
	DK_LJ_mkr setMarkerPosLocal (getPosWorld DK_LJ_Car);
};

