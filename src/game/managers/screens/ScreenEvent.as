package game.managers.screens
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ScreenEvent extends Event
	{
		public static const CHANGE:String = "screenEvent.change";
		
		public function ScreenEvent(type:Object, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
		
		public function get screenId():String
		{
			return String(data);
		}
	
	}

}