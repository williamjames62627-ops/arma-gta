
params ["_veh", "_src1", "_src2", "_params"];

_params params ["_color", "_rdmVec"];


_src1 setParticleParams
[
	["\A3\data_f\cl_basic", 1, 0, 1],
	"",
	"Billboard",
	1,
	30,
	[0.38,-3,-0.87],
	[((sin ((direction _veh) - 180)) * 1.7) - _rdmVec, (cos ((direction _veh) - 180)) * 1.7, -0.1],
	6,
	1.282,
	1.0125,
	0.4,
	[0.2, 3.65, 4.5, 5, 5.6, 6.55, 7.1],
	_color,
	[1.5,0.5],
	0,
	0,
	"",
	"",
	_veh,
	0,
	false,
	0.25,
	[[0,0,0,0]]
];

_src1 setDropInterval 0.06;



_src2 setParticleParams
[
	["\A3\data_f\cl_basic", 1, 0, 1],
	"",
	"Billboard",
	1,
	30,
	[-0.38,-3,-0.87],
	[((sin ((direction _veh) - 180)) * 1.7) + _rdmVec, (cos ((direction _veh) - 180)) * 1.7, -0.1],
	6,
	1.282,
	1.0125,
	0.4,
	[0.2, 3.65, 4.5, 5, 5.6, 6.55, 7.1],
	_color,
	[1.5,0.5],
	0,
	0,
	"",
	"",
	_veh,
	0,
	false,
	0.25,
	[[0,0,0,0]]
];

_src2 setDropInterval 0.06;

