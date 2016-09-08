package game.managers.battles.engine
{
	import common.system.Assert;
	import common.system.ClassType;
	import game.managers.battles.engine.BattleObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleObjectFactory
	{
		private var _idIndex:int;
		private var _map:Vector.<BattleObject>;
		
		public function BattleObjectFactory(map:Vector.<BattleObject>)
		{
			_map = map;
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