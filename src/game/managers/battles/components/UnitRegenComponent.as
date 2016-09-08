package game.managers.battles.components
{
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRegenComponent extends BattleComponent
	{
		private var _units:Number;
		
		public function UnitRegenComponent()
		{
			
		}
		
		public function get units():int
		{
			return _units;
		}
		
		public function get unitsPerTick():Number
		{
			return 0.1;
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