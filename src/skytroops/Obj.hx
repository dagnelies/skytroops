package skytroops;

import createjs.easeljs.BitmapAnimation;
import createjs.easeljs.Container;
import createjs.easeljs.SpriteSheet;

/**
 * ...
 * @author arnaud
 */

class Obj extends Container implements Entity
{
	public var radius :Float = 10;
	
	public var armor :Float = 1; // how much damage it can take before exploding
	public var damage :Float = 10; // the damage when colliding with another entity
	
	public var state :State;
	public var vx = 0.0;
	public var vy = 0.0;
	
	var boom_sprite :BitmapAnimation;
	
	public function new(?radius :Float)
	{
		super();
		
		var ss = {
			images: ["img/boom.png"],
			frames: {width:48, height:48, count: 7},
			animations: {run:[0,7, null, 2]}
		};
		
		var spriteSheet = new SpriteSheet(ss);
		boom_sprite = new BitmapAnimation(spriteSheet);
		boom_sprite.onAnimationEnd = function() {
			boom_sprite.stop();
			destroy();
		}
		addChild(boom_sprite);
		
		state = State.ACTIVE;
		
		if( radius != null && radius > 0 )
			setRadius(radius);
	}
	
	public function setRadius(radius)
	{
		this.radius = radius;
		
		var explosion_radius = radius;
		if ( explosion_radius < 10 )
			explosion_radius = 10;
		
		boom_sprite.scaleX = explosion_radius / 13;
		boom_sprite.scaleY = explosion_radius / 13;
		boom_sprite.x = -24 * boom_sprite.scaleX;
		boom_sprite.y = -24 * boom_sprite.scaleY;
		
	}
	
	public function hit(by :Entity) :Void
	{
		armor -= by.damage;
		if ( armor <= 0 )
			explode();
		else
			onHit(this);
	}
	
	public function update(dt :Float) 
	{
		x += dt * vx;
		y += dt * vy;
	}
	
	public function explode()
	{
		state = State.EXPLODING;
		boom_sprite.gotoAndPlay("run");
		onExplode(this);
	}
	
	public function destroy()
	{
		this.visible = false;
		this.state = State.DEAD;
		onDestroyed(this);
	}
	
	
	
	
	
	
	public dynamic function onHit(o :Obj)
	{
		//trace(o.toString() + " was hit");
	}
	
	public dynamic function onExplode(o :Obj)
	{
		//trace(o.toString() + " exploded");
	}
		
	public dynamic function onDestroyed(o :Obj)
	{
		//trace(o.toString() + " was destroyed");
	}
}