package skytroops;
import createjs.easeljs.Point;
import createjs.easeljs.Text;
import skytroops.defs.Motion;
import skytroops.defs.ShipDef;

/**
 * Behavior
 */


class AIShip extends Ship
{
	public var va = 0.0;
	public var acc_x = 0.0;
	public var acc_y = 0.0;
	
	public var motion :Motion;
	
	
	public function new(def :ShipDef) 
	{
		super(def);
	}
	
	
	override public function shoot(target:Point)
	{
		if ( isInside() )
			return super.shoot(target);
		else
			return [];
	}
	
	
	public override function update(dt :Float)
	{
		vx += acc_x * dt;
		vy += acc_y * dt;
		if ( va != 0 )
		{
			angle += va * dt;
			vx = Math.cos(angle) * def.speed;
			vy = Math.sin(angle) * def.speed;
			vy += Game.SPEED;
		}
		
		super.update(dt);
	}
	
	
	
	function isInside()
	{
		return ( 0 < x && x < Game.WIDTH && 0 < y && y < Game.HEIGHT );
	}
}