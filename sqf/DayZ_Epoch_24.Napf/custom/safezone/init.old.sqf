private ["_safezoneZonePerm", "_safezones"];

_safezones = [
	[[11447.91,11364.536],100, "Klen"], // Klen
	[[4064.2258,11665.938],100, "Bash"], // Bash
	[[6325.6772,7807.7412],100, "Stary"] // Stary
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
		_sign = createVehicle ["SignM_FARP_Winchester_EP1", _pos, [], 0, "CAN_COLLIDE"];
		_sign setVehicleInit "this setObjectTexture [0, ""safezone\sign.paa""];";
		_sign setDir ([_pos, _trigger_pos] call BIS_fnc_DirTo);
	};
};

SafeZoneEnable = {
	hintSilent "You have entered a safezone, you have godmode and your weapon has been deactivated!";
	fnc_usec_damageHandler = {};
	player allowDamage false;
	player removeAllEventhandlers "handleDamage";
	player addEventhandler ["handleDamage", {false}];
	SafezoneFiredEvent = player addEventHandler ["Fired", {
		NearestObject [_this select 0,_this select 4] setPos[0,0,0];
	}];
};

SafeZoneDisable = {
	hintSilent "You have left a safezone, you no longer have god mode and your weapon has been enabled!";
	fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
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