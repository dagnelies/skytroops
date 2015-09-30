package skytroops.screens;

import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
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
			x: 340,
			y: 176,
			level: function() { return Levels.buildDesertLevel(0, 1); }
		},
		{
			x: 259,
			y: 310,
			level: function() { return Levels.buildDesertLevel(1, 1.5); }
		},
		{
			x: 346,
			y: 410,
			level: function() { return Levels.buildDesertLevel(2, 2); }
		},
		{
			x: 492,
			y: 471,
			level: function() { return Levels.buildDesertLevel(2, 5); }
		}
	];
	
	public function new() 
	{
		super();
		var bmp = new Bitmap("img/bg/map.png");
		addChild(bmp);
		
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
	}
	
	public dynamic function onSelect( level :LevelDef ) :Void
	{
		trace("Level selected");
	}
}