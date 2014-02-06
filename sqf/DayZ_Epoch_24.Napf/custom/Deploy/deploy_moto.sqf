_maxMotos = 2;
if (isNil "motors_DEPLOYED") then {motors_DEPLOYED = 0;};
if (motors_DEPLOYED > _maxMotos) exitWith {
	_txt = format ["You have built %1 out of a maximum of %2 motorcycles.",motors_DEPLOYED,_maxMotos];
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
	
	_object = "TT650_Gue";
	_dir = getdir (vehicle player);
	_pos = getPos (vehicle player);
	_pos = [(_pos select 0)+4*sin(_dir),(_pos select 1)+4*cos(_dir),0];
	PVDZ_OBJ_DEPLOY = [_pos,player,_object];
	publicVariableServer "PVDZ_OBJ_DEPLOY";
	
	if (isNil "motors_DEPLOYED") then {motors_DEPLOYED = 1;} else {motors_DEPLOYED = motors_DEPLOYED + 1;};
	cutText ["You've used your toolbox to build a motorcycle!", "PLAIN DOWN"];
	_txt = format ["You have built a motorcycle! You have built %1 out of a maximum of %2 motorcycles.",motors_DEPLOYED,_maxMotos];
	systemChat (_txt);
	
	r_interrupt = false;
	player switchMove "";
	player playActionNow "stop";
	sleep 10;
	cutText ["WARNING: "+name player+"! Deployed vehicles do Not Save after server restart!", "PLAIN DOWN"];
	systemChat ("WARNING: "+name player+"! Deployed vehicles do not save after server restart! Have fun!");