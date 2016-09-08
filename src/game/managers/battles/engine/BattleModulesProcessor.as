package game.managers.battles.engine
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleModulesProcessor
	{
		private var _context:BattleContext;
		private var _modules:Vector.<BattleModule>;
		
		public function BattleModulesProcessor(context:BattleContext, modulesProvider:BattleModulesProvider)
		{
			_context = context;
			_modules = new Vector.<BattleModule>();
			
			for each (var module:BattleModule in modulesProvider.modules)
			{
				_modules.push(module);
				_context.battleEngine.addComponent(module);
			}
		}
		
		public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			for each (var item:BattleModule in _modules)
			{
				item.preTick(context, tick, deltaTick);
			}
		}
		
		public function postTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			for each (var item:BattleModule in _modules)
			{
				item.postTick(context, tick, deltaTick);
			}
		}
	
	}

}