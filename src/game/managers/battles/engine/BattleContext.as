package game.managers.battles.engine
{
	import game.managers.battles.engine.BattleActors;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.players.BattlePlayers;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleContext
	{
		private var _configuration:BattleConfiguration;
		private var _battleEngine:BattleEngine;
		private var _actors:BattleActors;
		private var _state:BattleState;
		private var _players:BattlePlayers;
		private var _output:BattleOutput;
		
		public function BattleContext(configuration:BattleConfiguration, battleEngine:BattleEngine, actors:BattleActors, state:BattleState, players:BattlePlayers, output:BattleOutput)
		{
			_output = output;
			_players = players;
			_state = state;
			_actors = actors;
			_battleEngine = battleEngine;
			_configuration = configuration;
		}
		
		public function get configuration():BattleConfiguration
		{
			return _configuration;
		}
		
		public function get battleEngine():BattleEngine
		{
			return _battleEngine;
		}
		
		public function get actors():BattleActors
		{
			return _actors;
		}
		
		public function get state():BattleState
		{
			return _state;
		}
		
		public function get players():BattlePlayers
		{
			return _players;
		}
		
		public function get output():BattleOutput 
		{
			return _output;
		}
	
	}

}