package game.managers.battles.modules
{
	import game.managers.battles.actors.damages.BattleDamageUnitToBuilding;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.components.units.UnitMoveComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.output.UnitMoveEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitsMoveModule extends BattleModule
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleUnitsMoveModule()
		{
		
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_temp.length = 0;
			context.actors.units.getActors(BattleUnit, _temp);
			for each (var unit:BattleUnit in _temp)
			{
				var move:UnitMoveComponent = unit.getComponent(UnitMoveComponent) as UnitMoveComponent;
				if (move != null)
				{
					if (move.updatePosition(deltaTick))
					{
						var evt:UnitMoveEvent = context.output.enqueueByFactory(UnitMoveEvent) as UnitMoveEvent;
						evt.tick = tick;
						evt.objectId = unit.objectId;
						evt.x = unit.transform.x;
						evt.y = unit.transform.y;
						evt.z = unit.transform.z;
					}
					if (move.moveCompleted)
					{
						var damage:BattleDamageUnitToBuilding = context.actors.factory.damageFactory.instantiate(BattleDamageUnitToBuilding) as BattleDamageUnitToBuilding;
						damage.setEnemy(unit, move.targetBuilding);
						context.actors.damages.addComponent(damage);
					}
				}
			}
		}
	
	}

}