package game.records.buildings
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingsRecordMap
	{
		private var _map:Dictionary;
		
		public function BuildingsRecordMap()
		{
			_map = new Dictionary();
		}
		
		public function getById(id:int):BuildingRecord
		{
			return _map[id];
		}
		
		public function parse(list:Vector.<BuildingRecord>):void
		{
			for each (var item:BuildingRecord in list)
			{
				_map[item.id] = item;
			}
		}
	
	}

}