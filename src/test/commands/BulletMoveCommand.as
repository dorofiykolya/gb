package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BulletMoveEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.TestView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletMoveCommand extends TestCommand
	{
		public function BulletMoveCommand()
		{
			super(BulletMoveEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var e:BulletMoveEvent = evt as BulletMoveEvent;
			
			var bullet:TestView = view.bullets.getById(e.objectId);
			bullet.x = e.x;
			bullet.y = e.y;
		}
	
	}

}