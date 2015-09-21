package skytroops.gui;

import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import createjs.easeljs.Shape;
import createjs.easeljs.Text;

/**
 * ...
 * @author Dagnelies
 */

class Button extends Container
{
	var bg :Shape;
	var label :String;
	var w = 247;
	var h = 89;
	
	public function new(label) 
	{
		super();
		
		var bg = new Bitmap("img/btn.png");
		addChild(bg);
		
		var txt = new Text(label, (2 * h / 3) + "px Luckiest Guy", "white");
		addChild(txt);
		txt.textAlign = "center";
		txt.y = -h/2 + h / 6;
		
		bg.x = -w / 2;
		bg.y = -h / 2;
		
		this.addEventListener("mouseover", function(e) {
			txt.color = "yellow";
		});
		
		this.addEventListener("mouseout", function(e) {
			txt.color = "white";
		});
		this.addEventListener("click", function(e) {
			trace("Button '" + label + "' clicked");
			onBtnClicked();
		});
	}
	
	public dynamic function onBtnClicked()
	{
	}
	
	
	
	
}