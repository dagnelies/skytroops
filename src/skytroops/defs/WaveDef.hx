package skytroops.defs;

/**
 * ...
 * @author dagnelies
 */
typedef WaveDef =
{
	?t :Float, // When does it appear? (in seconds)
	n :Int, // How many ships?
	ship :ShipDef, // What kind of ships?
	formation :Formation, // In what formation?
	from :Direction, // Where are they coming from?
	?motion :Motion, // How do they fly?
	?shoot_delay :Float // A possible delay before they start shooting
}