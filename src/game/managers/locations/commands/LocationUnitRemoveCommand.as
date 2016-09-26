package game.managers.locations.commands
{
	import game.managers.battles.output.UnitRemoveEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitRemoveCommand extends LocationCommand
	{
		
		public function LocationUnitRemoveCommand()
		{
			super(UnitRemoveEvent);
		}
	
	}

}