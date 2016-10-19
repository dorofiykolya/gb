package game.managers.locations.logics
{
	import game.managers.battles.output.UnitCreateEvent;
	import game.managers.locations.mediators.LocationObject;
	import game.managers.locations.mediators.LocationUnit;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitLogic extends LocationLogic
	{
		[Inject]
		public var factory:LocationObjectsLogic;
		
		public function LocationUnitLogic()
		{
		
		}
		
		public function add(data:UnitCreateEvent):LocationUnit
		{
			var result:LocationUnit = factory.instantiate(LocationUnit, data.objectId) as LocationUnit;
			result.setContent(data);
			return result;
		}
		
		public function getByObjectId(objectId:int):LocationUnit
		{
			return factory.getByObjectId(objectId) as LocationUnit;
		}
		
		public function remove(objectId:int):void
		{
			var object:LocationObject = factory.getByObjectId(objectId);
			object.dispose();
		}
	
	}

}