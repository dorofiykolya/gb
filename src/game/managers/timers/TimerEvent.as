package game.managers.timers
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TimerEvent extends Event
	{
		public static const TICK:String = "tick";
		
		public var delta:Number;
		public var time:Number;
		
		public function TimerEvent(type:Object)
		{
			super(type, false);
		}
		
		override protected function initializeEvent(args:Array):Event
		{
			delta = args[0];
			time = args[1];
			return this;
		}
	
	}

}