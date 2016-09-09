package game.managers.battles.modules 
{
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleDamangeModule extends BattleModule 
	{
		
		public function BattleDamangeModule() 
		{
			
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void 
		{
			context.damage.updateDamages(deltaTick);
		}
		
	}

}