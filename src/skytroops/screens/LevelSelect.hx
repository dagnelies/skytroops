package skytroops.screens;

import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import js.html.Image;
import js.html.ImageElement;
import skytroops.defs.LevelDef;
import skytroops.defs.Levels;
import skytroops.Game;
import skytroops.gui.Label;
import skytroops.gui.Button;


/**
 * ...
 * @author dagnelies
 */
class LevelSelect extends Container
{
	static var DOTS = [
		{
			x: 306,
			y: 2537,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 199,
			y: 2511,
			level: function() { return Levels.buildGrassLevel(0, 1.5); }
		},{
			x: 93,
			y: 2470,
			level: function() { return Levels.buildGrassLevel(0, 2); }
		},{
			x: 86,
			y: 2358,
			level: function() { return Levels.buildGrassLevel(1, 2); }
		},{
			x: 196,
			y: 2303,
			level: function() { return Levels.buildGrassLevel(1, 2.5); }
		},{
			x: 298,
			y: 2247,
			level: function() { return Levels.buildGrassLevel(1, 3); }
		},{
			x: 398,
			y: 2171,
			level: function() { return Levels.buildGrassLevel(2, 3); }
		},{
			x: 283,
			y: 2126,
			level: function() { return Levels.buildGrassLevel(2, 3.5); }
		},{
			x: 140,
			y: 2054,
			level: function() { return Levels.buildGrassLevel(2, 4); }
		},{
			x: 219,
			y: 1952,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 359,
			y: 1943,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 477,
			y: 1925,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 548,
			y: 1845,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 433,
			y: 1747,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		}/*,{
			x: 247,
			y: 1747,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 132,
			y: 1583,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 186,
			y: 1446,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		}
		*/
	];
	
	var bg :Bitmap; 
	var current_lvl = 0;
	var dots = [];
	
	public function new() 
	{
		super();
		bg = new Bitmap( Resources.get("img/bg/map.png") );
		addChild(bg);
		
		for ( d in DOTS ) {
			var icon = new Bitmap("img/gui/dot_empty.png");
			icon.x = d.x -icon.image.width/2;
			icon.y = d.y - icon.image.height/2;
			icon.onClick = function() {
				var lvl = d.level();
				onSelect( lvl );
			}
			addChild(icon);
		}
		center();
	}
	
	
	public dynamic function onSelect( level :LevelDef ) :Void
	{
		trace("Level selected");
	}
	
	
	public function win( lvl ) {
		if ( lvl == current_lvl ) {
			current_lvl++;
			center();
		}
	}
	
	private function center() {
		var dot = DOTS[current_lvl];
		var h = bg.image.height;
		var y = dot.y - Game.HEIGHT / 2;
		if ( y < 0 )
			y = 0;
		if ( y > h - Game.HEIGHT )
			y = h - Game.HEIGHT;
		this.y = -y;
	}
}
