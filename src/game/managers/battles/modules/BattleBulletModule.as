package game.managers.battles.modules
{
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.actors.bullets.BattleBullet;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.output.BulletRemoveEvent;
	
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
			context.actors.bullets.getActors(BattleBullet, _temp);
			
			for each (var bullet:BattleBullet in _temp)
			{
				bullet.update(tick, deltaTick);
				
				if (bullet.needGenerateDamage)
				{
					generateDamage(bullet, context, tick, deltaTick);
				}
				if (bullet.needRemove)
				{
					var evt:BulletRemoveEvent = context.output.enqueueByFactory(BulletRemoveEvent) as BulletRemoveEvent;
					evt.objectId = bullet.objectId;
					evt.tick = tick;
					
					bullet.dispose();
				}
			}
		}
		
		private function generateDamage(bullet:BattleBullet, context:BattleContext, tick:int, deltaTick:int):void
		{
			context.actors.damagesFactory.generateByBullet(bullet, tick, deltaTick);
		}
	
	}

}