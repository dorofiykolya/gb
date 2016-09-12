package game.managers.battles.components.buildings
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.engine.BattleUtils;
	import game.utils.Math2;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRegenComponent extends BattleComponent
	{
		private var _units:Number;
		private var _unitsPerTick:Number;
		
		public function UnitRegenComponent()
		{
			
		}
		
		override protected function attach():void 
		{
			super.attach();
			_units = BattleBuilding(target).battleInfo.units;
			
			var unitsPerSecond:Number = BattleBuilding(target).battleInfo.unitsPerSecond;
			_unitsPerTick = BattleUtils.floor(unitsPerSecond / engine.configuration.ticksPerSecond);
		}
		
		override public function get needRemove():Boolean 
		{
			return false;
		}
		
		public function set units(value:int):void
		{
			_units = value;
		}
		
		public function get units():int
		{
			return _units;
		}
		
		public function get unitsPerTick():Number
		{
			return _unitsPerTick;
		}
		
		public function removeHalf():int
		{
			var result:int = units / 2;
			_units -= result;
			return result;
		}
		
		public function regen(increaseValue:Number):Boolean
		{
			var lastUnits:int = units;
			_units += increaseValue;
			return lastUnits != units;
		}
	
	}

}