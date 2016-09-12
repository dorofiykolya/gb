package game.managers.battles.actors.factories
{
	import common.system.Assert;
	import game.managers.battles.actors.bullets.BattleBullet;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.actors.BattleObjectFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletFactory
	{
		private var _factory:BattleObjectFactory;
		
		public function BulletFactory(factory:BattleObjectFactory, battleEngine:BattleEngine)
		{
			_factory = factory;
		}
		
		public function instantiate(type:Class):BattleBullet
		{
			Assert.equalsClassOrSubclassOf(type, BattleBullet);
			var result:BattleBullet = _factory.instantiate(type) as BattleBullet;
			return result;
		}
	
	}

}