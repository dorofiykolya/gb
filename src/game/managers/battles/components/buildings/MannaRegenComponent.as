package game.managers.battles.components.buildings
{
	import common.composite.Component;
	import game.managers.battles.actors.BattleBuilding;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaRegenComponent extends BattleComponent
	{
		private var _temp:Vector.<Component> = new Vector.<Component>();
		
		private var _manna:Number;
		
		public function MannaRegenComponent()
		{
			_manna = 1;
		}
		
		override protected function attach():void
		{
			super.attach();
			_manna = BattleBuilding(target).battleInfo.manna;
		}
		
		override public function get needRemove():Boolean
		{
			return false;
		}
		
		public function get mannaPerTick():Number
		{
			var currentMannaPerTick:Number = _manna;
			
			_temp.length = 0;
			for each (var item:IMannaModifier in _temp)
			{
				currentMannaPerTick *= item.mannaModifierPercent;
			}
			
			return currentMannaPerTick;
		}
	
	}

}