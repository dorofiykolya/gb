package game.managers.battles.modules
{
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
			context.actors.group(ActorsGroup.UNIT).getActors(null, _temp);
			for each (var item:BattleObject in _temp)
			{
				var move:UnitMoveComponent = item.getComponent(UnitMoveComponent) as UnitMoveComponent;
				if (move != null)
				{
					if (move.updatePosition(deltaTick))
					{
						var evt:UnitMoveEvent = context.output.enqueueByFactory(UnitMoveEvent) as UnitMoveEvent;
						evt.tick = tick;
						evt.objectId = item.objectId;
						evt.x = item.transform.x;
						evt.y = item.transform.y;
						evt.z = item.transform.z;
					}
				}
			}
		}
	
	}

}