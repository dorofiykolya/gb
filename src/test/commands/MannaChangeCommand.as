package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.MannaChangeEvent;
	import test.TestBattleView;
	import test.TestCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaChangeCommand extends TestCommand
	{
		public function MannaChangeCommand()
		{
			super(MannaChangeCommand);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:MannaChangeEvent = evt as MannaChangeEvent;
			view.setManna(event.ownerId, event.manna);
		}
	
	}

}