package skytroops;
import createjs.easeljs.Container;
import createjs.easeljs.Text;
import createjs.easeljs.Ticker;
import haxe.Timer;

/**
 * ...
 * @author Dagnelies
 */

class DebugLayer extends Container
{
	var avg_fps = 0.0;
	var fps :Text;
	var msg :Text;
	
	public function new() 
	{
		super();
		fps = new Text();
		fps.x = 10;
		fps.y = 30;
		fps.color = 'white';
		fps.font = "12pt sans-serif";
		addChild(fps);

		
		msg = new Text();
		msg.x = 10;
		msg.y = 50;
		msg.color = 'white';
		msg.font = "12pt sans-serif";
		addChild(msg);
		
		
		untyped { setInterval(update, 1000); }
	}
	
	function update()
	{
		if ( avg_fps == 0 )
			avg_fps = Ticker.getMeasuredFPS();
		else
			avg_fps = (avg_fps + Ticker.getMeasuredFPS()) / 2;
		fps.text = Math.round(avg_fps) + " FPS";   
	}
	
	public function setMessage(txt)
	{
		msg.text = txt;
	}
}