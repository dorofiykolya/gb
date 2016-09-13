package game.managers.battles.engine
{
	import game.managers.battles.records.BattleBuildingRecord;
	import game.managers.battles.records.BattleNPCRecord;
	import game.managers.battles.records.BattleOwnerRecord;
	import game.managers.battles.records.BattleUnitRecord;
	import game.records.buildings.BuildingRecord;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.modes.ModeRecordMap;
	import game.records.spells.SpellRecordMap;
	import game.records.units.UnitRecordMap;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleConfiguration
	{
		public const ticksPerSecond:int = 30;
		public const processingSmothing:int = 100;
		public const maxTicks:int = ticksPerSecond * 60 * 3;
		
		public const buildings:Vector.<BattleBuildingRecord> = new Vector.<BattleBuildingRecord>();
		public const owners:Vector.<BattleOwnerRecord> = new Vector.<BattleOwnerRecord>();
		public const actions:Vector.<BattleAction> = new Vector.<BattleAction>();
		
		public var npcPlayer:BattleNPCRecord;
		public var unitRecords:UnitRecordMap;
		public var buildingRecords:BuildingsRecordMap;
		public var modeRecords:ModeRecordMap;
		public var spellRecords:SpellRecordMap;
		
		public function BattleConfiguration()
		{
		
		}
	
	}

}