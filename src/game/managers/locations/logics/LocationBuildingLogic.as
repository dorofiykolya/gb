package game.managers.locations.logics
{
	import flash.geom.Point;
	import game.managers.battles.output.BuildingCreateEvent;
	import game.managers.locations.mediators.LocationBuilding;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuildingLogic extends LocationLogic
	{
		[Inject]
		public var factory:LocationObjectsLogic;
		
		public function LocationBuildingLogic()
		{
			super();
		
		}
		
		public function add(data:BuildingCreateEvent):LocationBuilding
		{
			var result:LocationBuilding = factory.instantiate(LocationBuilding, data.objectId) as LocationBuilding;
			result.setContent(data);
			return result;
		}
		
		public function getByObjectId(objectId:int):LocationBuilding
		{
			return factory.getByObjectId(objectId) as LocationBuilding;
		}
	
	}

}