package game.managers.locations.components
{
	import flash.geom.Point;
	import game.managers.locations.logics.LocationObjectsLogic;
	import game.managers.locations.mediators.LocationObject;
	import game.managers.locations.supports.DirectionSupport;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitAnimationComponent extends LocationObjectAnimationComponent
	{
		private static const FROM:Point = new Point();
		private static const TO:Point = new Point();
		private static const STATES:Array = ["0", "1", "2", "3", "4", "5", "6", "7", "8"];
		
		[Inject]
		public var actorManager:LocationObjectsLogic;
		
		public function LocationUnitAnimationComponent()
		{
		
		}
		
		public function directionTo(toObjectId:int):void
		{
			var target:LocationObject = actorManager.getByObjectId(toObjectId);
			
			FROM.setTo(locationObject.x, locationObject.y);
			TO.setTo(target.x, target.y);
			
			var direction = DirectionSupport.getDirectionPointToPoint(FROM, TO, 8, 0, 0);
			
			component.setState(STATES[direction], false);
		}
	
	}

}