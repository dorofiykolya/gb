package game.extensions
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import game.records.buildings.BuildingsRecordMap;
	import game.records.localizations.LocalizationRecordMap;
	
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
		}
	
	}

}