package game.managers.locations.commands
{
	import flash.utils.Dictionary;
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitsChangeEvent;
	import game.managers.locations.logics.LocationObjectsLogic;
	import game.managers.locations.mediators.LocationBuilding;
	import game.managers.locations.mediators.LocationObject;
	import game.managers.locations.mediators.LocationUnit;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitsChangeCommand extends LocationCommand
	{
		[Inject]
		public var manager:LocationObjectsLogic;
		
		private var _map:Dictionary;
		
		public function LocationUnitsChangeCommand()
		{
			super(UnitsChangeEvent);
			
			_map = new Dictionary();
			
			_map[LocationBuilding] = changeInBuilding;
			_map[LocationUnit] = changeInUnit;
		}
		
		override public function execute(evt:OutputEvent):void
		{
			var data:UnitsChangeEvent = evt as UnitsChangeEvent;
			var locationObject:LocationObject = manager.getByObjectId(data.objectId);
			
			for (var clazz:Object in _map)
			{
				if (locationObject is Class(clazz))
				{
					_map[clazz](locationObject, data.units);
				}
			}
		}
		
		private function changeInBuilding(building:LocationBuilding, units:int):void
		{
			building.setUnits(units);
		}
		
		private function changeInUnit(unit:LocationUnit, units:int):void
		{
			unit.setUnits(units);
		}
	
	}

}