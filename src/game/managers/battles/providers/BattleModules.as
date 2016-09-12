package game.managers.battles.providers
{
	import game.managers.battles.engine.BattleModulesProvider;
	import game.managers.battles.modules.BattleBuildingAttackModule;
	import game.managers.battles.modules.BattleBulletModule;
	import game.managers.battles.modules.BattleDamangeModule;
	import game.managers.battles.modules.BattleMannaModule;
	import game.managers.battles.modules.BattleUpdateObjectModule;
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
			add(new BattleUpdateObjectModule());
			add(new BattleMannaModule());
			add(new BattleUnitsRegenModule());
			add(new BattleUnitsMoveModule());
			add(new BattleDamangeModule());
			add(new BattleBuildingAttackModule());
			add(new BattleBulletModule());
		}
	
	}

}