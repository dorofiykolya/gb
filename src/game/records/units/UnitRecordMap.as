package game.records.units
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRecordMap
	{
		private var _map:Dictionary;
		
		public function UnitRecordMap()
		{
			_map = new Dictionary();
		}
		
		public function getById(id:int):UnitRecord
		{
			return _map[id];
		}
		
		public function parse(list:Vector.<UnitRecord>):void
		{
			for each (var item:UnitRecord in list)
			{
				_map[item.id] = item;
			}
		}
	}

}