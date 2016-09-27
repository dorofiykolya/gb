package game.managers.locations.mediators 
{
	import game.managers.locations.components.LocationBuildingAnimationComponent;
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
		
		public function setContent():void
		{
			
		}
		
		public function get animation():LocationBuildingAnimationComponent
		{
			return getComponent(LocationBuildingAnimationComponent) as LocationBuildingAnimationComponent;
		}
		
	}

}