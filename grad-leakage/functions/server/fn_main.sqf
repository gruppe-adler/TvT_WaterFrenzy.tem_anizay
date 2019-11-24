if (!isServer) exitWith {};


["GRAD_leakage_holeAdd", {
    params ["_vehicle", "_offset"];

    [_vehicle, _offset] call GRAD_leakage_fnc_holeRegister;
   
}] call CBA_fnc_addEventHandler;