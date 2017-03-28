package game.records.units
{
	import common.system.DictionaryMap;
	import common.system.utils.ObjectUtils;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitRecordMap
	{
		private var _unitMap:DictionaryMap;
		
		public function UnitRecordMap()
		{
			_unitMap = new DictionaryMap();
			
			var units:Vector.<UnitRecord> = new Vector.<UnitRecord>();
			
			var produceUnit:UnitRecord = new UnitRecord();
			units.push(produceUnit);
			produceUnit.id = 1;
			produceUnit.description = "Produce unit description";
			produceUnit.name = "Produce unit";
			produceUnit.race = 1;
			produceUnit.speed = 2;
			produceUnit.levels = new Vector.<UnitLevelRecord>();
			var produceUnitLevel:UnitLevelRecord = new UnitLevelRecord();
			produceUnit.levels[0] = produceUnitLevel;
			produceUnit.levels[1] = produceUnitLevel;
			produceUnitLevel.hp = 2;
			produceUnitLevel.damage = 1;
			produceUnitLevel.defense = 0;
			produceUnitLevel.magicDefense = 0;
			produceUnitLevel.icon = "produce_unit_icon";
			produceUnitLevel.view = "light_warrior";//"produce_unit_view";
			
			var mannaUnit:UnitRecord = new UnitRecord();
			units.push(mannaUnit);
			mannaUnit.id = 2;
			mannaUnit.description = "Manna unit description";
			mannaUnit.name = "Manna unit";
			mannaUnit.race = 1;
			mannaUnit.speed = 3;
			mannaUnit.levels = new Vector.<UnitLevelRecord>();
			var mannaUnitLevel:UnitLevelRecord = new UnitLevelRecord();
			mannaUnit.levels[0] = mannaUnitLevel;
			mannaUnit.levels[1] = mannaUnitLevel;
			mannaUnitLevel.hp = 1;
			mannaUnitLevel.damage = 1;
			mannaUnitLevel.defense = 0;
			mannaUnitLevel.magicDefense = 0;
			mannaUnitLevel.icon = "manna_unit_icon";
			mannaUnitLevel.view = "horse_warrior";//"manna_unit_view";
			
			var defenseUnit:UnitRecord = new UnitRecord();
			units.push(defenseUnit);
			defenseUnit.id = 3;
			defenseUnit.description = "Defense unit description";
			defenseUnit.name = "Defense unit";
			defenseUnit.race = 1;
			defenseUnit.speed = 1;
			defenseUnit.levels = new Vector.<UnitLevelRecord>();
			var defenseUnitLevel:UnitLevelRecord = new UnitLevelRecord();
			defenseUnit.levels[0] = defenseUnitLevel;
			defenseUnit.levels[1] = defenseUnitLevel;
			defenseUnitLevel.hp = 2;
			defenseUnitLevel.damage = 2;
			defenseUnitLevel.defense = 1;
			defenseUnitLevel.magicDefense = 0;
			defenseUnitLevel.icon = "defense_unit_icon";
			defenseUnitLevel.view = "hard_warrior";//"defense_unit_view";
			
			var clone:Vector.<UnitRecord> = ObjectUtils.clone(units, Class(Vector.<UnitRecord>)) as Vector.<UnitRecord>;
			for each(var cur:UnitRecord in clone)
			{
				cur.race = 0;
				units.push(cur);
			}
			
			parse(units);
		}
		
		public function getBy(unitId:int, race:int):UnitRecord
		{
			return _unitMap.map(race, unitId).value;
		}
		
		public function parse(list:Vector.<UnitRecord>):void
		{
			for each (var item:UnitRecord in list)
			{
				_unitMap.map(item.race, item.id).value = item;
			}
		}
	}

}