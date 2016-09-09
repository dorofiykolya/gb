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
		internal var _damage:BattleDamages;
		internal var _configuration:BattleConfiguration;
		internal var _battleEngine:BattleEngine;
		internal var _actors:BattleActors;
		internal var _state:BattleState;
		internal var _players:BattlePlayers;
		internal var _output:BattleOutput;
		
		public function BattleContext()
		{
			
		}
		
		public function get configuration():BattleConfiguration
		{
			return _configuration;
		}
		
		public function get damage():BattleDamages
		{
			return _damage;
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