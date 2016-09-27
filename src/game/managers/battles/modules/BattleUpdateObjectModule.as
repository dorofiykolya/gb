package game.managers.battles.modules
{
	import common.composite.Component;
	import common.system.Enum;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleActorsGroup;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUpdateObjectModule extends BattleModule
	{
		private var _list:Vector.<BattleActorsGroup> = new Vector.<BattleActorsGroup>()
		private var _temp:Vector.<Component> = new Vector.<Component>();
		
		public function BattleUpdateObjectModule()
		{
			super();
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			super.preTick(context, tick, deltaTick);
			
			_temp.length = 0;
			for each (var enum:ActorsGroup in Enum.getEnums(ActorsGroup))
			{
				context.actors.group(enum).getComponentsInChildren(BattleComponent, true, true, _temp);
				
				for each (var item:BattleComponent in _temp)
				{
					item.update(tick, deltaTick);
					if (item.needRemove)
					{
						item.dispose();
					}
				}
			}
		
		}
	
	}

}