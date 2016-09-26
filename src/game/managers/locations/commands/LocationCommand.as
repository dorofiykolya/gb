package game.managers.locations.commands
{
	import common.system.Assert;
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationCommand
	{
		private var _eventType:Class;
		
		public function LocationCommand(eventType:Class)
		{
			Assert.subclassOf(eventType, OutputEvent);
			_eventType = eventType;
		}
		
		public function get eventType():Class
		{
			return _eventType;
		}
		
		public function execute(evt:OutputEvent):void
		{
		
		}
	
	}

}