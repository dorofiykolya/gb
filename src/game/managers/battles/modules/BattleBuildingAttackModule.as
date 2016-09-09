package game.managers.battles.modules
{
	import game.managers.battles.actors.BattleBuilding;
	import game.managers.battles.actors.BattleUnit;
	import game.managers.battles.components.buildings.BuildingAttackDefenseComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.engine.BattleObject;
	import game.managers.battles.output.BuildingAttackEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBuildingAttackModule extends BattleModule
	{
		private var _buildings:Vector.<BattleObject> = new Vector.<BattleObject>();
		private var _units:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleBuildingAttackModule()
		{
		
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_buildings.length = 0;
			context.actors.group(ActorsGroup.BUILDING).getActors(BattleBuilding, _buildings);
			
			_units.length = 0;
			context.actors.group(ActorsGroup.UNIT).getActors(BattleUnit, _units);
			
			for each (var building:BattleBuilding in _buildings)
			{
				var component:BuildingAttackDefenseComponent = building.getComponent(BuildingAttackDefenseComponent) as BuildingAttackDefenseComponent;
				if (component && component.canAttack)
				{
					var range:Number = component.range;
					var target:BattleUnit;
					var minDistance:Number = int.MAX_VALUE;
					for each (var unit:BattleUnit in _units)
					{
						var distance:Number = unit.transform.positionDistance(building.transform);
						if (distance <= range)
						{
							if (distance < minDistance)
							{
								minDistance = distance;
								target = unit;
							}
						}
					}
					if (target != null)
					{
						component.attack(target);
						
						var evt:BuildingAttackEvent = context.output.enqueueByFactory(BuildingAttackEvent) as BuildingAttackEvent;
						evt.objectId = building.objectId;
						evt.targetId = target.objectId;
						evt.tick = tick;
					}
				}
			}
		}
	
	}

}