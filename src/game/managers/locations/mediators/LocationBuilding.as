package game.managers.locations.mediators 
{
	import game.managers.battles.output.BuildingCreateEvent;
	import game.managers.locations.components.LocationBuildingAnimationComponent;
	import game.utils.Point3;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuilding extends LocationObject 
	{
		
		public function LocationBuilding() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			addComponent(LocationBuildingAnimationComponent);
		}
		
		public function setContent(data:BuildingCreateEvent):void
		{
			setPosition(Point3.week(data.x, data.y));
			
			animation.setup("buildings/player0/viking_barrack_1b");
		}
		
		public function setUnits(units:int):void 
		{
			
		}
		
		public function get animation():LocationBuildingAnimationComponent
		{
			return getComponent(LocationBuildingAnimationComponent) as LocationBuildingAnimationComponent;
		}
		
	}

}