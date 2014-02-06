_maxBirds = 1;
if (isNil "birds_DEPLOYED") then {birds_DEPLOYED = 0;};
if (birds_DEPLOYED > _maxBirds) exitWith {
	_txt = format ["You have built %1 out of a maximum of %2 little birds.",motors_DEPLOYED,_maxMotos];
	systemChat (_txt);
	cutText [_txt,"PLAIN DOWN"];
};
if (dayz_combat == 1) exitWith {
	_txt = "You can't deploy vehicles while in combat.";
	cutText [_txt, "PLAIN DOWN"];
	systemChat (_txt);
};

	r_interrupt = false;
	
	[player,"repair",0,false,10] call dayz_zombieSpeak;
	[player,10,true,(getPosATL player)] spawn player_alertZombies;
	sleep 6;
	
	_object = "MH6J_DZ";
	_dir = getdir (vehicle player);
	_pos = getPos (vehicle player);
	_pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
	PVDZ_OBJ_DEPLOY = [_pos,player,_object];
	publicVariable "PVDZ_OBJ_DEPLOY";
	
	if (isNil "birds_DEPLOYED") then {birds_DEPLOYED = 1;} else {birds_DEPLOYED = birds_DEPLOYED + 1;};
	cutText ["You've used your toolbox to build a little bird!", "PLAIN DOWN"];
	_txt = format ["Anti-Hack: You have built a little bird! You have built %1 out of a maximum of %2 little birds.",birds_DEPLOYED,_maxBirds];
	systemChat (_txt);
	
	r_interrupt = false;
	player switchMove "";
	player playActionNow "stop";
	sleep 10;
	
	cutText ["WARNING: "+name player+"! Deployed vehicles do Not Save after server restart!", "PLAIN DOWN"];
	systemChat ("WARNING: "+name player+"! Deployed vehicles do not save after server restart! Have fun!");