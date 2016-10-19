package game.managers.locations.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitMoveEvent;
	import game.managers.locations.logics.LocationUnitLogic;
	import game.managers.locations.mediators.LocationUnit;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitMoveCommand extends LocationCommand
	{
		[Inject]
		public var manager:LocationUnitLogic;
		
		public function LocationUnitMoveCommand()
		{
			super(UnitMoveEvent);
		}
		
		override public function execute(evt:OutputEvent):void
		{
			var data:UnitMoveEvent = evt as UnitMoveEvent;
			var unit:LocationUnit = manager.getByObjectId(data.objectId);
			unit.setPosition(Point3.week(data.x, data.y, data.z));
		}
	
	}

}