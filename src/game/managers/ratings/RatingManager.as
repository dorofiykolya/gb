package game.managers.ratings 
{
	import common.events.Event;
	import common.events.EventDispatcher;
	
	[Event(name = "change", type = "common.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RatingManager extends EventDispatcher
	{
		private var _current:int;
		
		public function RatingManager() 
		{
			
		}
		
		public function update(value:int):void
		{
			if (value != _current)
			{
				_current = value;
				dispatchEventWith(Event.CHANGE);
			}
		}
		
		public function get current():int 
		{
			return _current;
		}
		
	}

}