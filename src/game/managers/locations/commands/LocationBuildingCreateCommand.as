package game.managers.locations.commands 
{
	import game.managers.battles.output.BuildingCreateEvent;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuildingCreateCommand extends LocationCommand 
	{
		
		public function LocationBuildingCreateCommand() 
		{
			super(BuildingCreateEvent);			
		}
		
	}

}