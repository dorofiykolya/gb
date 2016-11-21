package game.managers.locations 
{
	import game.managers.battles.engine.BattleConfiguration;
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
	public class LocationData 
	{
		public var id:int;
		public var configuration:BattleConfiguration;
		
		public function LocationData() 
		{
			var config:BattleConfiguration = new BattleConfiguration();
			
			config.spellRecords = fillSpells(new SpellRecordMap());
			config.npcPlayer = fillNpcPlayer(new BattleNPCRecord());
			config.modeRecords = fillModes(new ModeRecordMap());
			
			fillBattleBuilding(config.buildings);
			fillBattleOwners(config.owners);
			fillActions(config.actions);
			
			configuration = config;
		}
		
		
		private function fillActions(list:Vector.<BattleAction>):void
		{
			var action1:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[0] = action1;
			
			action1.fromObjectId = 1;
			action1.toObjectId = 7;
			action1.tick = 5;
			
			var action2:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[1] = action2;
			
			action2.fromObjectId = 5;
			action2.toObjectId = 2
			action2.tick = 20;
			
			var action3:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[2] = action3;
			
			action3.fromObjectId = 5;
			action3.toObjectId = 2;
			action3.tick = 25;
			
			var action4:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[3] = action4;
			
			action4.fromObjectId = 5;
			action4.toObjectId = 2;
			action4.tick = 30;
			
			var action5:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[4] = action5;
			
			action5.fromObjectId = 5;
			action5.toObjectId = 2;
			action5.tick = 40;
			
			var action6:BattleUnitAttackAction = new BattleUnitAttackAction();
			list[5] = action6;
			
			action6.fromObjectId = 5;
			action6.toObjectId = 2;
			action6.tick = 45;
		}
		
		private function fillBattleBuilding(list:Vector.<BattleBuildingRecord>):void
		{
			var building1_1:BattleBuildingRecord = new BattleBuildingRecord();
			building1_1.id = 1;
			building1_1.level = 1;
			building1_1.mannaPerSecond = 0;
			building1_1.ownerId = 1;
			building1_1.position = new Point(100, 100);
			building1_1.unitId = 1;
			building1_1.unitLevel = 1;
			building1_1.units = 50;
			building1_1.unitsPerSecond = 3;
			
			list[0] = building1_1;
			
			var building1_2:BattleBuildingRecord = new BattleBuildingRecord();
			building1_2.id = 2;
			building1_2.level = 1;
			building1_2.mannaPerSecond = 1;
			building1_2.ownerId = 1;
			building1_2.position = new Point(400, 100);
			building1_2.unitId = 2;
			building1_2.unitLevel = 1;
			building1_2.units = 5;
			building1_2.unitsPerSecond = 2;
			
			list[1] = building1_2;
			
			var building1_3:BattleBuildingRecord = new BattleBuildingRecord();
			building1_3.id = 3;
			building1_3.level = 1;
			building1_3.mannaPerSecond = 0;
			building1_3.ownerId = 1;
			building1_3.position = new Point(700, 100);
			building1_3.unitId = 3;
			building1_3.unitLevel = 1;
			building1_3.units = 10;
			building1_3.unitsPerSecond = 1;
			
			list[2] = building1_3;
			
			var building2_1:BattleBuildingRecord = new BattleBuildingRecord();
			building2_1.id = 1;
			building2_1.level = 1;
			building2_1.mannaPerSecond = 0;
			building2_1.ownerId = 2;
			building2_1.position = new Point(100, 700);
			building2_1.unitId = 1;
			building2_1.unitLevel = 1;
			building2_1.units = 50;
			building2_1.unitsPerSecond = 3;
			
			list[3] = building2_1;
			
			var building2_2:BattleBuildingRecord = new BattleBuildingRecord();
			building2_2.id = 2;
			building2_2.level = 1;
			building2_2.mannaPerSecond = 1;
			building2_2.ownerId = 2;
			building2_2.position = new Point(400, 700);
			building2_2.unitId = 2;
			building2_2.unitLevel = 1;
			building2_2.units = 30;
			building2_2.unitsPerSecond = 2;
			
			list[4] = building2_2;
			
			var building2_3:BattleBuildingRecord = new BattleBuildingRecord();
			building2_3.id = 3;
			building2_3.level = 1;
			building2_3.mannaPerSecond = 0;
			building2_3.ownerId = 2;
			building2_3.position = new Point(700, 700);
			building2_3.unitId = 3;
			building2_3.unitLevel = 1;
			building2_3.units = 10;
			building2_3.unitsPerSecond = 1;
			
			list[5] = building2_3;
			
			var building0_3:BattleBuildingRecord = new BattleBuildingRecord();
			building0_3.id = 3;
			building0_3.level = 1;
			building0_3.mannaPerSecond = 0;
			building0_3.ownerId = 0;
			building0_3.position = new Point(400, 400);
			building0_3.unitId = 3;
			building0_3.unitLevel = 1;
			building0_3.units = 10;
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