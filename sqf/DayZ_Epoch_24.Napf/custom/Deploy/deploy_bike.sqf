_maxBikes = 2;
if (isNil "bicycles_DELOYED") then {bicycles_DELOYED = 0;};
if (bicycles_DELOYED > _maxBikes) exitWith {
	_txt = format ["You have built %1 out of a maximum of %2 bicycles.",motors_DEPLOYED,_maxMotos];
	systemChat (_txt);
	cutText [_txt,"PLAIN DOWN"];
};
if (dayz_combat == 1) exitWith {
	_txt = "You can't deploy vehicles while in combat.";
	cutText [_txt, "PLAIN DOWN"];
	systemChat (_txt);
};

	r_interrupt = false;
	player playActionNow "Medic";
	
	[player,"repair",0,false,10] call dayz_zombieSpeak;
	[player,10,true,(getPosATL player)] spawn player_alertZombies;
	sleep 6;
	
	_object = "Old_bike_TK_CIV_EP1";
	_dir = getdir (vehicle player);
	_pos = getPos (vehicle player);
	_pos = [(_pos select 0)+4*sin(_dir),(_pos select 1)+4*cos(_dir),0];
	PVDZ_OBJ_DEPLOY = [_pos,player,_object];
	publicVariableServer "PVDZ_OBJ_DEPLOY";
	
	if (isNil "bicycles_DELOYED") then {bicycles_DELOYED = 1;} else {bicycles_DELOYED = bicycles_DELOYED + 1;};
	cutText ["You used your toolbox to build a bicycle!", "PLAIN DOWN"];
	_txt = format ["You have built a bicycle! You have built %1 out of a maximum of %2 bicycles.",bicycles_DELOYED,_maxBikes];
	systemChat (_txt);
	
	r_interrupt = false;
	player switchMove "";
	player playActionNow "stop";
	sleep 10;
	cutText ["WARNING: "+name player+"! Deployed vehicles do Not Save after server restart!", "PLAIN DOWN"];
	systemChat ("WARNING: "+name player+"! Deployed vehicles do not save after server restart! Have fun!");