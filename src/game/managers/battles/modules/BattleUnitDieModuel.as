package game.managers.battles.modules
{
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.output.UnitDieEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitDieModuel extends BattleModule
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleUnitDieModuel()
		{
		
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_temp.length = 0;
			context.actors.group(ActorsGroup.UNIT).getActors(BattleUnit, _temp);
			
			for each (var unit:BattleUnit in _temp)
			{
				if (unit.isDied)
				{
					var evt:UnitDieEvent = context.output.enqueueByFactory(UnitDieEvent) as UnitDieEvent;
					evt.tick = tick;
					evt.objectId = unit.objectId;
					unit.dispose();
				}
			}
		}
	
	}

}