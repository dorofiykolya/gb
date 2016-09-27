package game.managers.locations.events
{
	import common.events.Event;
	import game.managers.locations.mediators.LocationObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObjectEvent extends Event
	{
		public static const CHANGE:String = "change";
		public static const MOVE:String = "move";
		
		public function LocationObjectEvent(type:Object)
		{
			super(type);
		}
		
		public function get object():LocationObject
		{
			return data as LocationObject;
		}
	
	}

}