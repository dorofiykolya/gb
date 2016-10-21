package game.managers.battles.commands
{
	import game.managers.battles.actions.BattleUnitAttackAction;
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.components.buildings.UnitRegenComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleEngineCommand;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.output.UnitAttackEvent;
	import game.managers.battles.output.UnitCreateEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitAttackCommand extends BattleEngineCommand
	{
		
		public function BattleUnitAttackCommand()
		{
			super(BattleUnitAttackAction);
		}
		
		override public function execute(action:BattleAction, context:BattleContext):void
		{
			var attack:BattleUnitAttackAction = BattleUnitAttackAction(action);
			var from:BattleBuilding = context.actors.getActorByObjectId(attack.fromObjectId) as BattleBuilding;
			var to:BattleBuilding = context.actors.getActorByObjectId(attack.toObjectId) as BattleBuilding;
			
			var regen:UnitRegenComponent = from.getComponent(UnitRegenComponent) as UnitRegenComponent;
			var unitCount:int = regen.removeHalf();
			
			if (unitCount > 0)
			{
				var unit:BattleUnit = context.actors.factory.unitFactory.instantiate(BattleUnit);
				context.actors.group(ActorsGroup.UNIT).addComponent(unit);
				
				unit.initialize(from, to, unitCount);
				
				var createUnit:UnitCreateEvent = context.output.enqueueByFactory(UnitCreateEvent) as UnitCreateEvent;
				createUnit.objectId = unit.objectId;
				createUnit.unitId = unit.unitId;
				createUnit.level = unit.level;
				createUnit.ownerId = unit.ownerId;
				createUnit.units = unit.units.count;
				createUnit.x = unit.transform.x;
				createUnit.y = unit.transform.y;
				createUnit.toObjectId = to.objectId;
				
				var evt:UnitAttackEvent = context.output.enqueueByFactory(UnitAttackEvent) as UnitAttackEvent;
				evt.count = unitCount;
				evt.unitId = unit.unitId;
				evt.unitLevel = unit.level;
				evt.from = attack.fromObjectId;
				evt.to = attack.toObjectId;
				evt.tick = action.tick;
				
			}
		}
	}

}