package game.records.units
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRecord
	{
		public var id:int;
		public var name:String;
		public var description:String;
		public var race:int;
		public var speed:int;
		public var levels:Vector.<UnitLevelRecord>;
		
		public function UnitRecord()
		{
		
		}
	
	}

}