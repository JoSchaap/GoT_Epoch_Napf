Maca134's Improved Safezones!
maca134@googlemail.com

This script creates safezones based soley on triggers, no crappy loops...
It will add signs around the perimeter, adds a marker to the map for each safezone.

Installing
----------
Copy the safezone folder into your mission pbo and open init.sqf, at the very bottom add:
_nil = [] execVM "safezone\init.sqf";

Make sure it is NOT in any if blocks, etc...

In safezone/init.sqf, the safezone locations are at the top:
_safezones = [
	[[11447.91,11364.536],100], // Klen
	[[4064.2258,11665.938],100], // Bash
	[[6325.6772,7807.7412],100] // Stary
];

The array format is [[x,y], radius]

Thats it, might need a battleye filter or two adding.