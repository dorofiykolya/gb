package game.managers.locations.logics
{
	import common.composite.Component;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.engine.OutputEvent;
	import game.managers.locations.events.TickEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBattleLogic extends LocationLogic
	{
		[Inject]
		public var timer:LocationTimeLogic;
		[Inject]
		public var commands:LocationCommandLogics;
		
		private var _ticksPerSecond:Number;
		private var _engine:BattleEngine;
		
		public function LocationBattleLogic()
		{
		
		}
		
		override public function initialize():void
		{
			//timer.addEventListener(TickEvent.TICK, onTickHandler);
			
			_ticksPerSecond = location.data.configuration.ticksPerSecond;
			//_engine = new BattleEngine(location.data.configuration);
		}
		
		internal function get engine():BattleEngine
		{
			return _engine;
		}
		
		private function onTickHandler(e:TickEvent):void
		{
			var ticks:int = (timer.elapsedTime * _ticksPerSecond);
			if (_engine.tick != ticks)
			{
				if (_engine.tick > ticks)
				{
					
				}
				else
				{
					_engine.fastForward(ticks);
				}
				while (!_engine.output.isEmpty)
				{
					var evt:OutputEvent = _engine.output.dequeue();
					commands.execute(evt);
					_engine.output.factory.release(evt);
				}
			}
		}
	
	}

}