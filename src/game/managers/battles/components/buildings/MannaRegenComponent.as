package game.managers.battles.components.buildings
{
	import common.composite.Component;
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaRegenComponent extends BattleComponent
	{
		private var _temp:Vector.<Component> = new Vector.<Component>();
		
		private var _mannaPerTick:Number;
		
		public function MannaRegenComponent()
		{
			_mannaPerTick = 1;
		}
		
		override protected function onAttach():void
		{
			super.onAttach();
			_mannaPerTick = BattleBuilding(target).mannaPerSecond / engine.configuration.ticksPerSecond;
		}
		
		override public function get needRemove():Boolean
		{
			return false;
		}
		
		public function get mannaPerTick():Number
		{
			var currentMannaPerTick:Number = _mannaPerTick;
			
			_temp.length = 0;
			for each (var item:IMannaModifier in _temp)
			{
				currentMannaPerTick *= item.mannaModifierPercent;
			}
			
			return currentMannaPerTick;
		}
	
	}

}