package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BuildingCreateEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.BuildingView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingCreateCommand extends TestCommand
	{
		
		public function BuildingCreateCommand()
		{
			super(BuildingCreateEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var action:BuildingCreateEvent = evt as BuildingCreateEvent;
			var building:BuildingView = new BuildingView();
			building.objectId = action.objectId;
			building.buildingId = action.buildingId;
			building.level = action.level;
			building.ownerId = action.ownerId;
			building.x = action.x;
			building.y = action.y;
			building.units = action.units;
			view.buildings.add(building);
		}
	
	}

}