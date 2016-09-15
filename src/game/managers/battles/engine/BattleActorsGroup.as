package game.managers.battles.engine
{
	import common.composite.Component;
	import common.composite.Entity;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.engine.ActorsGroup;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleActorsGroup extends Entity
	{
		private var _temp:Vector.<Component> = new Vector.<Component>();
		
		private var _group:ActorsGroup;
		private var _battleEngine:BattleEngine;
		
		public function BattleActorsGroup(group:ActorsGroup, battleEngine:BattleEngine)
		{
			_battleEngine = battleEngine;
			_group = group;
		}
		
		public function getActors(type:Class = null, result:Vector.<BattleObject> = null):Vector.<BattleObject>
		{
			if (result == null) result = new Vector.<BattleObject>();
			_temp.length = 0;
			for each (var item:BattleObject in getComponents(type, false, _temp))
			{
				if (type == null || item is type)
				{
					result.push(item);
				}
			}
			return result;
		}
		
		public function getActorsInRange(x:Number, y:Number, range:Number, type:Class = null, result:Vector.<BattleObject> = null):Vector.<BattleObject>
		{
			if (result == null) result = new Vector.<BattleObject>();
			_temp.length = 0;
			for each (var item:BattleObject in getComponents(type, false, _temp))
			{
				if (type == null || item is type)
				{
					if (item.transform.positionDistanceTo(x, y) <= range)
					{
						result.push(item);
					}
				}
			}
			return result;
		}
		
		public function get group():ActorsGroup
		{
			return _group;
		}
	
	}

}