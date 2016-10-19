package game.managers.locations.mediators
{
	import game.managers.battles.output.BulletCreateEvent;
	import game.managers.locations.components.LocationObjectAnimationComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBullet extends LocationObject
	{
		
		public function LocationBullet()
		{
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			addComponent(LocationObjectAnimationComponent);
		}
		
		public function setContent(data:BulletCreateEvent):void
		{
			animation.setup("bullet");
		}
		
		public function get animation():LocationObjectAnimationComponent
		{
			return getComponent(LocationObjectAnimationComponent) as LocationObjectAnimationComponent;
		}
	
	}

}