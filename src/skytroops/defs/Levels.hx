package skytroops.defs;

/**
 * ...
 * @author dagnelies
 */
class Levels
{
	static var BG_GRASS = "img/bg/grass.png";
	static var BG_ROCKY = "img/bg/rocky.png";
	static var BG_SNOW = "img/bg/snow.png";
	static var BG_DESERT = "img/bg/desert.png";
	static var BG_ISLANDS = "img/bg/islands.png";
	
	static var WAVES_GRASS = [ 
		[ Waves.WEAKLING_I, Waves.WEAKLING_TL_I, Waves.WEAKLING_TR_I, Waves.UPLANE_I ],
		[ Waves.WEAKLING_II, Waves.WEAKLING_TL_II, Waves.WEAKLING_TR_II, Waves.UPLANE_II ],
		[ Waves.SHOOTER_I, Waves.WEAKLING_TL_I, Waves.WEAKLING_TR_I, Waves.UPLANE_I ],
		[ Waves.TANK_L_I,  Waves.WEAKLING_TL_II, Waves.WEAKLING_TR_II, Waves.UPLANE_I ],
		[ Waves.TANK_H_I, Waves.WEAKLING_TL_II, Waves.WEAKLING_TR_II, Waves.MINES, Waves.UPLANE_I ],
		[ Waves.SHOOTER_III, Waves.MINES ]
	];
	static var WAVES_ROCKY = [];
	static var WAVES_SNOW = [];
	static var WAVES_DESERT = [];
	static var WAVES_ISLANDS = [];

	
	public static function buildGrassLevel(n: Int, diff :Float)
	{
		return buildSurvivalLevel(BG_GRASS);
		
		// return buildCustomLevel(BG_GRASS, WAVES_GRASS[n], diff, 60);
	}
	
	static function buildCustomLevel(bg_img :String, waves :Array<WaveDef>, diff :Float, duration :Float) :LevelDef
	{
		var t = 1.0; // nothing happens the first second
		var level :LevelDef = {
			bg_img: bg_img,
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
	
	
	static function buildSurvivalLevel(bg_img :String) :LevelDef
	{
		var t = 1.0; // nothing happens the first second
		var level :LevelDef = {
			bg_img: bg_img,
			spawns: []
		};
		
		var waves = WAVES_GRASS[0];
		
		while( t < 60*15 ) { // 15 minutes
			var i = Std.random( waves.length );
			var w = waves[i];
			level.spawns.push({
				t: t,
				wave: w
			});
			var diff = 0.5 + t / 60;
			var dt = w.n * w.ship.xp / diff;
			
			if ( Math.random() < 0.1 ) {
				// switch waves
				waves = WAVES_GRASS[ Std.random( WAVES_GRASS.length ) ];
			}
			t += dt;
		}
		return level;
	}
}