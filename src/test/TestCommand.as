package test
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TestCommand
	{
		private var _eventType:Class;
		
		public function TestCommand(eventType:Class)
		{
			_eventType = eventType;
		}
		
		public function execute(view:TestBattleView, evt:OutputEvent):void
		{
			
		}
		
		public function get eventType():Class
		{
			return _eventType;
		}
	
	}

}