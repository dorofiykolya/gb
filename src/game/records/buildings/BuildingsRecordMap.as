package game.records.buildings
{
	import common.system.DictionaryMap;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingsRecordMap
	{
		private var _map:Dictionary;
		private var _buildingMap:DictionaryMap;
		
		public function BuildingsRecordMap()
		{
			_map = new Dictionary();
			_buildingMap = new DictionaryMap();
		}
		
		public function getById(id:int):BuildingRecord
		{
			return _map[id];
		}
		
		public function getByBuildingId(buildingId:int, race:int):BuildingRecord
		{
			return _buildingMap.map(race, buildingId).value;
		}
		
		public function parse(list:Vector.<BuildingRecord>):void
		{
			for each (var item:BuildingRecord in list)
			{
				_map[item.id] = item;
				_buildingMap.map(item.race, item.buildingId).value = item;
			}
		}
	
	}

}