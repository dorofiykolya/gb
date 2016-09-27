package game.managers.locations.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitCreateEvent;
	import game.managers.locations.logics.LocationUnitLogic;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitCreateCommand extends LocationCommand 
	{
		[Inject]
		public var factory:LocationUnitLogic;
		
		public function LocationUnitCreateCommand() 
		{
			super(UnitCreateEvent);
		}
		
		override public function execute(evt:OutputEvent):void 
		{
			var data:UnitCreateEvent = evt as UnitCreateEvent;
			factory.add(data);
		}
		
	}

}