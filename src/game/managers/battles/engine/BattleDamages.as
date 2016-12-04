package game.managers.battles.engine
{
	import game.managers.battles.actors.bullets.BattleBullet;
	import game.managers.battles.actors.damages.BattleDamage;
	import game.managers.battles.components.bullets.BulletDamageComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleDamages
	{
		private var _context:BattleContext;
		
		public function BattleDamages(context:BattleContext)
		{
			_context = context;
		}
		
		public function generateByBullet(bullet:BattleBullet, tick:int, deltaTick:int):void
		{
			var damage:BattleDamage = bullet.generateDamage();
			_context.actors.damages.addComponent(damage);
		}
	
	}

}