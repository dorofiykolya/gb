package game.records.buildings
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingRecord
	{
		public var id:int;
		public var name:String;
		public var description:String;
		public var type:int;
		public var levels:Vector.<BuildingLevelRecord>;
		
		public function BuildingRecord()
		{
		
		}
	
	}

}