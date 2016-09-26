package game.managers.locations.commands
{
	import game.managers.battles.output.BulletMoveEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletMoveCommand extends LocationCommand
	{
		
		public function LocationBulletMoveCommand()
		{
			super(BulletMoveEvent);
		}
	
	}

}