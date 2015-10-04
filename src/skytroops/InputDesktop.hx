package skytroops;
import createjs.easeljs.Point;
import createjs.easeljs.Stage;
import js.Browser;



class InputDesktop implements Input
{
	var up = false;
	var left = false;
	var down = false;
	var right = false;
	
	var move_dir :Point;
	var shoot_target = new Point();
	
	public function new(stage :Stage) 
	{
		stage.onMouseMove = onMouseMove;
		
		// global key events
		Browser.document.onkeydown = onKeyDown;
		Browser.document.onkeyup = onKeyUp;
	}
	
	function onKeyDown(e :Dynamic)
	{
		if( move_dir == null )
			move_dir = new Point();
		
		switch( e.keyCode )
		{
			case 37, 65: left = true;
			case 38, 87: up = true;
			case 39, 68: right = true;
			case 40, 83: down = true;
		}
		updateDir();
	}
	
	
	function onKeyUp(e :Dynamic)
	{
		if( move_dir == null )
			move_dir = new Point();
		
		switch( e.keyCode )
		{
			case 37, 65: left = false;
			case 38, 87: up = false;
			case 39, 68: right = false;
			case 40, 83: down = false;
		}
		updateDir();
	}
	
	function updateDir()
	{
		move_dir.x = 0;
		move_dir.y = 0;
		
		if ( left )
			move_dir.x -= 1;
		if ( up )
			move_dir.y -= 1;
		if ( right )
			move_dir.x += 1;
		if ( down )
			move_dir.y += 1;
		
		if ( move_dir.x != 0 && move_dir.y != 0 )
		{
			var dist = Math.sqrt(move_dir.x * move_dir.x + move_dir.y * move_dir.y);
			move_dir.x /= dist;
			move_dir.y /= dist;
		}
	}
	
	function onMouseMove( e )
	{
		shoot_target.x = e.rawX;
		shoot_target.y = e.rawY;
	}
	
	
	public function getShootTarget() :Point
	{
		return shoot_target;
	}
	
	
	public function update(ship :PlayerShip, dt :Float) :Void
	{	
		if ( move_dir == null )
			return;
			
		ship.vx = move_dir.x * ship.def.speed;
		ship.vy = move_dir.y * ship.def.speed;
	}
}