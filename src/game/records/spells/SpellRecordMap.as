package game.records.spells
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SpellRecordMap
	{
		private var _map:Dictionary;
		
		public function SpellRecordMap()
		{
			_map = new Dictionary();
		}
		
		public function getById(id:int):SpellRecord
		{
			return _map[id];
		}
		
		public function parse(list:Vector.<SpellRecord>):void
		{
			for each (var item:SpellRecord in list)
			{
				_map[item.id] = item;
			}
		}
	
	}

}