package game.records.buildings
{
	import common.system.DictionaryMap;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingsRecordMap
	{
		private var _map:Dictionary;
		private var _buildingMap:DictionaryMap;
		
		public function BuildingsRecordMap()
		{
			_map = new Dictionary();
			_buildingMap = new DictionaryMap();
			
			var records:Vector.<BuildingRecord> = new Vector.<BuildingRecord>();
			
			var produceBuilding:BuildingRecord = new BuildingRecord();
			records.push(produceBuilding);
			produceBuilding.id = 1;
			produceBuilding.buildingId = 1;
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
			//produceBuildingLevel.defense = 0;
			produceBuildingLevel.icon = "produce_icon";
			//produceBuildingLevel.magicDefense = 0;
			produceBuildingLevel.mannaProduction = 0;
			produceBuildingLevel.unitId = 1;
			produceBuildingLevel.units = 1;
			produceBuildingLevel.unitsMaxProduction = 15;
			produceBuildingLevel.unitsProduction = 3;
			produceBuildingLevel.view = "barrack_1";
			
			var mannaBuilding:BuildingRecord = new BuildingRecord();
			records.push(mannaBuilding);
			mannaBuilding.id = 2;
			mannaBuilding.buildingId = 2;
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
			//mannaBuildingLevel.defense = 0;
			mannaBuildingLevel.icon = "manna_icon";
			//mannaBuildingLevel.magicDefense = 0;
			mannaBuildingLevel.mannaProduction = 1;
			mannaBuildingLevel.unitId = 2;
			mannaBuildingLevel.units = 1;
			mannaBuildingLevel.unitsMaxProduction = 10;
			mannaBuildingLevel.unitsProduction = 2;
			mannaBuildingLevel.view = "altar_1";
			
			var defenseBuilding:BuildingRecord = new BuildingRecord();
			records.push(defenseBuilding);
			defenseBuilding.id = 3;
			defenseBuilding.buildingId = 3;
			defenseBuilding.race = 1;
			defenseBuilding.name = "Defense";
			defenseBuilding.description = "Defense Building";
			defenseBuilding.race = 1;
			defenseBuilding.type = BuildingType.DEFENSE;
			defenseBuilding.levels = new Vector.<BuildingLevelRecord>();
			var defenseBuildingLevel:BuildingLevelRecord = new BuildingLevelRecord();
			defenseBuilding.levels[0] = defenseBuildingLevel;
			defenseBuilding.levels[1] = defenseBuildingLevel;
			defenseBuildingLevel.attackRange = 70;
			defenseBuildingLevel.attackSpeed = 1;
			defenseBuildingLevel.damage = 1;
			//defenseBuildingLevel.defense = 1;
			defenseBuildingLevel.icon = "defense_icon";
			//defenseBuildingLevel.magicDefense = 1;
			defenseBuildingLevel.mannaProduction = 0;
			defenseBuildingLevel.unitId = 3;
			defenseBuildingLevel.units = 1;
			defenseBuildingLevel.unitsMaxProduction = 5;
			defenseBuildingLevel.unitsProduction = 1;
			defenseBuildingLevel.view = "tower_1";
			
			parse(records);
		}
		
		public function getById(id:int):BuildingRecord
		{
			return _map[id];
		}
		
		public function getByBuildingId(buildingId:int, race:int):BuildingRecord
		{
			return _buildingMap.map(race, buildingId).value;
		}
		
		public function parse(list:Vector.<BuildingRecord>):void
		{
			for each (var item:BuildingRecord in list)
			{
				_map[item.id] = item;
				_buildingMap.map(item.race, item.buildingId).value = item;
			}
		}
	
	}

}