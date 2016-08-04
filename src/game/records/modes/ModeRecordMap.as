package game.records.modes
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ModeRecordMap
	{
		private var _map:Dictionary;
		
		public function ModeRecordMap()
		{
			_map = new Dictionary();
		}
		
		public function getById(id:int):ModeRecord
		{
			return _map[id];
		}
		
		public function parse(list:Vector.<ModeRecord>):void
		{
			for each (var item:ModeRecord in list)
			{
				_map[item.id] = item;
			}
		}
	
	}

}