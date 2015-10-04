package skytroops;
import createjs.easeljs.Container;
import createjs.easeljs.Stage;
import haxe.Timer;
import skytroops.defs.LevelDef;
import skytroops.defs.ShipDef;
import skytroops.levels.Grass;
import skytroops.waves.Spawner;
//import skytroops.waves.Spawner;


/**
 * ...
 * @author dagnelies
 */
class Game extends Container
{
	public static var SPEED = 50.0;
	
	var input :Input;
	var level :LevelDef;
	
	/*
	// Full HD
	public static var WIDTH = 1080;
	public static var HEIGHT = 1920;	
	*/
	/*
	public static var WIDTH = 480;
	public static var HEIGHT = 800;
	*/
	
	public static var WIDTH = 640;
	public static var HEIGHT = 960;	
	
	public static var TRACTOR = 100;
	/*
	public static var WIDTH = 480;
	public static var HEIGHT = 720;	
	*/

	/*
	// LD
	public static var WIDTH = 360;
	public static var HEIGHT = 640;	
	*/
	
	
	var bg :BackgroundScrolling;
	
	var coins :Container;
	
	var enemies :Layer<AIShip>;
	
	var player :PlayerShip;
	
	var p_bullets :Layer<Bullet>; // player bullets
	var e_bullets :Layer<Bullet>; // enemy bullets
	
	var life_bar :LifeBar;
	
	var debug_layer :DebugLayer;
	
	var timer :Timer;
	
	
	public function new(input,level) 
	{
		super();
		this.input = input;
		this.level = level;
	}
	
	
	
	public function updateShip(def :ShipDef)
	{
		player.def = def;
	}

	public function init()
	{
		bg = new BackgroundScrolling( level.bg_img );
		addChild(bg);
		
		coins = new Container();
		addChild(coins);
		
		enemies = new Layer<AIShip>();
		addChild(enemies.container);
		
		player = new PlayerShip();
		player.onDestroyed = function(o) { die(); };
		addChild(player);
		
		p_bullets = new Layer<Bullet>();
		addChild(p_bullets.container);
		e_bullets = new Layer<Bullet>();
		addChild(e_bullets.container);
		
		
		life_bar = new LifeBar(WIDTH - 40, 30);
		life_bar.x = 20;
		life_bar.y = 20;
		addChild(life_bar);
		
		debug_layer = new DebugLayer();
		addChild(debug_layer);
		
		
		spawner = new Spawner(level.spawns);
		spawner.onSpawn = onSpawn;
	
		//stage.update();
		//trace("initialized");
		
		timer = new Timer(1000);
		timer.run = oncePerSecond;
		
		Sound.music.play();
	}
	
	
	function onSpawn(ship :AIShip)
	{
		enemies.add(ship);
		ship.vy += Game.SPEED;
		ship.onDestroyed = onDestroyed;
	}
	
	var spawner :Spawner;
	
	var seconds = 0;
	var wave_index = 0;
	
	
	
	function oncePerSecond()
	{
		trace(seconds);
		seconds++;
		
		if ( spawner.isFinished() &&  enemies.size() == 0 )
			win();
	}
	
	
	
	
	function onDestroyed(o :Obj)
	{
		var ship :AIShip = cast o;
		if ( ship.def.xp <= 0 )
			return;
		
		var c = new Coin(ship.def.xp);
		c.x = o.x;
		c.y = o.y;
		//trace("Coin: " + c.x + " , " + c.y);
		coins.addChild(c);
	}
	
	function updateDebugInfo()
	{
		var msg = "";
		/*
		msg += "Ennemies: " + (asteroids.size() + enemies.size()) + "\n";
		msg += "Ammos: " + (p_bullets.size() + e_bullets.size()) + "\n";
		*/
		if(seconds % 60 < 10)
			msg += Math.floor(seconds / 60) + ":0" + (seconds % 60) + "\n";
		else
			msg += Math.floor(seconds / 60) + ":" + (seconds % 60) + "\n";
		msg += "Coins: " + player.collected_coins;
		debug_layer.setMessage(msg);
	}
	
	public function update(dt :Float)
	{
		updateDebugInfo();
		Sound.update(dt);
		
		bg.update(dt);
		spawner.update(dt);
		
		enemies.update(dt);
		var has_shot = false;
		for ( e in enemies )
		{
			var bullets = e.shoot(cast player);
			if ( bullets != null &&  bullets.length > 0 )
			{
				has_shot = true;
				for ( b in bullets )
				{
					e_bullets.add(b);
					b.vx += e.vx / 3;
					b.vy += e.vy / 3;
				}
			}
		}
		if ( has_shot )
			Sound.ball.play();
		
		
		
		input.update(player, dt);
		player.update(dt);
		
		var bullets = player.shoot(input.getShootTarget());
		if ( bullets != null && bullets.length > 0 )
		{
			Sound.laser.play();
			for ( b in bullets )
				p_bullets.add(b);
		}
		
		
			
		p_bullets.update(dt);
		e_bullets.update(dt);
		

		Collisions.check(cast p_bullets, cast enemies);
		Collisions.check(cast [player], cast e_bullets);
		Collisions.check(cast [player], cast enemies);
		
		life_bar.setValue(player.armor, player.def.armor);
		
		
		updateCoins(dt);
		
		//stage.update();
	}
	
	
	function updateCoins(dt :Float)
	{
		for ( c in coins.children )
		{
			if ( c.y > Game.HEIGHT + 10 )
			{
				coins.removeChild(c);
				continue;
			}
			var cc :Coin = cast c;
			
			var dx = player.x - cc.x;
			var dy = player.y - cc.y;
			var dist = Math.sqrt(dx * dx + dy * dy);
			var tractor = TRACTOR;
				
			if ( dist < player.radius )
			{
				Sound.coin.play();
				coins.removeChild(cc);
				player.collected_coins++;
			}
			else if (dist < tractor )
			{
				cc.x += dt * tractor * dx / dist;
				cc.y += dt * tractor * dy / dist;
			}
			else
			{
				cc.update(dt);
			}
		}
	}
	
	
	
	
	//public static var ARCADE = true;
	
	function win()
	{
		for ( e in enemies )
			e.explode();
			
		debug_layer.setMessage("You won!");
		Timer.delay(function() { timer.stop(); onWin(player.collected_coins); }, 1000);
		
	}
	
	public dynamic function onWin(coins)
	{
		
	}
	function die()
	{
		Timer.delay(function() { timer.stop(); onDie(player.collected_coins); }, 2000);
	}
	
	public dynamic function onDie(coins)
	{
		
	}
}