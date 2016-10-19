package game.managers.locations.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BulletMoveEvent;
	import game.managers.locations.logics.LocationBulletLogic;
	import game.managers.locations.mediators.LocationBullet;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletMoveCommand extends LocationCommand
	{
		[Inject]
		public var manager:LocationBulletLogic;
		
		public function LocationBulletMoveCommand()
		{
			super(BulletMoveEvent);
		}
		
		override public function execute(evt:OutputEvent):void
		{
			var data:BulletMoveEvent = evt as BulletMoveEvent;
			var bullet:LocationBullet = manager.getByObjectId(data.objectId);
			bullet.setPosition(Point3.week(data.x, data.y, data.z));
		}
	
	}

}