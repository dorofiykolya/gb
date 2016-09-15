package test.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitCreateEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.UnitView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitCreateCommand extends TestCommand 
	{
		
		public function UnitCreateCommand() 
		{
			super(UnitCreateEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:UnitCreateEvent = evt as UnitCreateEvent;
			
			var unit:UnitView = new UnitView();
			unit.objectId = event.objectId;
			unit.ownerId = event.ownerId;
			unit.unitId = event.unitId;
			unit.level = event.level;
			unit.x = event.x;
			unit.y = event.y;
			unit.units = event.units;
			
			view.units.add(unit);
			
		}
		
	}

}