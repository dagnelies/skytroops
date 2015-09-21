package skytroops.defs;
/**
 * ...
 * @author dagnelies
 */

class Ships
{
	public static var WEAKLING :ShipDef = {
		image: "img/ships/weakling.png",
		shadow: null,
		speed: 100,
		armor: 1,
		xp: 1,
		weapon: null
	}
	
	public static var TROOPER :ShipDef = {
		image: "img/ships/trooper.png",
		shadow: null,
		speed: 200,
		armor: 3,
		xp: 3,
		weapon: null
	}
	
	public static var GUNNER :ShipDef = {
		image: "img/ships/gunner.png",
		shadow: null,
		speed: 100,
		armor: 2,
		xp: 4,
		weapon: Weapons.MACHINE_GUN
	}
	
	public static var SNIPER :ShipDef = {
		image: "img/ships/sniper.png",
		shadow: null,
		speed: 100,
		armor: 2,
		xp: 6,
		weapon: Weapons.AIMED_GUN
	}
	
	
	public static var FOLLOWER :ShipDef = {
		image: "img/ships/uplane.png",
		shadow: null,
		speed: 100,
		armor: 1,
		xp: 1,
		weapon: null
	}
	
}