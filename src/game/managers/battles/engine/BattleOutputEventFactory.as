package game.managers.battles.engine
{
	import common.system.utils.Factory;
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleOutputEventFactory
	{
		private var _factory:Factory;
		
		public function BattleOutputEventFactory()
		{
			_factory = new Factory();
		}
		
		public function getInstance(type:Class):OutputEvent
		{
			return _factory.getInstance(type) as OutputEvent;
		}
		
		public function release(instance:OutputEvent):void
		{
			_factory.returnInstance(instance);
		}
	
	}

}