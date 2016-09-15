package test.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BulletRemoveEvent;
	import test.TestBattleView;
	import test.TestCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletRemoveCommand extends TestCommand 
	{
		
		public function BulletRemoveCommand() 
		{
			super(BulletRemoveEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:BulletRemoveEvent = evt as BulletRemoveEvent;
			view.bullets.remove(event.objectId);
		} 
		
	}

}