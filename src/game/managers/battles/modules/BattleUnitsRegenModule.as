package game.managers.battles.modules
{
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.components.buildings.UnitRegenComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.output.BuildingChangeUnitEvent;
	
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
			context.actors.buildings.getActors(BattleBuilding, _temp);
			for each (var item:BattleBuilding in _temp)
			{
				var regenComponent:UnitRegenComponent = item.getComponent(UnitRegenComponent) as UnitRegenComponent;
				if (regenComponent != null)
				{
					if (regenComponent.regen(deltaTick))
					{
						var evt:BuildingChangeUnitEvent = context.output.enqueueByFactory(BuildingChangeUnitEvent) as BuildingChangeUnitEvent;
						evt.objectId = item.objectId;
						evt.units = regenComponent.units;
						evt.tick = tick;
					}
				}
			}
		}
	}
}