if (hasInterface) then
{
	_DEBUG = format ["%1", false];

	mf_compile = compileFinal
	('
		private ["_path", "_isDebug", "_code"];
		_path = "";
		_isDebug = ' + _DEBUG + ';

		switch (toUpper typeName _this) do {
			case "STRING": {
				_path = _this;
			};
			case "ARRAY": {
				_path = format["%1\%2", _this select 0, _this select 1];
			};
			case "CODE": {
				_code = toArray str _this;
				_code set [0, (toArray " ") select 0];
				_code set [count _code - 1, (toArray " ") select 0];
			};
		};

		if (isNil "_code") then {
			if (_isDebug) then {
				compile format ["call compileFinal preprocessFileLineNumbers ""%1""", _path]
			} else {
				compileFinal preProcessFileLineNumbers _path
			};
		} else {
			if (_isDebug) then {
				compile toString _code
			} else {
				compileFinal toString _code
			};
		};
	');
};