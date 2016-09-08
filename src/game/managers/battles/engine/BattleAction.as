package game.managers.battles.engine
{
	import common.system.Assert;
	import common.system.IComparable;
	import common.system.errors.IllegalArgumentError;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleAction implements IComparable
	{
		public var tick:int;
		
		public function BattleAction()
		{
		
		}
		
		/* INTERFACE common.system.IComparable */
		
		public function compareTo(value:Object):int
		{
			Assert.instanceOf(value, BattleAction);
			
			if (tick > BattleAction(value).tick) return 1;
			if (tick < BattleAction(value).tick) return -1;
			return 0;
		}
	
	}

}