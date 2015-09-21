package skytroops;
import createjs.easeljs.BitmapAnimation;
import createjs.easeljs.Container;
import createjs.easeljs.SpriteSheet;

/**
 * ...
 * @author arnaud
 */
class Coin extends Container
{
	var sprite :BitmapAnimation;
	var value :Int;
	
	public function new(value) 
	{
		super();
		value = 1;
		this.value = value;
		
		var img;
		switch(value)
		{
			case 1:	img = "img/coin_silver.png";
			case 2: img = "img/coin_gold.png";
			case 3: img = "img/coin_red.png";
			case 4: img = "img/coin_green.png";
			default: return;
		}
		var ss = {
			images: [img],
			frames: {width:12, height:11, count: 6},
			animations: {run:[0,5,null,4]}
		};
		
		sprite = new BitmapAnimation(new SpriteSheet(ss));
		sprite.x = -12;
		sprite.y = -12;
		sprite.scaleX = 2;
		sprite.scaleY = 2;
		sprite.gotoAndPlay("run");
		addChild(sprite);
	}
	
	public function update(dt :Float)
	{
		this.y += dt * Game.SPEED;
	}
}