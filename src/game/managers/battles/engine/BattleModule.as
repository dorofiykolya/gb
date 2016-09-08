package game.managers.battles.engine
{
	import common.composite.Component;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleModule extends Component
	{
		
		public function BattleModule()
		{
		
		}
		
		public function get engine():BattleEngine
		{
			return entity as BattleEngine;
		}
		
		public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
		
		}
		
		public function postTick(context:BattleContext, tick:int, deltaTick:int):void
		{
		
		}
	
	}

}