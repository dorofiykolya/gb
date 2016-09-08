package game.managers.battles.players
{
	import flash.utils.Dictionary;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.records.BattleOwnerRecord;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattlePlayers
	{
		private var _battleEngine:BattleEngine;
		private var _configuration:BattleConfiguration;
		
		private var _map:Dictionary;
		
		public function BattlePlayers(configuration:BattleConfiguration, battleEngine:BattleEngine)
		{
			_configuration = configuration;
			_battleEngine = battleEngine;
			
			_map = new Dictionary();
			initialize();
		}
		
		public function getPlayer(ownerId:int):BattlePlayer
		{
			return _map[ownerId];
		}
		
		private function initialize():void
		{
			var player:BattlePlayer;
			for each (var item:BattleOwnerRecord in _configuration.owners)
			{
				_map[item.id] = player = new BattlePlayer();
				_battleEngine.addComponent(player);
				player.initialize(item);
			}
		}
	
	}

}