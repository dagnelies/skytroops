package skytroops;
import createjs.easeljs.Point;
import js.Browser;

/**
 * ...
 * @author dagnelies
 */
class InputMobile implements Input
{
	var init = null; // the initial orientation
	var now :Dynamic;
	
	public function new() 
	{
		Browser.window.addEventListener('devicemotion', onDeviceMoved);
	}
	
	
	
	function onDeviceMoved( evt )
	{
		if ( init == null ) {
			init = evt.accelerationIncludingGravity;
		}
		now = evt.accelerationIncludingGravity;
	}
	
	
	public function getShootTarget() :Point
	{
		return null;
	}
	
	public function update(ship :PlayerShip, dt :Float) :Void
	{
		if ( now == null )
			return;
			
		var dx = -(now.x - init.x);
		var dy = now.y - init.y;
		// var dz = now.z - init.z;
		
		var dist = Math.sqrt(dx * dx + dy * dy);
		
		var thrust = dist / 3;
		if (thrust < 0.1)
			return;
		if ( thrust > 1 )
			thrust = 1;
			
		var speed = ship.def.speed *  thrust;
		
		ship.x += speed * dt * dx / dist;
		ship.y += speed * dt * dy / dist;
		
		/*
		dx = pulled.x - ship.x;
		dy = pulled.y - ship.y;
		
		dist = Math.sqrt( dx * dx + dy * dy );
		pulled.x = ship.x + 30 * dx / dist;
		pulled.y = ship.y + 30 * dy / dist;
		*/
	}
}