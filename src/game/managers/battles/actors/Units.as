package game.managers.battles.actors
{
	import game.managers.battles.output.UnitsChangeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Units
	{
		private var _count:int;
		private var _battleObject:BattleObject;
		
		public function Units(battleObject:BattleObject)
		{
			_battleObject = battleObject;
		}
		
		public function setCount(count:int):void
		{
			_count = count;
		}
		
		public function change(count:int):Boolean
		{
			if (_count != count)
			{
				_count = count;
				outputEvent();
			}
			return _count;
		}
		
		public function add(count:int):int
		{
			if (count != 0)
			{
				_count += count;
				outputEvent();
			}
			return _count;
		}
		
		public function remove(count:int):int
		{
			if (_count != 0)
			{
				_count -= count;
				if (_count < 0) _count = 0;
				outputEvent();
			}
			return _count;
		}
		
		public function get count():int
		{
			return _count;
		}
		
		private function outputEvent():void
		{
			var evt:UnitsChangeEvent = _battleObject.engine.output.enqueueByFactory(UnitsChangeEvent) as UnitsChangeEvent;
			evt.tick = _battleObject.engine.tick;
			evt.objectId = _battleObject.objectId;
			evt.units = _count;
		}
	}

}