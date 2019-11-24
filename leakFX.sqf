params ["_vehicle", "_position", "_crater"];

[_vehicle, _position, _crater] spawn {
    params ["_vehicle", "_position", "_crater"];

    private _fuelLeakStrength = 0.005;
    private _stream = "#particlesource" createVehicleLocal [0,0,0];
    _stream setParticleRandom [0,[0.004,0.004,0.004],[0.01,0.01,0.01],30,0.01,[0,0,0,0],1,0.02,360];
    _stream setDropInterval 0.1;

    // get outwards dir
    private _dir = (_vehicle getRelDir _position);
    private _offset = _vehicle worldToModelVisual _position;

    systemchat ("offset: " + (str _offset));
    private _bbr = 0 boundingBoxReal _vehicle;
    _bbr params ["_p1", "_p2"];    
    private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
    private _offsetZ = _offset select 2; // might be -1.5, we need some 
    private _normalizedOffset = _maxHeight/2 + _offsetZ;
    private _heightInModel = _normalizedOffset/_maxHeight + 0.2; // add some offset

    systemChat ("offset: " + str _normalizedOffset);
    systemChat ("heightInModel: " + str _heightInModel);

    _stream attachTo [_vehicle, _offset];
    _crater attachTo [_vehicle, _offset];

    private _fuelLevel = _vehicle getVariable ["GRAD_fuelLeak_fuelLevel", 0];

    if (_fuelLevel > _heightInModel && _fuelLevel > 0) then {
        private _leakCount = _vehicle getVariable ["GRAD_fuelLeak_leakCount", 0];
        _vehicle setVariable ["GRAD_fuelLeak_leakCount", _leakCount + 1, true];

        /*
        for "_i" from 0 to 1 step 0.01 do {
            _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]] ;
            sleep 0.02;
            _full = _i;
            if (_fuelLevel > 0) then {
                _vehicle setVariable ["GRAD_fuelLeak_fuelLevel", (_fuelLevel - 0.01)];
            };
        };
        */

        while {_vehicle getVariable ["GRAD_fuelLeak_fuelLevel", 0] > _heightInModel} do {
            private _fuelLevel = _vehicle getVariable ["GRAD_fuelLeak_fuelLevel", 0];
            private _leakCount = _vehicle getVariable ["GRAD_fuelLeak_leakCount", 0];
            _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * (1/_fuelLevel),cos (_dir) * (1/_fuelLevel),0],0,1.5,1,0.1,[0.02,0.07,0.1],[[0.7,0.7,0.8,0.1],[0.7,0.7,0.8,0.1],[0.7,0.8,0.8,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]] ;
            sleep 0.02;
            if (_fuelLevel > 0) then {
                _vehicle setVariable ["GRAD_fuelLeak_fuelLevel", (_fuelLevel - (_fuelLeakStrength))]; // leak count not in yet
            };

            systemChat  ("fuel level: " + str _fuelLevel);
        };

        private _leakCount = _vehicle getVariable ["GRAD_fuelLeak_leakCount", 0];
        _vehicle setVariable ["GRAD_fuelLeak_leakCount", _leakCount - 1, true];
    };
    deleteVehicle _stream;
    deleteVehicle _crater;
};