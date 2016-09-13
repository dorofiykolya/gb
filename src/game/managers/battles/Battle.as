package game.managers.battles
{
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.engine.BattleModulesProvider;
	import game.managers.battles.players.BattleNPCPlayer;
	import game.managers.battles.providers.BattleCommands;
	import game.managers.battles.providers.BattleModules;
	import game.managers.battles.records.BattleBuildingRecord;
	import game.managers.battles.records.BattleNPCRecord;
	import game.managers.battles.records.BattleOwnerRecord;
	import game.records.buildings.BuildingLevelRecord;
	import game.records.buildings.BuildingRecord;
	import game.records.buildings.BuildingType;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.modes.ModeRecordMap;
	import game.records.spells.SpellRecordMap;
	import game.records.units.UnitRecordMap;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Battle
	{
		
		public function Battle()
		{
			var config:BattleConfiguration = new BattleConfiguration();
			
			config.buildingRecords = fillBuildings(new BuildingsRecordMap());
			config.unitRecords = fillUnits(new UnitRecordMap());
			config.spellRecords = fillSpells(new SpellRecordMap());
			config.npcPlayer = fillNpcPlayer(new BattleNPCRecord());
			config.modeRecords = fillModes(new ModeRecordMap());
			
			fillBattleBuilding(config.buildings);
			fillBattleOwners(config.owners);
			fillActions(config.actions);
			
			var engine:BattleEngine = new BattleEngine(config);
		}
		
		private function fillActions(list:Vector.<BattleAction>):void
		{
			
		}
		
		private function fillBattleBuilding(list:Vector.<BattleBuildingRecord>):void
		{
			
		}
		
		private function fillBattleOwners(list:Vector.<BattleOwnerRecord>):void
		{
			
		}
		
		private function fillBuildings(map:BuildingsRecordMap):BuildingsRecordMap
		{
			var records:Vector.<BuildingRecord> = new Vector.<BuildingRecord>();
			
			var produceBuilding:BuildingRecord = new BuildingRecord();
			records.push(produceBuilding);
			produceBuilding.id = 1;
			produceBuilding.name = "Produce";
			produceBuilding.description = "Produce Building";
			produceBuilding.race = 1;
			produceBuilding.type = BuildingType.PRODUCTION;
			produceBuilding.levels = new Vector.<BuildingLevelRecord>();
			
			var mannaBuilding:BuildingRecord = new BuildingRecord();
			records.push(mannaBuilding);
			mannaBuilding.id = 2;
			mannaBuilding.name = "Manna";
			mannaBuilding.description = "Manna Building";
			mannaBuilding.race = 1;
			mannaBuilding.type = BuildingType.MANNA;
			mannaBuilding.levels = new Vector.<BuildingLevelRecord>();
			
			var defenseBuilding:BuildingRecord = new BuildingRecord();
			records.push(defenseBuilding);
			defenseBuilding.id = 2;
			defenseBuilding.name = "Defense";
			defenseBuilding.description = "Defense Building";
			defenseBuilding.race = 1;
			defenseBuilding.type = BuildingType.DEFENSE;
			defenseBuilding.levels = new Vector.<BuildingLevelRecord>();
			
			map.parse(records);
			return map;
		}
		
		private function fillUnits(map:UnitRecordMap):UnitRecordMap
		{
			return map;
		}
		
		private function fillSpells(map:SpellRecordMap):SpellRecordMap
		{
			return map;
		}
		
		private function fillNpcPlayer(value:BattleNPCRecord):BattleNPCRecord
		{
			return value;
		}
		
		private function fillModes(map:ModeRecordMap):ModeRecordMap
		{
			return map;
		}
	
	}

}