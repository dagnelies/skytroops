package skytroops.levels;

import skytroops.defs.Direction;
import skytroops.defs.Ships;
import skytroops.defs.Formation;
import skytroops.defs.Motion;
import skytroops.defs.WaveDef;
import skytroops.defs.Waves;
import skytroops.Game;

/**
 * ...
 * @author arnaud
 */
class Grass extends Level
{
	static var cooldown = 0;
	static var WAVES = [ Waves.UPLANE_I, Waves.UPLANE_II, Waves.UPLANE_III, Waves.WEAKLING_I, Waves.WEAKLING_II, Waves.WEAKLING_III, Waves.WEAKLING_TL_I, Waves.WEAKLING_TL_II, Waves.WEAKLING_TR_I, Waves.WEAKLING_TR_II ];
	
	public static function buildWave(difficulty :Int) :WaveDef
	{
		cooldown += difficulty + 1;
		
		var i = Std.random( WAVES.length );
		var w = WAVES[i];
		var xp = w.n * w.ship.xp;
		trace("diff: " + xp + " vs " + difficulty);
		if ( xp*5 > cooldown )
			return null;
		
		cooldown -= xp * 5;
		return w;
	}
}