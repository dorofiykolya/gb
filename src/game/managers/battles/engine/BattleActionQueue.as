package game.managers.battles.engine
{
	import common.system.collection.PriorityQueueComparable;
	import game.managers.battles.engine.BattleAction;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleActionQueue
	{
		private var _configuration:BattleConfiguration;
		private var _queue:PriorityQueueComparable;
		
		public function BattleActionQueue(configuration:BattleConfiguration)
		{
			_configuration = configuration;
			_queue = new PriorityQueueComparable();
		}
		
		public function enqueue(action:BattleAction):void
		{
			_queue.enqueue(action);
		}
		
		public function peek():BattleAction
		{
			return BattleAction(_queue.peek());
		}
		
		public function dequeue():BattleAction
		{
			return BattleAction(_queue.dequeue());
		}
		
		public function get count():int
		{
			return _queue.count;
		}
		
		public function get isEmpty():Boolean
		{
			return _queue.count == 0;
		}
	
	}

}