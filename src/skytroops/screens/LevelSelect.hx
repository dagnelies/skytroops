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
			x: 336,
			y: 2567,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 209,
			y: 2541,
			level: function() { return Levels.buildGrassLevel(0, 1.5); }
		},{
			x: 103,
			y: 2500,
			level: function() { return Levels.buildGrassLevel(0, 2); }
		},{
			x: 101,
			y: 2388,
			level: function() { return Levels.buildGrassLevel(1, 2); }
		},{
			x: 216,
			y: 2343,
			level: function() { return Levels.buildGrassLevel(1, 2.5); }
		},{
			x: 338,
			y: 2277,
			level: function() { return Levels.buildGrassLevel(1, 3); }
		},{
			x: 428,
			y: 2191,
			level: function() { return Levels.buildGrassLevel(2, 3); }
		},{
			x: 283,
			y: 2156,
			level: function() { return Levels.buildGrassLevel(2, 3.5); }
		},{
			x: 140,
			y: 2084,
			level: function() { return Levels.buildGrassLevel(2, 4); }
		},{
			x: 239,
			y: 2002,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 369,
			y: 1988,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 497,
			y: 1975,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 578,
			y: 1895,
			level: function() { return Levels.buildGrassLevel(0, 1); }
		},{
			x: 433,
			y: 1774,
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