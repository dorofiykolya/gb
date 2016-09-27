package game.records.units
{
	import common.system.DictionaryMap;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRecordMap
	{
		private var _map:Dictionary;
		private var _unitMap:DictionaryMap;
		
		public function UnitRecordMap()
		{
			_map = new Dictionary();
			_unitMap = new DictionaryMap();
		}
		
		public function getById(id:int):UnitRecord
		{
			return _map[id];
		}
		
		public function getByUnitId(unitId:int, race:int):UnitRecord
		{
			return _unitMap.map(race, unitId).value;
		}
		
		public function parse(list:Vector.<UnitRecord>):void
		{
			for each (var item:UnitRecord in list)
			{
				_map[item.id] = item;
				_unitMap.map(item.race, item.unitId).value = item;
			}
		}
	}

}