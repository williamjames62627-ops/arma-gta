if (!hasInterface) exitWith {};



DK_fnc_amb_playSfxSoundInBuilding_cl = {

	_this spawn
	{
		params ["_durTime", "_buildingSrc", "_track", "_slpTime", "_dis"];


		private _time = time + _durTime;
		while { (time < _time) && { (damage _buildingSrc < 0.5) } } do
		{
			_buildingSrc say3D [_track, _dis, 1, true];

			uiSleep _slpTime;
		};
	};
};