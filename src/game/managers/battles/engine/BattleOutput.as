package game.managers.battles.engine
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleOutput
	{
		private var _queue:Vector.<OutputEvent>;
		private var _factory:BattleOutputEventFactory;
		
		public function BattleOutput()
		{
			_queue = new Vector.<OutputEvent>();
			_factory = new BattleOutputEventFactory();
		}
		
		public function enqueue(value:OutputEvent):void
		{
			_queue.push(value);
		}
		
		public function dequeue():OutputEvent
		{
			return _queue.shift();
		}
		
		public function get count():int
		{
			return _queue.length;
		}
		
		public function get isEmpty():Boolean
		{
			return _queue.length == 0;
		}
		
		public function enqueueByFactory(type:Class):OutputEvent
		{
			var result:OutputEvent = _factory.getInstance(type);
			_queue.push(result);
			return result;
		}
		
		public function get factory():BattleOutputEventFactory
		{
			return _factory;
		}
	
	}

}