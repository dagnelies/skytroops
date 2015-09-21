package skytroops;

/**
 * ...
 * @author arnaud
 */

interface Entity
{
	public var x :Float;
	public var y :Float;
	public var vx :Float;
	public var vy :Float;
	public var radius :Float;
	public var damage :Float;
	public var state :State;
	
	public function hit(by :Entity) :Void;
}