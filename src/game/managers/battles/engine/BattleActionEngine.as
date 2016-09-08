package game.managers.battles.engine
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleActionEngine
	{
		private var _actionQueue:BattleActionQueue;
		
		public function BattleActionEngine(actionQueue:BattleActionQueue)
		{
			_actionQueue = actionQueue;
		}
		
		public function enqueue(action:BattleAction):void
		{
			_actionQueue.enqueue(action);
		}
		
		public function get isEmpty():Boolean
		{
			return _actionQueue.isEmpty;
		}
		
		public function get count():int
		{
			return _actionQueue.count;
		}
	
	}

}