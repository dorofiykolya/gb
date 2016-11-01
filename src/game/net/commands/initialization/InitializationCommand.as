package game.net.commands.initialization
{
	import game.managers.records.RecordManager;
	import game.modules.net.NetCommand;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.locations.LocationRecordMap;
	import game.records.modes.ModeRecordMap;
	import game.records.skills.SkillRecordMap;
	import game.records.spells.SpellRecordMap;
	import game.records.units.UnitRecordMap;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class InitializationCommand extends NetCommand
	{
		[Inject]
		public var buildingMap:BuildingsRecordMap;
		[Inject]
		public var unitsMap:UnitRecordMap;
		[Inject]
		public var spellMap:SpellRecordMap;
		[Inject]
		public var skillMap:SkillRecordMap;
		[Inject]
		public var locationsMap:LocationRecordMap;
		[Inject]
		public var modeMap:ModeRecordMap;
		
		[Inject]
		public var recordManager:RecordManager;
		
		public function InitializationCommand(... flags)
		{
			super(Initialization, flags);
		}
		
		override public function execute(data:Object = null):void 
		{
			super.execute(data);
			
			var packet:Initialization = Initialization(data);
			
			buildingMap.parse(packet.buildings);
			unitsMap.parse(packet.units);
			locationsMap.parse(packet.locations);
			modeMap.parse(packet.modes);
			spellMap.parse(packet.spells);
			skillMap.parse(packet.skills);
			
			recordManager.saveInitialization(packet);
		}
	
	}

}