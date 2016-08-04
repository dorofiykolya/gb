package game.records.locations
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationRecordMap
	{
		private var _map:Dictionary;
		
		public function LocationRecordMap()
		{
			_map = new Dictionary();
		}
		
		public function getById(id:int):LocationRecord
		{
			return _map[id];
		}
		
		public function parse(list:Vector.<LocationRecord>):void
		{
			for each (var item:LocationRecord in list)
			{
				_map[item.id] = item;
			}
		}
	
	}

}