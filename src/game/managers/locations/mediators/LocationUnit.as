package game.managers.locations.mediators
{
	import game.managers.battles.output.UnitCreateEvent;
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
		
		public function setContent(data:UnitCreateEvent):void
		{
			animation.setup("warrior");
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