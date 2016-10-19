package game.managers.locations.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BulletRemoveEvent;
	import game.managers.locations.logics.LocationBulletLogic;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletRemoveCommand extends LocationCommand
	{
		[Inject]
		public var manager:LocationBulletLogic;
		
		public function LocationBulletRemoveCommand()
		{
			super(BulletRemoveEvent);
		}
		
		override public function execute(evt:OutputEvent):void 
		{
			var data:BulletRemoveEvent = evt as BulletRemoveEvent;
			manager.remove(data.objectId);
		}
	
	}

}