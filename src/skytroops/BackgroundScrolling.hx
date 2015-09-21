package skytroops;
import createjs.easeljs.Bitmap;
import createjs.easeljs.ColorMatrix;
import createjs.easeljs.ColorMatrixFilter;
import createjs.easeljs.Container;
import createjs.easeljs.DisplayObject;

/**
 * @author arnaud
 */
class BackgroundScrolling extends Container
{
	public static var img :String = "img/bg/grass.png";
			
	public function new() 
	{
		super();
		
		for ( i in 0...2 )
		{
			var tile = new Bitmap( img );
			tile.y = -1525 * i;
			addChild(tile);
		}
		
		
	}
	
	public function update(dt :Float)
	{
		for( c in children ) {
			c.y = (c.y + Game.SPEED * dt);
			if( c.y > Game.HEIGHT )
				c.y -= 2*1525;
		}
	}
	

	
}