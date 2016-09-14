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
		
		public function UnitRegenComponent()
		{
		
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
			return building.units;
		}
		
		public function get unitsPerTick():Number
		{
			return _unitsPerTick;
		}
		
		public function removeHalf():int
		{
			var result:int = units / 2;
			building.removeUnits(result);
			return result;
		}
		
		public function regen(deltaTick:Number):Boolean
		{
			if (building.units >= building.infoLevel.unitsMaxProduction)
			{
				return false;
			}
			
			var increaseValue:Number = unitsPerTick * deltaTick;
			increaseValue = engine.players.getPlayer(building.ownerId).modifier.calculate(ModifierType.UNITS_INCREASE, increaseValue);
			
			var lastUnits:int = units;
			if (lastUnits + increaseValue > building.infoLevel.unitsMaxProduction)
			{
				increaseValue = building.infoLevel.unitsMaxProduction;
			}
			building.addUnits(increaseValue);
			return lastUnits != units;
		}
	
	}

}