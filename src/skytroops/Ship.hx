package skytroops;
import createjs.easeljs.Bitmap;
import createjs.easeljs.BitmapAnimation;
import createjs.easeljs.Container;
import createjs.easeljs.Point;
import createjs.easeljs.Shape;
import createjs.easeljs.SpriteSheet;
import js.Lib;
import skytroops.defs.ShipDef;
import skytroops.Bullet;

/**
 * ...
 * @author arnaud
 */
class Ship extends Obj
{
	public var angle = 0.0;
	public var def :ShipDef;
	
	var image :Bitmap;
	var weapon_cooldown = 0.0;
	
	public function new(def :ShipDef) 
	{
		super();
		this.def = def;
		
		var img = Resources.get(def.image);
		image = new Bitmap(img);
		image.x = -img.width / 2;
		image.y = -img.height / 2;
		addChild(image);
		
		var r = (img.width + img.height) / 4;
		/*
		var shape = new Shape();
		shape.graphics.beginFill("red").arc(0, 0, r, 0, 2 * Math.PI, false);
		shape.alpha = 0.5;
		addChild(shape);
		*/
		addChild(image);
		
		setRadius( r );
		
		armor = def.armor;
	}
		
	public override function update(dt :Float)
	{
		if( def.weapon != null )
			weapon_cooldown -= dt;
		//rotation = angle * 180 / Math.PI;
		super.update(dt);
	}
	
	
	public override function explode()
	{
		Sound.explode.play();
		image.visible = false;
		super.explode();
	}
	
	public function shoot(target :Point) :Array<Bullet>
	{
		if ( state != State.ACTIVE || def.weapon == null || weapon_cooldown > 0 )
			return [];
		
		weapon_cooldown = 1.0 / def.weapon.fire_rate;
		
		var dir = Math.PI / 2;
		if( def.weapon.aim && target != null )
			dir = Math.atan2(target.y - y, target.x - x);
		
		return shootFrontal(dir);
	}
	
	
	function makeBullet(dx, dy, dir)
	{
		return new Bullet(def.weapon.bullet, x + dx, y + dy, dir);
	}
	
	
	function shootFrontal(dir :Float)
	{
		var bullets = [];
		var min = -(def.weapon.shots - 1) / 2;
		
		for ( i in 0...def.weapon.shots )
			bullets.push( makeBullet((min + i)*15, 0, dir) );
			
		return bullets;
	}
	
}