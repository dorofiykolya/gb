package game.managers.locations.events
{
	import common.events.Event;
	import game.managers.locations.Location;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationEvent extends Event
	{
		public static const LOADED:String = "loaded";
		
		public function LocationEvent(type:Object, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
		
		public function get location():Location
		{
			return data as Location;
		}
	
	}

}