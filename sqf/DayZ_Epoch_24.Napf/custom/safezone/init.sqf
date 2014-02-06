private ["_safezoneZonePerm", "_safezones"];

_safezones = [
	[[8246.3184,15485.867],50, "Lenz"], // Lenzburg
	[[15506.952,13229.368],100, "Emmen"], // Emmen
	[[12399.751,5074.5273],75, "Schratten"], // Schratten
	[[10398.626,8279.4619],50, "Bandit"], // Bandit camp
	[[5149.9814,4864.1191],50, "Hero"], // Hero vendor
	[[2122.7954,7807.9878],50, "Wholesaler"], // Wholesaler 1
	[[5379.0342,16103.187],50, "Wholesaler"], // Wholesaler 2
	[[6772.8877,16983.27],50, "Boatdealer"], // Boat dealer 1
	[[16839.973,5264.0566],50, "Boatdealer"], // Boat dealer 2
	[[15128.379,16421.879],75, "AircraftDealer"] //AWOL airport
];

_safezoneZonePerm = {
	private ["_trigger", "_trigger_pos", "_trigger_area", "_angle", "_radius", "_distance", "_count", "_step"];
	_trigger = _this;
	_trigger_pos = getPos _trigger;
	_trigger_area = triggerArea _trigger;
	_angle = _trigger_area select 2;
	_radius = _trigger_area select 0; // needs to be a circle with equal a and b
	_distance = 30; // meters
	_count = round((2 * 3.14592653589793 * _radius) / _distance);
	_step = 360/_count;

	for "_x" from 0 to _count do
	{
		private["_pos", "_sign"];
		_a = (_trigger_pos select 0) + (sin(_angle)*_radius);
		_b = (_trigger_pos select 1) + (cos(_angle)*_radius);

		_pos = [_a,_b,0];
		_angle = _angle + _step;
		diag_log format["Spawn sign at: %1", _pos];
//		_sign = createVehicle ["SignM_FARP_Winchester_EP1", _pos, [], 0, "CAN_COLLIDE"];
		_sign = createVehicle ["Sign_1L_Border", _pos, [], 0, "CAN_COLLIDE"];
//		_sign setVehicleInit "this setObjectTexture [0, ""custom\safezone\sign.paa""];";
		_sign setDir ([_pos, _trigger_pos] call BIS_fnc_DirTo);
	};
};

SafeZoneEnable = {
	inSafeZone = true;
	hintSilent "You have entered a safezone, you have godmode and your weapon has been deactivated!";
	fnc_usec_damageHandler = {};
	player_zombieCheck = {};
	player allowDamage false;
	player removeAllEventhandlers "handleDamage";
	player addEventhandler ["handleDamage", {false}];
	SafezoneFiredEvent = player addEventHandler ["Fired", {
		titleText ["You can not fire your weapon in a safe zone.","PLAIN DOWN"]; titleFadeOut 4;
		NearestObject [_this select 0,_this select 4] setPos[0,0,0];
	}];

	SafezoneSkinChange = [] spawn {
		_skin = typeOf player;
		waitUntil {typeOf player != _skin};
		terminate SafezoneVehicleSpeedLimit;
		SafezoneVehicle removeEventHandler ["Fired", SafezoneVehicleFiredEvent];
		SafezoneVehicleFiredEvent = nil;
		call SafeZoneEnable;
	};

	SafezoneVehicleSpeedLimit = [] spawn {
		_maxspeed = 25;
		while {true} do {
			waitUntil {vehicle player != player and !((vehicle player) isKindOf 'Air')};
			_vehicle = vehicle player;
			_curspeed = speed _vehicle;
			if (_curspeed > _maxspeed) then {
				_vel = velocity _vehicle;
				_dir = direction _vehicle;
				_speed = _curspeed - _maxspeed;
				_vehicle setVelocity [(_vel select 0)-((sin _dir)*_speed),(_vel select 1)- ((cos _dir)*_speed),(_vel select 2)];
			};
			sleep 0.1;
		};
	};
};

SafeZoneDisable = {
	inSafeZone = false;
	hintSilent "You have left a safezone, you no longer have god mode and your weapon has been enabled!";
	fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
	player_zombieCheck = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_zombieCheck.sqf";
	terminate SafezoneVehicleSpeedLimit;
	terminate SafezoneSkinChange;
	player allowDamage true;
	player removeAllEventHandlers 'HandleDamage';
	player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
	player removeEventHandler ["Fired", SafezoneFiredEvent];
};

{
	private ["_pos", "_radius", "_name", "_trigger", "_marker"];

	_pos = _x select 0;
	_radius = _x select 1;
	_name = _x select 2;

	_trigger = createTrigger ["EmptyDetector", _pos];
	_trigger setTriggerArea [_radius, _radius, 0, false];
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerType "SWITCH";

	if (isServer) then {
		_trigger spawn _safezoneZonePerm;
	} else {
		_trigger setTriggerStatements ["(vehicle player) in thisList", "call SafeZoneEnable", "call SafeZoneDisable"];

		_marker = createMarkerLocal [format["Safezone%1", _name], _pos];
		_marker setMarkerTextLocal format["Safezone%1", _name];
		_marker setMarkerShapeLocal "ELLIPSE";
		_marker setMarkerTypeLocal "Empty";
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerBrushLocal "Grid";
		_marker setMarkerSizeLocal [_radius, _radius];
	};
} forEach _safezones;