package game.managers.battles.actors.factories
{
	import common.system.Assert;
	import common.system.ClassType;
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.actors.BattleObjectFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingFactory
	{
		private var _factory:BattleObjectFactory;
		
		public function BuildingFactory(factory:BattleObjectFactory, battleEngine:BattleEngine)
		{
			_factory = factory;
		}
		
		public function instantiate(type:Class):BattleBuilding
		{
			Assert.equalsClassOrSubclassOf(type, BattleBuilding);
			var result:BattleBuilding = _factory.instantiate(type) as BattleBuilding;
			return result;
		}
	
	}

}