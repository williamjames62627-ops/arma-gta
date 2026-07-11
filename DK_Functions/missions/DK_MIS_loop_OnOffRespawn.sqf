private ["_target", "_nil", "_markerName", "_mkrPos"];

#define maxRespawnDis 1500


DK_MIS_respawnOffList = [];
DK_MIS_posNmkr_respawn = [];
DK_MIS_maxRespawnOff = round ((count DK_MTW_mkrs_respawn) / 2);


// Prepar array with position linked to marker respawn
DK_MTW_mkrs_respawn apply
{
	DK_MIS_posNmkr_respawn pushBackUnique [getMarkerPos _x, _x, markerDir _x];
};


while { true } do
{
	waitUntil { uiSleep 2; !(DK_MIS_allTargets isEqualTo []) OR !(DK_MIS_respawnOffList isEqualTo []) && { (([true] call DK_fnc_cntMaxPlyrsByFam) # 1) } };

	// Disable Spawn if Target near
	if !(DK_MIS_allTargets isEqualTo []) then
	{
		{
			_target = _x;

			call
			{
				if ( (!alive _target) OR (isNil "_target") OR (isNull _target) ) exitWith
				{
					_nil = DK_MIS_allTargets deleteAt (DK_MIS_allTargets find _target);
				};

				if (count DK_MIS_respawnOffList < DK_MIS_maxRespawnOff) then
				{
					{
						_mkrPos = _x # 0;

						if (_target distance (_x # 0) < maxRespawnDis) then
						{
							deleteMarker (_x # 1);

							_nil = DK_MIS_posNmkr_respawn deleteAt (DK_MIS_posNmkr_respawn find _x);

							_nil = DK_MIS_respawnOffList pushBackUnique _x;
						};

						uiSleep 0.1;

					} forEach DK_MIS_posNmkr_respawn;
				};

			};

			uiSleep 0.1;

		} count DK_MIS_allTargets;


		// Enable Spawn if Target far
		if !(DK_MIS_respawnOffList isEqualTo []) then
		{
			{
				_mkrPos = _x # 0;

				if (count DK_MIS_respawnOffList < DK_MIS_maxRespawnOff) then
				{
					if (DK_MIS_allTargets findIf { _x distance2D _mkrPos < maxRespawnDis } isEqualTo -1) then
					{
						_markerName = createMarker [(_x # 1), _mkrPos];
						_markerName setMarkerType "Empty";
						_markerName setMarkerDir (_x # 2);

						_nil = DK_MIS_respawnOffList deleteAt (DK_MIS_respawnOffList find _x);

						_nil = DK_MIS_posNmkr_respawn pushBackUnique _x;
					};
				};

				uiSleep 0.1;

			} count DK_MIS_respawnOffList;
		};

	}
	else
	{
		// Enable Spawn if all Targets are dead/delete
		if !(DK_MIS_respawnOffList isEqualTo []) then
		{
			{
				_markerName = createMarker [(_x # 1), (_x # 0)];
				_markerName setMarkerType "Empty";
				_markerName setMarkerDir (_x # 2);

				_nil = DK_MIS_respawnOffList deleteAt (DK_MIS_respawnOffList find _x);

				_nil = DK_MIS_posNmkr_respawn pushBackUnique _x;

				uiSleep 0.1;

			} count DK_MIS_respawnOffList;
		};
	};
};


