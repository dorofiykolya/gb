package game.managers.battles.providers
{
	import game.managers.battles.engine.BattleModulesProvider;
	import game.managers.battles.modules.BattleBuildingAttackModule;
	import game.managers.battles.modules.BattleMannaModule;
	import game.managers.battles.modules.BattleObjectModule;
	import game.managers.battles.modules.BattleUnitsMoveModule;
	import game.managers.battles.modules.BattleUnitsRegenModule;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleModules extends BattleModulesProvider
	{
		
		public function BattleModules()
		{
			add(new BattleObjectModule());
			add(new BattleMannaModule());
			add(new BattleUnitsRegenModule());
			add(new BattleUnitsMoveModule());
			add(new BattleBuildingAttackModule());
		}
	
	}

}