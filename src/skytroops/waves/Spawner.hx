package skytroops.waves;

import createjs.easeljs.Point;
import createjs.easeljs.Rectangle;
import haxe.Timer;
import js.Lib;
import skytroops.AIShip;
import skytroops.defs.Direction;
import skytroops.defs.Motion;
import skytroops.defs.ShipDef;
import skytroops.defs.SpawnDef;
import skytroops.defs.WaveDef;
import skytroops.Game;
import skytroops.Resources;
import skytroops.defs.Formation;
/**
 * ...
 * @author dagnelies
 */






class Spawner
{
	var spawns :Array<SpawnDef>;
	var t = 0.0;
	var spawns_index = 0;
	
	public function new(spawns)
	{
		this.spawns = spawns;
	}

	public function update(dt)
	{
		t += dt;
		while ( !isFinished() && t > spawns[spawns_index].t ) {
			launch(spawns[spawns_index].wave );
			spawns_index++;
		}
	}
	
	public function isFinished()
	{
		return spawns_index >= spawns.length;
	}
	
	function getRadius(image) :Float
	{
		var img = Resources.get(image);
		return (img.width + img.height) / 2;
	}
	
	public function launch(wave :WaveDef) :Void
	{
		var radius = getRadius(wave.ship.image);
		var points = getFormation(wave.formation, wave.n, radius);
		translate(points, wave.from, radius);
		
		var rot = getRotation(wave.from);
		
		var ships :Array<AIShip> = [];
		for (p in points)
		{
			var s = makeShip(wave.ship, p, rot);
			//if ( s.weapon != null )
			//	s.weapon.delay(wave.shoot_delay);
			ships.push(s);
		}
		
		
		applyMotion(ships, wave.motion);
		
		for( s in ships )
			onSpawn(s);
	}

	function applyMotion(ships :Array<AIShip>, motion :Motion)
	{
		if ( motion == null )
			return;
			
		switch( motion )
		{
			case Motion.GO_AND_BACK:
				for ( s in ships )
				{
					s.acc_x = -s.vx / 2.5;
					s.acc_y = -s.vy / 2.5;
				}
			case Motion.SPREAD:
				var mid = (ships.length - 1) / 2;
				for ( i in 0...ships.length )
					ships[i].va = (mid - i) * Math.PI / 10;
			case Motion.TURN_LEFT:
				for ( s in ships )
					s.va = -Math.PI / 4;
			case Motion.TURN_RIGHT:
				for ( s in ships )
					s.va = Math.PI / 4;
		}
	}
	
	function makeShip(def :ShipDef, pos :Point, rotation :Float) :AIShip
	{
		var angle = Math.PI * rotation / 180;
		var ship = new AIShip(def);
		ship.x = pos.x;
		ship.y = pos.y;
		ship.angle = angle;
		ship.vx = Math.cos(angle) * def.speed;
		ship.vy = Math.sin(angle) * def.speed;
		return ship;
	}
	
	function getRotation(from :Direction)
	{
		switch(from)
		{
			case TOP:
				return 90;
			case BOTTOM:
				return -90;
			case LEFT:
				return 0;
			case RIGHT:
				return 180;
			case TOP_LEFT:
				return 45;
			case TOP_RIGHT:
				return 135;	
			case BOTTOM_LEFT:
				return -45;	
			case BOTTOM_RIGHT:
				return -135;
		}
	}
	
	function getFormation(formation :Formation, n :Int, r :Float) :Array<Point>
	{
		var points = [];
		for (i in 0...n)
		{
			var p = new Point();
			points.push(p);
			
			var j = n - 1 - i;
			var m = Math.min(i, j);
			
			switch( formation )
			{
				case HORIZONTAL:
					p.x = i * r;
					p.y = 0;
						
				case VERTICAL:
					p.x = 0;
					p.y = i * r;
						
				case SLASH:
					p.x = i * r;
					p.y = j * r;
						
				case BSLASH:
					p.x = i * r;
					p.y = i * r;
						
				case DOWN:
					p.x = i * r;
					p.y = m * r;
						
				case UP:
					p.x = i * r;
					p.y = (Math.floor(n/2-0.5) - m) * r;
						
				case LEFT:
					p.x = (Math.floor(n/2-0.5) - m) * r;
					p.y = i * r;
						
				case RIGHT:
					p.x = m * r;
					p.y = i * r;
				
				case RANDOM:
					p.x = Math.random() * (Game.WIDTH - 2*r);
					p.y = Math.random() * (Game.WIDTH - 2*r);
			}
		}
		
		return points;
	}
	
	
	
	function translate(points :Array<Point>, from :Direction, radius :Float) :Void
	{
		var max = new Point();
		for ( p in points )
		{
			max.x = Math.max(max.x, p.x);
			max.y = Math.max(max.y, p.y);
		}
		
		// the min should ALWAYS be (0,0)
		
		var dx = Math.random() * (Game.WIDTH - max.x - 2*radius);
		var dy = Math.random() * (Game.HEIGHT - max.y - 2*radius);
		var rnd = Math.random();
		
		for ( p in points )
		{
			switch(from)
			{
				case TOP:
					p.x += radius + dx;
					p.y -= max.y + radius;
					
				case BOTTOM:
					p.x += radius + dx;
					p.y += Game.HEIGHT + radius;
					
				case LEFT:
					p.x -= radius + max.x;
					p.y += radius + dy;
					
				case RIGHT:
					p.x += Game.WIDTH + radius;
					p.y += radius + dy;
					
				case TOP_LEFT:
					p.x -= max.x + radius;
					p.y -= max.y + radius;
					if ( rnd < 0.5 )
						p.x += dx / 2;
					else
						p.y += dy / 2;
					
				case TOP_RIGHT:
					p.x += Game.WIDTH + radius;
					p.y -= max.y + radius;
					if ( rnd < 0.5 )
						p.x -= dx / 2;
					else
						p.y += dy / 2;
						
				case BOTTOM_LEFT:
					p.x -= max.x + radius;
					p.y += Game.HEIGHT + radius;
					if ( rnd < 0.5 )
						p.x += dx / 2;
					else
						p.y -= dy / 2;
						
				case BOTTOM_RIGHT:
					p.x += Game.WIDTH + radius;
					p.y += Game.HEIGHT + radius;
					if ( rnd < 0.5 )
						p.x -= dx / 2;
					else
						p.y -= dy / 2;
			}
		}
	}
	
	
	
	public dynamic function onSpawn(ship :AIShip)
	{
	}
}

