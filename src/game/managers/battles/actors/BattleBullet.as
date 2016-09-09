package game.managers.battles.actors
{
	import game.managers.battles.engine.BattleObject;
	
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
		
		public function get targetId():int
		{
			return 1;
		}
	
	}

}