package game.managers.battles.modules 
{
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitCollectorModule extends BattleModule 
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleUnitCollectorModule() 
		{
			
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void 
		{
			_temp.length = 0;
			context.actors.units.getActors(BattleUnit, _temp);
			for each (var unit:BattleUnit in _temp) 
			{
				if (unit.units <= 0)
				{
					
				}
			}
		}
		
	}

}