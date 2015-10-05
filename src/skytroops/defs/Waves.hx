package skytroops.defs;

/**
 * ...
 * @author dagnelies
 */
class Waves
{

	public static var WEAKLING_I :WaveDef = {
		n: 1,
		ship: Ships.WEAKLING,
		formation: Formation.DOWN,
		from: Direction.TOP
	}
	
	public static var WEAKLING_II :WaveDef = {
		n: 3,
		ship: Ships.WEAKLING,
		formation: Formation.DOWN,
		from: Direction.TOP
	}
	
	public static var WEAKLING_III :WaveDef = {
		n: 5,
		ship: Ships.WEAKLING,
		formation: Formation.DOWN,
		from: Direction.TOP
	}
	
	public static var WEAKLING_TL_I :WaveDef = {
		n: 2,
		ship: Ships.WEAKLING,
		formation: Formation.SLASH,
		from: Direction.TOP_LEFT
	}
	
	public static var WEAKLING_TR_I :WaveDef = {
		n: 2,
		ship: Ships.WEAKLING,
		formation: Formation.BSLASH,
		from: Direction.TOP_RIGHT
	}
	
	public static var WEAKLING_TL_II :WaveDef = {
		n: 4,
		ship: Ships.WEAKLING,
		formation: Formation.SLASH,
		from: Direction.TOP_LEFT
	}
	
	public static var WEAKLING_TR_II :WaveDef = {
		n: 4,
		ship: Ships.WEAKLING,
		formation: Formation.BSLASH,
		from: Direction.TOP_RIGHT
	}
	
	public static var UPLANE_I :WaveDef = {
		n: 1,
		ship: Ships.FOLLOWER,
		formation: Formation.HORIZONTAL,
		from: Direction.BOTTOM
	}
	
	public static var UPLANE_II :WaveDef = {
		n: 3,
		ship: Ships.FOLLOWER,
		formation: Formation.RANDOM,
		from: Direction.BOTTOM
	}
	
	public static var UPLANE_III :WaveDef = {
		n: 5,
		ship: Ships.FOLLOWER,
		formation: Formation.RANDOM,
		from: Direction.BOTTOM
	}
	
	public static var SHOOTER_I :WaveDef = {
		n: 1,
		ship: Ships.GUNNER,
		formation: Formation.HORIZONTAL,
		from: Direction.TOP
	}
	
	public static var SHOOTER_II :WaveDef = {
		n: 2,
		ship: Ships.GUNNER,
		formation: Formation.HORIZONTAL,
		from: Direction.TOP,
		motion: Motion.SPREAD
	}
	
	public static var SHOOTER_III :WaveDef = {
		n: 3,
		ship: Ships.GUNNER,
		formation: Formation.DOWN,
		from: Direction.TOP,
		motion: Motion.SPREAD
	}
	
	
	public static var MINES :WaveDef = {
		n: 3,
		ship: Ships.MINE,
		formation: Formation.HORIZONTAL,
		from: Direction.TOP
	}
	
	public static var TANK_L_I :WaveDef = {
		n: 1,
		ship: Ships.TANK_LIGHT,
		formation: Formation.HORIZONTAL,
		from: Direction.TOP
	}
	
	public static var TANK_H_I :WaveDef = {
		n: 1,
		ship: Ships.TANK_HEAVY,
		formation: Formation.HORIZONTAL,
		from: Direction.TOP
	}
	
}