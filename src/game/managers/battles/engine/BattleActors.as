package game.managers.battles.engine
{
	import common.composite.Component;
	import common.system.Enum;
	import flash.utils.Dictionary;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.actors.BattleObjectFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleActors
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		private var _tempActors:Vector.<BattleActorsGroup> = new Vector.<BattleActorsGroup>();
		private var _tempComponents:Vector.<Component> = new Vector.<Component>();
		
		private var _battleEngine:BattleEngine;
		private var _groupMap:Dictionary;
		private var _factory:BattleObjectFactory;
		private var _list:Vector.<BattleActorsGroup>;
		private var _map:Vector.<BattleObject>;
		private var _damages:BattleDamages;
		
		public function BattleActors(battleEngine:BattleEngine)
		{
			_battleEngine = battleEngine;
			_groupMap = new Dictionary();
			_map = new <BattleObject>[null];
			_factory = new BattleObjectFactory(_map, _battleEngine);
			_list = new Vector.<BattleActorsGroup>();
			_damages = new BattleDamages(_battleEngine.context);
			
			for each (var enum:ActorsGroup in Enum.getEnums(ActorsGroup))
			{
				group(enum);
			}
		}
		
		public function get damages():BattleDamages
		{
			return _damages;
		}
		
		public function get factory():BattleObjectFactory
		{
			return _factory;
		}
		
		public function getGroups(result:Vector.<BattleActorsGroup> = null):Vector.<BattleActorsGroup>
		{
			if (result == null) result = new Vector.<BattleActorsGroup>();
			for each (var item:BattleActorsGroup in _battleEngine.getComponents(BattleActorsGroup, false, _tempComponents))
			{
				result.push(item);
			}
			return result;
		}
		
		public function getActors(result:Vector.<BattleObject> = null):Vector.<BattleObject>
		{
			for each (var item:BattleActorsGroup in _list)
			{
				item.getActors(null, result);
			}
			return result;
		}
		
		public function getActorByObjectId(objectId:int):BattleObject
		{
			return _map[objectId];
		}
		
		public function group(enum:ActorsGroup):BattleActorsGroup
		{
			var result:BattleActorsGroup = _groupMap[enum];
			if (result == null)
			{
				_groupMap[enum] = result = new BattleActorsGroup(enum, _battleEngine);
				_list.push(result);
				_battleEngine.addComponent(result);
			}
			return result;
		}
	
	}

}