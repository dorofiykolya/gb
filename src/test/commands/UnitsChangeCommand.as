package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitsChangeEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.UnitOwnerView;
	import test.views.UnitView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitsChangeCommand extends TestCommand
	{
		public function UnitsChangeCommand()
		{
			super(UnitsChangeEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:UnitsChangeEvent = evt as UnitsChangeEvent;
			
			var unit:UnitOwnerView = view.getById(event.objectId) as UnitOwnerView;
			unit.units = event.units;
		}
	
	}

}