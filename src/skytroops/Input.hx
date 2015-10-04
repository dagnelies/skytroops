package skytroops;
import createjs.easeljs.Point;
import js.Lib;
import createjs.easeljs.Stage;


interface Input 
{
	public function getShootTarget() :Point;
	public function update(ship :PlayerShip, dt :Float) :Void;
}