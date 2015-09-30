package skytroops.levels;

import skytroops.defs.Direction;
import skytroops.defs.LevelDef;
import skytroops.defs.Ships;
import skytroops.defs.Formation;
import skytroops.defs.Motion;
import skytroops.defs.WaveDef;
import skytroops.defs.Waves;
import skytroops.Game;

/**
 * ...
 * @author dagnelies
 */
class Grass extends Level
{
	static var cooldown = 0;
	static var WAVES = [ Waves.MINES, Waves.TANK_L_I, Waves.TANK_H_I ]; //, Waves.SHOOTER_II, Waves.SHOOTER_III, Waves.SHOOTER_IV ]; // Waves.UPLANE_I, Waves.UPLANE_II, Waves.UPLANE_III, Waves.WEAKLING_I, Waves.WEAKLING_II, Waves.WEAKLING_III, Waves.WEAKLING_TL_I, Waves.WEAKLING_TL_II, Waves.WEAKLING_TR_I, Waves.WEAKLING_TR_II ];
	
	public static function buildWave(difficulty :Int) :WaveDef
	{
		cooldown += difficulty + 15;
		
		// 10 trials
		while ( true ) {
			var i = Std.random( WAVES.length );
			var w = WAVES[i];
			var xp = w.n * w.ship.xp * 3;
			if ( xp <= cooldown ) {
				cooldown -= xp;
				return w;
			}
			if ( Std.random(10) == 0 )
				return null;
		}
		//trace("diff: " + xp + " vs " + difficulty);
		//return null;
	}
	
	static var BG = "img/bg/grass.png";
	
	public static function buildLevel(diff :Float)
	{
		return buildCustomLevel(WAVES, diff, 60);
	}
	
	public static function buildCustomLevel(waves :Array<WaveDef>, diff :Float, duration :Float) :LevelDef
	{
		var t = 3.0;
		var level :LevelDef = {
			bg_img: BG,
			spawns: []
		};
		
		while( t < duration ) {
			var i = Std.random( waves.length );
			var w = waves[i];
			level.spawns.push({
				t: t,
				wave: w
			});
			var dt = w.n * w.ship.xp / diff;
			//dt /= (1 + 0.5 * Math.random());
			t += dt;
		}
		return level;
	}
}