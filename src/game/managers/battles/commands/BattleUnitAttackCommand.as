package game.managers.battles.commands
{
	import game.managers.battles.actions.BattleUnitAttackAction;
	import game.managers.battles.actors.BattleBuilding;
	import game.managers.battles.actors.BattleUnit;
	import game.managers.battles.components.UnitRegenComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleEngineCommand;
	import game.managers.battles.engine.BattleObject;
	import game.managers.battles.output.UnitAttackEvent;
	
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
			
			var unit:BattleUnit = context.actors.factory.instantiate(BattleUnit) as BattleUnit;
			context.actors.group(ActorsGroup.UNIT).addComponent(unit);
			
			unit.initialize(from, unitCount, to);
			
			var evt:UnitAttackEvent = context.output.factory.getInstance(UnitAttackEvent) as UnitAttackEvent;
			context.output.enqueue(evt);
			evt.count = unitCount;
			evt.from = attack.fromObjectId;
			evt.to = attack.toObjectId;
			evt.tick = action.tick;
		}
	}

}