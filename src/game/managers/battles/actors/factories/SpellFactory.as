package game.managers.battles.actors.factories
{
	import common.system.Assert;
	import game.managers.battles.actors.spells.BattleSpell;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.actors.BattleObjectFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SpellFactory
	{
		private var _factory:BattleObjectFactory;
		private var _battleEngine:BattleEngine;
		
		public function SpellFactory(factory:BattleObjectFactory, battleEngine:BattleEngine)
		{
			_battleEngine = battleEngine;
			_factory = factory;
		}
		
		public function instantiate(type:Class):BattleSpell
		{
			Assert.equalsClassOrSubclassOf(type, BattleSpell);
			var result:BattleSpell = _factory.instantiate(type) as BattleSpell;
			return result;
		}
	
	}

}