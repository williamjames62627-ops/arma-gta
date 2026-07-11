
if !(hasInterface) exitWith {};


_rdmCol1 = random 0.05;
_rdmCol2 = random 0.1;
_rdmCol3 = random 0.125;
_rdmCol4 = random 0.15;
_rdmCol5 = random 0.175;
_rdmCol6 = random 0.2;
_rdmCol7 = random 0.25;

private _color = [[0,0,0,0.4], [_rdmCol1,_rdmCol1,_rdmCol1,0.6], [_rdmCol2,_rdmCol2,_rdmCol2,0.35], [_rdmCol3,_rdmCol3,_rdmCol3,0.25], [_rdmCol4,_rdmCol4,_rdmCol4,0.18], [_rdmCol5,_rdmCol5,_rdmCol5,0.12], [_rdmCol6,_rdmCol6,_rdmCol6,0.04], [_rdmCol7,_rdmCol7,_rdmCol7,0]];
private _rdmVec = selectRandom [0,0.1,0.2,0.3,0.4];

[getPosWorld _this, _this, [_color, _rdmVec]] remoteExecCall ["DK_fnc_crtBoostSmoke", 2];


