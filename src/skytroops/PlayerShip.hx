package skytroops;
import createjs.easeljs.Bitmap;
import createjs.easeljs.BitmapAnimation;
import createjs.easeljs.Container;
import createjs.easeljs.Point;
import createjs.easeljs.Shape;
import createjs.easeljs.SpriteSheet;
import skytroops.defs.Bullets;
import skytroops.defs.ShipDef;
import skytroops.defs.WeaponDef;

/**
 * ...
 * @author arnaud
 */
class PlayerShip extends Ship
{
	public static var DEFAULT :ShipDef = {
		image: "img/ships/heli.png",
		shadow: null,
		speed: 500,
		armor: 10,
		xp: 0,
		weapon: {
			spread: WeaponSpread.FRONTAL,
			bullet: Bullets.BULLET,
			shots: 1,
			fire_rate: 2,
			aim: true
		}
	};
	
	public var collected_coins = 0;
	var blades :Container;
	var target :Shape;
	
	public function new() 
	{
		super(DEFAULT);
		x = Game.WIDTH / 2;
		y = 2 * Game.HEIGHT / 3;
		
		var blades_img = Resources.get("img/ships/heli_blades.png");
		var blades_bmp = new Bitmap(blades_img);
		blades_bmp.x = -blades_img.width / 2;
		blades_bmp.y = -blades_img.height / 2;
		blades = new Container();
		blades.addChild(blades_bmp);
		blades.y = -blades_img.height / 3;
		addChild(blades);
		
		target = new Shape();
		target.graphics.beginFill("red").arc(0, 0, 6, 0, 2 * Math.PI, false);
		//target.alpha = 0.7;
		addChild(target);
		
		scaleX = 1.2;
		scaleY = 1.2;
	}
	
	public override function shoot(t :Point) :Array<Bullet>
	{
		target.x = 2*(t.x - this.x);
		target.y = 2*(t.y - this.y);
		return super.shoot(t);
	}
	
	public override function update(dt :Float)
	{
		if ( state != State.ACTIVE )
			return;
			
		super.update(dt);
		blades.rotation += dt * 480;
		
		if ( x < 2*radius )
			x = 2*radius;
		if ( x > Game.WIDTH - 2*radius)
			x = Game.WIDTH - 2*radius;
			
		if ( y < 2*radius )
			y = 2*radius;
		if ( y > Game.HEIGHT - 2*radius)
			y = Game.HEIGHT - 2*radius;
	}
	
	
	public override function toString()
	{
		return "player (" + Math.round(x) + "," + Math.round(y) + ")";
	}
	
}