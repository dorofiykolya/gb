package game.managers.battles.engine
{
	import common.composite.Entity;
	import game.managers.battles.engine.BattleEngine;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleObject extends Entity
	{
		private var _engine:BattleEngine;
		private var _transform:BattleTransform;
		private var _objectId:int;
		
		public function BattleObject()
		{
			_transform = new BattleTransform(this);
		}
		
		public function get objectId():int
		{
			return _objectId;
		}
		
		internal function setObjectId(value:int):void
		{
			_objectId = value;
		}
		
		public function get transform():BattleTransform
		{
			return _transform;
		}
		
		public function get engine():BattleEngine
		{
			return root as BattleEngine;
		}
	
	}

}