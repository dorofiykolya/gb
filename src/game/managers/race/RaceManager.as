package game.managers.race
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import game.records.Race;
	
	[Event(name = "change", type = "common.events.Event")]
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RaceManager extends EventDispatcher
	{
		private var _races:Vector.<int>;
		private var _index:int;
		private var _current:int;
		
		public function RaceManager()
		{
			_races = new <int>[Race.RACE_0, Race.RACE_1, Race.RACE_2];
			_index = 0;
			_current = Race.RACE_0;
		}
		
		public function next():void
		{
			_index++;
			if (_index >= _races.length)
			{
				_index = 0;
			}
			updateByIndex();
		}
		
		public function prev():void
		{
			_index--;
			if (_index <= 0)
			{
				_index = _races.length - 1;
			}
			updateByIndex();
		}
		
		public function set current(value:int):void
		{
			if (value != _current)
			{
				var index:int = _races.indexOf(value);
				if (index >= 0 && index < _races.length)
				{
					_index = index;
					updateByIndex();
				}
			}
		}
		
		public function get current():int
		{
			return _current;
		}
		
		private function updateByIndex():void
		{
			_current = _races[_index];
			dispatchChange();
		}
		
		private function dispatchChange():void
		{
			dispatchEventWith(Event.CHANGE, false, _current);
		}
	
	}

}