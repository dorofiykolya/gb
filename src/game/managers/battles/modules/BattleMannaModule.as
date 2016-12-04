package game.managers.battles.modules
{
	import flash.utils.Dictionary;
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
		private var _lastManna:Dictionary = new Dictionary();
		
		public function BattleMannaModule()
		{
			super();
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_temp.length = 0;
			context.actors.buildings.getActors(BattleBuilding, _temp);
			
			saveLastManna(context, tick);
			
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
						player.manna.add(result);
					}
				}
			}
			
			checkManna(context, tick);
		
		}
		
		private function saveLastManna(context:BattleContext, tick:int):void
		{
			for each (var battlePlayer:BattlePlayer in context.players.players)
			{
				_lastManna[battlePlayer.id] = battlePlayer.manna.value;
			}
		}
		
		private function checkManna(context:BattleContext, tick:int):void
		{
			for each (var player:BattlePlayer in context.players.players)
			{
				if (_lastManna[player.id] != player.manna.value)
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