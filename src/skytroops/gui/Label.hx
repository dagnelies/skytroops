package skytroops.gui;
import createjs.easeljs.Container;
import createjs.easeljs.Text;

/**
 * ...
 * @author arnaud
 */
class Label extends Text
{

	public function new(label, ?fontsize = 24) 
	{
		super(label, fontsize + "px Luckiest Guy", "white");
		textAlign = "center";
	}
	
}