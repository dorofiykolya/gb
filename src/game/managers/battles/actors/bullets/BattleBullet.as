package game.managers.battles.actors.bullets
{
	import game.managers.battles.actors.damages.BattleDamage;
	import game.managers.battles.components.bullets.BulletMoveComponent;
	import game.managers.battles.actors.BattleObject;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBullet extends BattleObject
	{
		
		public function BattleBullet()
		{
			super();
		}
		
		public function update(tick:int, deltaTick:int):void
		{
			
		}
		
		public function generateDamage():BattleDamage
		{
			return null;
		}
		
		public function get needRemove():Boolean
		{
			return false;
		}
		
		public function get needGenerateDamage():Boolean
		{
			return false;
		}
	}
}