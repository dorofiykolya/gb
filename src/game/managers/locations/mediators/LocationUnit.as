package game.managers.locations.mediators
{
	import game.managers.locations.components.LocationUnitAnimationComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnit extends LocationObject
	{
		
		public function LocationUnit()
		{
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			addComponent(LocationUnitAnimationComponent);
		}
		
		public function setContent():void
		{
		
		}
		
		public function get animation():LocationUnitAnimationComponent
		{
			return getComponent(LocationUnitAnimationComponent) as LocationUnitAnimationComponent;
		}
	
	}

}