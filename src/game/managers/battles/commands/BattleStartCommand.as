package game.managers.battles.commands
{
	import game.managers.battles.actions.BattleStartAction;
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleEngineCommand;
	import game.managers.battles.output.BuildingCreateEvent;
	import game.managers.battles.records.BattleBuildingRecord;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleStartCommand extends BattleEngineCommand
	{
		
		public function BattleStartCommand()
		{
			super(BattleStartAction);
		}
		
		override public function execute(action:BattleAction, context:BattleContext):void
		{
			addBuildings(action, context);
		}
		
		private function addBuildings(action:BattleAction, context:BattleContext):void
		{
			for each (var record:BattleBuildingRecord in context.configuration.buildings)
			{
				var battleObject:BattleBuilding = context.actors.factory.buildingFactory.instantiate(BattleBuilding);
				context.actors.group(ActorsGroup.BUILDING).addComponent(battleObject);
				battleObject.initialize(record, context.configuration);
				
				var evt:BuildingCreateEvent = context.output.enqueueByFactory(BuildingCreateEvent) as BuildingCreateEvent;
				evt.objectId = battleObject.objectId;
				evt.buildingId = battleObject.info.id;
				evt.level = battleObject.level;
				evt.ownerId = battleObject.ownerId;
				evt.tick = action.tick;
				evt.x = battleObject.transform.x;
				evt.y = battleObject.transform.y;
				evt.units = battleObject.units;
			}
		}
	
	}

}