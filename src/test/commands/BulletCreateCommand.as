package test.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BulletCreateEvent;
	import test.TestBattleView;
	import test.TestCommand;
	import test.views.BulletView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletCreateCommand extends TestCommand 
	{
		
		public function BulletCreateCommand() 
		{
			super(BulletCreateEvent);
		}
		
		override public function execute(view:TestBattleView, evt:OutputEvent):void 
		{
			var event:BulletCreateEvent = evt as BulletCreateEvent;
			
			var bullet:BulletView = new BulletView();
			bullet.objectId = event.objectId;
			bullet.fromObjectId = event.fromObjectId;
			bullet.toObjectId = event.toObjectId;
			bullet.ownerId = view.getById(event.fromObjectId).ownerId;
			
			view.bullets.add(bullet);
		}
		
	}

}