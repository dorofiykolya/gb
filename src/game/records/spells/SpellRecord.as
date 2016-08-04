package game.records.spells
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SpellRecord
	{
		public var id:int;
		public var name:String;
		public var description:String;
		public var mannaCost:int;
		public var duration:int;
		public var useType:int;
		public var levels:Vector.<SpellLevelRecord>;
		
		public function SpellRecord()
		{
		
		}
	
	}

}