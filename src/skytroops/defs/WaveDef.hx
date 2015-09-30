package skytroops.defs;

/**
 * ...
 * @author dagnelies
 */
typedef WaveDef =
{
	n :Int, // How many ships?
	ship :ShipDef, // What kind of ships?
	formation :Formation, // In what formation?
	from :Direction, // Where are they coming from?
	?motion :Motion, // How do they fly? // deprecated?
	?shoot_delay :Float // A possible delay before they start shooting // deprecated?
}