package game.managers.locations.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BuildingCreateEvent;
	import game.managers.locations.logics.LocationBuildingLogic;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuildingCreateCommand extends LocationCommand 
	{
		[Inject]
		public var buildingLogic:LocationBuildingLogic;
		
		public function LocationBuildingCreateCommand() 
		{
			super(BuildingCreateEvent);			
		}
		
		override public function execute(evt:OutputEvent):void 
		{
			var data:BuildingCreateEvent = evt as BuildingCreateEvent;
			buildingLogic.add(data);
		}
		
	}

}