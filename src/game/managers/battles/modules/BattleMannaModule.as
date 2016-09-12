package game.managers.battles.modules
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.components.buildings.MannaRegenComponent;
	import game.managers.battles.components.buildings.MannaSlowComponent;
	import game.managers.battles.components.buildings.MannaStopComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.modifiers.BattleModifier;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.output.MannaChangeEvent;
	import game.managers.battles.players.BattlePlayer;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleMannaModule extends BattleModule
	{
		private var _temp:Vector.<BattleObject> = new Vector.<BattleObject>();
		
		public function BattleMannaModule()
		{
			super();
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_temp.length = 0;
			context.actors.group(ActorsGroup.BUILDING).getActors(BattleBuilding, _temp);
			
			for each (var item:BattleBuilding in _temp)
			{
				var mannaComponent:MannaRegenComponent = item.getComponent(MannaRegenComponent) as MannaRegenComponent;
				if (mannaComponent != null)
				{
					var increaseManna:Number = mannaComponent.mannaPerTick * deltaTick;
					
					if (increaseManna != 0)
					{
						var player:BattlePlayer = context.players.getPlayer(item.ownerId);
						var result:Number = player.modifier.calculate(ModifierType.MANNA_INCREASE, increaseManna);
						if (player.manna.add(result))
						{
							var evt:MannaChangeEvent = context.output.enqueueByFactory(MannaChangeEvent) as MannaChangeEvent;
							evt.ownerId = player.id;
							evt.manna = player.manna.value;
							evt.tick = tick;
						}
					}
				}
			}
		}
	}
}