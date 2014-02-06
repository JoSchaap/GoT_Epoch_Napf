_nearby = {isPlayer _x} count (nearestObjects [player, ["CAManBase"], 5]);
_count = (_nearby - 1);
if (_count > 0) exitWith {
	_txt = "You can't pack vehicles when a player is within 5m of you!";
	cutText [_txt,"PLAIN DOWN"];
	systemChat ("Anti-Hack: "+str _txt+"");
};
if (dayz_combat == 1) exitWith {
	_txt = "You can't pack vehicles while in combat.";
	cutText [_txt, "PLAIN DOWN"];
	systemChat (_txt);
};
_obj = _this select 3;
if (((damage _obj) > 0.8) || !(canMove _obj)) exitWith {
	cutText ["This "+typeOf _obj+" is too damaged to pack.","PLAIN DOWN"];
	systemChat ("This "+typeOf _obj+" is too damaged to pack.");
};
_objPos = getPosATL _obj;
player removeAction s_player_packOBJ;
r_interrupt = false;
player playActionNow "Medic";
sleep 1;

_sfx = "repair";
[player,_sfx,0,false,5] call dayz_zombieSpeak;
sleep 1;

deleteVehicle _obj;
if (typeOf _obj == "TT650_Gue") then {
	_origMat = ["PartGeneric","PartEngine","ItemJerrycan","PartFueltank"];
	{
		_bag = createVehicle ["WeaponHolder_"+_x+"",_objPos,[], 1, "CAN_COLLIDE"];
		_bag modelToWorld getPosATL player;
		_bag setdir (getDir player);
		player reveal _bag;
	} forEach _origMat;
	_tempclutter = createVehicle ["ClutterCutter_EP1",_objPos,[], 1, "CAN_COLLIDE"];
};
if (typeOf _obj == "Old_bike_TK_CIV_EP1") then {
	_origMat = ["PartGeneric"];
	{
		_bag = createVehicle ["WeaponHolder_"+_x+"",_objPos,[], 1, "CAN_COLLIDE"];
		_bag modelToWorld getPosATL player;
		_bag setdir (getDir player);
		player reveal _bag;
	} forEach _origMat;
	_tempclutter = createVehicle ["ClutterCutter_EP1",_objPos,[], 1, "CAN_COLLIDE"];
};
if (typeOf _obj == "MH6J_DZ") then {
	_origMat = ["ItemTankTrap","ItemTankTrap","PartGeneric","PartGeneric","ItemCompass","ItemFlashlight","ItemCrowbar","ItemWatch"];
	{
		_bag = createVehicle ["WeaponHolder_"+_x+"",_objPos,[], 1, "CAN_COLLIDE"];
		_bag modelToWorld getPosATL player;
		_bag setdir (getDir player);
		player reveal _bag;
	} forEach _origMat;
	_tempclutter = createVehicle ["ClutterCutter_EP1",_objPos,[], 1, "CAN_COLLIDE"];
};

cutText ["You have packed your "+typeOf _obj+".","PLAIN DOWN"];

systemChat ("You have packed the "+typeOf _obj+" for: "+str _origMat+"");
systemChat ("Look on the ground for your materials!");
sleep 5;
deleteVehicle _tempclutter;