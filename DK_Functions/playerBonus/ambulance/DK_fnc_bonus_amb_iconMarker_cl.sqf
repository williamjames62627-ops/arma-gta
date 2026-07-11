
	private ["_dis01","_dis02","_dis03","_dis04", "_medic01","_medic02", "_medic03", "_medic04","_pos","_medicSlc", "_cntUnitsGroup"];
	private _disAll= [];


	_medic01 = DK_BA_allMedics # 0;
	if ( (!isNil "_medic01") && { (!isNull _medic01) && { (alive _medic01) } } ) then
	{
		_dis01 = player distance _medic01;
		_disAll pushBack _dis01;
	};
	_medic02 = DK_BA_allMedics # 1;
	if ( (!isNil "_medic02") && { (!isNull _medic02) && { (alive _medic02) } } ) then
	{
		_dis02 = player distance _medic02;
		_disAll pushBack _dis02;
	};
	_cntUnitsGroup = count DK_BA_allMedics;
	if (_cntUnitsGroup > 2) then
	{
		_medic03 = DK_BA_allMedics # 2;
		if ( (!isNil "_medic03") && { (!isNull _medic03) && { (alive _medic03) } } ) then
		{
			_dis03 = player distance _medic03;
			_disAll pushBack _dis03;
		};
	};
	if (_cntUnitsGroup > 3) then
	{
		_medic04 = DK_BA_allMedics # 3;
		if ( (!isNil "_medic04") && { (!isNull _medic04) && { (alive _medic04) } } ) then
		{
			_dis04 = player distance _medic04;
			_disAll pushBack _dis04;
		};
	};

	private _nrstDisMed = selectMin _disAll;
	call
	{
		if (_nrstDisMed isEqualTo _dis01) exitWith
		{
			_medicSlc = _medic01;
		};
		if (_nrstDisMed isEqualTo _dis02) exitWith
		{
			_medicSlc = _medic02;
		};
		if (_nrstDisMed isEqualTo _dis03) exitWith
		{
			_medicSlc = _medic03;
		};
		if (_nrstDisMed isEqualTo _dis04) then
		{
			_medicSlc = _medic04;
		};
	};

	if (isNil "_medicSlc") exitWith {};

	call
	{
		if (_nrstDisMed < 15) exitWith
		{
			if (isNull objectParent _medicSlc) then
			{
				if !(stance _medicSlc isEqualTo "PRONE") then
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,2.2];
				}
				else
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,1];
				};
			}
			else
			{
				_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,2.3];
			};

			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",[0.85,0.85,0.1,1],_pos,0.58,0.58,0, "",2,0.036,"TahomaB","center",true];
		};

		if ( (_nrstDisMed >= 15) && { (_nrstDisMed <= 40) } ) exitWith
		{
			if (isNull objectParent _medicSlc) then
			{
				if !(stance _medicSlc isEqualTo "PRONE") then
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,2.7];
				}
				else
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,1.4];
				};
			}
			else
			{
				_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,2.7];
			};

			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",[0.85,0.85,0.1,1],_pos,0.48,0.48,0, str (round _nrstDisMed),2,0.032,"TahomaB","center",true];
		};

		if ( (_nrstDisMed > 40) && { (_nrstDisMed <= 75) } ) exitWith
		{
			if (isNull objectParent _medicSlc) then
			{
				if !(stance _medicSlc isEqualTo "PRONE") then
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,3.1];
				}
				else
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,1.55];
				};
			}
			else
			{
				_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,3.05];
			};

			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",[0.85,0.85,0.1,1],_pos,0.40,0.40,0, str (round _nrstDisMed),2,0.030,"TahomaB","center",true];
		};

		if ( (_nrstDisMed > 75) && { (_nrstDisMed < 140) } ) exitWith
		{
			if (isNull objectParent _medicSlc) then
			{
				if !(stance _medicSlc isEqualTo "PRONE") then
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,2.9];
				}
				else
				{
					_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,1.53];
				};
			}
			else
			{
				_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,2.8];
			};

			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",[0.85,0.85,0.1,1],_pos,0.31,0.31,0, str (round _nrstDisMed),2,0.025,"TahomaB","center",true];
		};

		if (isNull objectParent _medicSlc) then
		{
			if !(stance _medicSlc isEqualTo "PRONE") then
			{
				_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,3.3];
			}
			else
			{
				_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,1.15];
			};
		}
		else
		{
			_pos = (getPosATLVisual _medicSlc) vectorAdd [0,0,3.15];
		};

		drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa",[0.85,0.85,0.1,1],_pos,0.29,0.29,0, str (round _nrstDisMed),2,0.020,"TahomaB","center",true];
	};

	if (!isNil "DK_BA_mkr") then
	{
		DK_BA_mkr setMarkerPosLocal (getPosWorld _medicSlc);
	};
