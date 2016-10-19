package game.managers.locations.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitRemoveEvent;
	import game.managers.locations.logics.LocationUnitLogic;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitRemoveCommand extends LocationCommand
	{
		[Inject]
		public var manager:LocationUnitLogic;
		
		public function LocationUnitRemoveCommand()
		{
			super(UnitRemoveEvent);
		}
		
		override public function execute(evt:OutputEvent):void 
		{
			var data:UnitRemoveEvent = evt as UnitRemoveEvent;
			manager.remove(data.objectId);
		}
	
	}

}