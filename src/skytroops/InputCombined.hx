package skytroops;
import skytroops.PlayerShip;
import createjs.easeljs.Point;

/**
 * ...
 * @author dagnelies
 */
class InputCombined implements Input
{
	var mobile :Input;
	var desktop :Input;
	
	public function new(stage) 
	{
		mobile = new InputMobile();
		desktop = new InputDesktop(stage);
	}
	
	/* INTERFACE skytroops.Input */
	
	public function getShootTarget() :Point 
	{
		var trg = mobile.getShootTarget();
		if ( trg != null )
			return trg;
		else
			return desktop.getShootTarget();
	}
	
	public function update(ship:PlayerShip, dt:Float):Void 
	{
		mobile.update(ship, dt);
		desktop.update(ship, dt);
	}
	
}