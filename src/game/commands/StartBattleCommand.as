package game.commands 
{
	import game.managers.locations.LocationData;
	import game.managers.locations.LocationManager;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.units.UnitRecordMap;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StartBattleCommand implements ICommand 
	{
		[Inject]
		public var locationManager:LocationManager;
		[Inject]
		public var buildingRecords:BuildingsRecordMap;
		[Inject]
		public var unitRecords:UnitRecordMap;
		
		public function StartBattleCommand() 
		{
			
		}
		
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void 
		{
			var data:LocationData = new LocationData();
			data.configuration.buildingRecords = buildingRecords;
			data.configuration.unitRecords = unitRecords;
			locationManager.load(data);
		}
		
	}

}