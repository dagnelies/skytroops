package skytroops.screens;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import js.Browser;
import skytroops.Game;
import skytroops.gui.Label;
import skytroops.gui.Button;

/**
 * ...
 * @author dagnelies
 */
class Menu extends Container
{
	public function new() 
	{
		super();
		
		var bg = new Bitmap("img/gui/menu.png");
		addChild(bg);
		
		var play = new Button("Play !");
		play.x = Game.WIDTH / 2;
		play.y = 450;
		play.onBtnClicked = function () {
			onPlay();
		};
		addChild(play);
		
		var github = new Bitmap("img/github.png");
		github.x = Game.WIDTH - 20 - 64;
		github.y = 20;
		github.onClick = function() { Browser.window.open("https://github.com/dagnelies/skytroops", "_blank"); };
		addChild(github);
	}
	
	
	public dynamic function onPlay() :Void
	{
		trace("Play! clicked");
	}
}