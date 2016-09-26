package game.managers.locations.commands 
{
	import game.managers.battles.output.UnitCreateEvent;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitCreateCommand extends LocationCommand 
	{
		
		public function LocationUnitCreateCommand() 
		{
			super(UnitCreateEvent);
		}
		
	}

}