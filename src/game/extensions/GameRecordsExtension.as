package game.extensions
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.localizations.LocalizationRecordMap;
	import game.records.locations.LocationRecordMap;
	import game.records.modes.ModeRecordMap;
	import game.records.spells.SpellRecordMap;
	import game.records.units.UnitRecordMap;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameRecordsExtension implements IExtension
	{
		
		public function GameRecordsExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(LocalizationRecordMap);
			context.install(BuildingsRecordMap);
			context.install(UnitRecordMap);
			context.install(SpellRecordMap);
			context.install(ModeRecordMap);
			context.install(LocationRecordMap);
		}
	
	}

}