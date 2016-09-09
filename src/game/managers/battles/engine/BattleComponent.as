package game.managers.battles.engine
{
	import common.composite.Component;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleComponent extends Component
	{
		internal var _target:BattleObject;
		
		private var _lifeTick:int;
		private var _tick:int;
		
		public function BattleComponent()
		{
		
		}
		
		public function get engine():BattleEngine
		{
			return _target.engine;
		}
		
		public function setLifeTicks(ticks:int):void
		{
			_lifeTick = ticks;
		}
		
		public function get lifeTick():int
		{
			return _lifeTick;
		}
		
		public function get needRemove():Boolean
		{
			return _lifeTick <= 0;
		}
		
		public function get target():BattleObject
		{
			return _target;
		}
		
		public function update(tick:int, deltaTick:int):void
		{
			_tick = tick;
			_lifeTick -= deltaTick;
		}
	
	}

}