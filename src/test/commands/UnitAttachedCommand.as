package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitAttachedEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.BuildingView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitAttachedCommand extends TestCommand
	{
		public var buildingObjectId:int;
		public var unitObjectId:int;
		public var buildingUnits:int;
		
		public function UnitAttachedCommand()
		{
			super(UnitAttachedEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void
		{
			var e:UnitAttachedEvent = evt as UnitAttachedEvent;
			
			var building:BuildingView = view.buildings.getById(e.buildingObjectId) as BuildingView;
			building.units = e.buildingUnits;
		}
	
	}

}