package skytroops;
import createjs.easeljs.Container;
import createjs.easeljs.Shape;

/**
 * ...
 * @author dagnelies
 */
class LifeBar extends Container
{
	var w :Int;
	var h :Int;
	var shape :Shape;
	
	public function new(w,h) 
	{
		super();
		this.w = w;
		this.h = h;
		shape = new Shape();
		addChild(shape);
	}
	
	
	public function setValue(value :Float, max :Float)
	{
		shape.graphics.clear();
		var bg_color = "orange"; // hsla(" + Math.round(120 * value / max) + ", 100 % , 50 % , 0.5)";
		shape.graphics.beginFill(bg_color).rect(0, 0, w, h);
		var fg_color = "red"; // hsl(" + Math.round(120 * value / max) + ", 100 % , 50 % )";
		if( value > 0 )
			shape.graphics.beginFill(fg_color).rect(4, 4, (w-8)*value / max, h-8);
	}
}