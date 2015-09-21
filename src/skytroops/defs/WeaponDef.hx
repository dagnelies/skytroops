package skytroops.defs;

/**
 * ...
 * @author dagnelies
 */
typedef WeaponDef = {
	spread :WeaponSpread,
	bullet :BulletDef,
	shots :Int,
	fire_rate :Float,
	aim :Bool,
	?special :Bool
}

enum WeaponSpread {
	FRONTAL;
	SMALL_SPREAD;
	LARGE_SPREAD;
	XXL_SPREAD;
	SIDES;
	CLOCKWISE;
	COUNTER_CLOCKWISE;
}