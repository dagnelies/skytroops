package skytroops;
import createjs.preloadjs.LoadQueue;
import createjs.preloadjs.PreloadJS;
import skytroops.defs.Bullets;
import skytroops.defs.Ships;



/**
 * ...
 * @author dagnelies
 */
class Resources
{
	static var queue :LoadQueue;
	
	public static function load()
	{
		if ( queue != null )
			return; // already loaded
			
		queue = new LoadQueue(false); // Does this have anything to do with local / webserved?
		queue.addEventListener("progress", function(e) { trace(e); onProgress(e.loaded); } );
		queue.addEventListener("complete", function(e) { onFinished(); } );
		queue.addEventListener("error", function(e) { trace(e);  onError("Failed to load " + e.item.src); } );
		
		queue.loadFile("img/bg/map.png");
		queue.loadFile("img/gui/dot_empty.png");
		queue.loadFile("img/gui/dot_locked.png");
		queue.loadFile("img/gui/dot_medal.png");
		
		queue.loadFile("img/gui/menu.png");
		
		queue.loadFile("img/bg/grass.png");
		queue.loadFile("img/bg/rocky.png");
		queue.loadFile("img/bg/islands.png");
		queue.loadFile("img/bg/snow.png");
		queue.loadFile("img/bg/desert.png");
		//queue.loadFile("img/bg/clouds.png");
		
		queue.loadFile("img/ships/heli.png");
		queue.loadFile("img/ships/heli_blades.png");
		
		queue.loadFile(Bullets.BALL.image);
		queue.loadFile(Bullets.BUBBLES.image);
		queue.loadFile(Bullets.BULLET.image);
		queue.loadFile(Bullets.DISK.image);
		queue.loadFile(Bullets.MISSILE.image);
		queue.loadFile(Bullets.SLIME.image);
		queue.loadFile(Bullets.WAVES.image);
		
		queue.loadFile(Ships.GUNNER.image);
		queue.loadFile(Ships.SNIPER.image);
		queue.loadFile(Ships.TROOPER.image);
		queue.loadFile(Ships.WEAKLING.image);
		queue.loadFile(Ships.FOLLOWER.image);
		queue.loadFile(Ships.MINE.image);
		queue.loadFile(Ships.TANK_LIGHT.image);
		queue.loadFile(Ships.TANK_HEAVY.image);
		
		queue.loadFile("img/ships/ufo_grabber.png");
		
		
		queue.loadFile("snd/coin.wav");
		queue.loadFile("snd/ball.wav");
		queue.loadFile("snd/boom.wav");
		queue.loadFile("snd/hit.wav");
		
		queue.loadFile("music/1.ogg");
	}
	
	
	public static function get(path)
	{
		var res = queue.getResult(path);
		if ( res == null )
			throw "Resource missing: " + path;
		return res;
	}
	
	public static dynamic function onError(msg :String)
	{
		trace(msg);
	}
	
	public static dynamic function onFinished()
	{
		trace("Loading finished.");
	}
	
	public static dynamic function onProgress(value :Float)
	{
		trace("Loading... " + Math.floor(value * 100) + "%");
	}
	

}