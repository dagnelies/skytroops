package skytroops;

/**
 * ...
 * @author dagnelies
 */
class Collisions
{

	public function new() 
	{
		
	}
	
	public static function check(ia :Iterable<Entity>, ib :Iterable<Entity>)
	{
		for ( a in ia )
		{
			if ( a.state != State.ACTIVE )
				continue;
				
			for ( b in ib )
			{
				if ( b.state != State.ACTIVE )
					continue;
				
				if ( a != b && dist(a, b) < a.radius + b.radius )
				{
					a.hit(b);
					b.hit(a);
					
					if ( a.state != State.ACTIVE )
						break;
				}
			}
		}
	}
	
	
	
	public static function dist(a :Dynamic, b :Dynamic)
	{
		var dx :Float = b.x - a.x;
		var dy :Float = b.y - a.y;
		return Math.sqrt(dx * dx + dy * dy);
	}
	
}