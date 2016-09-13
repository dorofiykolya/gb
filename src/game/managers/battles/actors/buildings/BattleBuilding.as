package game.managers.battles.actors.buildings
{
	import game.managers.battles.components.buildings.BuildingAttackDefenseComponent;
	import game.managers.battles.components.buildings.MannaRegenComponent;
	import game.managers.battles.components.buildings.UnitRegenComponent;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.records.BattleBuildingRecord;
	import game.records.buildings.BuildingLevelRecord;
	import game.records.buildings.BuildingRecord;
	import game.records.buildings.BuildingType;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBuilding extends BattleObject
	{
		private var _units:int;
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
		
		public function get units():int
		{
			return _units;
		}
		
		public function get level():int
		{
			return _battleRecord.level;
		}
		
		public function addUnits(count:int):void
		{
			_units += count;
		}
		
		public function removeUnits(count:int):void
		{
			_units -= count;
		}
		
		public function setUnits(count:int):void
		{
			_units = count;
		}
		
		public function initialize(info:BattleBuildingRecord, configuration:BattleConfiguration):void
		{
			_record = configuration.buildingRecords.getById(info.id);
			_battleRecord = info;
			
			setOwnerId(info.ownerId);
			transform.setFromPoint(info.position);
			
			_units = _battleRecord.units;
			
			addComponent(UnitRegenComponent);
			
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
	
	}

}