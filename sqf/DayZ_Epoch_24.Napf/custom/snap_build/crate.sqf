_crate = "USVehicleBox" createVehicle (position player);
_crate setVariable ["Mission",1,true];
systemChat "je hebt 5 seconden om een plek voor de supplies te kiezen. na de restart zijn ze weer weg!";

// clear the crate first
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
// add tools
_crate addWeaponCargoGlobal ["ItemToolbox", 10];
_crate addWeaponCargoGlobal ["ItemSledge", 10];
_crate addWeaponCargoGlobal ["ChainSaw", 5];
_crate addWeaponCargoGlobal ["ItemEtool", 10];
// add suppies  
_crate addMagazineCargoGlobal ["ItemPainkiller", 10];
_crate addMagazineCargoGlobal ["ItemAntibiotic", 10];
_crate addMagazineCargoGlobal ["ItemMorphine", 10];
_crate addMagazineCargoGlobal ["FoodSteakCooked", 10];
_crate addMagazineCargoGlobal ["ItemSodaPepsi", 10];
_crate addMagazineCargoGlobal ["ItemJerryMixed2", 10];
// add building supplies metal_panel_kit ItemSandbagLarge  sandbag_nest_kit
_crate addMagazineCargoGlobal ["cinder_wall_kit", 40];
_crate addMagazineCargoGlobal ["CinderBlocks", 80];
_crate addMagazineCargoGlobal ["MortarBucket", 40];
_crate addMagazineCargoGlobal ["ItemWoodStairs", 20];
_crate addMagazineCargoGlobal ["ItemWoodFloorHalf", 20];
_crate addMagazineCargoGlobal ["metal_floor_kit", 30];
_crate addMagazineCargoGlobal ["ItemPole", 10];
_crate addMagazineCargoGlobal ["ItemTankTrap", 20];
_crate addMagazineCargoGlobal ["metal_panel_kit", 30];
_crate addMagazineCargoGlobal ["ItemSandbagLarge", 50];
_crate addMagazineCargoGlobal ["sandbag_nest_kit", 10];
// some storage buildings and workhouses
_crate addMagazineCargoGlobal ["storage_shed_kit", 2];
_crate addMagazineCargoGlobal ["wood_shack_kit", 2];
// some fancy skins
_crate addMagazineCargoGlobal ["Skin_Rocket_DZ", 5];
// and some backpacks for the builders
_crate addBackpackCargoGlobal ["DZ_LargeGunBag_EP1",1];

_crate attachto [player, [0,3,1.7]];
sleep 5;
detach _crate;
player reveal _crate;