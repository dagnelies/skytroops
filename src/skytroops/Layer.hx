package skytroops;
import createjs.easeljs.Container;
import haxe.Timer;

/**
 * ...
 * @author dagnelies
 */
class Layer<T :Obj>
{
	public var container :Container;
	public var width :Int;
	public var height :Int;
	
	public function new(?width = 640, ?height = 960) 
	{
		container = new Container();
		this.width = width;
		this.height = height;
	}
	
	public function clear()
	{
		container.removeAllChildren();
	}
	
	public function add(item :T)
	{
		//trace("Added: " + item);
		container.addChild(item);
	}
	
	public function iterator() :Iterator<T>
	{
		return cast container.children.iterator();
	}
	
	
	public function update(dt)
	{
		var dead = [];
		for ( o in this )
		{
			if ( o.state == State.DEAD || isOutOfBounds(o) )
				dead.push(o);
			else
				o.update(dt);
		}
		for ( o in dead )
			container.removeChild(o);
	}

	public function isOutOfBounds(obj :Obj)
	{
		if ( obj.vx < 0 && obj.x < -obj.radius )
			return true;
		if ( obj.vx > 0 && obj.x > width + obj.radius )
			return true;
		
		if ( obj.vy < 0 && obj.y < -obj.radius )
			return true;
		if ( obj.vy > 0 && obj.y > height + obj.radius )
			return true;
		
		return false;
	}
	
	public function size()
	{
		return container.children.length;
	}
	
}