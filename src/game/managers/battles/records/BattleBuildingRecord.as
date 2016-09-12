package game.managers.battles.records
{
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBuildingRecord
	{
		public var id:int;
		public var level:int;
		public var manna:int;
		public var mannaPerSecond:Number;
		public var units:int;
		public var unitsPerSecond:Number;
		public var position:Point3;
		public var ownerId:int;
		public var unitId:int;
		public var unitLevel:int;
		
		public function BattleBuildingRecord()
		{
		
		}
	
	}

}