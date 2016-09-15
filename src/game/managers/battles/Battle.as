package game.managers.battles
{
	import flash.geom.Point;
	import game.managers.battles.actions.BattleUnitAttackAction;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.engine.BattleEngine;
	import game.managers.battles.engine.BattleModulesProvider;
	import game.managers.battles.engine.BattleOutput;
	import game.managers.battles.players.BattleNPCPlayer;
	import game.managers.battles.providers.BattleCommands;
	import game.managers.battles.providers.BattleModules;
	import game.managers.battles.records.BattleBuildingRecord;
	import game.managers.battles.records.BattleModifierRecord;
	import game.managers.battles.records.BattleNPCRecord;
	import game.managers.battles.records.BattleOwnerRecord;
	import game.managers.battles.records.BattleSkillRecord;
	import game.managers.battles.records.BattleUnitRecord;
	import game.records.buildings.BuildingLevelRecord;
	import game.records.buildings.BuildingRecord;
	import game.records.buildings.BuildingType;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.modes.ModeRecordMap;
	import game.records.spells.SpellRecordMap;
	import game.records.units.UnitLevelRecord;
	import game.records.units.UnitRecord;
	import game.records.units.UnitRecordMap;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Battle
	{
		private var _engine:BattleEngine;
		private var _tick:int;
		
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
			
			_engine = new BattleEngine(config);
		}
		
		public function nextTick():void
		{
			_tick++;
			_engine.fastForward(_tick);
		}
		
		public function get out():BattleOutput
		{
			return _engine.output;
		}
		
		private function fillActions(list:Vector.<BattleAction>):void
		{
			var action1:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[0] = action1;
			
			action1.fromObjectId = 1;
			action1.toObjectId = 2;
			action1.tick = 5;
			
			var action2:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[1] = action2;
			
			action2.fromObjectId = 5;
			action2.toObjectId = 2
			action2.tick = 10;
		}
		
		private function fillBattleBuilding(list:Vector.<BattleBuildingRecord>):void
		{
			var building1_1:BattleBuildingRecord = new BattleBuildingRecord();
			building1_1.id = 1;
			building1_1.level = 1;
			building1_1.mannaPerSecond = 0;
			building1_1.ownerId = 1;
			building1_1.position = new Point(0, 0);
			building1_1.unitId = 1;
			building1_1.unitLevel = 1;
			building1_1.units = 5;
			building1_1.unitsPerSecond = 3;
			
			list[0] = building1_1;
			
			var building1_2:BattleBuildingRecord = new BattleBuildingRecord();
			building1_2.id = 2;
			building1_2.level = 1;
			building1_2.mannaPerSecond = 1;
			building1_2.ownerId = 1;
			building1_2.position = new Point(100, 0);
			building1_2.unitId = 2;
			building1_2.unitLevel = 1;
			building1_2.units = 3;
			building1_2.unitsPerSecond = 2;
			
			list[1] = building1_2;
			
			var building1_3:BattleBuildingRecord = new BattleBuildingRecord();
			building1_3.id = 3;
			building1_3.level = 1;
			building1_3.mannaPerSecond = 0;
			building1_3.ownerId = 1;
			building1_3.position = new Point(200, 0);
			building1_3.unitId = 3;
			building1_3.unitLevel = 1;
			building1_3.units = 1;
			building1_3.unitsPerSecond = 1;
			
			list[2] = building1_3;
			
			var building2_1:BattleBuildingRecord = new BattleBuildingRecord();
			building2_1.id = 1;
			building2_1.level = 1;
			building2_1.mannaPerSecond = 0;
			building2_1.ownerId = 2;
			building2_1.position = new Point(0, 200);
			building2_1.unitId = 1;
			building2_1.unitLevel = 1;
			building2_1.units = 5;
			building2_1.unitsPerSecond = 3;
			
			list[3] = building2_1;
			
			var building2_2:BattleBuildingRecord = new BattleBuildingRecord();
			building2_2.id = 2;
			building2_2.level = 1;
			building2_2.mannaPerSecond = 1;
			building2_2.ownerId = 2;
			building2_2.position = new Point(100, 200);
			building2_2.unitId = 2;
			building2_2.unitLevel = 1;
			building2_2.units = 3;
			building2_2.unitsPerSecond = 2;
			
			list[4] = building2_2;
			
			var building2_3:BattleBuildingRecord = new BattleBuildingRecord();
			building2_3.id = 3;
			building2_3.level = 1;
			building2_3.mannaPerSecond = 0;
			building2_3.ownerId = 2;
			building2_3.position = new Point(200, 200);
			building2_3.unitId = 3;
			building2_3.unitLevel = 1;
			building2_3.units = 1;
			building2_3.unitsPerSecond = 1;
			
			list[5] = building2_3;
			
			var building0_3:BattleBuildingRecord = new BattleBuildingRecord();
			building0_3.id = 3;
			building0_3.level = 1;
			building0_3.mannaPerSecond = 0;
			building0_3.ownerId = 2;
			building0_3.position = new Point(100, 100);
			building0_3.unitId = 3;
			building0_3.unitLevel = 1;
			building0_3.units = 1;
			building0_3.unitsPerSecond = 1;
			
			list[6] = building0_3;
		}
		
		private function fillBattleOwners(list:Vector.<BattleOwnerRecord>):void
		{
			var player1:BattleOwnerRecord = new BattleOwnerRecord();
			player1.id = 1;
			player1.race = 1;
			player1.modifiers = new Vector.<BattleModifierRecord>();
			player1.name = "player_1";
			player1.skills = new Vector.<BattleSkillRecord>();
			player1.units = new Vector.<BattleUnitRecord>();
			
			var player2:BattleOwnerRecord = new BattleOwnerRecord();
			player2.id = 2;
			player2.race = 1;
			player2.modifiers = new Vector.<BattleModifierRecord>();
			player2.name = "player_2";
			player2.skills = new Vector.<BattleSkillRecord>();
			player2.units = new Vector.<BattleUnitRecord>();
			
			list[0] = player1;
			list[1] = player2;
		}
		
		private function fillBuildings(map:BuildingsRecordMap):BuildingsRecordMap
		{
			var records:Vector.<BuildingRecord> = new Vector.<BuildingRecord>();
			
			var produceBuilding:BuildingRecord = new BuildingRecord();
			records.push(produceBuilding);
			produceBuilding.id = 1;
			produceBuilding.race = 1;
			produceBuilding.name = "Produce";
			produceBuilding.description = "Produce Building";
			produceBuilding.race = 1;
			produceBuilding.type = BuildingType.PRODUCTION;
			produceBuilding.levels = new Vector.<BuildingLevelRecord>();
			var produceBuildingLevel:BuildingLevelRecord = new BuildingLevelRecord();
			produceBuilding.levels[0] = produceBuildingLevel;
			produceBuilding.levels[1] = produceBuildingLevel;
			produceBuildingLevel.attackRange = 0;
			produceBuildingLevel.attackSpeed = 0;
			produceBuildingLevel.damage = 0;
			produceBuildingLevel.defense = 0;
			produceBuildingLevel.icon = "produce_icon";
			produceBuildingLevel.magicDefense = 0;
			produceBuildingLevel.mannaProduction = 0;
			produceBuildingLevel.unitId = 1;
			produceBuildingLevel.units = 1;
			produceBuildingLevel.unitsMaxProduction = 15;
			produceBuildingLevel.unitsProduction = 3;
			produceBuildingLevel.view = "production_view";
			
			var mannaBuilding:BuildingRecord = new BuildingRecord();
			records.push(mannaBuilding);
			mannaBuilding.id = 2;
			mannaBuilding.race = 1;
			mannaBuilding.name = "Manna";
			mannaBuilding.description = "Manna Building";
			mannaBuilding.race = 1;
			mannaBuilding.type = BuildingType.MANNA;
			mannaBuilding.levels = new Vector.<BuildingLevelRecord>();
			var mannaBuildingLevel:BuildingLevelRecord = new BuildingLevelRecord();
			mannaBuilding.levels[0] = mannaBuildingLevel;
			mannaBuilding.levels[1] = mannaBuildingLevel;
			mannaBuildingLevel.attackRange = 0;
			mannaBuildingLevel.attackSpeed = 0;
			mannaBuildingLevel.damage = 0;
			mannaBuildingLevel.defense = 0;
			mannaBuildingLevel.icon = "manna_icon";
			mannaBuildingLevel.magicDefense = 0;
			mannaBuildingLevel.mannaProduction = 1;
			mannaBuildingLevel.unitId = 2;
			mannaBuildingLevel.units = 1;
			mannaBuildingLevel.unitsMaxProduction = 10;
			mannaBuildingLevel.unitsProduction = 2;
			mannaBuildingLevel.view = "manna_view";
			
			var defenseBuilding:BuildingRecord = new BuildingRecord();
			records.push(defenseBuilding);
			defenseBuilding.id = 3;
			defenseBuilding.race = 1;
			defenseBuilding.name = "Defense";
			defenseBuilding.description = "Defense Building";
			defenseBuilding.race = 1;
			defenseBuilding.type = BuildingType.DEFENSE;
			defenseBuilding.levels = new Vector.<BuildingLevelRecord>();
			var defenseBuildingLevel:BuildingLevelRecord = new BuildingLevelRecord();
			defenseBuilding.levels[0] = defenseBuildingLevel;
			defenseBuilding.levels[1] = defenseBuildingLevel;
			defenseBuildingLevel.attackRange = 50;
			defenseBuildingLevel.attackSpeed = 1;
			defenseBuildingLevel.damage = 1;
			defenseBuildingLevel.defense = 1;
			defenseBuildingLevel.icon = "defense_icon";
			defenseBuildingLevel.magicDefense = 1;
			defenseBuildingLevel.mannaProduction = 0;
			defenseBuildingLevel.unitId = 3;
			defenseBuildingLevel.units = 1;
			defenseBuildingLevel.unitsMaxProduction = 5;
			defenseBuildingLevel.unitsProduction = 1;
			defenseBuildingLevel.view = "defense_view";
			
			map.parse(records);
			return map;
		}
		
		private function fillUnits(map:UnitRecordMap):UnitRecordMap
		{
			var units:Vector.<UnitRecord> = new Vector.<UnitRecord>();
			
			var produceUnit:UnitRecord = new UnitRecord();
			units.push(produceUnit);
			produceUnit.id = 1;
			produceUnit.description = "Produce unit description";
			produceUnit.name = "Produce unit";
			produceUnit.race = 1;
			produceUnit.speed = 20;
			produceUnit.levels = new Vector.<UnitLevelRecord>();
			var produceUnitLevel:UnitLevelRecord = new UnitLevelRecord();
			produceUnit.levels[0] = produceUnitLevel;
			produceUnit.levels[1] = produceUnitLevel;
			produceUnitLevel.hp = 2;
			produceUnitLevel.damage = 1;
			produceUnitLevel.defense = 0;
			produceUnitLevel.magicDefense = 0;
			produceUnitLevel.icon = "produce_unit_icon";
			produceUnitLevel.view = "produce_unit_view";
			
			var mannaUnit:UnitRecord = new UnitRecord();
			units.push(mannaUnit);
			mannaUnit.id = 2;
			mannaUnit.description = "Manna unit description";
			mannaUnit.name = "Manna unit";
			mannaUnit.race = 1;
			mannaUnit.speed = 30;
			mannaUnit.levels = new Vector.<UnitLevelRecord>();
			var mannaUnitLevel:UnitLevelRecord = new UnitLevelRecord();
			mannaUnit.levels[0] = mannaUnitLevel;
			mannaUnit.levels[1] = mannaUnitLevel;
			mannaUnitLevel.hp = 1;
			mannaUnitLevel.damage = 1;
			mannaUnitLevel.defense = 0;
			mannaUnitLevel.magicDefense = 0;
			mannaUnitLevel.icon = "manna_unit_icon";
			mannaUnitLevel.view = "manna_unit_view";
			
			var defenseUnit:UnitRecord = new UnitRecord();
			units.push(defenseUnit);
			defenseUnit.id = 3;
			defenseUnit.description = "Defense unit description";
			defenseUnit.name = "Defense unit";
			defenseUnit.race = 1;
			defenseUnit.speed = 10;
			defenseUnit.levels = new Vector.<UnitLevelRecord>();
			var defenseUnitLevel:UnitLevelRecord = new UnitLevelRecord();
			defenseUnit.levels[0] = defenseUnitLevel;
			defenseUnit.levels[1] = defenseUnitLevel;
			defenseUnitLevel.hp = 2;
			defenseUnitLevel.damage = 2;
			defenseUnitLevel.defense = 1;
			defenseUnitLevel.magicDefense = 0;
			defenseUnitLevel.icon = "defense_unit_icon";
			defenseUnitLevel.view = "defense_unit_view";
			
			map.parse(units);
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