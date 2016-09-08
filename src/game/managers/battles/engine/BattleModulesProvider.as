package game.managers.battles.engine
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleModulesProvider
	{
		private var _modules:Vector.<BattleModule>;
		
		public function BattleModulesProvider()
		{
			_modules = new Vector.<BattleModule>();
		}
		
		public function add(module:BattleModule):void
		{
			_modules.push(module);
		}
		
		public function get modules():Vector.<BattleModule>
		{
			return _modules;
		}
	
	}

}