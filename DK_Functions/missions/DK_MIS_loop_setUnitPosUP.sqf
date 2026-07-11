if !(isServer) exitWith {};


private "_nil";

DK_unitsStayUp = [];

while { true } do
{
	waitUntil
	{
		uiSleep 1;

		!(DK_unitsStayUp isEqualTo []);
	};

	{
		call
		{
			if !(alive _x) exitWith
			{
				_nil = DK_unitsStayUp deleteAt (DK_unitsStayUp find _x);
			};

			if (stance _x isEqualTo "PRONE") then
			{
				_x setUnitPos (_x getVariable ["DK_stance", "UP"]);

				uiSleep (0.02 + (random 1));
			};
		};

	} count DK_unitsStayUp;
};