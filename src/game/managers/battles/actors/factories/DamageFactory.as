package game.managers.battles.actors.factories
{
	import common.system.Assert;
	import game.managers.battles.actors.BattleObjectFactory;
	import game.managers.battles.actors.damages.BattleDamage;
	import game.managers.battles.engine.BattleEngine;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DamageFactory
	{
		private var _factory:BattleObjectFactory;
		private var _battleEngine:BattleEngine;
		
		public function DamageFactory(factory:BattleObjectFactory, battleEngine:BattleEngine)
		{
			_battleEngine = battleEngine;
			_factory = factory;
		}
		
		public function instantiate(type:Class):BattleDamage
		{
			Assert.equalsClassOrSubclassOf(type, BattleDamage);
			var result:BattleDamage = _factory.instantiate(type) as BattleDamage;
			return result;
		}
	
	}

}