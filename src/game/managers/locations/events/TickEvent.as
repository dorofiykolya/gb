package game.managers.locations.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TickEvent extends Event
	{
		public static const TICK:String = "tick";
		
		public function TickEvent(type:Object, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	
	}

}