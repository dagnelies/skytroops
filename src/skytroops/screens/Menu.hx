package skytroops.screens;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import skytroops.Game;
import skytroops.gui.Label;
import skytroops.gui.Button;

/**
 * ...
 * @author arnaud
 */
class Menu extends Container
{
	public function new() 
	{
		super();
		
		var bg = new Bitmap("img/gui/menu.png");
		addChild(bg);
		
		var easy = new Button("Play !");
		easy.x = Game.WIDTH / 2;
		easy.y = 450;
		easy.onBtnClicked = function () {
			onPlay();
		};
		addChild(easy);
	}
	
	
	public dynamic function onPlay() :Void
	{
		trace("Play! clicked");
	}
}