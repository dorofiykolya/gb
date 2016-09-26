package game.managers.locations.commands
{
	import game.managers.battles.output.BulletCreateEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletCreateCommand extends LocationCommand
	{
		
		public function LocationBulletCreateCommand()
		{
			super(BulletCreateEvent);
		}
	
	}

}