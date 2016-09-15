package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitMoveEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.TestView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitMoveCommand extends TestCommand
	{
		public function UnitMoveCommand()
		{
			super(UnitMoveEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void
		{
			var event:UnitMoveEvent = evt as UnitMoveEvent;
			var unit:TestView = view.units.getById(event.objectId);
			unit.x = event.x;
			unit.y = event.y;
		}
	
	}

}