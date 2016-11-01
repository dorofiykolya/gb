package game.managers.locations.mediators
{
	import game.managers.battles.output.UnitCreateEvent;
	import game.managers.locations.components.LocationUnitAnimationComponent;
	import game.records.units.UnitRecordMap;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnit extends LocationObject
	{
		[Inject]
		public var unitRecordMap:UnitRecordMap;
		
		public function LocationUnit()
		{
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			addComponent(LocationUnitAnimationComponent);
		}
		
		public function setContent(data:UnitCreateEvent):void
		{
			setPosition(Point3.week(data.x, data.y));
			animation.setup("warrior");
			animation.directionTo(data.toObjectId);
		}
		
		public function setUnits(units:int):void 
		{
			
		}
		
		public function get animation():LocationUnitAnimationComponent
		{
			return getComponent(LocationUnitAnimationComponent) as LocationUnitAnimationComponent;
		}
	
	}

}