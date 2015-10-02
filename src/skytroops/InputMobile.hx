package skytroops;
import createjs.easeljs.Point;
import js.Browser;

/**
 * ...
 * @author dagnelies
 */
class InputMobile implements Input
{
	var pulled = new Point(Game.WIDTH / 2, Game.HEIGHT / 2); // the anchor pulled behind
	var target = new Point(Game.WIDTH / 2, Game.HEIGHT / 2); // the end position target
	
	var init = null; // the initial orientation
	
	public function new() 
	{
		Browser.window.addEventListener('devicemotion', onDeviceMoved);
	}
	
	
	
	function onDeviceMoved( evt )
	{
		if ( init == null ) {
			init = evt.accelerationIncludingGravity;
		}
		else {
			var now = evt.accelerationIncludingGravity;
			var dx = now.x - init.x;
			var dy = now.y - init.y;
			var dz = now.z - init.z;
			if( Math.abs(dx) > 1 )
				target.x += dx;
			if( Math.abs(dy) > 1 )
				target.y += dy;
		}
	}
	
	
	public function getMoveTarget() :Point
	{
		return target;
	}
	
	public function getShootTarget() :Point
	{
		return pulled;
	}
	
	public function update(ship :PlayerShip, dt :Float) :Void
	{
		var trg = getMoveTarget();
		var dy = trg.y - ship.y;
		var dx = trg.x - ship.x;
		var dist = Math.sqrt( dx * dx + dy * dy );
		
		if ( dist == 0 )
			return;
			
		var speed = ship.def.speed;
		
		if ( speed * dt >= dist )
		{
			ship.x = trg.x;
			ship.y = trg.y;
		}
		else
		{
			ship.x += speed * dt * dx / dist;
			ship.y += speed * dt * dy / dist;
		}
		
		dx = pulled.x - ship.x;
		dy = pulled.y - ship.y;
		
		dist = Math.sqrt( dx * dx + dy * dy );
		pulled.x = ship.x + 30 * dx / dist;
		pulled.y = ship.y + 30 * dy / dist;	
	}
}