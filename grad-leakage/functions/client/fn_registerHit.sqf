params ["_vehicle", ["_liquidLevel", 0]];

if (hasInterface) then {
	_vehicle addEventHandler ["HitPart", {
	    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

	    private _position = ASLToAGL _position; // HitPart position is ASL
		private _modelOffset = _vehicle worldToModelVisual _position; // calculate locally for precision

		// dont make every hit count
		if (random 3 > 2) then {
	    	["GRAD_leakage_holeAdd", [_vehicle, _modelOffset]] call CBA_fnc_serverEvent;
	    };
	}];
};


if (isServer) then {
	// doublecheck fuel is maxed out at 1
	_vehicle setVariable ["GRAD_leakage_liquidLevel", _liquidLevel min 1, true];
};