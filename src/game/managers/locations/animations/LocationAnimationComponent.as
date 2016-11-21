package game.managers.locations.animations
{
	import game.managers.locations.mediators.LocationObject;
	import game.modules.animations.AnimationComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationAnimationComponent extends AnimationComponent
	{
		public var source:String;
		
		public function LocationAnimationComponent()
		{
		
		}
		
		public function get locationObject():LocationObject
		{
			return entity as LocationObject;
		}
		
		public function setHover(value:Boolean):void
		{
			
		}
	
	}

}