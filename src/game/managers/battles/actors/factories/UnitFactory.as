package game.managers.battles.actors.factories
{
	import common.system.Assert;
	import common.system.ClassType;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.actors.BattleObjectFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitFactory
	{
		private var _factory:BattleObjectFactory;
		
		public function UnitFactory(factory:BattleObjectFactory, battleEngine:BattleEngine)
		{
			_factory = factory;
		}
		
		public function instantiate(type:Class):BattleUnit
		{
			Assert.equalsClassOrSubclassOf(type, BattleUnit);
			var result:BattleUnit = _factory.instantiate(type) as BattleUnit;
			return result;
		}
	
	}

}