package game.managers.localization
{
	import common.events.EventDispatcher;
	import common.system.utils.ObjectUtils;
	import game.modules.localizations.ILocalizationProvider;
	import game.modules.localizations.Localization;
	import game.modules.localizations.LocalizationValue;
	import game.records.localizations.LocalizationRecord;
	import game.records.localizations.LocalizationRecordMap;
	import game.records.localizations.LocalizationTexts;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocalizationProvider implements ILocalizationProvider
	{
		[Inject]
		public var recordMap:LocalizationRecordMap;
		
		private var _eventDispatcher:EventDispatcher;
		
		public function LocalizationProvider()
		{
			_eventDispatcher = new EventDispatcher();
		}
		
		/* INTERFACE game.modules.localizations.ILocalizationProvider */
		
		public function getByName(value:String):Localization
		{
			var record:LocalizationRecord = recordMap.getByName(value);
			if (record != null)
			{
				return getLocalization(record);
			}
			return null;
		}
		
		public function getByLanguage(value:String):Localization
		{
			var record:LocalizationRecord = recordMap.getByLanguage(value);
			if (record != null)
			{
				return getLocalization(record);
			}
			return null;
		}
		
		public function addEventListener(type:Object, listener:Function):void
		{
			_eventDispatcher.addEventListener(type, listener);
		}
		
		public function removeEventListener(type:Object, listener:Function):void
		{
			_eventDispatcher.removeEventListener(type, listener);
		}
		
		public function removeEventListeners(type:Object = null):void
		{
			_eventDispatcher.removeEventListeners(type);
		}
		
		private function getLocalization(record:LocalizationRecord):Localization
		{
			var result:Localization = new Localization();
			result.name = record.name;
			result.language = record.language;
			result.localization = new Vector.<LocalizationValue>(record.texts.length);
			
			var localization:Vector.<LocalizationValue> = result.localization;
			var records:Vector.<LocalizationTexts> = record.texts;
			
			for (var i:int = 0; i < result.localization.length; i++)
			{
				localization[i] = new LocalizationValue(records[i].id, records[i].value);
			}
			return result;
		}
	
	}

}