params ["_vehicle"];

_vehicle setVariable ["GRAD_fuelLeak_fuelLevel", 1];

// must be put on every client to get the shooter
_vehicle addEventHandler ["HitPart", {
    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

    private _position = ASLToAGL _position;
    private _existingCraters = _target getVariable ["GRAD_existingCraters", []];   
    private _crater = createVehicle ["Sign_Sphere10cm_F", _position, [], 0, "CAN_COLLIDE"];

    _existingCraters pushBackUnique _crater;

    [_target, _position, _crater] execVM "leakFX.sqf";
    _target setVariable ["GRAD_existingCraters", _existingCraters];
}];

/*
_vehicle addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];

    systemChat (str _unit + " hit by " + str (position _source));
}];
*/
/*
_vehicle addEventHandler ["HitPart", {
    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

    "Sign_Sphere10cm_F" createVehicle _position;
}];
*/
/*
_vehicle addEventHandler ["Dammaged", {
    params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];

    "Sign_Sphere10cm_F" createVehicle (position _projectile);
}];
*/
/*
_vehicle addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];

    private _allCraters = (position _unit) nearObjects ["#crateronvehicle",15];
    private _existingCraters = _unit getVariable ["GRAD_existingCraters", []];
    private _newCraters = _allCraters arrayIntersect _newCraters;

    if (count _newCraters > 0)  then {
        {
            _existingCraters pushBackUnique _x;
            "Sign_Sphere10cm_F" createVehicle position _x;
        } forEach _newCraters;
    };

    _unit setVariable ["GRAD_existingCraters", _existingCraters];
}];

*/

/*
_vehicle addEventHandler ["EpeContact", {
    params ["_object1", "_object2", "_selection1", "_selection2", "_force"];

    systemChat (str _object1 + " hit by " + str _object2);
}];
*/

