package game.managers.locations.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BuildingChangeOwnerEvent;
	import game.managers.locations.logics.LocationBuildingLogic;
	import game.managers.locations.mediators.LocationBuilding;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuildingChangeOwnerCommand extends LocationCommand
	{
		[Inject]
		public var buildingsManager:LocationBuildingLogic;
		
		public function LocationBuildingChangeOwnerCommand()
		{
			super(BuildingChangeOwnerEvent);
		}
		
		override public function execute(evt:OutputEvent):void
		{
			var data:BuildingChangeOwnerEvent = evt as BuildingChangeOwnerEvent;
			var building:LocationBuilding = buildingsManager.getByObjectId(data.objectId);
			building.setOwnerId(data.ownerId);
		}
	
	}

}