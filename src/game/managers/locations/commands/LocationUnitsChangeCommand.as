package game.managers.locations.commands
{
	import game.managers.battles.output.UnitsChangeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitsChangeCommand extends LocationCommand
	{
		
		public function LocationUnitsChangeCommand()
		{
			super(UnitsChangeEvent);
		}
	
	}

}