package game.managers.battles.records
{
	import flash.geom.Point;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBuildingRecord
	{
		public var id:int;
		public var level:int;
		public var mannaPerSecond:Number;
		public var units:int;
		public var unitsPerSecond:Number;
		public var position:Point;
		public var ownerId:int;
		public var unitId:int;
		public var unitLevel:int;
		
		public function BattleBuildingRecord()
		{
		
		}
	
	}

}