package game.records.locations
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationRecord
	{
		public var id:int;
		public var name:String;
		public var decsription:String;
		public var icon:String;
		public var view:String;
		public var buildings:Vector.<LocationBuildingRecord>;
		
		public function LocationRecord()
		{
		
		}
	
	}

}