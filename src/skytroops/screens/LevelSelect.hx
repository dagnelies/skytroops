package skytroops.screens;

import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import skytroops.Game;
import skytroops.gui.Label;
import skytroops.gui.Button;


/**
 * ...
 * @author dagnelies
 */
class LevelSelect extends Container
{
	public function new() 
	{
		super();
		
		var bg = new Bitmap("img/gui/splash.png");
		addChild(bg);
		
		addButton("grass", 350);
		addButton("rocky", 450);
		addButton("snow", 550);
		addButton("desert", 650);
		addButton("islands", 750);
	}
	
	function addButton( level, y ) {
		var btn = new Button(level);
		btn.x = Game.WIDTH / 2;
		btn.y = y;
		btn.onBtnClicked = function () {
			onSelect( level );
		};
		addChild(btn);
	}
	
	public dynamic function onSelect( level ) :Void
	{
		trace("Level selected: " + level);
	}
}