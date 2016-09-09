package game.managers.battles.engine
{
	import game.managers.battles.actors.BattleBullet;
	
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
		
		public function updateDamages(deltaTick:int):void
		{
		
		}
		
		public function generateByBullet(bullet:BattleBullet, tick:int, deltaTick:int):void
		{
		
		}
	
	}

}