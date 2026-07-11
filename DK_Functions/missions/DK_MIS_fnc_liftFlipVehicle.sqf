
_this allowdamage false;

private _newPos = getPosASL _this;
_newPos set [2, (_newPos # 2) + 1.5];

_this setPosASL _newPos;
_this setVectorUp [0,0,1];


_this spawn
{
	uiSleep 1;

	_this allowdamage true;
};
