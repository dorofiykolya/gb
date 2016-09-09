package game.managers.battles.modules
{
	import game.managers.battles.actors.BattleBuilding;
	import game.managers.battles.components.buildings.UnitRegenComponent;
	import game.managers.battles.components.buildings.UnitSlowRegenComponent;
	import game.managers.battles.components.buildings.UnitStopRegenComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.engine.BattleObject;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.output.UnitsChangeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitsRegenModule extends BattleModule
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleUnitsRegenModule()
		{
			super();
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_temp.length = 0;
			context.actors.group(ActorsGroup.BUILDING).getActors(BattleBuilding, _temp);
			for each (var item:BattleBuilding in _temp)
			{
				var regenComponent:UnitRegenComponent = item.getComponent(UnitRegenComponent) as UnitRegenComponent;
				if (regenComponent != null)
				{
					var increaseValue:Number = regenComponent.unitsPerTick * deltaTick;
					increaseValue = context.players.getPlayer(item.ownerId).modifier.calculate(ModifierType.UNITS_INCREASE, increaseValue);
					
					if (regenComponent.regen(increaseValue))
					{
						var evt:UnitsChangeEvent = context.output.enqueueByFactory(UnitsChangeEvent) as UnitsChangeEvent;
						evt.ownerId = item.ownerId;
						evt.objectId = item.objectId;
						evt.units = regenComponent.units;
						evt.tick = tick;
					}
				}
			}
		}
	}
}