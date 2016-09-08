package game.managers.battles.commands 
{
	import game.managers.battles.actions.BattleStartAction;
	import game.managers.battles.actors.BattleBuilding;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleEngineCommand;
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
				var battleObject:BattleBuilding = BattleBuilding(context.actors.factory.instantiate(BattleBuilding));
				context.actors.group(ActorsGroup.BUILDING).addComponent(battleObject);
				battleObject.initialize(record);
			}
		}
		
	}

}