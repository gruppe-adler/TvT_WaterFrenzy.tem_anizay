GRAD_LEAKAGE_DEBUG = true;
GRAD_LEAKAGE_SPEED = 0.01;

// CLIENT EH
if (hasInterface) then {

    ["GRAD_leakage_holeSpall", {
        params ["_vehicle", "_offset"];

        diag_log format ["holeSpall"];
        [_vehicle, _offset] call GRAD_leakage_fnc_holeSpall;
    }] call CBA_fnc_addEventHandler;

    ["GRAD_leakage_holeFX", {
        params ["_vehicle", "_hole", "_relDir"];

        diag_log format ["holeFX"];
        [_vehicle, _hole, _relDir] call GRAD_leakage_fnc_holeFX;
        [_vehicle, _offset] call GRAD_leakage_fnc_holeSpall;
    }] call CBA_fnc_addEventHandler;
};

// SERVER EH
if (isServer) then {

    ["GRAD_leakage_holeRegister", {
        params ["_vehicle", "_offset", "_relDir"];

        [_vehicle, _offset, _relDir] call GRAD_leakage_fnc_holeRegister;
       
    }] call CBA_fnc_addEventHandler;
};