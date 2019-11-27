params ["_vehicle", "_offset", "_relDir"];

if (random 3 > 2) then {
    ["GRAD_leakage_holeSpall", [_vehicle, _offset]] call CBA_fnc_globalEvent;
} else {
    /*
    private _holes = _vehicle getVariable ["GRAD_leakage_holesExisting", []];
    _holes pushBackUnique _offset;
    _vehicle setVariable ["GRAD_leakage_holesExisting", _holes, true];
    */
    private _hole = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    _hole attachTo [_vehicle, _offset];
    _hole setVariable ["GRAD_leakage_holeOffset", _offset];

    private _existingHoles = _vehicle getVariable ["GRAD_leakage_holes", []];
    _existingHoles pushBackUnique _hole;
    _vehicle setVariable ["GRAD_leakage_holes", _existingHoles];

    ["GRAD_leakage_holeFX", [_vehicle, _hole, _relDir]] call CBA_fnc_globalEvent;
};