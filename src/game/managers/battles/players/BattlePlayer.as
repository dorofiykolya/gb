package game.managers.battles.players
{
	import common.composite.Entity;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.modifiers.BattleModifier;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.records.BattleOwnerRecord;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattlePlayer extends Entity
	{
		private var _id:int;
		private var _manna:PlayerManna;
		private var _modifier:PlayerModifier;
		private var _race:int;
		
		public function BattlePlayer()
		{
			_manna = addComponent(PlayerManna) as PlayerManna;
			_modifier = addComponent(PlayerModifier) as PlayerModifier;
		}
		
		public function initialize(item:BattleOwnerRecord):void
		{
			_id = item.id;
			_race = item.race;
		}
		
		public function getModifier(type:ModifierType):BattleModifier
		{
			return null;
		}
		
		public function get modifier():PlayerModifier
		{
			return _modifier;
		}
		
		public function get manna():PlayerManna
		{
			return _manna;
		}
		
		public function get engine():BattleEngine
		{
			return BattleEngine(root);
		}
		
		public function get race():int
		{
			return _race;
		}
		
		public function get id():int 
		{
			return _id;
		}
	
	}

}