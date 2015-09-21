package skytroops;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import createjs.easeljs.Shape;
import createjs.easeljs.SpriteSheet;
import haxe.Timer;
import skytroops.Bullet;
import skytroops.defs.BulletDef;
import skytroops.Entity;
import skytroops.Obj;

/**
 * ...
 * @author Dagnelies
 */

class Bullet extends Obj
{
	var image :Bitmap;
	
	public function new(def :BulletDef, x :Float, y :Float, angle :Float) 
	{
		super();
		this.armor = 1;
		this.damage = def.damage;
		
		var img = Resources.get( def.image );
		var r = img.height / 2;
		setRadius(r);
		image = new Bitmap(img);
		image.x = -(img.width - r);
		image.y = -r;
		addChild(image);
		
		this.x = x;
		this.y = y;
		this.rotation = 180 * angle / Math.PI;
		
		vx = Math.cos(angle) * def.speed;
		vy = Math.sin(angle) * def.speed;
		scaleX = 1.5;
		scaleY = 1.5;
	}
	
	public override function hit(by :Entity)
	{
		//Sound.hit.play();
		vx = by.vx;
		vy = by.vy;
		super.hit(by);
	}
	
	public override function explode()
	{
		image.visible = false;
		super.explode();
	}
	

	public override function toString()
	{
		return "bullet (" + Math.round(x) + "," + Math.round(y) + ")";
	}
}