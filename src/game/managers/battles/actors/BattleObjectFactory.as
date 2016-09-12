package game.managers.battles.actors
{
	import common.system.Assert;
	import common.system.ClassType;
	import game.managers.battles.actors.factories.BuildingFactory;
	import game.managers.battles.actors.factories.BulletFactory;
	import game.managers.battles.actors.factories.DamageFactory;
	import game.managers.battles.actors.factories.SpellFactory;
	import game.managers.battles.actors.factories.UnitFactory;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.engine.BattleEngine;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleObjectFactory
	{
		private var _idIndex:int;
		private var _map:Vector.<BattleObject>;
		private var _buildingFactory:BuildingFactory;
		private var _unitFactory:UnitFactory;
		private var _bulletFactory:BulletFactory;
		private var _spellFactory:SpellFactory;
		private var _damageFactory:DamageFactory;
		
		public function BattleObjectFactory(map:Vector.<BattleObject>, battleEngine:BattleEngine)
		{
			_map = map;
			_buildingFactory = new BuildingFactory(this, battleEngine);
			_unitFactory = new UnitFactory(this, battleEngine);
			_bulletFactory = new BulletFactory(this, battleEngine);
			_spellFactory = new SpellFactory(this, battleEngine);
			_damageFactory = new DamageFactory(this, battleEngine);
		}
		
		public function get buildingFactory():BuildingFactory
		{
			return _buildingFactory;
		}
		
		public function get unitFactory():UnitFactory
		{
			return _unitFactory;
		}
		
		public function get bulletFactory():BulletFactory
		{
			return _bulletFactory;
		}
		
		public function get spellFactory():SpellFactory
		{
			return _spellFactory;
		}
		
		public function get damageFactory():DamageFactory
		{
			return _damageFactory;
		}
		
		public function instantiate(type:Class):BattleObject
		{
			Assert.equalsClassOrSubclassOf(type, BattleObject);
			
			var result:BattleObject = ClassType.newInstance(type) as BattleObject;
			result.setObjectId(++_idIndex);
			_map[_idIndex] = result;
			
			return result;
		}
	
	}

}