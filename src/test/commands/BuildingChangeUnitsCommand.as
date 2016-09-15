package test.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BuildingChangeUnitEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.BuildingView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingChangeUnitsCommand extends TestCommand 
	{
		
		public function BuildingChangeUnitsCommand() 
		{
			super(BuildingChangeUnitEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var e:BuildingChangeUnitEvent = evt as BuildingChangeUnitEvent;
			var building:BuildingView = view.buildings.getById(e.objectId) as BuildingView;
			building.units = e.units;
		}
		
	}

}