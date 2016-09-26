package game.managers.locations.commands
{
	import game.managers.battles.output.BulletRemoveEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletRemoveCommand extends LocationCommand
	{
		
		public function LocationBulletRemoveCommand()
		{
			super(BulletRemoveEvent);
		}
	
	}

}