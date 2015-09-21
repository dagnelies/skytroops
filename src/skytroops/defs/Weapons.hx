package skytroops.defs;
import skytroops.defs.WeaponDef.WeaponSpread;
/**
 * ...
 * @author dagnelies
 */

class Weapons
{
	public static var BASIC_GUN :WeaponDef = {
		spread: WeaponSpread.FRONTAL,
		bullet: Bullets.BALL,
		shots: 1,
		fire_rate: 0.4,
		aim: false
	}
	public static var MACHINE_GUN :WeaponDef = {
		spread: WeaponSpread.FRONTAL,
		bullet: Bullets.BALL,
		shots: 1,
		fire_rate: 1.2,
		aim: false
	}
	public static var AIMED_GUN :WeaponDef = {
		spread: WeaponSpread.FRONTAL,
		bullet: Bullets.BALL,
		shots: 1,
		fire_rate: 0.4,
		aim: true
	}
	public static var DOUBLE_GUN :WeaponDef = {
		spread: WeaponSpread.FRONTAL,
		bullet: Bullets.BALL,
		shots: 2,
		fire_rate: 0.6,
		aim: false
	}
	public static var FLOWER_GUN :WeaponDef = {
		spread: WeaponSpread.SIDES,
		bullet: Bullets.BALL,
		shots: 8,
		fire_rate: 0.3,
		aim: false
	}
	public static var MISSILE_LAUNCHER :WeaponDef = {
		spread: WeaponSpread.FRONTAL,
		bullet: Bullets.MISSILE,
		shots: 1,
		fire_rate: 0.4,
		aim: false
	}
}