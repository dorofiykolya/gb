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
		private var _players:Vector.<BattlePlayer>;
		private var _npcPlayer:BattleNPCPlayer;
		
		public function BattlePlayers(configuration:BattleConfiguration, battleEngine:BattleEngine)
		{
			_configuration = configuration;
			_battleEngine = battleEngine;
			
			_map = new Dictionary();
			_players = new Vector.<BattlePlayer>();
			_npcPlayer = new BattleNPCPlayer(configuration.npcPlayer);
			initialize();
		}
		
		public function isNPC(ownerId:int):Boolean
		{
			return getPlayer(ownerId) == null;
		}
		
		public function getPlayer(ownerId:int):BattlePlayer
		{
			var result:BattlePlayer = _map[ownerId];
			if (result == null)
			{
				result = _npcPlayer;
			}
			return result;
		}
		
		public function get players():Vector.<BattlePlayer>
		{
			return _players;
		}
		
		private function initialize():void
		{
			var player:BattlePlayer;
			for each (var item:BattleOwnerRecord in _configuration.owners)
			{
				_map[item.id] = player = new BattlePlayer();
				_battleEngine.addComponent(player);
				_players.push(player);
				player.initialize(item);
			}
			_battleEngine.addComponent(_npcPlayer);
		}
	
	}

}