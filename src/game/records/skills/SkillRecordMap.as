package game.records.skills
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SkillRecordMap
	{
		private var _map:Dictionary;
		
		public function SkillRecordMap()
		{
			_map = new Dictionary();
		}
		
		public function parse(list:Vector.<SkillRecord>):void
		{
			for each (var item:SkillRecord in list)
			{
				_map[item.id] = item;
			}
		}
		
		public function getById(id:int):SkillRecord
		{
			return _map[id];
		}
	
	}

}