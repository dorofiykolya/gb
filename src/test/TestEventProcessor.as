package test 
{
	import common.system.ClassType;
	import flash.utils.Dictionary;
	import game.managers.battles.engine.OutputEvent;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TestEventProcessor 
	{
		private var _core:TestBattleView;
		private var _map:Dictionary;
		
		public function TestEventProcessor(testBattleView:TestBattleView) 
		{
			_core = testBattleView;
			_map = new Dictionary();
		}
		
		public function map(command:TestCommand):void
		{
			_map[command.eventType] = command;
		}
		
		public function execute(view:TestBattleView, evt:OutputEvent):void
		{
			var command:TestCommand = _map[ClassType.getAsClass(evt)];
			if (command)
			{
				command.execute(view, evt);
			}
		}
		
	}

}