package game.managers.battles.engine
{
	import common.system.IntRandom;
	import game.managers.battles.engine.BattleConfiguration;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleState
	{
		private var _configuration:BattleConfiguration;
		private var _tick:int;
		private var _isFinished:Boolean;
		private var _random:IntRandom;
		private var _prevTick:int;
		
		public function BattleState(configuration:BattleConfiguration)
		{
			_configuration = configuration;
			_random = new IntRandom(0);
			_tick = 0;
			_prevTick = 0;
		}
		
		public function get random():IntRandom
		{
			return _random;
		}
		
		internal function get deltaTick():int
		{
			return _tick - _prevTick;
		}
		
		internal function updateTick(tick:int):void
		{
			_prevTick = _tick;
			_tick = tick;
		}
		
		internal function finishBattle():void
		{
			_isFinished = true;
		}
		
		public function get tick():int
		{
			return _tick;
		}
		
		public function get isFinished():Boolean
		{
			return _isFinished;
		}
	
	}

}