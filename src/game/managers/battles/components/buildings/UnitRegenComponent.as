package game.managers.battles.components.buildings
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.engine.BattleUtils;
	import game.managers.battles.modifiers.ModifierType;
	import game.utils.Math2;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRegenComponent extends BattleComponent
	{
		private var _unitsPerTick:Number;
		private var _increase:Number;
		
		public function UnitRegenComponent()
		{
			_increase = 0;
		}
		
		override protected function attach():void
		{
			super.attach();
			
			var unitsPerSecond:Number = BattleBuilding(target).battleInfo.unitsPerSecond;
			_unitsPerTick = BattleUtils.floor(unitsPerSecond / engine.configuration.ticksPerSecond);
		}
		
		public function get building():BattleBuilding
		{
			return BattleBuilding(target);
		}
		
		override public function get needRemove():Boolean
		{
			return false;
		}
		
		public function get units():int
		{
			return building.units.count;
		}
		
		public function get unitsPerTick():Number
		{
			return _unitsPerTick;
		}
		
		public function setUnitsPerTick(value:Number):void
		{
			_unitsPerTick = value;
		}
		
		public function removeHalf():int
		{
			var result:int = units / 2;
			building.units.remove(result);
			return result;
		}
		
		public function regen(deltaTick:Number):Boolean
		{
			if (building.units.count >= building.infoLevel.unitsMaxProduction)
			{
				return false;
			}
			
			var increaseValue:Number = unitsPerTick * deltaTick;
			increaseValue = engine.players.getPlayer(building.ownerId).modifier.calculate(ModifierType.UNITS_INCREASE, increaseValue);
			_increase += increaseValue;
			
			var newUnits:int = int(_increase);
			if (newUnits > 0)
			{
				_increase -= newUnits;
			}
			
			var lastUnits:int = units;
			if (lastUnits + newUnits > building.infoLevel.unitsMaxProduction)
			{
				newUnits = building.infoLevel.unitsMaxProduction - building.units.count;
			}
			building.units.add(newUnits);
			return lastUnits != units;
		}
	
	}

}