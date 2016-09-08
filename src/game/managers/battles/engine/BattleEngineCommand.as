package game.managers.battles.engine
{
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleEngineCommand
	{
		private var _actionType:Class;
		
		public function BattleEngineCommand(actionType:Class)
		{
			_actionType = actionType;
		}
		
		public function execute(action:BattleAction, context:BattleContext):void
		{
		
		}
		
		public function get actionType():Class
		{
			return _actionType;
		}
	}

}