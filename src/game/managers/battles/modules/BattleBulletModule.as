package game.managers.battles.modules
{
	import game.managers.battles.actors.BattleBullet;
	import game.managers.battles.components.bullets.BulletMoveComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.engine.BattleObject;
	import game.managers.battles.output.BulletMoveEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBulletModule extends BattleModule
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleBulletModule()
		{
		
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			super.preTick(context, tick, deltaTick);
			
			_temp.length = 0;
			context.actors.group(ActorsGroup.BULLET).getActors(BattleBullet, _temp);
			
			for each (var bullet:BattleBullet in _temp)
			{
				var move:BulletMoveComponent = bullet.getComponent(BulletMoveComponent) as BulletMoveComponent;
				if (move.updatePosition(deltaTick))
				{
					var evt:BulletMoveEvent = context.output.enqueueByFactory(BulletMoveEvent) as BulletMoveEvent;
					evt.objectId = bullet.objectId;
					evt.tick = tick;
					evt.x = bullet.transform.x;
					evt.y = bullet.transform.y;
					evt.z = bullet.transform.z;
				}
				if (move.moveCompleted)
				{
					generateDamage(bullet, context, tick, deltaTick);
					bullet.dispose();
				}
			}
		}
		
		private function generateDamage(bullet:BattleBullet, context:BattleContext, tick:int, deltaTick:int):void
		{
			context.damage.generateByBullet(bullet, tick, deltaTick);
		}
	
	}

}