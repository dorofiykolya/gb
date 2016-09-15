package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitsChangeEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.UnitView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitsChangeCommand extends TestCommand
	{
		public function UnitsChangeCommand()
		{
			super(UnitsChangeCommand);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:UnitsChangeEvent = evt as UnitsChangeEvent;
			
			var unit:UnitView = view.units.getById(event.objectId) as UnitView;
			unit.units = event.units;
		}
	
	}

}