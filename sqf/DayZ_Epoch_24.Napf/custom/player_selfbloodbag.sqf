// Script writen by Krixes
//    Infection chance and comments added by Player2
//    Version 1.1
//
 
player removeAction s_player_selfBloodbag;        //remove the action from users scroll menu
player playActionNow "Medic";                    //play bloodbag animation
 
sleep 5;                                        //wait 5 seconds for animation to finish
 
player removeMagazine "ItemBloodbag";            //remove the used bloodbag from inventory
 
r_player_blood = r_player_bloodTotal;            //set their blood to the maximum allowed
r_player_lowblood = false;                        //set lowblood setting to false
10 fadeSound 1;                                    //slowly fade their volume back to maximum
"dynamicBlur" ppEffectAdjust [0]; "dynamicBlur" ppEffectCommit 5;    //disable post processing blur effect
"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 1]];"colorCorrections" ppEffectCommit 5;    //give them their colour back
r_player_lowblood = false;                        //just double checking their blood isnt low
player setVariable["USEC_BloodQty",r_player_bloodTotal,true];    //set their blood back up to maximum again
 
cutText [format["You have used a bloodbag on yourself!"], "PLAIN DOWN"];    //display text at bottom center of screen
 
if (random 10 < 1) then {                                    //10% chance
    r_player_infected = true;                                //set players client to show infection
    player setVariable["USEC_infected",true,true];            //tell the server the player is infected
};
 
if (isServer) then {                                        //if running on server
    player setVariable["medForceUpdate",true];                //force the server to update the players medical status
};