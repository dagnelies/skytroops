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
class Loading extends Container
{
	var title :Label;
	var progress :Label;
	
	public function new() 
	{
		super();
		
		var bg = new Bitmap("img/gui/splash.png");
		addChild(bg);
		
		title = new Label("Loading...");
		title.x = Game.WIDTH / 2;
		title.y = 600;
		title.color = "black";
		addChild(title);
		
		progress = new Label("");
		progress.x = Game.WIDTH / 2;
		progress.y = 520;
		progress.color = "black";
		addChild(progress);
	}
	
	public function setTitle( text :String )
	{
		title.text = text;
	}
	
	public function setProgress( percents :Int )
	{
		if ( percents < 0 )
			progress.text = "";
		else
			progress.text = percents + " %";
	}
	
}