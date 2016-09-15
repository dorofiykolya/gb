package test.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.UnitRemoveEvent;
	import test.TestBattleView;
	import test.TestCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRemoveCommand extends TestCommand 
	{
		
		public function UnitRemoveCommand() 
		{
			super(UnitRemoveEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:UnitRemoveEvent = evt as UnitRemoveEvent;
			
			view.units.remove(event.objectId);
		}
		
	}

}