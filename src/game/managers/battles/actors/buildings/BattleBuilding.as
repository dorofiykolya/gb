package game.managers.battles.actors.buildings
{
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.actors.BattleUnitOwner;
	import game.managers.battles.actors.DefenseType;
	import game.managers.battles.components.buildings.BuildingAttackDefenseComponent;
	import game.managers.battles.components.buildings.MannaRegenComponent;
	import game.managers.battles.components.buildings.UnitRegenComponent;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.output.BuildingChangeUnitEvent;
	import game.managers.battles.records.BattleBuildingRecord;
	import game.records.buildings.BuildingLevelRecord;
	import game.records.buildings.BuildingRecord;
	import game.records.buildings.BuildingType;
	import game.records.units.UnitLevelRecord;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBuilding extends BattleUnitOwner
	{
		private var _record:BuildingRecord;
		private var _battleRecord:BattleBuildingRecord;
		
		public function BattleBuilding()
		{
			super();
		}
		
		public function get battleInfo():BattleBuildingRecord
		{
			return _battleRecord;
		}
		
		public function get info():BuildingRecord
		{
			return _record;
		}
		
		public function get infoLevel():BuildingLevelRecord
		{
			return _record.levels[_battleRecord.level];
		}
		
		public function get level():int
		{
			return _battleRecord.level;
		}
		
		public function getOneUnitDefense(defenseType:int):Number
		{
			if (defenseType == DefenseType.MAGIC_DEFENSE)
			{
				return oneUnitMagicDefense;
			}
			return oneUnitDefense;
		}
		
		public function get oneUnitDefense():Number
		{
			var unitRecord:UnitLevelRecord = engine.configuration.unitRecords.getById(battleInfo.unitId).levels[battleInfo.unitLevel];
			var unitDefense:Number = engine.players.getPlayer(ownerId).modifier.calculate(ModifierType.UNITS_DEFENSE, unitRecord.defense, battleInfo.unitId);
			return unitDefense;
		}
		
		public function get oneUnitMagicDefense():Number
		{
			var unitRecord:UnitLevelRecord = engine.configuration.unitRecords.getById(battleInfo.unitId).levels[battleInfo.unitLevel];
			var unitDefense:Number = engine.players.getPlayer(ownerId).modifier.calculate(ModifierType.UNITS_MAGIC_DEFENSE, unitRecord.magicDefense, battleInfo.unitId);
			return unitDefense;
		}
		
		public function get oneUnitHp():Number
		{
			var unitRecord:UnitLevelRecord = engine.configuration.unitRecords.getById(battleInfo.unitId).levels[battleInfo.unitLevel];
			var unitHp:Number = engine.players.getPlayer(ownerId).modifier.calculate(ModifierType.UNITS_HP, unitRecord.hp, battleInfo.unitId);
			return unitHp;
		}
		
		public function get oneUnitDamage():Number
		{
			var unitRecord:UnitLevelRecord = engine.configuration.unitRecords.getById(battleInfo.unitId).levels[battleInfo.unitLevel];
			var damage:Number = engine.players.getPlayer(ownerId).modifier.calculate(ModifierType.UNITS_DAMAGE, unitRecord.damage, battleInfo.unitId);
			return damage;
		}
		
		public function get hp():Number
		{
			return oneUnitHp * units.count;
		}
		
		public function get powerDefense():Number
		{
			return (oneUnitDefense + oneUnitHp) * units.count;
		}
		
		public function get powerMagicDefense():Number
		{
			return (oneUnitMagicDefense + oneUnitHp) * units.count;
		}
		
		public function initialize(info:BattleBuildingRecord, configuration:BattleConfiguration):void
		{
			_record = configuration.buildingRecords.getById(info.id);
			_battleRecord = info;
			
			setOwnerId(info.ownerId);
			transform.setFromPoint(info.position);
			
			units.setCount(_battleRecord.units);
			
			var unitsPerSecond:Number = battleInfo.unitsPerSecond;
			UnitRegenComponent(addComponent(UnitRegenComponent)).setUnitsPerTick((unitsPerSecond / engine.configuration.ticksPerSecond));
			
			switch (_record.type)
			{
				case BuildingType.DEFENSE: 
					addComponent(BuildingAttackDefenseComponent);
					break;
				case BuildingType.MANNA: 
					addComponent(MannaRegenComponent);
					break;
				case BuildingType.PRODUCTION: 
					break;
			}
		}
		
		public function changeOwner(ownerId:int):void
		{
			setOwnerId(ownerId);
		}
		
		public function receiveDamage(damage:Number):void
		{
			var unitDefense:Number = oneUnitDefense;
			var unitHP:Number = oneUnitHp;
			
			while (damage > 0 && units.count > 0)
			{
				var currentHp:Number = unitHP;
				damage -= unitDefense;
				currentHp -= damage;
				damage -= unitHP;
				if (currentHp <= 0)
				{
					units.remove(1);
				}
			}
		}
		
		public function get powerDamage():Number
		{
			return units.count * oneUnitDamage;
		}
		
		private function outputEvent():void
		{
			var evt:BuildingChangeUnitEvent = engine.output.enqueueByFactory(BuildingChangeUnitEvent) as BuildingChangeUnitEvent;
			evt.tick = engine.tick;
			evt.objectId = objectId;
			evt.units = units.count;
		}
	
	}

}