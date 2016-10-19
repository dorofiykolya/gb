package game.managers.locations.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BulletCreateEvent;
	import game.managers.locations.logics.LocationBulletLogic;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletCreateCommand extends LocationCommand
	{
		[Inject]
		public var manager:LocationBulletLogic;
		
		public function LocationBulletCreateCommand()
		{
			super(BulletCreateEvent);
		}
		
		override public function execute(evt:OutputEvent):void 
		{
			var data:BulletCreateEvent = evt as BulletCreateEvent;
			manager.add(data);
		}
	
	}

}