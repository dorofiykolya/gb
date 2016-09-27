package game.managers.locations.commands 
{
	import game.managers.battles.output.MannaChangeEvent;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationMannaChangeCommand extends LocationCommand 
	{
		
		public function LocationMannaChangeCommand() 
		{
			super(MannaChangeEvent);
		}
		
	}

}