package game.managers.battles
{
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.engine.BattleModulesProvider;
	import game.managers.battles.providers.BattleCommands;
	import game.managers.battles.providers.BattleModules;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Battle
	{
		
		public function Battle()
		{
			var config:BattleConfiguration = new BattleConfiguration();
			var commands:BattleCommands = new BattleCommands();
			var modules:BattleModules = new BattleModules();
			var engine:BattleEngine = new BattleEngine(config, commands, modules);
		}
	
	}

}