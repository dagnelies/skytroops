package skytroops.defs;

/**
 * ...
 * @author dagnelies
 */
typedef ShipDef = {
	image :String, // the name of the picture in "img/ships/*.png"
	shadow :String, // the shadow's picture
	speed :Float, // how fast the ship is, in pixels/sec
	armor :Float, // how much life the ship has
	xp :Int, // how much xp the ship is worth
	weapon :WeaponDef,
	?follow :Bool, // does the ship follow the player?
	?special :Bool // if yes, anything may be ignored and special behavior triggerred
}